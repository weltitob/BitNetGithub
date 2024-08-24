import 'dart:typed_data';

import 'package:bitnet/pages/website/contact/report/report_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => ReportController();
}

class ReportController extends State<Report> {
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

  Future<void> onAddButton() async {
    if (imageList.length >= 3) {
      return;
    }

    final List<XFile> pickedImages = (await ImagePicker().pickMultiImage());
        final List<Uint8List> pickedFiles = List.empty(growable: true);

    for(int i = 0; i < pickedImages.length; i++) {
      pickedFiles.add(await pickedImages[i].readAsBytes());
    }
   
    // Process each picked file
    for (var fileBytes in pickedFiles) {
      if (imageList.length < 3) {
        // Check again to ensure we do not exceed the limit
        imageList.add(Uint8List.fromList(fileBytes));
      } else {}
    }
    setState(() {});
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
    return ReportView(controller: this);
  }
}
