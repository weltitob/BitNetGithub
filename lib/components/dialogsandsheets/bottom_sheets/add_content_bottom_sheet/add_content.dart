import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/chat.dart';
import 'package:flutter/material.dart';

//controller.onAddPopupMenuButtonSelected('file'),

Widget AddContentBottomSheet(BuildContext context, ChatController controller) {
  return Container(
    height: 280,
    width: MediaQuery.of(context).size.width,
    child: Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            //controller.onAddPopupMenuButtonSelected
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(Icons.insert_drive_file, Colors.orange, "Document",
                    MediaType.document, controller),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.link_rounded, Colors.orange, "Link",
                    MediaType.link, controller),
                // iconCreation(Icons.camera_alt, Colors.orange, "Camera",
                //     MediaType.camera),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.insert_photo, Colors.orange, "Gallery",
                    MediaType.image, controller),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(Icons.headset, Colors.orange, "Audio",
                    MediaType.audio, controller),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.location_pin, Colors.orange, "Location",
                    MediaType.location, controller),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.qr_code_rounded, Colors.orange, "Wallet",
                    MediaType.wallet, controller),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iconCreation(IconData icons, Color color, String text,
    MediaType mediaType, ChatController controller) {
  return InkWell(
    onTap: () => controller.onAddPopupMenuButtonSelected(
        mediaType), //print("Add media function on post screen but on"),//_addMedia(mediaType),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icons,
            // semanticLabel: "Help",
            size: 29,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            // fontWeight: FontWeight.w100,
          ),
        )
      ],
    ),
  );
}
