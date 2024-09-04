import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/search_receiver.dart';
import 'package:bitnet/pages/wallet/actions/send/send_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class Send extends StatefulWidget {
  final String? parameters;
  final GoRouterState? state;
  const Send({super.key, this.parameters, this.state});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  bool inited = false;
  late final SendsController sendController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!inited) {
      sendController = Get.put(SendsController(context: context, getClipOnInit: false));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        sendController.processParameters(
            context,
            widget.parameters != null
                ? (widget.parameters! +
                    (widget.state!.uri.queryParameters.containsKey('amount')
                        ? ('?amount=${widget.state!.uri.queryParameters['amount']!}')
                        : ''))
                : null);
      });

      inited = true;
    }

    return Obx(() => sendController.hasReceiver.value ? const SendBTCScreen() : const SearchReceiver());
  }
}
