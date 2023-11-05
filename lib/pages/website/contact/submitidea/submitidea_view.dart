import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/fadein.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/items/podest.dart';
import 'package:bitnet/pages/website/contact/submitidea/submitidea.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SubmitIdeaView extends StatelessWidget {
  final SubmitIdeaController controller;

  const SubmitIdeaView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          // Diese sind die Breite und Höhe aus den Constraints
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
          bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

          double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
          double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
          double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
          double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

          return bitnetScaffold(
          extendBodyBehindAppBar: true,
          appBar: bitnetWebsiteAppBar(
            centerWidget:  Text(
              "Shape the Future with us! We Want to Hear Your Brilliant Ideas!",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
            body: BackgroundWithContent(
              opacity: 0.7,
              backgroundType: BackgroundType.asset,
              withGradientLeftBig: true,
              withGradientTopSmall: true,
              withGradientBottomSmall: true,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: AppTheme.cardPadding * 8,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                FadeIn(
                                  delay: Duration(milliseconds: 0),
                                  duration: Duration(seconds: 2),
                                  child: Container(
                                    child: Text(
                                      "Idea Leaderboard",
                                      style: Theme.of(context).textTheme.headlineLarge,
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppTheme.cardPadding,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FadeIn(
                                      delay: Duration(milliseconds: 1200),
                                      duration: Duration(seconds: 2),
                                      child: PodestWidget(
                                        controller: controller,
                                          size: AppTheme.cardPadding * 4,
                                          height: AppTheme.cardPadding * 6.5,
                                          width: AppTheme.cardPadding * 7,
                                          avatarName: controller.submitters[0].name,
                                          counterValue: 2,
                                          onTap: (){}),
                                    ),
                                    SizedBox(width: AppTheme.cardPadding,),
                                    FadeIn(
                                      delay: Duration(milliseconds: 1600),
                                      duration: Duration(seconds: 2),
                                      child: PodestWidget(
                                        controller: controller,
                                          size: AppTheme.cardPadding * 4,
                                          height: AppTheme.cardPadding * 9.5,
                                          width: AppTheme.cardPadding * 7,
                                          avatarName: controller.submitters[1].name,
                                          counterValue: 1,
                                          onTap: (){}),
                                    ),
                                    SizedBox(width: AppTheme.cardPadding,),
                                    FadeIn(
                                      delay: Duration(milliseconds: 800),
                                      duration: Duration(seconds: 2),
                                      child: PodestWidget(
                                        controller: controller,
                                          size: AppTheme.cardPadding * 4,
                                          height: AppTheme.cardPadding * 5.5,
                                          width: AppTheme.cardPadding * 7,
                                          avatarName: controller.submitters[2].name,
                                          counterValue: 3,
                                          onTap: (){}),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppTheme.cardPadding * 2,),
                                FadeIn(
                                  delay: Duration(milliseconds: 1600),
                                  duration: Duration(seconds: 2),
                                  child: Container(
                                    width: textWidth,
                                    color: Colors.transparent,
                                    child: Text(
                                      controller.submitters[controller.currentSelected].name + ": " + '"' + controller.submitters[controller.currentSelected].idea + '"',
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 4,

                                      overflow: TextOverflow.ellipsis,),
                                  ),
                                ),

                              ],
                            ),

                          ),
                          SizedBox(width: AppTheme.cardPadding * 4,),
                          FadeIn(
                            delay: Duration(milliseconds: 0),
                            duration: Duration(seconds: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Submit Idea",
                                    style: Theme.of(context).textTheme.headlineLarge,
                                  ),
                                ),
                                SizedBox(height: AppTheme.elementSpacing,),
                                //email optional
                                Container(
                                  width: AppTheme.cardPadding * 18,
                                  child: FormTextField(hintText: "Contact information (Email, username, did...)"),
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
                                          hintText: "Your idea goes here"),
                                    ),
                                    Positioned(
                                      bottom: AppTheme.elementSpacing,
                                      right: AppTheme.elementSpacing,
                                      child: GestureDetector(
                                        onTap: controller.onAddButtonTap,
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
                                      title: "Submit Idea!",
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
                    ],
                  ),
                ),
              ),
            ),
            context: context);
      }
    );
  }
}
