import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/country_picker_widget.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

//import 'package:universal_html/html.dart' as html;

class CreateAccountView extends StatefulWidget {
  CreateAccountController controller;
  CreateAccountView({required this.controller});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView>
    with TickerProviderStateMixin {
  //MERGED connect_page from matrix in this screen
  //String? get domain => VRouter.of(context).queryParameters['domain'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.controller.isLoading) {
          context.go('/authhome');
        }
        return false; // Prevent the system from popping the current route.
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        bool isSuperSmallScreen =
            constraints.maxWidth < AppTheme.isSuperSmallScreen;
        return bitnetScaffold(
          margin: isSuperSmallScreen
              ? EdgeInsets.symmetric(horizontal: 0)
              : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250.w),
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
         PopUpLangPickerWidget()
        ]),
          body: Form(
            key: widget.controller.form,
            child: ListView(
              padding: EdgeInsets.only(
                  left: AppTheme.cardPadding * 2.w,
                  right: AppTheme.cardPadding * 2.w,
                  top: AppTheme.cardPadding * 5.h),
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 4.h,
                ),
                Container(
                  height: AppTheme.cardPadding * 5.h,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        L10n.of(context)!.powerToThePeople,
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.left,
                        speed: const Duration(milliseconds: 120),
                      ),
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: false,
                    stopPauseOnTap: false,
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PopUpCountryPickerWidget(),
                    FormTextField(
                      width: AppTheme.cardPadding * 14.w,
                      hintText: "Username",
                      validator: (val) => val!.isEmpty
                          ? 'The username you entered is not valid'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          widget.controller.username = val;
                        });
                      },
                      controller: widget.controller.controllerUsername,
                      isObscure: false,
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding.h,
                    ),
                    LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 14.w,
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
                            padding:   EdgeInsets.only(
                                top: AppTheme.cardPadding.h),
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
                      margin: EdgeInsets.only(top: AppTheme.cardPadding * 2),
                      child: Text(
                        L10n.of(context)!.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: AppTheme.cardPadding.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black60,
                          width: 2,
                        ),
                        borderRadius: AppTheme.cardRadiusCircular,
                      ),
                      child: SizedBox(
                        height: 0,
                        width: 65.w,
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
