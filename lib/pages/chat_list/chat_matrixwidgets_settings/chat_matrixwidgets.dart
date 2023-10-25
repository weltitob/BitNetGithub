import 'package:bitnet/pages/chat_list/chat_matrixwidgets_settings/chat_matrixwidgets_view.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ChatMatrixWidgets extends StatefulWidget {
  const ChatMatrixWidgets({super.key});

  @override
  State<ChatMatrixWidgets> createState() => ChatMatrixWidgetController();
}

class ChatMatrixWidgetController extends State<ChatMatrixWidgets> with SingleTickerProviderStateMixin{
  String? get roomId => VRouter.of(context).pathParameters['roomid'];
  final TextEditingController urlController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String widgetType = 'm.etherpad';
  late TabController tabController;

  String? nameError;
  String? urlError;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this,);
    super.initState();
  }

  void setWidgetType(String value) => setState(() => widgetType = value);

  void addWidget() {
    try {
      nameError = null;
      urlError = null;

      final name = nameController.text;
      final uri = Uri.tryParse(urlController.text);

      if (name.length < 3) {
        setState(() {
          nameError = L10n.of(context)!.widgetNameError;
        });
        return;
      }

      if (uri == null || uri.scheme != 'https') {
        setState(() {
          urlError = L10n.of(context)!.widgetUrlError;
        });
        return;
      }
      setState(() {});

      late MatrixWidget matrixWidget;
      switch (widgetType) {
        case 'm.etherpad':
          matrixWidget = MatrixWidget.etherpad(room, name, uri);
          break;
        case 'm.jitsi':
          matrixWidget = MatrixWidget.jitsi(room, name, uri);
          break;
        case 'm.video':
          matrixWidget = MatrixWidget.video(room, name, uri);
          break;
        default:
          matrixWidget = MatrixWidget.custom(room, name, uri);
          break;
      }
      room.addWidget(matrixWidget);
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context)!.errorAddingWidget)),
      );
    }
  }

  Room get room => Matrix.of(context).client.getRoomById(roomId!)!;

  @override
  Widget build(BuildContext context) {
    return ChatMatrixWidgetsView(controller: this,);
  }
}
