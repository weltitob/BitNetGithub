import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/fadein.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/items/podest.dart';
import 'package:bitnet/pages/website/contact/submitidea/submitidea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SubmitIdeaView extends StatelessWidget {
  final SubmitIdeaController controller;

  const SubmitIdeaView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
      bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

      double textWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 16
              : AppTheme.cardPadding * 22
          : AppTheme.cardPadding * 24;

      return bitnetScaffold(
          extendBodyBehindAppBar: true,
          appBar: bitnetWebsiteAppBar(
            centerWidget: Text(
              L10n.of(context)!.shapeTheFuture,
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
                    const SizedBox(
                      height: AppTheme.cardPadding * 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              FadeIn(
                                delay: const Duration(milliseconds: 0),
                                duration: const Duration(seconds: 2),
                                child: Container(
                                  child: Text(
                                    L10n.of(context)!.ideaLeaderboard,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppTheme.cardPadding,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FadeIn(
                                    delay: const Duration(milliseconds: 1200),
                                    duration: const Duration(seconds: 2),
                                    child: PodestWidget(
                                        controller: controller,
                                        size: AppTheme.cardPadding * 4,
                                        height: AppTheme.cardPadding * 6.5,
                                        width: AppTheme.cardPadding * 7,
                                        avatarName:
                                            controller.submitters[0].name,
                                        counterValue: 2,
                                        onTap: () {}),
                                  ),
                                  const SizedBox(
                                    width: AppTheme.cardPadding,
                                  ),
                                  FadeIn(
                                    delay: const Duration(milliseconds: 1600),
                                    duration: const Duration(seconds: 2),
                                    child: PodestWidget(
                                        controller: controller,
                                        size: AppTheme.cardPadding * 4,
                                        height: AppTheme.cardPadding * 9.5,
                                        width: AppTheme.cardPadding * 7,
                                        avatarName:
                                            controller.submitters[1].name,
                                        counterValue: 1,
                                        onTap: () {}),
                                  ),
                                  const SizedBox(
                                    width: AppTheme.cardPadding,
                                  ),
                                  FadeIn(
                                    delay: const Duration(milliseconds: 800),
                                    duration: const Duration(seconds: 2),
                                    child: PodestWidget(
                                        controller: controller,
                                        size: AppTheme.cardPadding * 4,
                                        height: AppTheme.cardPadding * 5.5,
                                        width: AppTheme.cardPadding * 7,
                                        avatarName:
                                            controller.submitters[2].name,
                                        counterValue: 3,
                                        onTap: () {}),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppTheme.cardPadding * 2,
                              ),
                              FadeIn(
                                delay: const Duration(milliseconds: 1600),
                                duration: const Duration(seconds: 2),
                                child: Container(
                                  width: textWidth,
                                  color: Colors.transparent,
                                  child: Text(
                                    controller
                                            .submitters[
                                                controller.currentSelected]
                                            .name +
                                        ": " +
                                        '"' +
                                        controller
                                            .submitters[
                                                controller.currentSelected]
                                            .idea +
                                        '"',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                    textAlign: TextAlign.center,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: AppTheme.cardPadding * 4,
                        ),
                        FadeIn(
                          delay: const Duration(milliseconds: 0),
                          duration: const Duration(seconds: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  L10n.of(context)!.submitIdea,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                              const SizedBox(
                                height: AppTheme.elementSpacing,
                              ),
                              //email optional
                              Container(
                                width: AppTheme.cardPadding * 18,
                                child: FormTextField(
                                    hintText:
                                        L10n.of(context)!.contactInfoHint),
                              ),
                              //idea
                              Stack(
                                children: [
                                  Container(
                                    width: AppTheme.cardPadding * 18,
                                    //height: AppTheme.cardPadding * 12,
                                    constraints: const BoxConstraints(
                                      minHeight:
                                          60, // Minimum height that the container starts with
                                      maxHeight:
                                          300, // Maximum height that the container can expand to
                                    ),
                                    child: FormTextField(
                                        isMultiline: true,
                                        hintText: L10n.of(context)!.yourIdeasGoesHere),
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
                                    title: L10n.of(context)!.submitIdea,
                                    customWidth: AppTheme.cardPadding * 18,
                                    onTap: () { 
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
    });
  }
}
