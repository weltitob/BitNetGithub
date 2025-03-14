import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/matrix_helpers/isrg_x1.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class CustomHttpClient {
  static HttpClient customHttpClient(String? cert) {
    final context = SecurityContext.defaultContext;

    try {
      if (cert != null) {
        final bytes = utf8.encode(cert);
        context.setTrustedCertificatesBytes(bytes);
      }
    } on TlsException catch (e) {
      if (e.osError != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
      } else {
        rethrow;
      }
    }

    return HttpClient(context: context);
  }

  static http.Client createHTTPClient() => IOClient(customHttpClient(ISRG_X1));
}
