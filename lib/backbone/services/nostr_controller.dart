import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/add_invoice.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/streams/lnd/sendpayment_v2.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:nip01/nip01.dart' as nip01;
import 'package:nip06/nip06.dart';
import 'package:nip47/nip47.dart' as nip47;
import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Model class to represent an NWC connection
class NwcConnection {
  final String id; // Unique identifier for the connection
  final String appName;
  final Uri connectionUri;
  final List<nip47.Method> methods;
  final DateTime createdAt;
  final StreamSubscription<nip47.RequestEvent>? requestStream;
  final String walletPubkey;
  final BuildContext? context; // Context for showing dialogs

  NwcConnection({
    required this.id,
    required this.appName,
    required this.connectionUri,
    required this.methods,
    required this.createdAt,
    this.requestStream,
    required this.walletPubkey,
    this.context,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appName': appName,
      'connectionUri': connectionUri.toString(),
      'methods': methods.map((m) => m.name).toList(),
      'createdAt': createdAt.toIso8601String(),
      'walletPubkey': walletPubkey,
    };
  }

  // Create from JSON
  factory NwcConnection.fromJson(Map<String, dynamic> json) {
    return NwcConnection(
      id: json['id'],
      appName: json['appName'],
      connectionUri: Uri.parse(json['connectionUri']),
      methods: (json['methods'] as List)
          .map((m) =>
              nip47.Method.values.firstWhere((method) => method.name == m))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      walletPubkey: json['walletPubkey'],
    );
  }
}

class NostrController extends GetxController {
  // Core NIP-01 use cases
  late nip01.PublishEventUseCase publishEventUseCase;
  late nip01.SubscribeUseCase subscribeUseCase;
  late nip01.UnsubscribeUseCase unsubscribeUseCase;

  // NIP-47 use cases
  late nip47.CreateWalletConnectionUseCase createWalletConnectionUseCase;
  late nip47.GetRequestEventStreamUseCase getRequestEventStreamUseCase;
  late nip47.SendResponseUseCase sendResponseUseCase;

  // Wallet key pairs
  late nip01.KeyPair walletServiceKeyPair;
  late nip01.KeyPair userKeyPair;

  // List of all active NWC connections
  final RxList<NwcConnection> activeConnections = <NwcConnection>[].obs;

  // SharedPreferences key for storing connections
  static const String _connectionsStorageKey = 'nwc_connections';

  // Default relays for NWC
  final List<Uri> defaultRelays = [
    // Uri.parse('wss://relay.nwc.dev'), // NWC-optimized
    Uri.parse('wss://nos.lol'), // Reliable + fast
    Uri.parse('wss://relay.damus.io'), // Public + widely used
    Uri.parse("wss://relay.getalby.com/v1")
  ];

  // Default methods to support
  final List<nip47.Method> defaultMethods = [
    nip47.Method.getInfo,
    nip47.Method.getBalance,
    nip47.Method.listTransactions,
    nip47.Method.payInvoice,
    nip47.Method.makeInvoice,
    nip47.Method.lookupInvoice,
    // nip47.Method.payKeysend, // Might not be available in current version
  ];

  @override
  void onInit() {
    super.onInit();
    setupNip47();
  }

  Future<void> setupNip47() async {
    if (Auth().currentUser != null) {
      // Initialize key pairs
      walletServiceKeyPair = Nip06KeyPair.fromMnemonic(
          (await getPrivateData(Auth().currentUser!.uid)).mnemonic);
      userKeyPair = Nip06KeyPair.fromMnemonic(
          (await getPrivateData(Auth().currentUser!.uid)).mnemonic,
          accountIndex: 1);
      // Initialize nip01 dependencies
      final relayDataSource = nip01.WebSocketRelayDataSource();
      final relayRepository =
          nip01.RelayRepositoryImpl(relayDataSource: relayDataSource);
      final eventRepository =
          nip01.EventRepositoryImpl(relayDataSource: relayDataSource);
      final subscriptionRepository =
          nip01.SubscriptionRepositoryImpl(relayDataSource: relayDataSource);

      // Initialize use cases as class members
      publishEventUseCase = nip01.PublishEventUseCase(
          eventRepository: eventRepository, relayRepository: relayRepository);
      subscribeUseCase = nip01.SubscribeUseCase(
          subscriptionRepository: subscriptionRepository,
          eventRepository: eventRepository,
          relayRepository: relayRepository);
      unsubscribeUseCase = nip01.UnsubscribeUseCase(
          subscriptionRepository: subscriptionRepository);

      // Initialize NIP-47 database
      Directory dir = await getApplicationDocumentsDirectory();
      final nip47Database =
          nip47.Nip47Database(filePath: join(dir.path, "dartstr_nip47.db"));
      // Initialize datasources
      final nostrDataSource = nip47.NostrDataSourceImpl(
        publishEventUseCase: publishEventUseCase,
        subscribeUseCase: subscribeUseCase,
        unsubscribeUseCase: unsubscribeUseCase,
      );
      final localRequestDataSource =
          nip47.SqliteLocalRequestDataSource(database: nip47Database);
      final localResponseDataSource =
          nip47.SqliteLocalResponseDataSource(database: nip47Database);
      // Initialize repositories
      final walletConnectionRepository = nip47.WalletConnectionRepositoryImpl(
        localWalletConnectionDataSource:
            nip47.SqliteLocalWalletConnectionDataSource(
                database: nip47Database),
      );
      final infoEventRepository = nip47.InfoEventRepositoryImpl(
        nostrDataSource: nostrDataSource,
      );
      final requestRepository = nip47.RequestRepositoryImpl(
        nostrDataSource: nostrDataSource,
        localRequestDataSource: localRequestDataSource,
        localWalletConnectionDataSource:
            nip47.SqliteLocalWalletConnectionDataSource(
                database: nip47Database),
      );
      final responseRepository = nip47.ResponseRepositoryImpl(
        nostrDataSource: nostrDataSource,
        localResponseDataSource: localResponseDataSource,
        localWalletConnectionDataSource:
            nip47.SqliteLocalWalletConnectionDataSource(
                database: nip47Database),
      );
      // Initialize use cases as class members
      createWalletConnectionUseCase = nip47.CreateWalletConnectionUseCase(
        walletConnectionRepository: walletConnectionRepository,
        infoEventRepository: infoEventRepository,
        requestRepository: requestRepository,
      );
      getRequestEventStreamUseCase = nip47.GetRequestEventStreamUseCase(
        requestRepository: requestRepository,
      );
      sendResponseUseCase = nip47.SendResponseUseCase(
        responseRepository: responseRepository,
      );

      // Load any previously saved connections
      await _loadActiveConnections();

      // Example code commented out - will be replaced with actual implementation
      /*
      final methods = [
        Method.getInfo,
        Method.getBalance,
        Method.listTransactions,
        Method.payInvoice,
        Method.makeInvoice,
        Method.lookupInvoice,
        Method.payKeysend,
      ];

      // Add a new connection
      final connectionUri = await createWalletConnectionUseCase.execute(
        walletServiceKeyPair: walletServiceKeyPair,
        relays: [
          Uri.parse('wss://relay.nwc.dev'), // NWC-optimized
          Uri.parse('wss://nos.lol'), // Reliable + fast
          Uri.parse('wss://relay.damus.io'), // Public + widely used
        ],
        methods: methods,
      );
      print('Connection URI: ${connectionUri.uri}');

      // Listen for nwc requests
      final sub = getRequestEventStreamUseCase.execute().listen((event) async {
        print('Request event: $event');
        switch (event.request) {
          case GetBalanceRequest request:
            try {
              final response = nip47.Response.getBalance(
                  requestId: event.eventId,
                  clientPubkey: request.clientPubkey,
                  balanceSat: 10101);
              await sendResponseUseCase.execute(
                response,
                walletServicePrivateKey: walletServiceKeyPair.privateKey,
                waitForOkMessage: false,
              );
            } catch (e) {
              print('Error responding to GetBalanceRequest: $e');
            }
          case GetInfoRequest request:
            try {
              final response = nip47.Response.getInfo(
                requestId: event.eventId,
                clientPubkey: request.clientPubkey,
                alias: 'Dartstr Wallet',
                color: '#FF0000',
                network: nip47.Network.mainnet,
                methods: methods,
              );
              await sendResponseUseCase.execute(
                response,
                walletServicePrivateKey: walletServiceKeyPair.privateKey,
                waitForOkMessage: false,
              );
            } catch (e) {
              print('Error responding to GetInfoRequest: $e');
            }
          default:
            print('TODO: handle other requests');
        }
      });
      */
    }
  }

  // Function to create a new NWC connection and generate connection URI
  Future<Uri?> createNwcConnection({
    required String appName,
    List<nip47.Method>? methods,
    List<Uri>? relays,
    BuildContext? context,
  }) async {
    try {
      // Use provided methods or default methods
      final connectionMethods = methods ?? defaultMethods;
      final connectionRelays = relays ?? defaultRelays;

      // Create the wallet connection
      final connectionUri = await createWalletConnectionUseCase.execute(
        walletServiceKeyPair: walletServiceKeyPair,
        relays: connectionRelays,
        methods: connectionMethods,
      );

      // Start listening for requests from this connection
      final requestStream =
          getRequestEventStreamUseCase.execute().listen((event) async {
        await _handleNwcRequest(event);
      });

      // Create connection object
      final connection = NwcConnection(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        appName: appName,
        connectionUri: connectionUri.uri,
        methods: connectionMethods,
        createdAt: DateTime.now(),
        requestStream: requestStream,
        walletPubkey: walletServiceKeyPair.publicKey,
        context: context,
      );

      // Add to active connections list
      activeConnections.add(connection);

      // Save connections to storage
      await _saveActiveConnections();

      print('NWC Connection created for $appName: ${connectionUri.uri}');
      return connectionUri.uri;
    } catch (e) {
      print('Error creating NWC connection: $e');
      return null;
    }
  }

  // Function to close/remove an NWC connection
  Future<bool> closeNwcConnection(String connectionId) async {
    try {
      // Find the connection
      final connectionIndex =
          activeConnections.indexWhere((c) => c.id == connectionId);
      if (connectionIndex == -1) {
        print('Connection not found: $connectionId');
        return false;
      }

      final connection = activeConnections[connectionIndex];

      // Cancel the request stream subscription
      await connection.requestStream?.cancel();

      // Remove from active connections
      activeConnections.removeAt(connectionIndex);

      // Save updated connections to storage
      await _saveActiveConnections();

      print('NWC Connection closed for ${connection.appName}');
      return true;
    } catch (e) {
      print('Error closing NWC connection: $e');
      return false;
    }
  }

  // Function to close all NWC connections
  Future<void> closeAllNwcConnections() async {
    for (final connection in activeConnections) {
      await connection.requestStream?.cancel();
    }
    activeConnections.clear();

    // Save updated (empty) connections to storage
    await _saveActiveConnections();

    print('All NWC connections closed');
  }

  // Function to get connection details by ID
  NwcConnection? getConnectionById(String connectionId) {
    try {
      return activeConnections.firstWhere((c) => c.id == connectionId);
    } catch (e) {
      return null;
    }
  }

  // Function to get all active connections
  List<NwcConnection> getAllConnections() {
    return activeConnections.toList();
  }

  // Internal function to handle incoming NWC requests
  Future<void> _handleNwcRequest(nip47.RequestEvent event) async {
    print('Handling NWC request: ${event.request.method}');

    switch (event.request) {
      case nip47.GetInfoRequest request:
        await _handleGetInfo(event, request);
        break;
      case nip47.GetBalanceRequest request:
        await _handleGetBalance(event, request);
        break;
      case nip47.PayInvoiceRequest request:
        await _handlePayInvoice(event, request);
        break;
      case nip47.MakeInvoiceRequest request:
        await _handleMakeInvoice(event, request);
        break;
      case nip47.ListTransactionsRequest request:
        await _handleListTransactions(event, request);
        break;
      case nip47.LookupInvoiceRequest request:
        await _handleLookupInvoice(event, request);
        break;
      // PayKeysend might not be available in current version
      // case nip47.PayKeysendRequest request:
      //   await _handlePayKeysend(event, request);
      //   break;
      default:
        print('Unhandled request type: ${event.request.method}');
    }
  }

  // Placeholder methods for handling each request type
  Future<void> _handleGetInfo(
      nip47.RequestEvent event, nip47.GetInfoRequest request) async {
    try {
      print('Handling get_info request from ${request.clientPubkey}');

      // Find which connection this request is for

      // Create the get_info response
      final response = nip47.Response.getInfo(
        requestId: event.eventId,
        clientPubkey: request.clientPubkey,
        alias: 'BitNET Wallet', // Wallet name
        color: '#f7931a', // Bitcoin orange color
        network: nip47.Network.mainnet, // Using mainnet
        methods: defaultMethods, // Methods supported by this connection
        // Optional fields that could be added:
        pubkey: walletServiceKeyPair.publicKey, // Wallet's public key
        // notifications: [], // Notification types supported
      );

      // Send the response
      await sendResponseUseCase.execute(
        response,
        walletServicePrivateKey: walletServiceKeyPair.privateKey,
        waitForOkMessage: false,
      );

      print('Successfully sent get_info response');
    } catch (e) {
      print('Error handling GetInfoRequest: $e');

      // Send error response
      try {
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "get_info",
          errorMessage: 'Failed to process get_info request: ${e.toString()}',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
      } catch (sendError) {
        print('Failed to send error response: $sendError');
      }
    }
  }

  Future<void> _handleGetBalance(
      nip47.RequestEvent event, nip47.GetBalanceRequest request) async {
    try {
      print('Handling get_balance request from ${request.clientPubkey}');

      // Get the WalletsController instance
      final WalletsController walletsController = Get.find<WalletsController>();

      // Fetch the latest balances
      await walletsController.fetchOnchainWalletBalance();
      await walletsController.fetchLightingWalletBalance();

      // Get the total balance in satoshis
      final totalBalanceSat = walletsController.totalBalanceSAT.value.toInt();

      print('Total balance: $totalBalanceSat sats');

      // Create the get_balance response
      final response = nip47.Response.getBalance(
        requestId: event.eventId,
        clientPubkey: request.clientPubkey,
        balanceSat: totalBalanceSat,
      );

      // Send the response
      await sendResponseUseCase.execute(
        response,
        walletServicePrivateKey: walletServiceKeyPair.privateKey,
        waitForOkMessage: false,
      );

      print('Successfully sent get_balance response: $totalBalanceSat sats');
    } catch (e) {
      print('Error handling GetBalanceRequest: $e');

      // Send error response
      try {
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "get_balance",
          errorMessage: 'Failed to fetch wallet balance: ${e.toString()}',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
      } catch (sendError) {
        print('Failed to send error response: $sendError');
      }
    }
  }

  Future<void> _handlePayInvoice(
      nip47.RequestEvent event, nip47.PayInvoiceRequest request) async {
    try {
      print('Handling pay_invoice request from ${request.clientPubkey}');

      // Find the connection that has a context for this request
      NwcConnection? connectionWithContext;
      for (final conn in activeConnections) {
        if (conn.context != null &&
            conn.methods.contains(nip47.Method.payInvoice)) {
          connectionWithContext = conn;
          break;
        }
      }

      if (connectionWithContext == null ||
          connectionWithContext.context == null) {
        print('No connection with context found for payment confirmation');
        // Send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "pay_invoice",
          errorMessage: 'No UI context available for payment confirmation',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      final context = connectionWithContext.context!;

      // Decode the invoice to get details
      final invoice = request.invoice;
      Bolt11PaymentRequest decodedInvoice;
      try {
        decodedInvoice = Bolt11PaymentRequest(invoice);
      } catch (e) {
        print('Failed to decode invoice: $e');
        // Send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "pay_invoice",
          errorMessage: 'Invalid invoice format',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      // Get amount (from invoice or request parameter)
      int amountSat = 0;
      // Convert Decimal to int (Decimal is from decimal package)
      amountSat = int.parse(decodedInvoice.amount.toString());

      // Get invoice description
      String description = '';
      for (var tag in decodedInvoice.tags) {
        if (tag.type == 'description') {
          description = tag.data.toString();
          break;
        }
      }

      // Format amount for display
      final btcAmount =
          CurrencyConverter.convertSatoshiToBTC(amountSat.toDouble());
      final formattedAmount =
          '$amountSat sats (${btcAmount.toStringAsFixed(8)} BTC)';

      // Show confirmation dialog
      bool? userConfirmed = await showDialogue(
        context: context,
        title:
            'Confirm Lightning Payment\n\nAmount: $formattedAmount\n${description.isNotEmpty ? '\nDescription: $description' : ''}\n\nFrom: ${connectionWithContext.appName}',
        image: 'assets/images/bitcoin.png',
        leftAction: () {
          print('User rejected payment');
        },
        rightAction: () {
          print('User confirmed payment');
        },
      );

      // Check if user confirmed
      if (userConfirmed != true) {
        // User cancelled - send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "pay_invoice",
          errorMessage: 'Payment rejected by user',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      // User confirmed - proceed with payment
      print('User confirmed payment, processing...');

      // Show loading overlay
      final overlayController = Get.find<OverlayController>();
      overlayController.showOverlay("Processing payment...");

      try {
        // Execute the payment using sendPaymentV2Stream
        final paymentStream = sendPaymentV2Stream(
          Auth().currentUser!.uid,
          [invoice],
          amountSat > 0 ? amountSat : null,
        );

        // Listen for payment result
        bool paymentSuccessful = false;
        String? paymentHash;
        String? paymentPreimage;
        String? failureReason;

        await for (final paymentUpdate in paymentStream) {
          print('Payment update: $paymentUpdate');

          final status = paymentUpdate['status'];
          if (status == 'SUCCEEDED') {
            paymentSuccessful = true;
            paymentHash = paymentUpdate['payment_hash'];
            paymentPreimage = paymentUpdate['payment_preimage'];
            break;
          } else if (status == 'FAILED') {
            failureReason = paymentUpdate['failure_reason'] ?? 'Payment failed';
            break;
          }
        }

        overlayController.removeOverlay();

        if (paymentSuccessful) {
          // Payment successful - send success response
          final response = nip47.Response.payInvoice(
            requestId: event.eventId,
            clientPubkey: request.clientPubkey,
            preimage: paymentPreimage ?? '',
          );

          await sendResponseUseCase.execute(
            response,
            walletServicePrivateKey: walletServiceKeyPair.privateKey,
            waitForOkMessage: false,
          );

          // Show success message
          overlayController.showOverlay("Payment sent successfully!");

          print('Payment successful! Hash: $paymentHash');
        } else {
          // Payment failed - send error response
          final errorResponse = nip47.Response.error(
            requestId: event.eventId,
            clientPubkey: request.clientPubkey,
            method: "pay_invoice",
            errorMessage: failureReason ?? 'Payment failed',
            errorCode: nip47.ErrorCode.paymentFailed,
          );

          await sendResponseUseCase.execute(
            errorResponse,
            walletServicePrivateKey: walletServiceKeyPair.privateKey,
            waitForOkMessage: false,
          );

          // Show error message
          overlayController.showOverlay(
              "Payment failed: ${failureReason ?? 'Unknown error'}");
        }
      } catch (e) {
        print('Error processing payment: $e');

        // Clear overlay if still showing
        overlayController.removeOverlay();

        // Send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "pay_invoice",
          errorMessage: 'Payment processing error: ${e.toString()}',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );

        // Show error overlay
        overlayController.showOverlay("Payment error");
      }
    } catch (e) {
      print('Error handling PayInvoiceRequest: $e');

      // Send error response
      try {
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "pay_invoice",
          errorMessage:
              'Failed to process pay_invoice request: ${e.toString()}',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
      } catch (sendError) {
        print('Failed to send error response: $sendError');
      }
    }
  }

  Future<void> _handleMakeInvoice(
      nip47.RequestEvent event, nip47.MakeInvoiceRequest request) async {
    try {
      print('Handling make_invoice request from ${request.clientPubkey}');

      // Extract request parameters
      final amountSat = request.amountSat; // Convert millisats to sats
      final description = request.description ?? '';
      final descriptionHash = request.descriptionHash;
      final DateTime expiry = request.expiry ??
          DateTime.now().add(Duration(hours: 1)); // Default 1 hour

      print(
          'Creating invoice for $amountSat sats with description: $description');

      // Get the user's onchain address for fallback
      final walletsController = Get.find<WalletsController>();
      final addresses = await walletsController.getOnchainAddresses();
      if (addresses.isEmpty) {
        print('No onchain addresses available');
        // Send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "make_invoice",
          errorMessage: 'No Bitcoin addresses available',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      final fallbackAddress = addresses.first;
      print('Using fallback address: $fallbackAddress');

      // Generate preimage for the invoice
      final preimage = generatePreimage();

      // Create the invoice using the existing addInvoice function
      final invoiceResponse = await addInvoice(
        amountSat,
        description,
        fallbackAddress,
        preimage,
      );

      if (invoiceResponse.statusCode == "error") {
        print('Failed to create invoice: ${invoiceResponse.message}');
        // Send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "make_invoice",
          errorMessage: invoiceResponse.message,
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      // Parse the invoice response
      final invoiceData = invoiceResponse.data;
      final paymentRequest = invoiceData['payment_request'] as String;
      final rHash = invoiceData['r_hash'] as String;
      final createdAt = DateTime.now();

      print(
          'Invoice created successfully: ${paymentRequest.substring(0, 50)}...');

      // Create the make_invoice response
      final response = nip47.Response.makeInvoice(
        requestId: event.eventId,
        clientPubkey: request.clientPubkey,
        invoice: paymentRequest,
        paymentHash: rHash,
        amountSat: amountSat, // Convert back to millisats
        description: description,
        descriptionHash: descriptionHash,
        expiresAt: expiry,
        createdAt: createdAt,
        metadata: {
          "fallback_address": fallbackAddress,
          "created_via": "nwc",
        },
      );

      // Send the response
      await sendResponseUseCase.execute(
        response,
        walletServicePrivateKey: walletServiceKeyPair.privateKey,
        waitForOkMessage: false,
      );

      // Show notification to user
      final overlayController = Get.find<OverlayController>();
      overlayController.showOverlay("Invoice created: $amountSat sats");

      print('Successfully sent make_invoice response');
    } catch (e) {
      print('Error handling MakeInvoiceRequest: $e');

      // Send error response
      try {
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "make_invoice",
          errorMessage:
              'Failed to process make_invoice request: ${e.toString()}',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
      } catch (sendError) {
        print('Failed to send error response: $sendError');
      }
    }
  }

  Future<void> _handleListTransactions(
      nip47.RequestEvent event, nip47.ListTransactionsRequest request) async {
    try {
      print('Handling list_transactions request from ${request.clientPubkey}');

      // Get current user ID
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        print('No user logged in');
        // Send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "list_transactions",
          errorMessage: 'No user logged in',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      // Extract request parameters
      final from = request.from != null
          ? request.from!.millisecondsSinceEpoch ~/ 1000
          : null; // Convert DateTime to unix timestamp
      final until = request.until != null
          ? request.until!.millisecondsSinceEpoch ~/ 1000
          : null; // Convert DateTime to unix timestamp
      final limit = request.limit;
      final offset = request.offset;
      final unpaid = request.unpaid ?? false;
      final transactionType = request.type;

      print(
          'Fetching transactions: from=$from, until=$until, limit=$limit, offset=$offset, unpaid=$unpaid, type=$transactionType');

      // Import the necessary functions
      final listPaymentsFunction = listPayments;
      final listInvoicesFunction = listInvoices;

      // Lists to hold all transactions
      List<Map<String, dynamic>> allTransactions = [];

      // Fetch outgoing payments if requested or no specific type
      if (transactionType == null ||
          transactionType == nip47.TransactionType.outgoing) {
        try {
          final payments = await listPaymentsFunction(userId);
          print('Found ${payments.length} outgoing payments');

          // Convert payments to transaction format
          for (final payment in payments) {
            // Filter by date range if specified
            final creationDate = payment.creationDate;
            if (from != null && creationDate < from) continue;
            if (until != null && creationDate > until) continue;

            allTransactions.add({
              'type': 'outgoing',
              'invoice': payment.paymentRequest,
              'description': '', // Payments don't have memo in the model
              'description_hash': null,
              'preimage': payment.paymentPreimage,
              'payment_hash': payment.paymentHash,
              'amount': payment.valueMsat, // Already in millisats
              'fees_paid': payment.feeMsat, // Already in millisats
              'created_at': creationDate,
              'expires_at': null,
              'settled_at': payment.status == 'SUCCEEDED' ? creationDate : null,
              'metadata': {
                'payment_index': payment.paymentIndex,
                'htlcs': payment.htlcs,
              },
            });
          }
        } catch (e) {
          print('Error fetching payments: $e');
        }
      }

      // Fetch incoming invoices if requested or no specific type
      if (transactionType == null ||
          transactionType == nip47.TransactionType.incoming) {
        try {
          final invoices =
              await listInvoicesFunction(userId, pending_only: unpaid);
          print('Found ${invoices.length} incoming invoices');

          // Convert invoices to transaction format
          for (final invoice in invoices) {
            // Filter by date range if specified
            final creationDate = invoice.creationDate;
            if (from != null && creationDate < from) continue;
            if (until != null && creationDate > until) continue;

            // Skip unpaid invoices unless specifically requested
            if (!unpaid && invoice.state != 'SETTLED') continue;

            allTransactions.add({
              'type': 'incoming',
              'invoice': invoice.paymentRequest,
              'description': invoice.memo,
              'description_hash': null,
              'preimage': invoice.rPreimage,
              'payment_hash': invoice.rHash,
              'amount': invoice.valueMsat, // Already in millisats
              'fees_paid': 0, // No fees for receiving
              'created_at': creationDate,
              'expires_at': creationDate + 3600, // Default 1 hour expiry
              'settled_at':
                  invoice.state == 'SETTLED' ? invoice.settleDate : null,
              'metadata': {
                'state': invoice.state,
                'amt_paid_msat': invoice.amtPaidMsat,
                'amt_paid_sat': invoice.amtPaidSat,
              },
            });
          }
        } catch (e) {
          print('Error fetching invoices: $e');
        }
      }

      // Sort transactions by creation date (newest first)
      allTransactions.sort(
          (a, b) => (b['created_at'] as int).compareTo(a['created_at'] as int));

      // Apply pagination
      final startIndex = offset ?? 0;
      final endIndex =
          limit != null ? startIndex + limit : allTransactions.length;
      final paginatedTransactions = allTransactions.sublist(
        startIndex.clamp(0, allTransactions.length),
        endIndex.clamp(0, allTransactions.length),
      );

      print(
          'Returning ${paginatedTransactions.length} transactions after filtering and pagination');

      // Convert to Transaction objects
      final transactions = paginatedTransactions.map((txData) {
        return nip47.Transaction(
          type: txData['type'] == 'incoming'
              ? nip47.TransactionType.incoming
              : nip47.TransactionType.outgoing,
          invoice: txData['invoice'] as String,
          description: txData['description'] as String?,
          descriptionHash: txData['description_hash'] as String?,
          preimage: txData['preimage'] as String?,
          paymentHash: txData['payment_hash'] as String,
          amountSat:
              (txData['amount'] as int) ~/ 1000, // Convert millisats to sats
          feesPaidSat:
              (txData['fees_paid'] as int) ~/ 1000, // Convert millisats to sats
          createdAt: DateTime.fromMillisecondsSinceEpoch(
              (txData['created_at'] as int) * 1000),
          expiresAt: txData['expires_at'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  (txData['expires_at'] as int) * 1000)
              : null,
          settledAt: txData['settled_at'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  (txData['settled_at'] as int) * 1000)
              : null,
          metadata: txData['metadata'] as Map<String, dynamic>?,
        );
      }).toList();

      // Create the list_transactions response
      final response = nip47.Response.listTransactions(
        requestId: event.eventId,
        clientPubkey: request.clientPubkey,
        transactions: transactions,
      );

      // Send the response
      await sendResponseUseCase.execute(
        response,
        walletServicePrivateKey: walletServiceKeyPair.privateKey,
        waitForOkMessage: false,
      );

      print('Successfully sent list_transactions response');
    } catch (e) {
      print('Error handling ListTransactionsRequest: $e');

      // Send error response
      try {
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "list_transactions",
          errorMessage:
              'Failed to process list_transactions request: ${e.toString()}',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
      } catch (sendError) {
        print('Failed to send error response: $sendError');
      }
    }
  }

  Future<void> _handleLookupInvoice(
      nip47.RequestEvent event, nip47.LookupInvoiceRequest request) async {
    try {
      print('Handling lookup_invoice request from ${request.clientPubkey}');

      // Get current user ID
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        print('No user logged in');
        // Send error response
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "lookup_invoice",
          errorMessage: 'No user logged in',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      // Extract request parameters
      final invoice = request.invoice; // Bolt11 invoice string
      final paymentHash = request.paymentHash; // Payment hash to look up

      print('Looking up invoice: invoice=$invoice, paymentHash=$paymentHash');

      Map<String, dynamic>? invoiceData;
      String? foundInvoice;
      String? foundPaymentHash;

      // Search in user's invoices (backend/userId/invoices)
      try {
        final invoices = await listInvoices(userId);

        for (final inv in invoices) {
          // Check by payment hash
          if (paymentHash != null && inv.rHash == paymentHash) {
            print('Found invoice by payment hash in user invoices');
            invoiceData = {
              'type': 'incoming',
              'invoice': inv.paymentRequest,
              'description': inv.memo,
              'preimage': inv.settled ? inv.rPreimage : null,
              'payment_hash': inv.rHash,
              'amount': inv.valueMsat,
              'fees_paid': 0,
              'created_at': inv.creationDate,
              'expires_at': inv.creationDate + 3600,
              'settled_at': inv.settled ? inv.settleDate : null,
              'paid': inv.settled,
              'state': inv.state,
              'metadata': {
                'amt_paid_msat': inv.amtPaidMsat,
                'amt_paid_sat': inv.amtPaidSat,
              },
            };
            foundInvoice = inv.paymentRequest;
            foundPaymentHash = inv.rHash;
            break;
          }
          // Check by invoice string
          if (invoice != null && inv.paymentRequest == invoice) {
            print('Found invoice by invoice string in user invoices');
            invoiceData = {
              'type': 'incoming',
              'invoice': inv.paymentRequest,
              'description': inv.memo,
              'preimage': inv.settled ? inv.rPreimage : null,
              'payment_hash': inv.rHash,
              'amount': inv.valueMsat,
              'fees_paid': 0,
              'created_at': inv.creationDate,
              'expires_at': inv.creationDate + 3600,
              'settled_at': inv.settled ? inv.settleDate : null,
              'paid': inv.settled,
              'state': inv.state,
              'metadata': {
                'amt_paid_msat': inv.amtPaidMsat,
                'amt_paid_sat': inv.amtPaidSat,
              },
            };
            foundInvoice = inv.paymentRequest;
            foundPaymentHash = inv.rHash;
            break;
          }
        }
      } catch (e) {
        print('Error searching user invoices: $e');
      }

      // Check if invoice was found
      if (invoiceData == null) {
        print('Invoice not found');
        // Send not found error
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "lookup_invoice",
          errorMessage: 'Invoice not found',
          errorCode: nip47.ErrorCode.notFound,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
        return;
      }

      // Create the lookup_invoice response
      // The NIP-47 lookupInvoice response includes the full transaction details
      final response = nip47.Response.lookupInvoice(
        requestId: event.eventId,
        clientPubkey: request.clientPubkey,
        type: 'incoming', // Use string type
        invoice: foundInvoice!,
        description: invoiceData['description'] as String?,
        descriptionHash: null,
        paymentHash: foundPaymentHash!,
        amountSat:
            (invoiceData['amount'] as int) ~/ 1000, // Convert millisats to sats
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            (invoiceData['created_at'] as int) * 1000),
        metadata: invoiceData['metadata'] as Map<String, dynamic>?,
      );

      // Send the response
      await sendResponseUseCase.execute(
        response,
        walletServicePrivateKey: walletServiceKeyPair.privateKey,
        waitForOkMessage: false,
      );

      print('Successfully sent lookup_invoice response');
    } catch (e) {
      print('Error handling LookupInvoiceRequest: $e');

      // Send error response
      try {
        final errorResponse = nip47.Response.error(
          requestId: event.eventId,
          clientPubkey: request.clientPubkey,
          method: "lookup_invoice",
          errorMessage:
              'Failed to process lookup_invoice request: ${e.toString()}',
          errorCode: nip47.ErrorCode.internal,
        );

        await sendResponseUseCase.execute(
          errorResponse,
          walletServicePrivateKey: walletServiceKeyPair.privateKey,
          waitForOkMessage: false,
        );
      } catch (sendError) {
        print('Failed to send error response: $sendError');
      }
    }
  }

  // PayKeysend might not be available in current version
  // Future<void> _handlePayKeysend(RequestEvent event, PayKeysendRequest request) async {
  //   // TODO: Implement pay_keysend handler
  //   print('TODO: Implement pay_keysend handler');
  // }

  // Save active connections to SharedPreferences
  Future<void> _saveActiveConnections() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final connectionsJson =
          activeConnections.map((connection) => connection.toJson()).toList();
      final connectionsString = jsonEncode(connectionsJson);
      await prefs.setString(_connectionsStorageKey, connectionsString);
      print('Saved ${activeConnections.length} NWC connections to storage');
    } catch (e) {
      print('Error saving NWC connections: $e');
    }
  }

  // Load connections from SharedPreferences
  Future<void> _loadActiveConnections() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final connectionsString = prefs.getString(_connectionsStorageKey);
      if (connectionsString == null || connectionsString.isEmpty) {
        print('No saved NWC connections found');
        return;
      }

      final connectionsJson = jsonDecode(connectionsString) as List;
      final loadedConnections = connectionsJson
          .map((json) => NwcConnection.fromJson(json as Map<String, dynamic>))
          .toList();

      // Don't add to activeConnections yet - we need to reconnect them first
      print('Loaded ${loadedConnections.length} NWC connections from storage');

      // Reconnect each connection
      for (final savedConnection in loadedConnections) {
        await _reconnectConnection(savedConnection);
      }
    } catch (e) {
      print('Error loading NWC connections: $e');
    }
  }

  // Reconnect a saved connection
  Future<void> _reconnectConnection(NwcConnection savedConnection) async {
    try {
      print('Reconnecting to ${savedConnection.appName}...');

      // Start listening for requests from this connection
      final requestStream =
          getRequestEventStreamUseCase.execute().listen((event) async {
        await _handleNwcRequest(event);
      });

      // Create new connection object with the stream
      final connection = NwcConnection(
        id: savedConnection.id,
        appName: savedConnection.appName,
        connectionUri: savedConnection.connectionUri,
        methods: savedConnection.methods,
        createdAt: savedConnection.createdAt,
        requestStream: requestStream,
        walletPubkey: savedConnection.walletPubkey,
      );

      // Add to active connections
      activeConnections.add(connection);

      print('Successfully reconnected to ${connection.appName}');
    } catch (e) {
      print('Error reconnecting to ${savedConnection.appName}: $e');
    }
  }
}
