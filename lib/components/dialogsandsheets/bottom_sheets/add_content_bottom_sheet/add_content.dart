import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/helpers.dart';

class AddContentWidget extends StatelessWidget {
  final controller;

  AddContentWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: AppTheme.cardPadding * 2, bottom: AppTheme.cardPadding * 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconCreationWidget(
                icon: Icons.link_rounded,
                color: Colors.orange,
                text: "Collection",
                mediaType: MediaType.external_url,
                onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              ),


              IconCreationWidget(
                icon: Icons.abc,
                color: Colors.orange,
                text: "Description",
                mediaType: MediaType.description,
                onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              ),


              IconCreationWidget(
                icon: Icons.link_rounded,
                color: Colors.orange,
                text: "Link",
                mediaType: MediaType.external_url,
                onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              ),

            ],
          ),
          SizedBox(height: AppTheme.cardPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconCreationWidget(
                icon: Icons.insert_drive_file,
                color: Colors.orange,
                text: "Document",
                mediaType: MediaType.document,
                onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              ),


              IconCreationWidget(
                icon: Icons.insert_photo,
                color: Colors.orange,
                text: "Gallery",
                mediaType: MediaType.image,
                onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              ),

              IconCreationWidget(
                icon: Icons.qr_code_rounded,
                color: Colors.orange,
                text: "Wallet",
                mediaType: MediaType.wallet_address,
                onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              ),
            ],
          ),
          SizedBox(height: AppTheme.cardPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //location
              // IconCreationWidget(
              //   icon: Icons.location_on,
              //   color: Colors.orange,
              //   text: "Location",
              //   mediaType: MediaType.text,
              //   onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              // ),
              //
              // IconCreationWidget(
              //   icon: Icons.headset,
              //   color: Colors.orange,
              //   text: "Audio",
              //   mediaType: MediaType.audio,
              //   onTap: (mediaType) => controller.onAddPopupMenuButtonSelected(mediaType),
              // ),
              SizedBox(width: AppTheme.cardPadding),

            ],
          ),
        ],
      ),
    );
  }
}


class IconCreationWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final MediaType mediaType;
  final Function(MediaType) onTap;

  IconCreationWidget({
    required this.icon,
    required this.color,
    required this.text,
    required this.mediaType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => onTap(mediaType),
      child: Container(
        width: AppTheme.cardPadding * 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: AppTheme.elementSpacing,
            vertical: AppTheme.elementSpacing),
        child: Column(
          children: [
            RoundedButtonWidget(
              iconData: icon,
              onTap: () {  },
            ),
            SizedBox(height: AppTheme.cardPadding / 2.5),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
