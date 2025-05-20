import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/components/loaders/loading_view.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bitnet/pages/auth/createaccount/createaccount.dart';

import 'package:bitnet/pages/auth/getstartedscreen.dart';

import 'package:bitnet/pages/auth/ionloadingscreen.dart';

import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';

import 'package:bitnet/pages/auth/persona/personascreen.dart';

import 'package:bitnet/pages/auth/pinverificationscreen.dart';

import 'package:bitnet/pages/auth/restore/chooserestorescreen.dart';

import 'package:bitnet/pages/auth/restore/email_recovery/email_recovery_screen.dart';

import 'package:bitnet/pages/auth/restore/other_device/otherdevicescreen.dart';

import 'package:bitnet/pages/auth/restore/social_recovery/info_social_recovery.dart';

import 'package:bitnet/pages/auth/restore/social_recovery/socialrecoveryscreen.dart';

import 'package:bitnet/pages/auth/restore/word_recovery/wordrecoveryscreen.dart';

import 'package:bitnet/pages/bottomnav.dart';

import 'package:bitnet/pages/comingsoonpage.dart';

import 'package:bitnet/pages/create/createasset.dart';

import 'package:bitnet/pages/create/finalizescreen.dart';
import 'package:bitnet/pages/feed/webview_page.dart';

import 'package:bitnet/pages/marketplace/CollectionScreen.dart';

import 'package:bitnet/pages/marketplace/ListScreen.dart';

import 'package:bitnet/pages/marketplace/NftProductScreen.dart';

import 'package:bitnet/pages/marketplace/NotificationScreen.dart';

import 'package:bitnet/pages/other_profile/other_profile.dart';

import 'package:bitnet/pages/profile/profile.dart';

import 'package:bitnet/pages/qrscanner/qrscanner.dart';

import 'package:bitnet/pages/report/report_mobile_controller.dart';

import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';

import 'package:bitnet/pages/secondpages/agbs_and_impressum.dart';

import 'package:bitnet/pages/secondpages/analysisscreen.dart';

import 'package:bitnet/pages/secondpages/bitcoinscreen.dart';

import 'package:bitnet/pages/secondpages/fear_and_greed.dart';

import 'package:bitnet/pages/secondpages/hashrate/hashrate.dart';

import 'package:bitnet/pages/secondpages/keymetrics/keymetricsscreen.dart';

import 'package:bitnet/pages/secondpages/mempool/view/block_transactions.dart';

import 'package:bitnet/pages/secondpages/newsscreen.dart';

import 'package:bitnet/pages/secondpages/transactionsscreen.dart';

import 'package:bitnet/pages/secondpages/whalebehaviour.dart';

import 'package:bitnet/pages/settings/bottomsheet/settings.dart';

import 'package:bitnet/pages/settings/currency/change_currency.dart';

import 'package:bitnet/pages/settings/invite/invitation_page.dart';

import 'package:bitnet/pages/settings/language/change_language.dart';

import 'package:bitnet/pages/settings/security/security_page.dart';

import 'package:bitnet/pages/settings/settings_style/settings_style_view.dart';

import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';

import 'package:bitnet/pages/wallet/actions/receive/receivescreen.dart';

import 'package:bitnet/pages/wallet/actions/send/send.dart';

import 'package:bitnet/pages/wallet/btc_address_screen.dart';

import 'package:bitnet/pages/wallet/cardinfo/fiat_card_info_screen.dart';

import 'package:bitnet/pages/wallet/buy/buy_screen.dart';
import 'package:bitnet/pages/wallet/buy/payment_methods_screen.dart';
import 'package:bitnet/pages/wallet/buy/providers_screen.dart';
import 'package:bitnet/pages/wallet/loop/loop.dart';


import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class AppRoutes {
  final bool columnMode;

  AppRoutes(this.columnMode);

  // Safe redirect for web to prevent Firebase-related errors
  String? webSafeRedirect(BuildContext context, GoRouterState state) {
    // No longer need to redirect to website
    return null;
  }

  List<RouteBase> get routes => [
        ...bottomnav_routes,

        ..._authRoutes,

        //if (columnMode) ..._tabletRoutes,
      ];

  //if currentUserUID cant be fetched nothing is used this might cause bugs but when this is the case you shouldnt even get to the VRouter anyways

  // Safely get current user ID with error handling for web
  String get currentUserUID {
    try {
      return Auth().currentUser?.uid ?? '';
    } catch (e) {
      print('Error accessing currentUser (safe to ignore in web preview): $e');
      return '';
    }
  }

  // Define your routes like this

  List<dynamic> get bottomnav_routes => [
        // Loading route with fallback for web
        GoRoute(
            path: '/loading',
            builder: (ctx, state) {
              if (kIsWeb) {
                // For web, directly return a simple loading screen that will redirect to website
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 24),
                        Text('Loading BitNet...'),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () => GoRouter.of(ctx).go('/website'),
                          child: Text('Go to website'),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                // Normal LoadingViewAppStart for mobile
                return const LoadingViewAppStart();
              }
            }),


        GoRoute(
          path: '/report',
          redirect: webRedirect,
          builder: (ctx, state) => const ReportMobile(),
        ),

        GoRoute(
          path: '/showprofile/:profile_id',
          builder: _dynamicTransition == null
              ? (ctx, state) => OtherProfile(
                  profileId: state.pathParameters['profile_id'] ?? '')
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: OtherProfile(
                      profileId: state.pathParameters['profile_id'] ?? ''),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),

        GoRoute(
            path: '/qrscanner',
            redirect: webRedirect,
            builder: _dynamicTransition == null
                ? (ctx, state) => const QrScanner()
                : null,
            pageBuilder: _dynamicTransition != null
                ? (ctx, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: const QrScanner(),
                    transitionsBuilder: _dynamicTransition!)
                : null),

        GoRoute(
          path: '/error',
          redirect: webRedirect,
          builder: _dynamicTransition == null
              ? (ctx, state) => const ReceiveScreen()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const ReceiveScreen(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),

        GoRoute(
          path: '/asset_screen',
          redirect: webRedirect,
          builder: (ctx, state) {
            return NftProductScreen(routerState: state);
          },
        ),

        GoRoute(
            path: '/feed',
            builder: (ctx, state) => BottomNav(routerState: state),
            redirect: webRedirect,
            routes: [
              GoRoute(
                  path: kListScreenRoute,
                  name: kListScreenRoute,
                  builder: (ctx, state) => const ListScreen()),
              GoRoute(
                  path: kNotificationScreenRoute,
                  builder: (ctx, state) => const NotificationScreen()),
              GoRoute(
                path: kCollectionScreenRoute + "/:collection_id",
                name: kCollectionScreenRoute,
                builder: (ctx, state) => CollectionScreen(
                  routerState: state,
                  context: ctx,
                ),
              ),
              GoRoute(
                  path: kAppPageRoute,
                  builder: (context, state) => AppTab(routerState: state)),
              GoRoute(
                  name: kMyAppsPageRoute,
                  path: kMyAppsPageRoute,
                  builder: (ctx, state) => MyAppsPage(
                        routerState: state,
                      ),
                  routes: [
                    GoRoute(
                        path: kAppPageRoute,
                        builder: (context, state) => AppTab(routerState: state))
                  ]),
              GoRoute(
                  path: kWebViewScreenRoute + "/:url/:name",
                  name: kWebViewScreenRoute,
                  builder: (ctx, state) => WebViewPage(
                        routerState: state,
                      ))
            ]), //(path: '/feed', builder: (ctx,state) => FeedScreen()),

        GoRoute(
            path: "/agbs",
            redirect: webRedirect,
            builder: (ctx, state) =>
                AgbsAndImpressumScreen(key: state.pageKey)),

        GoRoute(
            path: "/comingsoon",
            redirect: webRedirect,
            builder: (ctx, state) => ComingSoonPage(key: state.pageKey)),

        GoRoute(
          path: '/wallet',
          builder: (ctx, state) => Container(),
          redirect: webRedirect,
          routes: [
            GoRoute(
                path: 'bitcoinscreen',
                builder: _dynamicTransition == null
                    ? (ctx, state) => const BitcoinScreen()
                    : null,
                pageBuilder: _dynamicTransition != null
                    ? (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: const BitcoinScreen(),
                        transitionsBuilder: _dynamicTransition!)
                    : null,
                routes: [
                  GoRoute(
                    path: 'hashrate',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const HashrateScreen()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: const BlockTransactions(isConfirmed: true),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'whales',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const WhaleBehaviour()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: const BlockTransactions(isConfirmed: true),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'keymetrics',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const KeyMetricsScreen()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: const BlockTransactions(isConfirmed: true),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'transactions',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const LastTransactions(
                              ownedTransactions: [],
                            )
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: const BlockTransactions(isConfirmed: true),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'analysts',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => AnalysisScreen()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: const BlockTransactions(isConfirmed: true),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'news',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => NewsScreen()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: const BlockTransactions(isConfirmed: true),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'fearandgreed',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const FearAndGreed()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child: const BlockTransactions(isConfirmed: true),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                ]),

            GoRoute(
              path: 'block_transactions',
              redirect: webRedirect,
              builder: _dynamicTransition == null
                  ? (ctx, state) => const BlockTransactions(isConfirmed: true)
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const BlockTransactions(isConfirmed: true),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),

            GoRoute(
              path: 'unaccepted_block_transactions',
              redirect: webRedirect,
              builder: _dynamicTransition == null
                  ? (ctx, state) => const BlockTransactions(isConfirmed: false)
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const BlockTransactions(isConfirmed: false),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),

            // GoRoute(

            //   name: 'finalize',

            //   path: 'finalize/:batch_key',

            //   builder: (ctx, state) {

            //     final batchKey = state.pathParameters['batch_key'];

            //     print('Batch key in route: $batchKey');

            //     return BatchScreen(routerState: state);

            //   },

            // ),

            GoRoute(
              name: 'receive',

              path: 'receive/:network',

              redirect: webRedirect,

              builder: (ctx, state) {
                final batchKey = state.pathParameters['network'];

                print('network: $batchKey');

                return ReceiveScreen(routerState: state);
              },

              // pageBuilder: _dynamicTransition != null

              //     ? (ctx, state) => CustomTransitionPage(

              //         key: state.pageKey,

              //         child: ReceiveScreen(),

              //         transitionsBuilder: _dynamicTransition!)

              //     : null,
            ),

            GoRoute(
              path: 'loop_screen',
              builder: _dynamicTransition == null
                  ? (ctx, state) => const Loop()
                  : null,
              redirect: webRedirect,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const Loop(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),

            // Buy Bitcoin routes
            GoRoute(
              path: 'buy',
              builder: (ctx, state) => const BuyScreen(),
              redirect: webRedirect,
              routes: [
                GoRoute(
                  path: 'payment_methods',
                  builder: (ctx, state) => const PaymentMethodsScreen(),
                  redirect: webRedirect,
                ),
                GoRoute(
                  path: 'providers',
                  builder: (ctx, state) => const ProvidersScreen(),
                  redirect: webRedirect,
                ),
              ],
            ),

            GoRoute(
              path: 'send',
              redirect: webRedirect,
              builder: _dynamicTransition == null
                  ? (ctx, state) => Send(key: state.pageKey)
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const Send(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),

            GoRoute(
              path: 'send/:code',
              redirect: webRedirect,
              builder: _dynamicTransition == null
                  ? (ctx, state) => Send(
                      key: state.pageKey,
                      parameters: state.pathParameters['code'],
                      state: state)
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: Send(
                          key: state.pageKey,
                          parameters: state.pathParameters['code'],
                          state: state),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),

            GoRoute(
              path: 'fiatcard',
              redirect: webRedirect,
              builder: _dynamicTransition == null
                  ? (ctx, state) => const FiatCardInfoScreen()
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const FiatCardInfoScreen(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),

            GoRoute(
                path: 'bitcoincard',
                redirect: webRedirect,
                builder: _dynamicTransition == null
                    ? (ctx, state) => const BitcoinScreen()
                    : null,
                pageBuilder: _dynamicTransition != null
                    ? (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: const BitcoinScreen(),
                        transitionsBuilder: _dynamicTransition!)
                    : null,
                routes: [
                  GoRoute(
                    path: 'btcaddressinfo/:address',
                    redirect: webRedirect,
                    builder: _dynamicTransition == null
                        ? (ctx, state) =>
                            BitcoinAddressInformationScreen(state: state)
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                            key: state.pageKey,
                            child:
                                BitcoinAddressInformationScreen(state: state),
                            transitionsBuilder: _dynamicTransition!)
                        : null,
                  )
                ]),
          ],
        ),

        GoRoute(
            path: '/profile/:profileId',
            name: '/profile',
            redirect: webRedirect,
            builder: (ctx, state) => const Profile(),
            routes: []),

        GoRoute(
          path: '/create',
          builder: (ctx, state) => const CreateAsset(),
          routes: [
            GoRoute(
              name: 'finalize',
              path: 'finalize/:batch_key',
              builder: (ctx, state) {
                final batchKey = state.pathParameters['batch_key'];

                print('Batch key in route: $batchKey');

                return BatchScreen(routerState: state);
              },
            ),
          ],
        ),

        GoRoute(
          path: '/single_transaction',
          redirect: webRedirect,
          builder: _dynamicTransition == null
              ? (ctx, state) => const SingleTransactionScreen()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const SingleTransactionScreen(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),

        GoRoute(
          path: '/settings',
          redirect: webRedirect,
          builder: (ctx, state) => Settings(),
          routes: _settingsRoutes,
        ),

        // ShellRoute(

        //   builder: (ctx, state, child) {

        //     return BottomNav(routerState: state);

        //   },

        //   routes: [

        //     // GoRoute(

        //     //   path: '',

        //     //   redirect: (context, state) => '/feed', // '/feed'

        //     // ),

        //

        //   ],

        // ),
      ];

  FutureOr<String?> webRedirect(ctx, state) {
    if (kIsWeb && Auth().currentUser == null) {
      return '/';
    }

    return null;
  }

  List<GoRoute> get _authRoutes => [
        GoRoute(
          path: '/',
          builder: (ctx, state) => const LoadingViewAppStart(),
        ),
        GoRoute(
          path: '/authhome',
          builder: (ctx, state) => const GetStartedScreen(),
          routes: [
            GoRoute(
              path: 'pinverification',
              builder: (ctx, state) => const PinVerificationScreen(),
              routes: [
                GoRoute(
                  path: 'createaccount',
                  builder: (ctx, state) => const CreateAccount(),
                ),
                GoRoute(
                  path: 'mnemonicgen',
                  builder: (ctx, state) => const MnemonicGen(),
                ),
                GoRoute(
                  path: 'persona',
                  builder: (ctx, state) => const PersonaScreen(),
                ),
                GoRoute(
                  path: 'reg_loading',
                  builder: (ctx, state) => const AuthLoadingScreen(
                    loadingText:
                        "Patience, please. We're creating your account on the blockchain...",
                  ),
                ),
              ],
            ),

            GoRoute(
              path: 'log_loading',
              builder: (ctx, state) => const AuthLoadingScreen(
                loadingText:
                    "Patience, please. We're validating your account on the blockchain...",
              ),
            ),

            GoRoute(
              path: 'login',
              builder: (ctx, state) => const ChooseRestoreScreen(),
              routes: [
                GoRoute(
                  path: 'word_recovery',
                  builder: (ctx, state) => WordRecoveryScreen(),
                ),
                GoRoute(
                  path: 'device_recovery',
                  builder: (ctx, state) => const OtherDeviceScreen(),
                ),
                GoRoute(
                  path: 'social_recovery',
                  builder: (ctx, state) => const SocialRecoveryScreen(),
                  routes: [
                    GoRoute(
                      path: 'info_social_recovery',
                      builder: (ctx, state) => const InfoSocialRecoveryScreen(),
                    ),
                  ],
                ),
                GoRoute(
                    path: 'email_recovery',
                    builder: (ctx, state) => const EmailRecoveryScreen())
              ],
            ),

            // GoRoute(

            //   path: 'logs',

            //   builder: (ctx,state) => const LogViewer(),

            //   pageBuilder:_dynamicTransition != null ? (ctx,state) => CustomTransitionPage(key: state.pageKey ,child: , transitionsBuilder: _dynamicTransition!) : null,

            // ),
          ],
        ),
      ];

  List<GoRoute> get _settingsRoutes => [
        GoRoute(
          path: 'settings?tab=language',
          builder: _dynamicTransition == null
              ? (ctx, state) => const ChangeLanguage()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const ChangeLanguage(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
        GoRoute(
          path: 'settings?tab=currency',
          builder: _dynamicTransition == null
              ? (ctx, state) => const ChangeCurrency()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const ChangeCurrency(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
        GoRoute(
          path: 'settings?tab=style',
          builder: _dynamicTransition == null
              ? (ctx, state) => const SettingsStyleView()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const SettingsStyleView(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
        GoRoute(
          path: 'settings?tab=invite_friends',
          builder: _dynamicTransition == null
              ? (ctx, state) => const InvitationSettingsPage()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const InvitationSettingsPage(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
        GoRoute(
          path: 'settings?tab=security_own',
          builder: _dynamicTransition == null
              ? (ctx, state) => const SecuritySettingsPage()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const SecuritySettingsPage(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
      ];

  FadeTransition Function(
          BuildContext, Animation<double>, Animation<double>, Widget)?
      get _dynamicTransition => columnMode ? _fadeTransition : null;

  FadeTransition _fadeTransition(
    ctx,
    animation1,
    _,
    child,
  ) =>
      FadeTransition(opacity: animation1, child: child);
}

/**




 *




 * => /loading




             => /qrscanner




             => /error




             => /feed




             =>   /feed/nft_product_screen_route/:nft_id




             =>   /feed/notification_screen_route




             =>   /feed/collection_screen_route/:collection_id




             =>     /feed/collection_screen_route/:collection_id/nft_product_screen_route/:nft_id




             => /create




             => /wallet




             =>   /wallet/bitcoinscreen




             =>   /wallet/block_transactions




             =>   /wallet/unaccepted_block_transactions




             =>   /wallet/receive




             =>   /wallet/loop_screen




             =>   /wallet/send




             => /profile/:profileId




             => /single_transaction




             => /rooms




             => /rooms/create




             =>   /rooms/create/chat




             =>   /rooms/create/group




             =>   /rooms/create/space




             => /rooms/spaces/:roomid




             =>   /rooms/spaces/:roomid/permissions




             =>   /rooms/spaces/:roomid/widgets




             =>   /rooms/spaces/:roomid/invite




             =>   /rooms/spaces/:roomid/multiple_emotes




             =>   /rooms/spaces/:roomid/emotes




             =>   /rooms/spaces/:roomid/emotes/:state_key




             => /rooms/:roomid




             =>   /rooms/:roomid/encryption




             =>   /rooms/:roomid/invite




             =>   /rooms/:roomid/details




             =>     /rooms/:roomid/details/permissions




             =>     /rooms/:roomid/details/widgets




             =>     /rooms/:roomid/details/invite




             =>     /rooms/:roomid/details/multiple_emotes




             =>     /rooms/:roomid/details/emotes




             =>     /rooms/:roomid/details/emotes/:state_key




             => /rooms/settings




             =>   /rooms/settings/settings?tab=language




             =>   /rooms/settings/settings?tab=currency




             =>   /rooms/settings/settings?tab=notifications




             =>   /rooms/settings/settings?tab=style




             =>   /rooms/settings/settings?tab=devices




             =>   /rooms/settings/settings?tab=invite_friends




             =>   /rooms/settings/settings?tab=security_own




             =>   /rooms/settings/settings?tab=chat




             =>     /rooms/settings/settings?tab=chat/settings?tab=chat&subtab=emotes




             =>   /rooms/settings/settings?tab=security




             =>     /rooms/settings/settings?tab=security/settings?tab=security&subtab=ignorelist




             =>     /rooms/settings/settings?tab=security/settings?tab=security&subtab=3pid




             =>   /rooms/settings/settings?tab=logs




             => /rooms/archive




             =>   /rooms/archive/:roomid




             => /




             => /website




             =>   /website/report




             =>   /website/aboutus




             =>   /website/ourteam




             =>   /website/agbs




             =>   /website/impressum




             =>   /website/submitidea




             => /authhome




             =>   /authhome/pinverification




             =>     /authhome/pinverification/createaccount




             =>     /authhome/pinverification/mnemonicgen




             =>   /authhome/ionloading




             =>   /authhome/login




             =>     /authhome/login/word_recovery




             =>     /authhome/login/device_recovery




             =>     /authhome/login/social_recovery




             =>       /authhome/login/social_recovery/info_social_recovery




             =>     /authhome/login/did_recovery




             =>   /authhome/connect




             =>     /authhome/connect/signup




           known full paths for route names:




             nft_product_screen_route => /feed/nft_product_screen_route/:nft_id




             collection_screen_route/nft_product_screen_route => /feed/collection_screen_route/:collection_id/nft_product_screen_route/:nft_id




             /profile => /profile/:profileId




             /rooms/spaces => /rooms/spaces/:roomid




             emotes => /rooms/spaces/:roomid/emotes/:state_key




             rooms => /rooms/:roomid




             emotes2 => /rooms/:roomid/details/emotes/:state_key




             archive => /rooms/archive/:roomid




 */
