
import 'package:bitnet/pages/chat_list/createnew/new_group/new_group_view.dart';
import 'package:flutter/material.dart';

import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart' as sdk;


import 'package:bitnet/pages/routetrees/matrix.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  NewGroupController createState() => NewGroupController();
}

class NewGroupController extends State<NewGroup> {
  TextEditingController controller = TextEditingController();
  bool publicGroup = false;

  void setPublicGroup(bool b) => setState(() => publicGroup = b);

  void submitAction([_]) async {
    final client = Matrix.of(context).client;
    final roomID = await showFutureLoadingDialog(
      context: context,
      future: () async {
        final roomId = await client.createGroupChat(
          visibility:
              publicGroup ? sdk.Visibility.public : sdk.Visibility.private,
          preset: publicGroup
              ? sdk.CreateRoomPreset.publicChat
              : sdk.CreateRoomPreset.privateChat,
          groupName: controller.text.isNotEmpty ? controller.text : null,
        );
        return roomId;
      },
    );
    if (roomID.error == null) {
          final String location = context.namedLocation('rooms', pathParameters: {'roomid': roomID.result!});
      context.go(location + '/invite');
    }
  }

  @override
  Widget build(BuildContext context) => NewGroupView(this);
}
