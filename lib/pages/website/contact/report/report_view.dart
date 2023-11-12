import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/fadein.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/website/contact/report/report.dart';
import 'package:flutter/material.dart';

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
                    SizedBox(height: AppTheme.cardPadding * 2,),
                    Container(
                      child: Text(
                        "Report Issue",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(height: AppTheme.cardPadding,),
                    Container(
                      child: Text(
                        "Contact information",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(height: AppTheme.elementSpacing,),
                    //email optional
                    Container(
                      width: AppTheme.cardPadding * 18,
                      child: FormTextField(hintText: "Contact information (Email, username, did...)"),
                    ),
                    SizedBox(height: AppTheme.elementSpacing,),

                    //issues: Incident, Bug, fraud, help, other
                    Container(
                      height: AppTheme.cardPadding * 5,
                      color: Colors.green,
                    ),
                    //idea
                    Stack(
                      children: [
                        Container(
                          width: AppTheme.cardPadding * 18,
                          //height: AppTheme.cardPadding * 12,
                          constraints: BoxConstraints(
                            minHeight: 60, // Minimum height that the container starts with
                            maxHeight: 300, // Maximum height that the container can expand to
                          ),
                          child: FormTextField(
                              isMultiline: true,
                              hintText: "Your issue goes here"),
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
                                )
                            ),
                          ),
                        ),
                      ],

                    ),
                    //submit button
                    SizedBox(height: AppTheme.elementSpacing,),
                    Container(
                      child: LongButtonWidget(
                          title: "Submit report!",
                          customWidth: AppTheme.cardPadding * 18,
                          onTap: (){
                            print('implement like report button to push model with info up in firebase');
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ), context: context);
  }
}
