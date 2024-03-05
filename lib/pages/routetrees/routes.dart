import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/pages/auth/getstartedscreen.dart';
import 'package:bitnet/pages/auth/ionloadingscreen.dart';
import 'package:bitnet/pages/auth/old_matrix/connect/connect_page.dart';
import 'package:bitnet/pages/auth/pinverificationscreen.dart';
import 'package:bitnet/pages/auth/restore/chooserestorescreen.dart';
import 'package:bitnet/pages/auth/restore/did_and_pk/didandpkscreen.dart';
import 'package:bitnet/pages/auth/restore/other_device/otherdevicescreen.dart';
import 'package:bitnet/pages/auth/restore/social_recovery/info_social_recovery.dart';
import 'package:bitnet/pages/auth/restore/social_recovery/socialrecoveryscreen.dart';
import 'package:bitnet/pages/auth/restore/word_recovery/wordrecoveryscreen.dart';
import 'package:bitnet/pages/bottomnav.dart';
import 'package:bitnet/pages/chat_list/chat_details/chat_details.dart';
import 'package:bitnet/pages/chat_list/chat_encryption_settings/chat_encryption_settings.dart';
import 'package:bitnet/pages/chat_list/chat_list.dart';
import 'package:bitnet/pages/chat_list/chat_matrixwidgets_settings/chat_matrixwidgets.dart';
import 'package:bitnet/pages/chat_list/chat_permissions_settings/chat_permissions_settings.dart';
import 'package:bitnet/pages/chat_list/createnew/createnewscreen.dart';
import 'package:bitnet/pages/create/createscreen.dart';
import 'package:bitnet/pages/feed/feedscreen.dart';
import 'package:bitnet/pages/marketplace/CollectionScreen.dart';
import 'package:bitnet/pages/marketplace/NotificationScreen.dart';
import 'package:bitnet/pages/marketplace/NftProductScreen.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:bitnet/pages/secondpages/bitcoinscreen.dart';
import 'package:bitnet/pages/secondpages/mempool/view/block_transactions.dart';
import 'package:bitnet/pages/secondpages/mempool/view/unaccepted_block_transactions.dart';
import 'package:bitnet/pages/settings/archive/archive.dart';
import 'package:bitnet/pages/settings/currency/change_currency.dart';
import 'package:bitnet/pages/settings/device_settings/device_settings.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:bitnet/pages/wallet/actions/receive/receive.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:bitnet/pages/wallet/loop_screen.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:bitnet/pages/website/compliance/agbscreen.dart';
import 'package:bitnet/pages/website/compliance/impressumscreen.dart';
import 'package:bitnet/pages/website/contact/report/report.dart';
import 'package:bitnet/pages/website/contact/submitidea/submitidea.dart';
import 'package:bitnet/pages/website/product/aboutus/aboutus.dart';
import 'package:bitnet/pages/website/product/ourteam/ourteam.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:bitnet/pages/chat_list/chat/chat.dart';
import 'package:bitnet/pages/matrix/pages/invitation_selection/invitation_selection.dart';
import 'package:bitnet/components/loaders/loading_view.dart';
import 'package:bitnet/pages/matrix/widgets/log_view.dart';
import 'package:bitnet/pages/profile/profile.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:bitnet/pages/settings/invite/invitation_page.dart';
import 'package:bitnet/pages/settings/security/security_page.dart';
import 'package:bitnet/pages/settings/security/settings_security/settings_security.dart';
import 'package:bitnet/pages/settings/settings_3pid/settings_3pid.dart';
import 'package:bitnet/pages/settings/settings_chat/settings_chat.dart';
import 'package:bitnet/pages/settings/settings_emotes/settings_emotes.dart';
import 'package:bitnet/pages/settings/settings_ignore_list/settings_ignore_list.dart';
import 'package:bitnet/pages/settings/settings_multiple_emotes/settings_multiple_emotes.dart';
import 'package:bitnet/pages/settings/settings_notifications/settings_notifications.dart';
import 'package:bitnet/pages/settings/settings_style/settings_style.dart';
import 'package:flutter/material.dart';

import 'package:vrouter/vrouter.dart';

class AppRoutes {
  final bool columnMode;

  AppRoutes(this.columnMode);

  List<VRouteElement> get routes => [
        ...bottomnav_routes,
        ..._authRoutes,
        //if (columnMode) ..._tabletRoutes,
      ];

  //if currentUserUID cant be fetched nothing is used this might cause bugs but when this is the case you shouldnt even get to the VRouter anyways
  final currentUserUID = Auth().currentUser?.uid ?? '';

  // Define your routes like this
  List<VRouteElement> get bottomnav_routes => [
        VWidget(path: '/', widget: const LoadingViewAppStart()),

    VNester(
          path: '/home',
          widgetBuilder: (child) {
            return BottomNav(child: child);
          },
          nestedRoutes: [
            VRouteRedirector(
              path: '',
              redirectTo: '/feed', // '/feed'
            ),
            VWidget(
                path: '/qrscanner',
                widget: const QrScanner(),
                buildTransition: _dynamicTransition),
            VWidget(
              path: '/error',
              widget: Receive(),
              buildTransition: _dynamicTransition,
            ),
            VWidget(path: '/feed', widget: FeedScreen(), stackedRoutes: [
              VWidget(
                  path: kNftProductScreenRoute + "/:nft_id",
                  widget: NftProductScreen()),
              VWidget(
                  path: kNotificationScreenRoute, widget: NotificationScreen()),
              VWidget(
                  path: kCollectionScreenRoute + "/:collection_id",
                  widget: CollectionScreen(),
                  stackedRoutes: [
                    VWidget(
                        path: kNftProductScreenRoute + "/:nft_id",
                        widget: NftProductScreen()),
                  ]),
            ]), //(path: '/feed', widget: FeedScreen()),
            VWidget(
                path: '/create',
                widget:
                    //CreatePostScreen(currentUserUID: '', onCameraButtonPressed: () {  },)
                    CreatePage(
                  currentUserUID: currentUserUID,
                )),
            VWidget(
              path: '/wallet',
              widget: Wallet(),
              stackedRoutes: [
                VWidget(
                  path: '/wallet/bitcoinscreen',
                  widget: const BitcoinScreen(),
                  buildTransition: _fadeTransition,
                ),
                VWidget(
                  path: '/wallet/block_transactions',
                  widget: const BlockTransactions(),
                  buildTransition: _fadeTransition,
                ),
                VWidget(
                  path: '/wallet/unaccepted_block_transactions',
                  widget: const UnacceptedBlockTransactions(),
                  buildTransition: _fadeTransition,
                ),
                VWidget(
                  path: '/wallet/receive',
                  widget: Receive(),
                  buildTransition: _fadeTransition,
                ),
                VWidget(
                  path: '/wallet/loop_screen',
                  widget: LoopScreen(),
                  buildTransition: _fadeTransition,
                ),
                // VWidget(
                //   path: '/wallet/send_choose_receiver',
                //   widget: const SearchReceiver(controller: null,),
                //   buildTransition: _fadeTransition,
                // ),
                VWidget(
                  path: '/wallet/send',
                  widget: const Send(),
                  buildTransition: _fadeTransition,
                ),
                VWidget(
                  path: '/wallet/loop',
                  widget: const Send(),
                  buildTransition: _fadeTransition,
                ),
              ],
            ),
            VWidget(
                path: '/profile/:profileId',
                widget: Profile(),
                stackedRoutes: []),
            VWidget(
              path: '/single_transaction',
              widget: const SingleTransactionScreen(),
              buildTransition: _fadeTransition,
            ),
            VWidget(
              path: '/rooms',
              widget: const ChatList(),
            ),
          ],
        ),

        // Chat details and other chat-related routes without BottomNav
        VWidget(
          path: '/rooms/create',
          widget: const CreateNewScreen(
            initialIndex: 0,
          ),
          buildTransition: _fadeTransition,
          stackedRoutes: _chatCreateRoutes,
        ),
        VWidget(
          path: '/rooms/spaces/:roomid',
          widget: const ChatDetails(),
          stackedRoutes: _chatDetailsRoutes,
        ),
        VWidget(
          path: '/rooms/:roomid',
          widget: const ChatPage(),
          stackedRoutes: [
            VWidget(
              path: 'encryption',
              widget: const ChatEncryptionSettings(),
            ),
            VWidget(
              path: 'invite',
              widget: const InvitationSelection(),
            ),
            VWidget(
              path: 'details',
              widget: const ChatDetails(),
              stackedRoutes: _chatDetailsRoutes,
            ),
          ],
        ),
        VWidget(
          path: '/rooms/settings',
          widget: const Settings(),
          stackedRoutes: _settingsRoutes,
        ),
        VWidget(
          path: '/rooms/archive',
          widget: const Archive(),
          stackedRoutes: [
            VWidget(
              path: ':roomid',
              widget: const ChatPage(),
              buildTransition: _dynamicTransition,
            ),
          ],
        ),
      ];
  //
  // List<VRouteElement> get _tabletRoutes => [
  //       VNester(
  //         path: '/rooms',
  //         widgetBuilder: (child) => TwoColumnLayout(
  //           mainView: const ChatList(),
  //           sideView: child,
  //         ),
  //         buildTransition: _fadeTransition,
  //         nestedRoutes: [
  //           VWidget(
  //             path: '',
  //             widget: const EmptyPage(),
  //             buildTransition: _fadeTransition,
  //             stackedRoutes: [
  //               VWidget(
  //                 path: '/spaces/:roomid',
  //                 widget: const ChatDetails(),
  //                 buildTransition: _fadeTransition,
  //                 stackedRoutes: _chatDetailsRoutes,
  //               ),
  //               VNester(
  //                 path: ':roomid',
  //                 widgetBuilder: (child) => SideViewLayout(
  //                   mainView: const ChatPage(),
  //                   sideView: child,
  //                 ),
  //                 buildTransition: _fadeTransition,
  //                 nestedRoutes: [
  //                   VWidget(
  //                     path: '',
  //                     widget: const ChatPage(),
  //                     buildTransition: _fadeTransition,
  //                   ),
  //                   VWidget(
  //                     path: 'encryption',
  //                     widget: const ChatEncryptionSettings(),
  //                     buildTransition: _fadeTransition,
  //                   ),
  //                   VWidget(
  //                     path: 'details',
  //                     widget: const ChatDetails(),
  //                     buildTransition: _fadeTransition,
  //                     stackedRoutes: _chatDetailsRoutes,
  //                   ),
  //                   VWidget(
  //                     path: 'invite',
  //                     widget: const InvitationSelection(),
  //                     buildTransition: _fadeTransition,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       VWidget(
  //         path: '/rooms',
  //         widget: const TwoColumnLayout(
  //           mainView: ChatList(),
  //           sideView: EmptyPage(),
  //         ),
  //         buildTransition: _fadeTransition,
  //         stackedRoutes: [
  //           VNester(
  //             path: '/settings',
  //             widgetBuilder: (child) => TwoColumnLayout(
  //               mainView: const Settings(),
  //               sideView: child,
  //             ),
  //             buildTransition: _dynamicTransition,
  //             nestedRoutes: [
  //               VWidget(
  //                 path: '',
  //                 widget: const EmptyPage(),
  //                 buildTransition: _dynamicTransition,
  //                 stackedRoutes: _settingsRoutes,
  //               ),
  //             ],
  //           ),
  //           VNester(
  //             path: '/archive',
  //             widgetBuilder: (child) => TwoColumnLayout(
  //               mainView: const Archive(),
  //               sideView: child,
  //             ),
  //             buildTransition: _fadeTransition,
  //             nestedRoutes: [
  //               VWidget(
  //                 path: '',
  //                 widget: const EmptyPage(),
  //                 buildTransition: _dynamicTransition,
  //               ),
  //               VWidget(
  //                 path: ':roomid',
  //                 widget: const ChatPage(),
  //                 buildTransition: _dynamicTransition,
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ];

  List<VRouteElement> get _authRoutes => [
        VWidget(path: '/', widget: const LoadingViewAppStart()),
        VWidget(path: '/website', widget: WebsiteLandingPage(), stackedRoutes: [
          VWidget(
            path: '/report',
            widget: const Report(),
          ),
          VWidget(
            path: '/aboutus',
            widget: const AboutUs(),
          ),
          VWidget(
            path: '/ourteam',
            widget: const OurTeam(),
          ),
          VWidget(path: '/agbs', widget: const AGBScreen()),
          VWidget(path: '/impressum', widget: const ImpressumScreen()),
          VWidget(path: '/submitidea', widget: const SubmitIdea()),
        ]),
        VWidget(
          path: '/authhome',
          widget: GetStartedScreen(),
          stackedRoutes: [
            VWidget(
              path: '/pinverification',
              widget: const PinVerificationScreen(),
              stackedRoutes: [
                VWidget(
                  path: '/register/:pin',
                  widget: const ChatDetails(),
                ),
              ],
            ),
            VWidget(
              path: '/ionloading',
              widget: IONLoadingScreen(
                loadingText:
                    "Patience, please. We're validating your account on the blockchain...",
              ),
            ),
            VWidget(
              path: '/login',
              widget: ChooseRestoreScreen(),
              stackedRoutes: [
                VWidget(
                  path: '/word_recovery',
                  widget: WordRecoveryScreen(),
                ),
                VWidget(
                  path: '/device_recovery',
                  widget: OtherDeviceScreen(),
                ),
                VWidget(
                  path: '/social_recovery',
                  widget: SocialRecoveryScreen(),
                  stackedRoutes: [
                    VWidget(
                      path: '/info_social_recovery',
                      widget: InfoSocialRecoveryScreen(),
                    ),
                  ],
                ),
                VWidget(
                  path: '/did_recovery',
                  widget: DidAndPrivateKeyScreen(),
                ),
              ],
            ),

            // VWidget(
            //   path: 'logs',
            //   widget: const LogViewer(),
            //   buildTransition: _dynamicTransition,
            // ),
            VWidget(
              path: 'connect',
              widget: const ConnectPage(),
              stackedRoutes: [
                VWidget(
                  path: 'signup',
                  widget: Container(),
                ),
              ],
            ),
          ],
        ),
      ];

  List<VRouteElement> get _chatCreateRoutes => [
        VWidget(
          path: '/chat',
          widget: const CreateNewScreen(
            initialIndex: 0,
          ),
        ),
        VWidget(
          path: '/group',
          widget: const CreateNewScreen(
            initialIndex: 1,
          ),
        ),
        VWidget(
          path: '/space',
          widget: const CreateNewScreen(
            initialIndex: 2,
          ),
        ),
      ];

  List<VRouteElement> get _chatDetailsRoutes => [
        VWidget(
          path: 'permissions',
          widget: const ChatPermissionsSettings(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: 'widgets',
          widget: const ChatMatrixWidgets(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: 'invite',
          widget: const InvitationSelection(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: 'multiple_emotes',
          widget: const MultipleEmotesSettings(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: 'emotes',
          widget: const EmotesSettings(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: 'emotes/:state_key',
          widget: const EmotesSettings(),
          buildTransition: _dynamicTransition,
        ),
      ];

  List<VRouteElement> get _settingsRoutes => [
        VWidget(
          path: '/settings?tab=language',
          widget: ChangeLanguage(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: '/settings?tab=currency',
          widget: ChangeCurrency(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: '/settings?tab=notifications',
          widget: const SettingsNotifications(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: '/settings?tab=style',
          widget: const SettingsStyle(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: '/settings?tab=devices',
          widget: const DevicesSettings(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: '/settings?tab=invite_friends',
          widget: InvitationSettingsPage(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: '/settings?tab=security_own',
          widget: SecuritySettingsPage(),
          buildTransition: _dynamicTransition,
        ),
        VWidget(
          path: '/settings?tab=chat',
          widget: const SettingsChat(),
          buildTransition: _dynamicTransition,
          stackedRoutes: [
            VWidget(
              path: '/settings?tab=chat&subtab=emotes',
              widget: const EmotesSettings(),
              buildTransition: _dynamicTransition,
            ),
          ],
        ),
        VWidget(
          path: '/settings?tab=security',
          widget: const SettingsSecurity(),
          buildTransition: _dynamicTransition,
          stackedRoutes: [
            VWidget(
              path: '/settings?tab=security&subtab=ignorelist',
              widget: const SettingsIgnoreList(),
              buildTransition: _dynamicTransition,
            ),
            VWidget(
              path: '/settings?tab=security&subtab=3pid',
              widget: const Settings3Pid(),
              buildTransition: _dynamicTransition,
            ),
          ],
        ),
        VWidget(
          path: '/settings?tab=logs',
          widget: const LogViewer(),
          buildTransition: _dynamicTransition,
        ),
      ];

  FadeTransition Function(dynamic, dynamic, dynamic)? get _dynamicTransition =>
      columnMode ? _fadeTransition : null;

  FadeTransition _fadeTransition(animation1, _, child) =>
      FadeTransition(opacity: animation1, child: child);
}
