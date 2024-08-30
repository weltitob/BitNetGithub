import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/fadein.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/report/report_mobile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';

class ReportMobileView extends StatelessWidget {
  final ReportMobileController controller;

  const ReportMobileView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          text: L10n.of(context)!.reportIssue,
          context: context,
          onTap: () {
            context.pop();
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                FadeIn(
                  delay: const Duration(milliseconds: 0),
                  duration: const Duration(seconds: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: AppTheme.cardPadding * 4,
                      ),
                      Container(
                        child: Text(
                          L10n.of(context)!.contactInfo,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      //email optional
                      Container(
                        width: AppTheme.cardPadding * 18,
                        child: FormTextField(hintText: L10n.of(context)!.contactInfoHint, controller: controller.contactInfoController),
                      ),
                      const SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      Container(
                        child: Text(
                          'Issue Type',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: AppTheme.cardPadding,
                      ),
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () async {
                            String issueType = await showPopover(
                              backgroundColor: Colors.transparent,
                              context: context,
                              direction: PopoverDirection.bottom,
                              bodyBuilder: (context) {
                                return const IssueTypeColumn();
                              },
                            ) as String;

                            controller.issueType = issueType;
                            controller.update();
                          },
                          child: GlassContainer(
                              width: AppTheme.cardPadding * 18,
                              height: AppTheme.cardPadding * 2,
                              borderThickness: 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(controller.issueType == '' ? "Select The Type of Issue" : controller.issueType,
                                        style: Theme.of(context).textTheme.bodyLarge),
                                    const Icon(Icons.arrow_drop_down_outlined)
                                  ],
                                ),
                              )),
                        );
                      }),
                      const SizedBox(
                        height: AppTheme.cardPadding,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: AppTheme.cardPadding * 18,
                            //height: AppTheme.cardPadding * 12,
                            constraints: const BoxConstraints(
                              minHeight: 60, // Minimum height that the container starts with
                              maxHeight: 300, // Maximum height that the container can expand to
                            ),
                            child: FormTextField(
                                isMultiline: true,
                                hintText: L10n.of(context)!.yourIssuesGoesHere,
                                controller: controller.complaintController),
                          ),
                          Positioned(
                            bottom: AppTheme.elementSpacing,
                            right: AppTheme.elementSpacing,
                            child: GestureDetector(
                              onTap: () {controller.onAddButton(context);},
                              child: GlassContainer(
                                  height: AppTheme.cardPadding * 1.25,
                                  width: AppTheme.cardPadding * 1.25,
                                  child: Icon(
                                    Icons.add,
                                    color: AppTheme.white90,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      //submit button
                      const SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      Container(
                        child: LongButtonWidget(
                            title: L10n.of(context)!.submitReport,
                            customWidth: AppTheme.cardPadding * 18,
                            onTap: () async {
                              if (controller.contactInfoController.text.isEmpty || controller.complaintController.text.isEmpty) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill out all fields first.')));
                                }
                              } else if (controller.issueType == '') {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an issue type first.')));
                                }
                              } else {
                                //initiate upload.
                                controller.setSubmitting(true);
                                DocumentReference ref = await issueCollection.add({
                                  'contact_info': controller.contactInfoController.text,
                                  'issue_type': controller.issueType,
                                  'complaint': controller.complaintController.text
                                });
                                List<String> imageUrls = List.empty(growable: true);
                                for (int i = 0; i < controller.imageList.length; i++) {
                                  Reference imageFile = storageRef.child('${ref.id}/$i');
                                  await imageFile.putData(controller.imageList[i]);
                                  imageUrls.add(await imageFile.getDownloadURL());
                                }
                                await ref.update({'image_urls': imageUrls});
                                controller.setSubmitting(false);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your report was sent successfully.')));
                                }
                              }
                            }),
                      ),
                      if (controller.isSubmitting) ...[
                        Container(
                          child: Text(
                            'submitting... please wait',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppTheme.elementSpacing),
                      ...controller.imageList
                          .mapIndexed((index, data) => ReportImage(data: data, delete: () => controller.deleteImage(index)))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        context: context);
  }
}

class ReportImage extends StatelessWidget {
  const ReportImage({
    super.key,
    required this.data,
    required this.delete,
  });
  final Uint8List data;
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: AppTheme.cardPadding * 18,
        child: Stack(children: [
          GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Image.memory(
                          data,
                          width: MediaQuery.of(context).size.width,
                          // frameBuilder: (ctx, wid, _, wasLoaded) {
                          //   return wasLoaded ? wid : dotProgress(ctx);
                          // },
                        )));
              },
              child: Image.memory(
                data,
                width: AppTheme.cardPadding * 18,
                fit: BoxFit.contain,
                // frameBuilder: (ctx, wid, _, wasLoaded) {
                //   print('was loaded: $wasLoaded');
                //   return wasLoaded ? wid : dotProgress(ctx);
                // },
              )),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Container(decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle), child: const Icon(Icons.close)),
                onPressed: delete,
              ))
        ]),
      ),
    );
  }
}

class IssueTypeColumn extends StatelessWidget {
  const IssueTypeColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop('Complaint');
          },
          child: Container(
              width: AppTheme.cardPadding * 18,
              decoration: BoxDecoration(
                  color: AppTheme.colorGlassContainer,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Complaint", style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop('Bug');
          },
          child: Container(
              width: AppTheme.cardPadding * 18,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Bug", style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop('Fraud');
          },
          child: Container(
              width: AppTheme.cardPadding * 18,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Fraud", style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop('Other');
          },
          child: Container(
              width: AppTheme.cardPadding * 18,
              decoration: BoxDecoration(
                  color: AppTheme.colorGlassContainer,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Other", style: TextStyle(color: Colors.white)),
              )),
        )
      ],
    );
  }
}
