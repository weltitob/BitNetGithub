import 'package:bitnet/pages/marketplace/AboutScreen.dart';
import 'package:bitnet/pages/marketplace/ActivityScreen.dart';
import 'package:bitnet/pages/marketplace/CategoriesDetailScreen.dart';
import 'package:bitnet/pages/marketplace/CollectionScreen.dart';
import 'package:bitnet/pages/marketplace/FavouriteScreen.dart';
import 'package:bitnet/pages/marketplace/FilterScreen.dart';
import 'package:bitnet/pages/marketplace/HomeScreen.dart';
import 'package:bitnet/pages/marketplace/ListScreen.dart';
import 'package:bitnet/pages/marketplace/NotificationScreen.dart';
import 'package:bitnet/pages/marketplace/OwnerDetailScreen.dart';
import 'package:bitnet/pages/marketplace/SearchScreen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> allRoutes = {
  kInitialRoute: (BuildContext context) => const HomeScreen(),
  kMainScreenRoute: (BuildContext context) => const HomeScreen(),
  kNotificationScreenRoute: (BuildContext context) =>
      const NotificationScreen(),
  kListScreenRoute: (BuildContext context) => const ListScreen(),
  kFilterScreenRoute: (BuildContext context) => const FilterScreen(),
  kOwnerScreenRoute: (BuildContext context) => CollectionScreen(
        routerState: null,
        context: context,
      ),
  kSearchScreenRoute: (BuildContext context) => const SearchScreen(),
  kOwnerDetailScreenRoute: (BuildContext context) => const OwnerDetailScreen(),
  kActivityScreenRoute: (BuildContext context) => const ActivityScreen(),
  kFavouriteScreenRoute: (BuildContext context) => const FavouriteScreen(),
  kAboutScreenRoute: (BuildContext context) => const AboutScreen(),
};

const kInitialRoute = '/';
const kForgotPasswordScreenRoute = 'forgot_password_screen_route';
const kCreateNewAccountScreenRoute = 'create_new_account_screen_route';
const kLoginVerifyMobileNumberScreenRoute =
    'login_verify_mobile_number_screen_route';
const kLoginSetPasswordScreenRoute = 'login_set_password_screen_route';
const kSignupVerifyMobileNumberScreenRoute =
    'signup_verify_mobile_number_screen_route';
const kSignupSetPasswordScreenRoute = 'signup_set_password_screen_route';
const kMainScreenRoute = 'main_screen_route';
const kNotificationScreenRoute = 'notification_screen_route';
const kCategoriesDetailScreenRoute = 'categories_detail_screen_route';
const kListScreenRoute = 'list_screen_route';
const kFilterScreenRoute = 'filter_screen_route';

const kOwnerScreenRoute = 'owner_screen_route';
const kSearchScreenRoute = 'search_screen_route';
const kOwnerDetailScreenRoute = 'owner_detail_screen_route';
const kActivityScreenRoute = 'activity_screen_route';
const kProfileEditScreenRoute = 'profile_edit_screen_route';
const kFavouriteScreenRoute = 'favourite_screen_route';
const kAboutScreenRoute = 'about_screen_route';
const kCollectionScreenRoute = 'collection_screen_route';
const kWebViewScreenRoute = 'webview_screen_route';
