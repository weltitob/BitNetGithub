import 'dart:typed_data';

import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/pages/report/report_mobile.dart';
import 'package:flutter/material.dart';

class ReportMobile extends StatefulWidget {
  const ReportMobile({super.key});

  @override
  State<ReportMobile> createState() => ReportMobileController();
}

class ReportMobileController extends State<ReportMobile> {
  String issueType = '';
  List<Uint8List> imageList = []; // This will hold the selected images
  late TextEditingController contactInfoController;
  late TextEditingController complaintController;
  bool isSubmitting = false;
  @override
  void initState() {
    super.initState();
    contactInfoController = TextEditingController();
    complaintController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    contactInfoController.dispose();
    complaintController.dispose();
  }

  void setSubmitting(bool val) {
    isSubmitting = val;
    setState(() {});
  }

  Future<void> onAddButton(BuildContext context) async {
    await ImagePickerCombinedBottomSheet(context, 
      includeNFTs: false,
      onImageTap: (album, image, pair) async {
        // This is intentionally empty as we're using the onPop callback
      },
      onPop: (photos) async {
        int length = photos.length;
        if(photos.length > 3 && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload 3 images at most.'),));
          length = 3;
        } 
        imageList.clear();
        for(int i = 0; i < length; i++) {
          Uint8List? data = await (await photos[i].loadFile())?.readAsBytes();
          if(data != null) {
            imageList.add(data);
          }
        }
        setState((){});
      }
    );
  }

  void deleteImage(int index) {
    this.imageList.removeAt(index);
    setState(() {});
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ReportMobileView(controller: this);
  }
}