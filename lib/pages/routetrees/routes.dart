import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount.dart';
import 'package:bitnet/pages/auth/getstartedscreen.dart';
import 'package:bitnet/pages/auth/ionloadingscreen.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:bitnet/pages/auth/pinverificationscreen.dart';
import 'package:bitnet/pages/auth/restore/chooserestorescreen.dart';
import 'package:bitnet/pages/auth/restore/did_and_pk/didandpkscreen.dart';
import 'package:bitnet/pages/auth/restore/other_device/otherdevicescreen.dart';
import 'package:bitnet/pages/auth/restore/social_recovery/info_social_recovery.dart';
import 'package:bitnet/pages/auth/restore/social_recovery/socialrecoveryscreen.dart';
import 'package:bitnet/pages/auth/restore/word_recovery/wordrecoveryscreen.dart';
import 'package:bitnet/pages/bottomnav.dart';
import 'package:bitnet/pages/create/createasset.dart';
import 'package:bitnet/pages/marketplace/CollectionScreen.dart';
import 'package:bitnet/pages/marketplace/NotificationScreen.dart';
import 'package:bitnet/pages/marketplace/NftProductScreen.dart';
import 'package:bitnet/pages/matrix/widgets/log_view.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:bitnet/pages/secondpages/analysisscreen.dart';
import 'package:bitnet/pages/secondpages/bitcoinscreen.dart';
import 'package:bitnet/pages/secondpages/fear_and_greed.dart';
import 'package:bitnet/pages/secondpages/hashrate/hashrate.dart';
import 'package:bitnet/pages/secondpages/keymetrics/keymetricsscreen.dart';
import 'package:bitnet/pages/secondpages/mempool/view/block_transactions.dart';
import 'package:bitnet/pages/secondpages/mempool/view/mempoolhome.dart';
import 'package:bitnet/pages/secondpages/mempool/view/unaccepted_block_transactions.dart';
import 'package:bitnet/pages/secondpages/newsscreen.dart';
import 'package:bitnet/pages/secondpages/transactionsscreen.dart';
import 'package:bitnet/pages/secondpages/whalebehaviour.dart';
import 'package:bitnet/pages/settings/currency/change_currency.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:bitnet/pages/wallet/actions/receive/receivescreen.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:bitnet/pages/wallet/cardinfo/btc_cardinfoscreen.dart';
import 'package:bitnet/pages/wallet/cardinfo/lightning_cardinfoscreen.dart';
import 'package:bitnet/pages/wallet/loop/loop.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:bitnet/pages/website/compliance/agbscreen.dart';
import 'package:bitnet/pages/website/compliance/impressumscreen.dart';
import 'package:bitnet/pages/website/contact/report/report.dart';
import 'package:bitnet/pages/website/contact/submitidea/submitidea.dart';
import 'package:bitnet/pages/website/product/aboutus/aboutus.dart';
import 'package:bitnet/pages/website/product/ourteam/ourteam.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:bitnet/components/loaders/loading_view.dart';
import 'package:bitnet/pages/profile/profile.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:bitnet/pages/settings/invite/invitation_page.dart';
import 'package:bitnet/pages/settings/security/security_page.dart';
import 'package:bitnet/pages/settings/settings_style/settings_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  final bool columnMode;

  AppRoutes(this.columnMode);

  List<RouteBase> get routes => [
        ...bottomnav_routes,
        ..._authRoutes,
        //if (columnMode) ..._tabletRoutes,
      ];

  //if currentUserUID cant be fetched nothing is used this might cause bugs but when this is the case you shouldnt even get to the VRouter anyways
  final currentUserUID = Auth().currentUser?.uid ?? '';

  // Define your routes like this
  List<dynamic> get bottomnav_routes => [
        GoRoute(
            path: '/loading',
            builder: (ctx, state) => const LoadingViewAppStart()),

        GoRoute(
            path: '/qrscanner',
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
          builder:
              _dynamicTransition == null ? (ctx, state) => ReceiveScreen() : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: ReceiveScreen(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),

        GoRoute(
            path: '/feed',
            builder: (ctx, state) => BottomNav(routerState: state),
            routes: [
              GoRoute(
                  path: kNftProductScreenRoute + "/:nft_id",
                  name: kNftProductScreenRoute,
                  builder: (ctx, state) => NftProductScreen()),
              GoRoute(
                  path: kNotificationScreenRoute,
                  builder: (ctx, state) => NotificationScreen()),
              GoRoute(
                  path: kCollectionScreenRoute + "/:collection_id",
                  name: kCollectionScreenRoute,
                  builder: (ctx, state) => CollectionScreen(
                        routerState: state,
                      ),
                  routes: [
                    GoRoute(
                        path: kNftProductScreenRoute + "/:nft_id",
                        name: '$kCollectionScreenRoute$kNftProductScreenRoute',
                        builder: (ctx, state) => NftProductScreen()),
                  ]),
            ]), //(path: '/feed', builder: (ctx,state) => FeedScreen()),
        GoRoute(
          path: '/create',
          builder: (ctx, state) =>
              //CreatePostScreen(currentUserUID: '', onCameraButtonPressed: () {  },)
              CreateAsset(),
        ),


        GoRoute(
          path: '/wallet',
          builder: (ctx, state) => Container(),
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
                    path: 'mempool',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const MempoolHome()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: const BlockTransactions(),
                        transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'hashrate',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const HashrateScreen()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: const BlockTransactions(),
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
                        child: const BlockTransactions(),
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
                        child: const BlockTransactions(),
                        transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'transactions',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => const LastTransactionsScreen()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: const BlockTransactions(),
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
                        child: const BlockTransactions(),
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
                        child: const BlockTransactions(),
                        transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                  GoRoute(
                    path: 'fearandgreed',
                    builder: _dynamicTransition == null
                        ? (ctx, state) => FearAndGreed()
                        : null,
                    pageBuilder: _dynamicTransition != null
                        ? (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: const BlockTransactions(),
                        transitionsBuilder: _dynamicTransition!)
                        : null,
                  ),
                ]),
            GoRoute(
              path: 'block_transactions',
              builder: _dynamicTransition == null
                  ? (ctx, state) => const BlockTransactions()
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const BlockTransactions(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),
            GoRoute(
              path: 'unaccepted_block_transactions',
              builder: _dynamicTransition == null
                  ? (ctx, state) => const UnacceptedBlockTransactions()
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const UnacceptedBlockTransactions(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),
            GoRoute(
              path: 'receive',
              builder:
                  _dynamicTransition == null ? (ctx, state) => ReceiveScreen() : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: ReceiveScreen(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),
            GoRoute(
              path: 'loop_screen',
              builder:
                  _dynamicTransition == null ? (ctx, state) => Loop() : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: Loop(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),
            GoRoute(
              path: 'send',
              builder: _dynamicTransition == null
                  ? (ctx, state) =>  Send(key: state.pageKey)
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const Send(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),
            GoRoute(
              path: 'lightningcard',
              builder: _dynamicTransition == null
                  ? (ctx, state) => const LightningCardInformationScreen()
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const BitcoinScreen(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),
            GoRoute(
              path: 'bitcoincard',
              builder: _dynamicTransition == null
                  ? (ctx, state) =>  BitcoinCardInformationScreen()
                  : null,
              pageBuilder: _dynamicTransition != null
                  ? (ctx, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const BitcoinScreen(),
                      transitionsBuilder: _dynamicTransition!)
                  : null,
            ),
          ],
        ),
        GoRoute(
            path: '/profile/:profileId',
            name: '/profile',
            builder: (ctx, state) => Profile(),
            routes: []),
        GoRoute(
          path: '/single_transaction',
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

  List<GoRoute> get _authRoutes => [
        GoRoute(
            path: '/', builder: (ctx, state) => const LoadingViewAppStart()),
        GoRoute(
            path: '/website',
            builder: (ctx, state) => WebsiteLandingPage(),
            routes: [
              GoRoute(
                path: 'report',
                builder: (ctx, state) => const Report(),
              ),
              GoRoute(
                path: 'aboutus',
                builder: (ctx, state) => const AboutUs(),
              ),
              GoRoute(
                path: 'ourteam',
                builder: (ctx, state) => const OurTeam(),
              ),
              GoRoute(path: 'agbs', builder: (ctx, state) => const AGBScreen()),
              GoRoute(
                  path: 'impressum',
                  builder: (ctx, state) => const ImpressumScreen()),
              GoRoute(
                  path: 'submitidea',
                  builder: (ctx, state) => const SubmitIdea()),
            ]),
        GoRoute(
          path: '/authhome',
          builder: (ctx, state) => GetStartedScreen(),
          routes: [
            GoRoute(
              path: 'pinverification',
              builder: (ctx, state) => const PinVerificationScreen(),
              routes: [
                GoRoute(
                  path: 'createaccount',
                  builder: (ctx, state) => CreateAccount(),
                ),
                GoRoute(
                  path: 'mnemonicgen',
                  builder: (ctx, state) => const MnemonicGen(),
                ),
              ],
            ),
            GoRoute(
              path: 'ionloading',
              builder: (ctx, state) => IONLoadingScreen(
                loadingText:
                    "Patience, please. We're validating your account on the blockchain...",
              ),
            ),
            GoRoute(
              path: 'login',
              builder: (ctx, state) => ChooseRestoreScreen(),
              routes: [
                GoRoute(
                  path: 'word_recovery',
                  builder: (ctx, state) => WordRecoveryScreen(),
                ),
                GoRoute(
                  path: 'device_recovery',
                  builder: (ctx, state) => OtherDeviceScreen(),
                ),
                GoRoute(
                  path: 'social_recovery',
                  builder: (ctx, state) => SocialRecoveryScreen(),
                  routes: [
                    GoRoute(
                      path: 'info_social_recovery',
                      builder: (ctx, state) => InfoSocialRecoveryScreen(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'did_recovery',
                  builder: (ctx, state) => DidAndPrivateKeyScreen(),
                ),
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
              ? (ctx, state) => ChangeLanguage()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: ChangeLanguage(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
        GoRoute(
          path: 'settings?tab=currency',
          builder: _dynamicTransition == null
              ? (ctx, state) => ChangeCurrency()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: ChangeCurrency(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
       
        GoRoute(
          path: 'settings?tab=style',
          builder: _dynamicTransition == null
              ? (ctx, state) => const SettingsStyle()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: SettingsStyle(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
       
        GoRoute(
          path: 'settings?tab=invite_friends',
          builder: _dynamicTransition == null
              ? (ctx, state) => InvitationSettingsPage()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: InvitationSettingsPage(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
        GoRoute(
          path: 'settings?tab=security_own',
          builder: _dynamicTransition == null
              ? (ctx, state) => SecuritySettingsPage()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: SecuritySettingsPage(),
                  transitionsBuilder: _dynamicTransition!)
              : null,
        ),
        GoRoute(
          path: 'settings?tab=logs',
          builder: _dynamicTransition == null
              ? (ctx, state) => const LogViewer()
              : null,
          pageBuilder: _dynamicTransition != null
              ? (ctx, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: LogViewer(),
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
