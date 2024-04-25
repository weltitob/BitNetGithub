import 'package:bitnet/pages/settings/settings_multiple_emotes/settings_multiple_emotes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:go_router/go_router.dart';

import 'package:bitnet/pages/routetrees/matrix.dart';

class MultipleEmotesSettingsView extends StatelessWidget {
  final MultipleEmotesSettingsController controller;

  const MultipleEmotesSettingsView(this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final room = Matrix.of(context).client.getRoomById(controller.roomId!)!;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(L10n.of(context)!.emotePacks),
      ),
      body: StreamBuilder(
        stream: room.onUpdate.stream,
        builder: (context, snapshot) {
          final packStateEvents = room.states['im.ponies.room_emotes'];
          // we need to manually convert the map using Map.of, otherwise assigning null will throw a type error.
          final Map<String, Event?> packs = packStateEvents != null
              ? Map<String, Event?>.of(packStateEvents)
              : <String, Event?>{};
          if (!packs.containsKey('')) {
            packs[''] = null;
          }
          final keys = packs.keys.toList();
          keys.sort();
          return ListView.separated(
            separatorBuilder: (BuildContext context, int i) =>
                const SizedBox.shrink(),
            itemCount: keys.length,
            itemBuilder: (BuildContext context, int i) {
              final event = packs[keys[i]];
              String? packName = keys[i].isNotEmpty ? keys[i] : 'Default Pack';
              if (event != null && event.content['pack'] is Map) {
                if (event.content['pack']['displayname'] is String) {
                  packName = event.content['pack']['displayname'];
                } else if (event.content['pack']['name'] is String) {
                  packName = event.content['pack']['name'];
                }
              }
              return ListTile(
                title: Text(packName!),
                onTap: () async {
                  //TODO: segmented routing doesnt exist for Go Router, potential bugs
                  context.go(
                    context.namedLocation('emotes2', pathParameters: {'roomid': room.id, 'state_key': keys[i]}) 
                    // + '/details/'  '/rooms/:'+ room.id+'/details/'+ 'emotes/'+ keys[i],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
