import 'package:bitnet/backbone/helper/matrix_helpers/other/custom_scroll_behaviour.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/loaders/empty_page.dart';
import 'package:bitnet/pages/routetrees/controllers/widget_tree_controller.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetTree extends StatelessWidget {
  static GlobalKey<NavigatorState>? routerKey = GlobalKey<NavigatorState>();

  static bool gotInitialLink = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);
    Get.put(WidgetTreeController());

    final controller = Get.find<WidgetTreeController>();

    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) => LayoutBuilder(
        builder: (context, constraints) {
          final isColumnMode =
              AppTheme.isColumnModeByWidth(constraints.maxWidth);
          if (isColumnMode != controller.columnMode!.value) {
            Logs().v('Set Column Mode = $isColumnMode');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              () {
                controller.initialUrl!.value = "/loading";
                controller.columnMode!.value = isColumnMode;
              };
            });
          }
          print("running");
          return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: false,
              splitScreenMode: false,
              builder: (_, child) {
                return MaterialApp.router(
                  routerConfig: AppRouter.router,
                  title: AppTheme.applicationName,
                  debugShowCheckedModeBanner: false,
                  themeMode: themeMode,
                  theme: AppTheme.customTheme(Brightness.light, primaryColor),
                  darkTheme:
                      AppTheme.customTheme(Brightness.dark, primaryColor),
                  scrollBehavior: CustomScrollBehavior(),
                  locale: provider.locale,
                  supportedLocales: L10n.supportedLocales,
                  localizationsDelegates: const [
                    L10n.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  builder: (context, child) => Obx(
                    () => (controller.isLoadingClients.value)
                        ? EmptyPage(
                            loading: true, text: "Clients still loading...")
                        : Matrix(
                            context: context,
                            clients: controller.clients,
                            child: child,
                          ),
                  ),
                );
              });
        },
      ),
    );
  }

  int? primaryColor;
  SharedPreferences? preferences;

  // Future getColor() async {
  //   preferences = await SharedPreferences.getInstance();
  //   var data = await settingsCollection.doc(profileId).get();
  //   primaryColor = data['primary_color'];
  //   setState(() {});
  //   return primaryColor.toString();
  // }
  //
  // ThemeMode? theme_mode;
  //
  // Future getBrightness() async {
  //   preferences = await SharedPreferences.getInstance();
  //   String theme = preferences!.getString("theme_mode") ?? '';
  //   print('theeme');
  //   print(theme);
  //   setState(() {});
  //   return theme_mode.toString();
  // }
}
