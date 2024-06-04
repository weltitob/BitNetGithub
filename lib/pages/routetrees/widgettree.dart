import 'package:bitnet/backbone/helper/matrix_helpers/other/custom_scroll_behaviour.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/intl/generated/l10n.dart' as intl;
import 'package:bitnet/pages/routetrees/controllers/widget_tree_controller.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetTree extends StatelessWidget {
  static GlobalKey<NavigatorState>? routerKey = GlobalKey<NavigatorState>();

  static bool gotInitialLink = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);
    LoggerService logger = Get.find();
    Get.put(WidgetTreeController());

    final controller = Get.find<WidgetTreeController>();

    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) => LayoutBuilder(
        builder: (context, constraints) {
          final isColumnMode =
              AppTheme.isColumnModeByWidth(constraints.maxWidth);
          if (isColumnMode != controller.columnMode!.value) {
            logger.i('Set Column Mode = $isColumnMode');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              () {
                controller.initialUrl!.value = "/loading";
                controller.columnMode!.value = isColumnMode;
              };
            });
          }
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
                  darkTheme: AppTheme.customTheme(Brightness.dark, primaryColor),
                  scrollBehavior: CustomScrollBehavior(),
                  locale: provider.locale,
                  supportedLocales: L10n.supportedLocales,
                  localizationsDelegates:  [
                    intl.L10n.delegate,
                    L10n.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  builder: (context, child) =>  Matrix(
                            context: context,
                            child: child,
                          ),
                  
                );
              });
        },
      ),
    );
  }

  int? primaryColor;
  SharedPreferences? preferences;
 
}
