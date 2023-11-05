import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

// Define the StatefulWidget
class AddContentWidget extends StatefulWidget {
  final controller;

  AddContentWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _AddContentWidgetState createState() => _AddContentWidgetState();
}

// The state class of the StatefulWidget
class _AddContentWidgetState extends State<AddContentWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.cardPadding * 12,
      width: AppTheme.cardPadding * 18,
      child: Card(
        color: Theme.of(context).canvasColor,
        margin: EdgeInsets.only(bottom: AppTheme.cardPadding * 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(Icons.insert_drive_file, Colors.orange, "Document", MediaType.document),
                SizedBox(width: AppTheme.cardPadding),
                iconCreation(Icons.link_rounded, Colors.orange, "Link", MediaType.link),
                SizedBox(width: AppTheme.cardPadding),
                iconCreation(Icons.insert_photo, Colors.orange, "Gallery", MediaType.image),
              ],
            ),
            SizedBox(height: AppTheme.cardPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(Icons.headset, Colors.orange, "Audio", MediaType.audio),
                SizedBox(width: AppTheme.cardPadding),
                iconCreation(Icons.location_pin, Colors.orange, "Location", MediaType.location),
                SizedBox(width: AppTheme.cardPadding),
                iconCreation(Icons.qr_code_rounded, Colors.orange, "Wallet", MediaType.wallet),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text, MediaType mediaType) {
    return InkWell(

      borderRadius: BorderRadius.circular(24),
      onTap: () => widget.controller.onAddPopupMenuButtonSelected(mediaType),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: AppTheme.elementSpacing,
            vertical: AppTheme.elementSpacing),
        child: Column(
          children: [
            RoundedButtonWidget(
                iconData: icons,
              onTap: () {  },),
            SizedBox(height: 5),
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
