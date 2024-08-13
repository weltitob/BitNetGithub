import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/fadein.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/website/contact/report/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ReportView extends StatelessWidget {
  final ReportController controller;

  const ReportView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        appBar: bitnetWebsiteAppBar(),
        body: Container(
          child: Column(
            children: [
              FadeIn(
                delay: Duration(milliseconds: 0),
                duration: Duration(seconds: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppTheme.cardPadding * 2,
                    ),
                    Container(
                      child: Text(
                        L10n.of(context)!.reportIssue,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding,
                    ),
                    Container(
                      child: Text(
                        L10n.of(context)!.contactInfo,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    //email optional
                    Container(
                      width: AppTheme.cardPadding * 18,
                      child: FormTextField(
                          hintText: L10n.of(context)!.contactInfoHint),
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),

                    //issue selection: Incident, Bug, fraud, help, other
                    //idea
                    Stack(
                      children: [
                        Container(
                          width: AppTheme.cardPadding * 18,
                          //height: AppTheme.cardPadding * 12,
                          constraints: BoxConstraints(
                            minHeight:
                                60, // Minimum height that the container starts with
                            maxHeight:
                                300, // Maximum height that the container can expand to
                          ),
                          child: FormTextField(
                              isMultiline: true,
                              hintText: L10n.of(context)!.yourIssuesGoesHere),
                        ),
                        Positioned(
                          bottom: AppTheme.elementSpacing,
                          right: AppTheme.elementSpacing,
                          child: GestureDetector(
                            onTap: controller.onAddButton,
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
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    Container(
                      child: LongButtonWidget(
                          title: L10n.of(context)!.submitReport,
                          customWidth: AppTheme.cardPadding * 18,
                          onTap: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        context: context);
  }
}
