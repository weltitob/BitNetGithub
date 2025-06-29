import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/country_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

class CreateAccountView extends StatefulWidget {
  final CreateAccountController controller;
  const CreateAccountView({required this.controller});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final overlayController = Get.find<OverlayController>();

    // Frühe ProfileController-Initialisierung für bessere UX
    ProfileController? profileController;
    try {
      profileController = Get.find<ProfileController>();
    } catch (e) {
      // ProfileController noch nicht verfügbar, wird später erstellt
      print("ProfileController not yet available during registration");
    }

    return PopScope(
      canPop: false, // Prevent default back navigation
      onPopInvoked: (bool didPop) {
        if (!didPop && !widget.controller.isLoading) {
          context.go('/authhome');
        }
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        bool isSuperSmallScreen =
            constraints.maxWidth < AppTheme.isSuperSmallScreen;
        return bitnetScaffold(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          extendBodyBehindAppBar: true,
          context: context,
          gradientColor: Colors.black,
          appBar: bitnetAppBar(
              text: L10n.of(context)!.register,
              context: context,
              onTap: () {
                if (!widget.controller.isLoading) {
                  context.go('/authhome');
                }
              },
              actions: [
                // const PopUpLangPickerWidget()
              ]),
          body: Form(
            key: widget.controller.form,
            child: ListView(
              padding: EdgeInsets.only(
                  left: AppTheme.cardPadding * 2.ws,
                  right: AppTheme.cardPadding * 2.ws,
                  top: AppTheme.cardPadding * 5.h),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 2.h,
                ),
                // Container(
                //   height: AppTheme.cardPadding * 5.h,
                //   child: Text(
                //     L10n.of(context)!.powerToThePeople,
                //     style: Theme.of(context).textTheme.displayMedium,
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          // Navigator.pop(context);
                          final PermissionState ps =
                              await PhotoManager.requestPermissionExtend();
                          if (!ps.isAuth && !ps.hasAccess) {
                            overlayController.showOverlay(
                                'please give the app photo access to continue.',
                                color: AppTheme.errorColor);
                            return;
                          }
                          ImagePickerCombinedBottomSheet(context,
                              includeNFTs:
                                  false, // Disable NFTs during registration
                              onImageTap: (AssetPathEntity? album,
                                  AssetEntity? image,
                                  MediaDatePair? pair) async {
                            // During registration, only regular images are supported (no NFTs)
                            if (image != null) {
                              widget.controller.image = image;
                              widget.controller.pair = null;
                              widget.controller.bytes = await image.originBytes;
                              setState(() {});
                            }
                            Navigator.pop(context);
                          });
                        },
                        child: Avatar(
                          local: widget.controller.bytes != null,
                          imageBytes: widget.controller.bytes,
                          mxContent: Uri.parse(''),
                          size: AppTheme.cardPadding * 5.25.h,
                          type: profilePictureType.lightning,
                          isNft: widget.controller.pair != null,
                          cornerWidget: ProfileButton(),
                        )),
                    SizedBox(
                      height: AppTheme.cardPadding.h * 2,
                    ),
                    PopUpCountryPickerWidget(),
                    FormTextField(
                      width: AppTheme.cardPadding * 14.ws,
                      hintText: L10n.of(context)!.username,
                      validator: (val) => val!.isEmpty
                          ? L10n.of(context)!.pleaseEnterValidUsername
                          : null,
                      onChanged: (val) {
                        widget.controller.username = val;
                      },
                      controller: widget.controller.controllerUsername,
                      isObscure: false,
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding.h,
                    ),
                    LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 14.ws,
                      title: L10n.of(context)!.register,
                      onTap: () {
                        //no sso removed sso (single-sign-on) buttons because we have own system
                        if (widget.controller.form.currentState!.validate()) {
                          widget.controller.createAccountPressed();
                        }
                      },
                      state: widget.controller.isLoading
                          ? ButtonState.loading
                          : ButtonState.idle,
                    ),
                    widget.controller.errorMessage == null
                        ? Container()
                        : Padding(
                            padding:
                                EdgeInsets.only(top: AppTheme.cardPadding.h),
                            child: Text(
                              widget.controller.errorMessage!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppTheme.errorColor),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(top: AppTheme.cardPadding * 2.h),
                      child: Text(
                        textAlign: TextAlign.center,
                        L10n.of(context)!.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: AppTheme.cardPadding.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.white60
                              : AppTheme.black60,
                          width: 2,
                        ),
                        borderRadius: AppTheme.cardRadiusCircular,
                      ),
                      child: SizedBox(
                        height: 0,
                        width: 65.ws,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: AppTheme.cardPadding.h,
                          bottom: AppTheme.cardPadding.h),
                      child: GestureDetector(
                        onTap: () {
                          if (!widget.controller.isLoading) {
                            context.go('/authhome/login');
                          }
                        },
                        child: Text(
                          L10n.of(context)!.restoreAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
