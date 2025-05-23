// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {

  L10n();

  static L10n? _current;


  static L10n get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Hello World!`
  String get helloWorld {
    return Intl.message(
      'Hello World!',
      name: 'helloWorld',
      desc: '',
      args: [],
    );
  }

  /// `Restore Account`
  String get restoreAccount {
    return Intl.message(
      'Restore Account',
      name: 'restoreAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get register {
    return Intl.message(
      'Create Account',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Powered with DIDs by`
  String get poweredByDIDs {
    return Intl.message(
      'Powered with DIDs by',
      name: 'poweredByDIDs',
      desc: '',
      args: [],
    );
  }

  /// `Username or DID`
  String get usernameOrDID {
    return Intl.message(
      'Username or DID',
      name: 'usernameOrDID',
      desc: '',
      args: [],
    );
  }

  /// `Private Key`
  String get privateKey {
    return Intl.message(
      'Private Key',
      name: 'privateKey',
      desc: '',
      args: [],
    );
  }

  /// `Restore with social recovery`
  String get restoreWithSocialRecovery {
    return Intl.message(
      'Restore with social recovery',
      name: 'restoreWithSocialRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Pin Code Verification`
  String get pinCodeVerification {
    return Intl.message(
      'Pin Code Verification',
      name: 'pinCodeVerification',
      desc: '',
      args: [],
    );
  }

  /// `Invitation Code`
  String get invitationCode {
    return Intl.message(
      'Invitation Code',
      name: 'invitationCode',
      desc: '',
      args: [],
    );
  }

  /// `You don't have an account yet?`
  String get noAccountYet {
    return Intl.message(
      'You don\'t have an account yet?',
      name: 'noAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `You already have an registered Account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'You already have an registered Account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `It seems like this code has already been used`
  String get codeAlreadyUsed {
    return Intl.message(
      'It seems like this code has already been used',
      name: 'codeAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `Code is not valid.`
  String get codeNotValid {
    return Intl.message(
      'Code is not valid.',
      name: 'codeNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get errorSomethingWrong {
    return Intl.message(
      'Something went wrong',
      name: 'errorSomethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Power to the people!`
  String get powerToThePeople {
    return Intl.message(
      'Power to the people!',
      name: 'powerToThePeople',
      desc: '',
      args: [],
    );
  }

  /// `We're thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users.`
  String get platformDemandText {
    return Intl.message(
      'We\'re thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users.',
      name: 'platformDemandText',
      desc: '',
      args: [],
    );
  }

  /// `We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration.`
  String get platformExlusivityText {
    return Intl.message(
      'We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration.',
      name: 'platformExlusivityText',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!`
  String get platformExpandCapacityText {
    return Intl.message(
      'Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!',
      name: 'platformExpandCapacityText',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match!`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match!',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get repeatPassword {
    return Intl.message(
      'Repeat password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please choose at least {min} characters.`
  String pleaseChooseAtLeastChars(Object min) {
    return Intl.message(
      'Please choose at least $min characters.',
      name: 'pleaseChooseAtLeastChars',
      desc: '',
      args: [min],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `FluffyChat update available`
  String get updateAvailable {
    return Intl.message(
      'FluffyChat update available',
      name: 'updateAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Start update in background`
  String get updateNow {
    return Intl.message(
      'Start update in background',
      name: 'updateNow',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `👍 {username} accepted the invitation`
  String acceptedTheInvitation(Object username) {
    return Intl.message(
      '👍 $username accepted the invitation',
      name: 'acceptedTheInvitation',
      desc: '',
      args: [username],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `🔐 {username} activated end to end encryption`
  String activatedEndToEndEncryption(Object username) {
    return Intl.message(
      '🔐 $username activated end to end encryption',
      name: 'activatedEndToEndEncryption',
      desc: '',
      args: [username],
    );
  }

  /// `Add email`
  String get addEmail {
    return Intl.message(
      'Add email',
      name: 'addEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your Matrix ID in order to delete your account.`
  String get confirmMatrixId {
    return Intl.message(
      'Please confirm your Matrix ID in order to delete your account.',
      name: 'confirmMatrixId',
      desc: '',
      args: [],
    );
  }

  /// `This should be {mxid}`
  String supposedMxid(Object mxid) {
    return Intl.message(
      'This should be $mxid',
      name: 'supposedMxid',
      desc: '',
      args: [mxid],
    );
  }

  /// `Add a group description`
  String get addGroupDescription {
    return Intl.message(
      'Add a group description',
      name: 'addGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add to space`
  String get addToSpace {
    return Intl.message(
      'Add to space',
      name: 'addToSpace',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `alias`
  String get alias {
    return Intl.message(
      'alias',
      name: 'alias',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `All chats`
  String get allChats {
    return Intl.message(
      'All chats',
      name: 'allChats',
      desc: '',
      args: [],
    );
  }

  /// `Send some googly eyes`
  String get commandHint_googly {
    return Intl.message(
      'Send some googly eyes',
      name: 'commandHint_googly',
      desc: '',
      args: [],
    );
  }

  /// `Send a cuddle`
  String get commandHint_cuddle {
    return Intl.message(
      'Send a cuddle',
      name: 'commandHint_cuddle',
      desc: '',
      args: [],
    );
  }

  /// `Send a hug`
  String get commandHint_hug {
    return Intl.message(
      'Send a hug',
      name: 'commandHint_hug',
      desc: '',
      args: [],
    );
  }

  /// `{senderName} sends you googly eyes`
  String googlyEyesContent(Object senderName) {
    return Intl.message(
      '$senderName sends you googly eyes',
      name: 'googlyEyesContent',
      desc: '',
      args: [senderName],
    );
  }

  /// `{senderName} cuddles you`
  String cuddleContent(Object senderName) {
    return Intl.message(
      '$senderName cuddles you',
      name: 'cuddleContent',
      desc: '',
      args: [senderName],
    );
  }

  /// `{senderName} hugs you`
  String hugContent(Object senderName) {
    return Intl.message(
      '$senderName hugs you',
      name: 'hugContent',
      desc: '',
      args: [senderName],
    );
  }

  /// `{senderName} answered the call`
  String answeredTheCall(Object senderName) {
    return Intl.message(
      '$senderName answered the call',
      name: 'answeredTheCall',
      desc: '',
      args: [senderName],
    );
  }

  /// `Anyone can join`
  String get anyoneCanJoin {
    return Intl.message(
      'Anyone can join',
      name: 'anyoneCanJoin',
      desc: '',
      args: [],
    );
  }

  /// `App lock`
  String get appLock {
    return Intl.message(
      'App lock',
      name: 'appLock',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message(
      'Archive',
      name: 'archive',
      desc: '',
      args: [],
    );
  }

  /// `Are guest users allowed to join`
  String get areGuestsAllowedToJoin {
    return Intl.message(
      'Are guest users allowed to join',
      name: 'areGuestsAllowedToJoin',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get areYouSureYouWantToLogout {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'areYouSureYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `To be able to sign the other person, please enter your secure store passphrase or recovery key.`
  String get askSSSSSign {
    return Intl.message(
      'To be able to sign the other person, please enter your secure store passphrase or recovery key.',
      name: 'askSSSSSign',
      desc: '',
      args: [],
    );
  }

  /// `Accept this verification request from {username}?`
  String askVerificationRequest(Object username) {
    return Intl.message(
      'Accept this verification request from $username?',
      name: 'askVerificationRequest',
      desc: '',
      args: [username],
    );
  }

  /// `Automatically play animated stickers and emotes`
  String get autoplayImages {
    return Intl.message(
      'Automatically play animated stickers and emotes',
      name: 'autoplayImages',
      desc: '',
      args: [],
    );
  }

  /// `Send on enter`
  String get sendOnEnter {
    return Intl.message(
      'Send on enter',
      name: 'sendOnEnter',
      desc: '',
      args: [],
    );
  }

  /// `Ban from chat`
  String get banFromChat {
    return Intl.message(
      'Ban from chat',
      name: 'banFromChat',
      desc: '',
      args: [],
    );
  }

  /// `Banned`
  String get banned {
    return Intl.message(
      'Banned',
      name: 'banned',
      desc: '',
      args: [],
    );
  }

  /// `{username} banned {targetName}`
  String bannedUser(Object username, Object targetName) {
    return Intl.message(
      '$username banned $targetName',
      name: 'bannedUser',
      desc: '',
      args: [username, targetName],
    );
  }

  /// `Block Device`
  String get blockDevice {
    return Intl.message(
      'Block Device',
      name: 'blockDevice',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get blocked {
    return Intl.message(
      'Blocked',
      name: 'blocked',
      desc: '',
      args: [],
    );
  }

  /// `Bot messages`
  String get botMessages {
    return Intl.message(
      'Bot messages',
      name: 'botMessages',
      desc: '',
      args: [],
    );
  }

  /// `Bubble size`
  String get bubbleSize {
    return Intl.message(
      'Bubble size',
      name: 'bubbleSize',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Can't open the URI {uri}`
  String cantOpenUri(Object uri) {
    return Intl.message(
      'Can\'t open the URI $uri',
      name: 'cantOpenUri',
      desc: '',
      args: [uri],
    );
  }

  /// `Change device name`
  String get changeDeviceName {
    return Intl.message(
      'Change device name',
      name: 'changeDeviceName',
      desc: '',
      args: [],
    );
  }

  /// `{username} changed the chat avatar`
  String changedTheChatAvatar(Object username) {
    return Intl.message(
      '$username changed the chat avatar',
      name: 'changedTheChatAvatar',
      desc: '',
      args: [username],
    );
  }

  /// `{username} changed the chat description to: '{description}'`
  String changedTheChatDescriptionTo(Object username, Object description) {
    return Intl.message(
      '$username changed the chat description to: \'$description\'',
      name: 'changedTheChatDescriptionTo',
      desc: '',
      args: [username, description],
    );
  }

  /// `{username} changed the chat name to: '{chatname}'`
  String changedTheChatNameTo(Object username, Object chatname) {
    return Intl.message(
      '$username changed the chat name to: \'$chatname\'',
      name: 'changedTheChatNameTo',
      desc: '',
      args: [username, chatname],
    );
  }

  /// `{username} changed the chat permissions`
  String changedTheChatPermissions(Object username) {
    return Intl.message(
      '$username changed the chat permissions',
      name: 'changedTheChatPermissions',
      desc: '',
      args: [username],
    );
  }

  /// `{username} changed their displayname to: '{displayname}'`
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return Intl.message(
      '$username changed their displayname to: \'$displayname\'',
      name: 'changedTheDisplaynameTo',
      desc: '',
      args: [username, displayname],
    );
  }

  /// `{username} changed the guest access rules`
  String changedTheGuestAccessRules(Object username) {
    return Intl.message(
      '$username changed the guest access rules',
      name: 'changedTheGuestAccessRules',
      desc: '',
      args: [username],
    );
  }

  /// `{username} changed the guest access rules to: {rules}`
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return Intl.message(
      '$username changed the guest access rules to: $rules',
      name: 'changedTheGuestAccessRulesTo',
      desc: '',
      args: [username, rules],
    );
  }

  /// `{username} changed the history visibility`
  String changedTheHistoryVisibility(Object username) {
    return Intl.message(
      '$username changed the history visibility',
      name: 'changedTheHistoryVisibility',
      desc: '',
      args: [username],
    );
  }

  /// `{username} changed the history visibility to: {rules}`
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return Intl.message(
      '$username changed the history visibility to: $rules',
      name: 'changedTheHistoryVisibilityTo',
      desc: '',
      args: [username, rules],
    );
  }

  /// `{username} changed the join rules`
  String changedTheJoinRules(Object username) {
    return Intl.message(
      '$username changed the join rules',
      name: 'changedTheJoinRules',
      desc: '',
      args: [username],
    );
  }

  /// `{username} changed the join rules to: {joinRules}`
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return Intl.message(
      '$username changed the join rules to: $joinRules',
      name: 'changedTheJoinRulesTo',
      desc: '',
      args: [username, joinRules],
    );
  }

  /// `{username} changed their avatar`
  String changedTheProfileAvatar(Object username) {
    return Intl.message(
      '$username changed their avatar',
      name: 'changedTheProfileAvatar',
      desc: '',
      args: [username],
    );
  }

  /// `{username} changed the room aliases`
  String changedTheRoomAliases(Object username) {
    return Intl.message(
      '$username changed the room aliases',
      name: 'changedTheRoomAliases',
      desc: '',
      args: [username],
    );
  }

  /// `{username} changed the invitation link`
  String changedTheRoomInvitationLink(Object username) {
    return Intl.message(
      '$username changed the invitation link',
      name: 'changedTheRoomInvitationLink',
      desc: '',
      args: [username],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Change the homeserver`
  String get changeTheHomeserver {
    return Intl.message(
      'Change the homeserver',
      name: 'changeTheHomeserver',
      desc: '',
      args: [],
    );
  }

  /// `Change your style`
  String get changeTheme {
    return Intl.message(
      'Change your style',
      name: 'changeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Change the name of the group`
  String get changeTheNameOfTheGroup {
    return Intl.message(
      'Change the name of the group',
      name: 'changeTheNameOfTheGroup',
      desc: '',
      args: [],
    );
  }

  /// `Change wallpaper`
  String get changeWallpaper {
    return Intl.message(
      'Change wallpaper',
      name: 'changeWallpaper',
      desc: '',
      args: [],
    );
  }

  /// `Change your avatar`
  String get changeYourAvatar {
    return Intl.message(
      'Change your avatar',
      name: 'changeYourAvatar',
      desc: '',
      args: [],
    );
  }

  /// `The encryption has been corrupted`
  String get channelCorruptedDecryptError {
    return Intl.message(
      'The encryption has been corrupted',
      name: 'channelCorruptedDecryptError',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Your chat backup has been set up.`
  String get yourChatBackupHasBeenSetUp {
    return Intl.message(
      'Your chat backup has been set up.',
      name: 'yourChatBackupHasBeenSetUp',
      desc: '',
      args: [],
    );
  }

  /// `Chat backup`
  String get chatBackup {
    return Intl.message(
      'Chat backup',
      name: 'chatBackup',
      desc: '',
      args: [],
    );
  }

  /// `Your old messages are secured with a recovery key. Please make sure you don't lose it.`
  String get chatBackupDescription {
    return Intl.message(
      'Your old messages are secured with a recovery key. Please make sure you don\'t lose it.',
      name: 'chatBackupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Chat details`
  String get chatDetails {
    return Intl.message(
      'Chat details',
      name: 'chatDetails',
      desc: '',
      args: [],
    );
  }

  /// `Chat has been added to this space`
  String get chatHasBeenAddedToThisSpace {
    return Intl.message(
      'Chat has been added to this space',
      name: 'chatHasBeenAddedToThisSpace',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Choose a strong password`
  String get chooseAStrongPassword {
    return Intl.message(
      'Choose a strong password',
      name: 'chooseAStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Choose a username`
  String get chooseAUsername {
    return Intl.message(
      'Choose a username',
      name: 'chooseAUsername',
      desc: '',
      args: [],
    );
  }

  /// `Clear archive`
  String get clearArchive {
    return Intl.message(
      'Clear archive',
      name: 'clearArchive',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Mark as direct message room`
  String get commandHint_markasdm {
    return Intl.message(
      'Mark as direct message room',
      name: 'commandHint_markasdm',
      desc: '',
      args: [],
    );
  }

  /// `Mark as group`
  String get commandHint_markasgroup {
    return Intl.message(
      'Mark as group',
      name: 'commandHint_markasgroup',
      desc: '',
      args: [],
    );
  }

  /// `Ban the given user from this room`
  String get commandHint_ban {
    return Intl.message(
      'Ban the given user from this room',
      name: 'commandHint_ban',
      desc: 'Usage hint for the command /ban',
      args: [],
    );
  }

  /// `Clear cache`
  String get commandHint_clearcache {
    return Intl.message(
      'Clear cache',
      name: 'commandHint_clearcache',
      desc: 'Usage hint for the command /clearcache',
      args: [],
    );
  }

  /// `Create an empty group chat\nUse --no-encryption to disable encryption`
  String get commandHint_create {
    return Intl.message(
      'Create an empty group chat\nUse --no-encryption to disable encryption',
      name: 'commandHint_create',
      desc: 'Usage hint for the command /create',
      args: [],
    );
  }

  /// `Discard session`
  String get commandHint_discardsession {
    return Intl.message(
      'Discard session',
      name: 'commandHint_discardsession',
      desc: 'Usage hint for the command /discardsession',
      args: [],
    );
  }

  /// `Start a direct chat\nUse --no-encryption to disable encryption`
  String get commandHint_dm {
    return Intl.message(
      'Start a direct chat\nUse --no-encryption to disable encryption',
      name: 'commandHint_dm',
      desc: 'Usage hint for the command /dm',
      args: [],
    );
  }

  /// `Send HTML-formatted text`
  String get commandHint_html {
    return Intl.message(
      'Send HTML-formatted text',
      name: 'commandHint_html',
      desc: 'Usage hint for the command /html',
      args: [],
    );
  }

  /// `Invite the given user to this room`
  String get commandHint_invite {
    return Intl.message(
      'Invite the given user to this room',
      name: 'commandHint_invite',
      desc: 'Usage hint for the command /invite',
      args: [],
    );
  }

  /// `Join the given room`
  String get commandHint_join {
    return Intl.message(
      'Join the given room',
      name: 'commandHint_join',
      desc: 'Usage hint for the command /join',
      args: [],
    );
  }

  /// `Remove the given user from this room`
  String get commandHint_kick {
    return Intl.message(
      'Remove the given user from this room',
      name: 'commandHint_kick',
      desc: 'Usage hint for the command /kick',
      args: [],
    );
  }

  /// `Leave this room`
  String get commandHint_leave {
    return Intl.message(
      'Leave this room',
      name: 'commandHint_leave',
      desc: 'Usage hint for the command /leave',
      args: [],
    );
  }

  /// `Describe yourself`
  String get commandHint_me {
    return Intl.message(
      'Describe yourself',
      name: 'commandHint_me',
      desc: 'Usage hint for the command /me',
      args: [],
    );
  }

  /// `Set your picture for this room (by mxc-uri)`
  String get commandHint_myroomavatar {
    return Intl.message(
      'Set your picture for this room (by mxc-uri)',
      name: 'commandHint_myroomavatar',
      desc: 'Usage hint for the command /myroomavatar',
      args: [],
    );
  }

  /// `Set your display name for this room`
  String get commandHint_myroomnick {
    return Intl.message(
      'Set your display name for this room',
      name: 'commandHint_myroomnick',
      desc: 'Usage hint for the command /myroomnick',
      args: [],
    );
  }

  /// `Set the given user's power level (default: 50)`
  String get commandHint_op {
    return Intl.message(
      'Set the given user\'s power level (default: 50)',
      name: 'commandHint_op',
      desc: 'Usage hint for the command /op',
      args: [],
    );
  }

  /// `Send unformatted text`
  String get commandHint_plain {
    return Intl.message(
      'Send unformatted text',
      name: 'commandHint_plain',
      desc: 'Usage hint for the command /plain',
      args: [],
    );
  }

  /// `Send reply as a reaction`
  String get commandHint_react {
    return Intl.message(
      'Send reply as a reaction',
      name: 'commandHint_react',
      desc: 'Usage hint for the command /react',
      args: [],
    );
  }

  /// `Send text`
  String get commandHint_send {
    return Intl.message(
      'Send text',
      name: 'commandHint_send',
      desc: 'Usage hint for the command /send',
      args: [],
    );
  }

  /// `Unban the given user from this room`
  String get commandHint_unban {
    return Intl.message(
      'Unban the given user from this room',
      name: 'commandHint_unban',
      desc: 'Usage hint for the command /unban',
      args: [],
    );
  }

  /// `Command invalid`
  String get commandInvalid {
    return Intl.message(
      'Command invalid',
      name: 'commandInvalid',
      desc: '',
      args: [],
    );
  }

  /// `{command} is not a command.`
  String commandMissing(Object command) {
    return Intl.message(
      '$command is not a command.',
      name: 'commandMissing',
      desc: 'State that {command} is not a valid /command.',
      args: [command],
    );
  }

  /// `Please compare the emojis`
  String get compareEmojiMatch {
    return Intl.message(
      'Please compare the emojis',
      name: 'compareEmojiMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please compare the numbers`
  String get compareNumbersMatch {
    return Intl.message(
      'Please compare the numbers',
      name: 'compareNumbersMatch',
      desc: '',
      args: [],
    );
  }

  /// `Configure chat`
  String get configureChat {
    return Intl.message(
      'Configure chat',
      name: 'configureChat',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Contact has been invited to the group`
  String get contactHasBeenInvitedToTheGroup {
    return Intl.message(
      'Contact has been invited to the group',
      name: 'contactHasBeenInvitedToTheGroup',
      desc: '',
      args: [],
    );
  }

  /// `Contains display name`
  String get containsDisplayName {
    return Intl.message(
      'Contains display name',
      name: 'containsDisplayName',
      desc: '',
      args: [],
    );
  }

  /// `Contains username`
  String get containsUserName {
    return Intl.message(
      'Contains username',
      name: 'containsUserName',
      desc: '',
      args: [],
    );
  }

  /// `The content has been reported to the server admins`
  String get contentHasBeenReported {
    return Intl.message(
      'The content has been reported to the server admins',
      name: 'contentHasBeenReported',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copiedToClipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Copy to clipboard`
  String get copyToClipboard {
    return Intl.message(
      'Copy to clipboard',
      name: 'copyToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Could not decrypt message: {error}`
  String couldNotDecryptMessage(Object error) {
    return Intl.message(
      'Could not decrypt message: $error',
      name: 'couldNotDecryptMessage',
      desc: '',
      args: [error],
    );
  }

  /// `{count} participants`
  String countParticipants(Object count) {
    return Intl.message(
      '$count participants',
      name: 'countParticipants',
      desc: '',
      args: [count],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `💬 {username} created the chat`
  String createdTheChat(Object username) {
    return Intl.message(
      '💬 $username created the chat',
      name: 'createdTheChat',
      desc: '',
      args: [username],
    );
  }

  /// `Create new group`
  String get createNewGroup {
    return Intl.message(
      'Create new group',
      name: 'createNewGroup',
      desc: '',
      args: [],
    );
  }

  /// `New space`
  String get createNewSpace {
    return Intl.message(
      'New space',
      name: 'createNewSpace',
      desc: '',
      args: [],
    );
  }

  /// `Currently active`
  String get currentlyActive {
    return Intl.message(
      'Currently active',
      name: 'currentlyActive',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get darkTheme {
    return Intl.message(
      'Dark',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `{date}, {timeOfDay}`
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return Intl.message(
      '$date, $timeOfDay',
      name: 'dateAndTimeOfDay',
      desc: '',
      args: [date, timeOfDay],
    );
  }

  /// `{month}-{day}`
  String dateWithoutYear(Object month, Object day) {
    return Intl.message(
      '$month-$day',
      name: 'dateWithoutYear',
      desc: '',
      args: [month, day],
    );
  }

  /// `{year}-{month}-{day}`
  String dateWithYear(Object year, Object month, Object day) {
    return Intl.message(
      '$year-$month-$day',
      name: 'dateWithYear',
      desc: '',
      args: [year, month, day],
    );
  }

  /// `This will deactivate your user account. This can not be undone! Are you sure?`
  String get deactivateAccountWarning {
    return Intl.message(
      'This will deactivate your user account. This can not be undone! Are you sure?',
      name: 'deactivateAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `Default permission level`
  String get defaultPermissionLevel {
    return Intl.message(
      'Default permission level',
      name: 'defaultPermissionLevel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete message`
  String get deleteMessage {
    return Intl.message(
      'Delete message',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Deny`
  String get deny {
    return Intl.message(
      'Deny',
      name: 'deny',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get device {
    return Intl.message(
      'Device',
      name: 'device',
      desc: '',
      args: [],
    );
  }

  /// `Device ID`
  String get deviceId {
    return Intl.message(
      'Device ID',
      name: 'deviceId',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get devices {
    return Intl.message(
      'Devices',
      name: 'devices',
      desc: '',
      args: [],
    );
  }

  /// `Direct Chats`
  String get directChats {
    return Intl.message(
      'Direct Chats',
      name: 'directChats',
      desc: '',
      args: [],
    );
  }

  /// `All Group Chats`
  String get allRooms {
    return Intl.message(
      'All Group Chats',
      name: 'allRooms',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get discover {
    return Intl.message(
      'Discover',
      name: 'discover',
      desc: '',
      args: [],
    );
  }

  /// `Displayname has been changed`
  String get displaynameHasBeenChanged {
    return Intl.message(
      'Displayname has been changed',
      name: 'displaynameHasBeenChanged',
      desc: '',
      args: [],
    );
  }

  /// `Download file`
  String get downloadFile {
    return Intl.message(
      'Download file',
      name: 'downloadFile',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Edit blocked servers`
  String get editBlockedServers {
    return Intl.message(
      'Edit blocked servers',
      name: 'editBlockedServers',
      desc: '',
      args: [],
    );
  }

  /// `Edit chat permissions`
  String get editChatPermissions {
    return Intl.message(
      'Edit chat permissions',
      name: 'editChatPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Edit displayname`
  String get editDisplayname {
    return Intl.message(
      'Edit displayname',
      name: 'editDisplayname',
      desc: '',
      args: [],
    );
  }

  /// `Edit room aliases`
  String get editRoomAliases {
    return Intl.message(
      'Edit room aliases',
      name: 'editRoomAliases',
      desc: '',
      args: [],
    );
  }

  /// `Edit room avatar`
  String get editRoomAvatar {
    return Intl.message(
      'Edit room avatar',
      name: 'editRoomAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Emote already exists!`
  String get emoteExists {
    return Intl.message(
      'Emote already exists!',
      name: 'emoteExists',
      desc: '',
      args: [],
    );
  }

  /// `Invalid emote shortcode!`
  String get emoteInvalid {
    return Intl.message(
      'Invalid emote shortcode!',
      name: 'emoteInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Emote packs for room`
  String get emotePacks {
    return Intl.message(
      'Emote packs for room',
      name: 'emotePacks',
      desc: '',
      args: [],
    );
  }

  /// `Emote Settings`
  String get emoteSettings {
    return Intl.message(
      'Emote Settings',
      name: 'emoteSettings',
      desc: '',
      args: [],
    );
  }

  /// `Emote shortcode`
  String get emoteShortcode {
    return Intl.message(
      'Emote shortcode',
      name: 'emoteShortcode',
      desc: '',
      args: [],
    );
  }

  /// `You need to pick an emote shortcode and an image!`
  String get emoteWarnNeedToPick {
    return Intl.message(
      'You need to pick an emote shortcode and an image!',
      name: 'emoteWarnNeedToPick',
      desc: '',
      args: [],
    );
  }

  /// `Empty chat`
  String get emptyChat {
    return Intl.message(
      'Empty chat',
      name: 'emptyChat',
      desc: '',
      args: [],
    );
  }

  /// `Enable emote pack globally`
  String get enableEmotesGlobally {
    return Intl.message(
      'Enable emote pack globally',
      name: 'enableEmotesGlobally',
      desc: '',
      args: [],
    );
  }

  /// `Enable encryption`
  String get enableEncryption {
    return Intl.message(
      'Enable encryption',
      name: 'enableEncryption',
      desc: '',
      args: [],
    );
  }

  /// `You won't be able to disable the encryption anymore. Are you sure?`
  String get enableEncryptionWarning {
    return Intl.message(
      'You won\'t be able to disable the encryption anymore. Are you sure?',
      name: 'enableEncryptionWarning',
      desc: '',
      args: [],
    );
  }

  /// `Encrypted`
  String get encrypted {
    return Intl.message(
      'Encrypted',
      name: 'encrypted',
      desc: '',
      args: [],
    );
  }

  /// `Encryption`
  String get encryption {
    return Intl.message(
      'Encryption',
      name: 'encryption',
      desc: '',
      args: [],
    );
  }

  /// `Encryption is not enabled`
  String get encryptionNotEnabled {
    return Intl.message(
      'Encryption is not enabled',
      name: 'encryptionNotEnabled',
      desc: '',
      args: [],
    );
  }

  /// `{senderName} ended the call`
  String endedTheCall(Object senderName) {
    return Intl.message(
      '$senderName ended the call',
      name: 'endedTheCall',
      desc: '',
      args: [senderName],
    );
  }

  /// `Enter a group name`
  String get enterAGroupName {
    return Intl.message(
      'Enter a group name',
      name: 'enterAGroupName',
      desc: '',
      args: [],
    );
  }

  /// `Enter an email address`
  String get enterAnEmailAddress {
    return Intl.message(
      'Enter an email address',
      name: 'enterAnEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter a space name`
  String get enterASpacepName {
    return Intl.message(
      'Enter a space name',
      name: 'enterASpacepName',
      desc: '',
      args: [],
    );
  }

  /// `Homeserver`
  String get homeserver {
    return Intl.message(
      'Homeserver',
      name: 'homeserver',
      desc: '',
      args: [],
    );
  }

  /// `Enter your homeserver`
  String get enterYourHomeserver {
    return Intl.message(
      'Enter your homeserver',
      name: 'enterYourHomeserver',
      desc: '',
      args: [],
    );
  }

  /// `Error obtaining location: {error}`
  String errorObtainingLocation(Object error) {
    return Intl.message(
      'Error obtaining location: $error',
      name: 'errorObtainingLocation',
      desc: '',
      args: [error],
    );
  }

  /// `Everything ready!`
  String get everythingReady {
    return Intl.message(
      'Everything ready!',
      name: 'everythingReady',
      desc: '',
      args: [],
    );
  }

  /// `Extremely offensive`
  String get extremeOffensive {
    return Intl.message(
      'Extremely offensive',
      name: 'extremeOffensive',
      desc: '',
      args: [],
    );
  }

  /// `File name`
  String get fileName {
    return Intl.message(
      'File name',
      name: 'fileName',
      desc: '',
      args: [],
    );
  }

  /// `FluffyChat`
  String get fluffychat {
    return Intl.message(
      'FluffyChat',
      name: 'fluffychat',
      desc: '',
      args: [],
    );
  }

  /// `Font size`
  String get fontSize {
    return Intl.message(
      'Font size',
      name: 'fontSize',
      desc: '',
      args: [],
    );
  }

  /// `Forward`
  String get forward {
    return Intl.message(
      'Forward',
      name: 'forward',
      desc: '',
      args: [],
    );
  }

  /// `From joining`
  String get fromJoining {
    return Intl.message(
      'From joining',
      name: 'fromJoining',
      desc: '',
      args: [],
    );
  }

  /// `From the invitation`
  String get fromTheInvitation {
    return Intl.message(
      'From the invitation',
      name: 'fromTheInvitation',
      desc: '',
      args: [],
    );
  }

  /// `Go to the new room`
  String get goToTheNewRoom {
    return Intl.message(
      'Go to the new room',
      name: 'goToTheNewRoom',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Group description`
  String get groupDescription {
    return Intl.message(
      'Group description',
      name: 'groupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Group description changed`
  String get groupDescriptionHasBeenChanged {
    return Intl.message(
      'Group description changed',
      name: 'groupDescriptionHasBeenChanged',
      desc: '',
      args: [],
    );
  }

  /// `Group is public`
  String get groupIsPublic {
    return Intl.message(
      'Group is public',
      name: 'groupIsPublic',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message(
      'Groups',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Group with {displayname}`
  String groupWith(Object displayname) {
    return Intl.message(
      'Group with $displayname',
      name: 'groupWith',
      desc: '',
      args: [displayname],
    );
  }

  /// `Guests are forbidden`
  String get guestsAreForbidden {
    return Intl.message(
      'Guests are forbidden',
      name: 'guestsAreForbidden',
      desc: '',
      args: [],
    );
  }

  /// `Guests can join`
  String get guestsCanJoin {
    return Intl.message(
      'Guests can join',
      name: 'guestsCanJoin',
      desc: '',
      args: [],
    );
  }

  /// `{username} has withdrawn the invitation for {targetName}`
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return Intl.message(
      '$username has withdrawn the invitation for $targetName',
      name: 'hasWithdrawnTheInvitationFor',
      desc: '',
      args: [username, targetName],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Hide redacted events`
  String get hideRedactedEvents {
    return Intl.message(
      'Hide redacted events',
      name: 'hideRedactedEvents',
      desc: '',
      args: [],
    );
  }

  /// `Hide unknown events`
  String get hideUnknownEvents {
    return Intl.message(
      'Hide unknown events',
      name: 'hideUnknownEvents',
      desc: '',
      args: [],
    );
  }

  /// `How offensive is this content?`
  String get howOffensiveIsThisContent {
    return Intl.message(
      'How offensive is this content?',
      name: 'howOffensiveIsThisContent',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Identity`
  String get identity {
    return Intl.message(
      'Identity',
      name: 'identity',
      desc: '',
      args: [],
    );
  }

  /// `Ignore`
  String get ignore {
    return Intl.message(
      'Ignore',
      name: 'ignore',
      desc: '',
      args: [],
    );
  }

  /// `Ignored users`
  String get ignoredUsers {
    return Intl.message(
      'Ignored users',
      name: 'ignoredUsers',
      desc: '',
      args: [],
    );
  }

  /// `You can ignore users who are disturbing you. You won't be able to receive any messages or room invites from the users on your personal ignore list.`
  String get ignoreListDescription {
    return Intl.message(
      'You can ignore users who are disturbing you. You won\'t be able to receive any messages or room invites from the users on your personal ignore list.',
      name: 'ignoreListDescription',
      desc: '',
      args: [],
    );
  }

  /// `Ignore username`
  String get ignoreUsername {
    return Intl.message(
      'Ignore username',
      name: 'ignoreUsername',
      desc: '',
      args: [],
    );
  }

  /// `I have clicked on the link`
  String get iHaveClickedOnLink {
    return Intl.message(
      'I have clicked on the link',
      name: 'iHaveClickedOnLink',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect passphrase or recovery key`
  String get incorrectPassphraseOrKey {
    return Intl.message(
      'Incorrect passphrase or recovery key',
      name: 'incorrectPassphraseOrKey',
      desc: '',
      args: [],
    );
  }

  /// `Inoffensive`
  String get inoffensive {
    return Intl.message(
      'Inoffensive',
      name: 'inoffensive',
      desc: '',
      args: [],
    );
  }

  /// `Invite contact`
  String get inviteContact {
    return Intl.message(
      'Invite contact',
      name: 'inviteContact',
      desc: '',
      args: [],
    );
  }

  /// `Invite contact to {groupName}`
  String inviteContactToGroup(Object groupName) {
    return Intl.message(
      'Invite contact to $groupName',
      name: 'inviteContactToGroup',
      desc: '',
      args: [groupName],
    );
  }

  /// `Invited`
  String get invited {
    return Intl.message(
      'Invited',
      name: 'invited',
      desc: '',
      args: [],
    );
  }

  /// `📩 {username} invited {targetName}`
  String invitedUser(Object username, Object targetName) {
    return Intl.message(
      '📩 $username invited $targetName',
      name: 'invitedUser',
      desc: '',
      args: [username, targetName],
    );
  }

  /// `Invited users only`
  String get invitedUsersOnly {
    return Intl.message(
      'Invited users only',
      name: 'invitedUsersOnly',
      desc: '',
      args: [],
    );
  }

  /// `Invite for me`
  String get inviteForMe {
    return Intl.message(
      'Invite for me',
      name: 'inviteForMe',
      desc: '',
      args: [],
    );
  }

  /// `{username} invited you to FluffyChat. \n1. Install FluffyChat: https://fluffychat.im \n2. Sign up or sign in \n3. Open the invite link: {link}`
  String inviteText(Object username, Object link) {
    return Intl.message(
      '$username invited you to FluffyChat. \n1. Install FluffyChat: https://fluffychat.im \n2. Sign up or sign in \n3. Open the invite link: $link',
      name: 'inviteText',
      desc: '',
      args: [username, link],
    );
  }

  /// `is typing…`
  String get isTyping {
    return Intl.message(
      'is typing…',
      name: 'isTyping',
      desc: '',
      args: [],
    );
  }

  /// `👋 {username} joined the chat`
  String joinedTheChat(Object username) {
    return Intl.message(
      '👋 $username joined the chat',
      name: 'joinedTheChat',
      desc: '',
      args: [username],
    );
  }

  /// `Join room`
  String get joinRoom {
    return Intl.message(
      'Join room',
      name: 'joinRoom',
      desc: '',
      args: [],
    );
  }

  /// `👞 {username} kicked {targetName}`
  String kicked(Object username, Object targetName) {
    return Intl.message(
      '👞 $username kicked $targetName',
      name: 'kicked',
      desc: '',
      args: [username, targetName],
    );
  }

  /// `🙅 {username} kicked and banned {targetName}`
  String kickedAndBanned(Object username, Object targetName) {
    return Intl.message(
      '🙅 $username kicked and banned $targetName',
      name: 'kickedAndBanned',
      desc: '',
      args: [username, targetName],
    );
  }

  /// `Kick from chat`
  String get kickFromChat {
    return Intl.message(
      'Kick from chat',
      name: 'kickFromChat',
      desc: '',
      args: [],
    );
  }

  /// `Last active: {localizedTimeShort}`
  String lastActiveAgo(Object localizedTimeShort) {
    return Intl.message(
      'Last active: $localizedTimeShort',
      name: 'lastActiveAgo',
      desc: '',
      args: [localizedTimeShort],
    );
  }

  /// `Seen a long time ago`
  String get lastSeenLongTimeAgo {
    return Intl.message(
      'Seen a long time ago',
      name: 'lastSeenLongTimeAgo',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Left the chat`
  String get leftTheChat {
    return Intl.message(
      'Left the chat',
      name: 'leftTheChat',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message(
      'License',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get lightTheme {
    return Intl.message(
      'Light',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Load {count} more participants`
  String loadCountMoreParticipants(Object count) {
    return Intl.message(
      'Load $count more participants',
      name: 'loadCountMoreParticipants',
      desc: '',
      args: [count],
    );
  }

  /// `Export session and wipe device`
  String get dehydrate {
    return Intl.message(
      'Export session and wipe device',
      name: 'dehydrate',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone. Ensure you safely store the backup file.`
  String get dehydrateWarning {
    return Intl.message(
      'This action cannot be undone. Ensure you safely store the backup file.',
      name: 'dehydrateWarning',
      desc: '',
      args: [],
    );
  }

  /// `TOR Users: Export session`
  String get dehydrateTor {
    return Intl.message(
      'TOR Users: Export session',
      name: 'dehydrateTor',
      desc: '',
      args: [],
    );
  }

  /// `For TOR users, it is recommended to export the session before closing the window.`
  String get dehydrateTorLong {
    return Intl.message(
      'For TOR users, it is recommended to export the session before closing the window.',
      name: 'dehydrateTorLong',
      desc: '',
      args: [],
    );
  }

  /// `TOR Users: Import session export`
  String get hydrateTor {
    return Intl.message(
      'TOR Users: Import session export',
      name: 'hydrateTor',
      desc: '',
      args: [],
    );
  }

  /// `Did you export your session last time on TOR? Quickly import it and continue chatting.`
  String get hydrateTorLong {
    return Intl.message(
      'Did you export your session last time on TOR? Quickly import it and continue chatting.',
      name: 'hydrateTorLong',
      desc: '',
      args: [],
    );
  }

  /// `Restore from backup file`
  String get hydrate {
    return Intl.message(
      'Restore from backup file',
      name: 'hydrate',
      desc: '',
      args: [],
    );
  }

  /// `Loading… Please wait.`
  String get loadingPleaseWait {
    return Intl.message(
      'Loading… Please wait.',
      name: 'loadingPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Load more…`
  String get loadMore {
    return Intl.message(
      'Load more…',
      name: 'loadMore',
      desc: '',
      args: [],
    );
  }

  /// `Location services are disabled. Please enable them to be able to share your location.`
  String get locationDisabledNotice {
    return Intl.message(
      'Location services are disabled. Please enable them to be able to share your location.',
      name: 'locationDisabledNotice',
      desc: '',
      args: [],
    );
  }

  /// `Location permission denied. Please grant them to be able to share your location.`
  String get locationPermissionDeniedNotice {
    return Intl.message(
      'Location permission denied. Please grant them to be able to share your location.',
      name: 'locationPermissionDeniedNotice',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Log in to {homeserver}`
  String logInTo(Object homeserver) {
    return Intl.message(
      'Log in to $homeserver',
      name: 'logInTo',
      desc: '',
      args: [homeserver],
    );
  }

  /// `Sign in with one click`
  String get loginWithOneClick {
    return Intl.message(
      'Sign in with one click',
      name: 'loginWithOneClick',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Make sure the identifier is valid`
  String get makeSureTheIdentifierIsValid {
    return Intl.message(
      'Make sure the identifier is valid',
      name: 'makeSureTheIdentifierIsValid',
      desc: '',
      args: [],
    );
  }

  /// `Member changes`
  String get memberChanges {
    return Intl.message(
      'Member changes',
      name: 'memberChanges',
      desc: '',
      args: [],
    );
  }

  /// `Mention`
  String get mention {
    return Intl.message(
      'Mention',
      name: 'mention',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Message will be removed for all participants`
  String get messageWillBeRemovedWarning {
    return Intl.message(
      'Message will be removed for all participants',
      name: 'messageWillBeRemovedWarning',
      desc: '',
      args: [],
    );
  }

  /// `Moderator`
  String get moderator {
    return Intl.message(
      'Moderator',
      name: 'moderator',
      desc: '',
      args: [],
    );
  }

  /// `Mute chat`
  String get muteChat {
    return Intl.message(
      'Mute chat',
      name: 'muteChat',
      desc: '',
      args: [],
    );
  }

  /// `Please be aware that you need Pantalaimon to use end-to-end encryption for now.`
  String get needPantalaimonWarning {
    return Intl.message(
      'Please be aware that you need Pantalaimon to use end-to-end encryption for now.',
      name: 'needPantalaimonWarning',
      desc: '',
      args: [],
    );
  }

  /// `New chat`
  String get newChat {
    return Intl.message(
      'New chat',
      name: 'newChat',
      desc: '',
      args: [],
    );
  }

  /// `💬 New message in FluffyChat`
  String get newMessageInFluffyChat {
    return Intl.message(
      '💬 New message in FluffyChat',
      name: 'newMessageInFluffyChat',
      desc: '',
      args: [],
    );
  }

  /// `New verification request!`
  String get newVerificationRequest {
    return Intl.message(
      'New verification request!',
      name: 'newVerificationRequest',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No connection to the server`
  String get noConnectionToTheServer {
    return Intl.message(
      'No connection to the server',
      name: 'noConnectionToTheServer',
      desc: '',
      args: [],
    );
  }

  /// `No emotes found. 😕`
  String get noEmotesFound {
    return Intl.message(
      'No emotes found. 😕',
      name: 'noEmotesFound',
      desc: '',
      args: [],
    );
  }

  /// `You can only activate encryption as soon as the room is no longer publicly accessible.`
  String get noEncryptionForPublicRooms {
    return Intl.message(
      'You can only activate encryption as soon as the room is no longer publicly accessible.',
      name: 'noEncryptionForPublicRooms',
      desc: '',
      args: [],
    );
  }

  /// `It seems that you have no google services on your phone. That's a good decision for your privacy! To receive push notifications in FluffyChat we recommend using https://microg.org/ or https://unifiedpush.org/.`
  String get noGoogleServicesWarning {
    return Intl.message(
      'It seems that you have no google services on your phone. That\'s a good decision for your privacy! To receive push notifications in FluffyChat we recommend using https://microg.org/ or https://unifiedpush.org/.',
      name: 'noGoogleServicesWarning',
      desc: '',
      args: [],
    );
  }

  /// `{server1} is no matrix server, use {server2} instead?`
  String noMatrixServer(Object server1, Object server2) {
    return Intl.message(
      '$server1 is no matrix server, use $server2 instead?',
      name: 'noMatrixServer',
      desc: '',
      args: [server1, server2],
    );
  }

  /// `Share your invite link`
  String get shareYourInviteLink {
    return Intl.message(
      'Share your invite link',
      name: 'shareYourInviteLink',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code`
  String get scanQrCode {
    return Intl.message(
      'Scan QR code',
      name: 'scanQrCode',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `You have not added a way to recover your password yet.`
  String get noPasswordRecoveryDescription {
    return Intl.message(
      'You have not added a way to recover your password yet.',
      name: 'noPasswordRecoveryDescription',
      desc: '',
      args: [],
    );
  }

  /// `No permission`
  String get noPermission {
    return Intl.message(
      'No permission',
      name: 'noPermission',
      desc: '',
      args: [],
    );
  }

  /// `No rooms found…`
  String get noRoomsFound {
    return Intl.message(
      'No rooms found…',
      name: 'noRoomsFound',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Notifications enabled for this account`
  String get notificationsEnabledForThisAccount {
    return Intl.message(
      'Notifications enabled for this account',
      name: 'notificationsEnabledForThisAccount',
      desc: '',
      args: [],
    );
  }

  /// `{count} users are typing…`
  String numUsersTyping(Object count) {
    return Intl.message(
      '$count users are typing…',
      name: 'numUsersTyping',
      desc: '',
      args: [count],
    );
  }

  /// `Obtaining location…`
  String get obtainingLocation {
    return Intl.message(
      'Obtaining location…',
      name: 'obtainingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Offensive`
  String get offensive {
    return Intl.message(
      'Offensive',
      name: 'offensive',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Online Key Backup is enabled`
  String get onlineKeyBackupEnabled {
    return Intl.message(
      'Online Key Backup is enabled',
      name: 'onlineKeyBackupEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Unfortunately, an error occurred when setting up the push notifications.`
  String get oopsPushError {
    return Intl.message(
      'Oops! Unfortunately, an error occurred when setting up the push notifications.',
      name: 'oopsPushError',
      desc: '',
      args: [],
    );
  }

  /// `Oops, something went wrong…`
  String get oopsSomethingWentWrong {
    return Intl.message(
      'Oops, something went wrong…',
      name: 'oopsSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Open app to read messages`
  String get openAppToReadMessages {
    return Intl.message(
      'Open app to read messages',
      name: 'openAppToReadMessages',
      desc: '',
      args: [],
    );
  }

  /// `Open camera`
  String get openCamera {
    return Intl.message(
      'Open camera',
      name: 'openCamera',
      desc: '',
      args: [],
    );
  }

  /// `Open camera for a video`
  String get openVideoCamera {
    return Intl.message(
      'Open camera for a video',
      name: 'openVideoCamera',
      desc: '',
      args: [],
    );
  }

  /// `One of your clients has been logged out`
  String get oneClientLoggedOut {
    return Intl.message(
      'One of your clients has been logged out',
      name: 'oneClientLoggedOut',
      desc: '',
      args: [],
    );
  }

  /// `Add account`
  String get addAccount {
    return Intl.message(
      'Add account',
      name: 'addAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit bundles for this account`
  String get editBundlesForAccount {
    return Intl.message(
      'Edit bundles for this account',
      name: 'editBundlesForAccount',
      desc: '',
      args: [],
    );
  }

  /// `Add to bundle`
  String get addToBundle {
    return Intl.message(
      'Add to bundle',
      name: 'addToBundle',
      desc: '',
      args: [],
    );
  }

  /// `Remove from this bundle`
  String get removeFromBundle {
    return Intl.message(
      'Remove from this bundle',
      name: 'removeFromBundle',
      desc: '',
      args: [],
    );
  }

  /// `Bundle name`
  String get bundleName {
    return Intl.message(
      'Bundle name',
      name: 'bundleName',
      desc: '',
      args: [],
    );
  }

  /// `(BETA) Enable multi accounts on this device`
  String get enableMultiAccounts {
    return Intl.message(
      '(BETA) Enable multi accounts on this device',
      name: 'enableMultiAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Open in maps`
  String get openInMaps {
    return Intl.message(
      'Open in maps',
      name: 'openInMaps',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `This server needs to validate your email address for registration.`
  String get serverRequiresEmail {
    return Intl.message(
      'This server needs to validate your email address for registration.',
      name: 'serverRequiresEmail',
      desc: '',
      args: [],
    );
  }

  /// `(Optional) Group name`
  String get optionalGroupName {
    return Intl.message(
      '(Optional) Group name',
      name: 'optionalGroupName',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Participant`
  String get participant {
    return Intl.message(
      'Participant',
      name: 'participant',
      desc: '',
      args: [],
    );
  }

  /// `passphrase or recovery key`
  String get passphraseOrKey {
    return Intl.message(
      'passphrase or recovery key',
      name: 'passphraseOrKey',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password forgotten`
  String get passwordForgotten {
    return Intl.message(
      'Password forgotten',
      name: 'passwordForgotten',
      desc: '',
      args: [],
    );
  }

  /// `Password has been changed`
  String get passwordHasBeenChanged {
    return Intl.message(
      'Password has been changed',
      name: 'passwordHasBeenChanged',
      desc: '',
      args: [],
    );
  }

  /// `Password recovery`
  String get passwordRecovery {
    return Intl.message(
      'Password recovery',
      name: 'passwordRecovery',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Pick an image`
  String get pickImage {
    return Intl.message(
      'Pick an image',
      name: 'pickImage',
      desc: '',
      args: [],
    );
  }

  /// `Pin`
  String get pin {
    return Intl.message(
      'Pin',
      name: 'pin',
      desc: '',
      args: [],
    );
  }

  /// `Play {fileName}`
  String play(Object fileName) {
    return Intl.message(
      'Play $fileName',
      name: 'play',
      desc: '',
      args: [fileName],
    );
  }

  /// `Please choose`
  String get pleaseChoose {
    return Intl.message(
      'Please choose',
      name: 'pleaseChoose',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a pass code`
  String get pleaseChooseAPasscode {
    return Intl.message(
      'Please choose a pass code',
      name: 'pleaseChooseAPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a username`
  String get pleaseChooseAUsername {
    return Intl.message(
      'Please choose a username',
      name: 'pleaseChooseAUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please click on the link in the email and then proceed.`
  String get pleaseClickOnLink {
    return Intl.message(
      'Please click on the link in the email and then proceed.',
      name: 'pleaseClickOnLink',
      desc: '',
      args: [],
    );
  }

  /// `Please enter 4 digits or leave empty to disable app lock.`
  String get pleaseEnter4Digits {
    return Intl.message(
      'Please enter 4 digits or leave empty to disable app lock.',
      name: 'pleaseEnter4Digits',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a Matrix ID.`
  String get pleaseEnterAMatrixIdentifier {
    return Intl.message(
      'Please enter a Matrix ID.',
      name: 'pleaseEnterAMatrixIdentifier',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your recovery key:`
  String get pleaseEnterRecoveryKey {
    return Intl.message(
      'Please enter your recovery key:',
      name: 'pleaseEnterRecoveryKey',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your pin`
  String get pleaseEnterYourPin {
    return Intl.message(
      'Please enter your pin',
      name: 'pleaseEnterYourPin',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username`
  String get pleaseEnterYourUsername {
    return Intl.message(
      'Please enter your username',
      name: 'pleaseEnterYourUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please follow the instructions on the website and tap on next.`
  String get pleaseFollowInstructionsOnWeb {
    return Intl.message(
      'Please follow the instructions on the website and tap on next.',
      name: 'pleaseFollowInstructionsOnWeb',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Public Rooms`
  String get publicRooms {
    return Intl.message(
      'Public Rooms',
      name: 'publicRooms',
      desc: '',
      args: [],
    );
  }

  /// `Push rules`
  String get pushRules {
    return Intl.message(
      'Push rules',
      name: 'pushRules',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `Recording`
  String get recording {
    return Intl.message(
      'Recording',
      name: 'recording',
      desc: '',
      args: [],
    );
  }

  /// `{username} redacted an event`
  String redactedAnEvent(Object username) {
    return Intl.message(
      '$username redacted an event',
      name: 'redactedAnEvent',
      desc: '',
      args: [username],
    );
  }

  /// `Redact message`
  String get redactMessage {
    return Intl.message(
      'Redact message',
      name: 'redactMessage',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `{username} rejected the invitation`
  String rejectedTheInvitation(Object username) {
    return Intl.message(
      '$username rejected the invitation',
      name: 'rejectedTheInvitation',
      desc: '',
      args: [username],
    );
  }

  /// `Rejoin`
  String get rejoin {
    return Intl.message(
      'Rejoin',
      name: 'rejoin',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Remove all other devices`
  String get removeAllOtherDevices {
    return Intl.message(
      'Remove all other devices',
      name: 'removeAllOtherDevices',
      desc: '',
      args: [],
    );
  }

  /// `Removed by {username}`
  String removedBy(Object username) {
    return Intl.message(
      'Removed by $username',
      name: 'removedBy',
      desc: '',
      args: [username],
    );
  }

  /// `Remove device`
  String get removeDevice {
    return Intl.message(
      'Remove device',
      name: 'removeDevice',
      desc: '',
      args: [],
    );
  }

  /// `Unban from chat`
  String get unbanFromChat {
    return Intl.message(
      'Unban from chat',
      name: 'unbanFromChat',
      desc: '',
      args: [],
    );
  }

  /// `Remove your avatar`
  String get removeYourAvatar {
    return Intl.message(
      'Remove your avatar',
      name: 'removeYourAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Render rich message content`
  String get renderRichContent {
    return Intl.message(
      'Render rich message content',
      name: 'renderRichContent',
      desc: '',
      args: [],
    );
  }

  /// `Replace room with newer version`
  String get replaceRoomWithNewerVersion {
    return Intl.message(
      'Replace room with newer version',
      name: 'replaceRoomWithNewerVersion',
      desc: '',
      args: [],
    );
  }

  /// `Reply`
  String get reply {
    return Intl.message(
      'Reply',
      name: 'reply',
      desc: '',
      args: [],
    );
  }

  /// `Report message`
  String get reportMessage {
    return Intl.message(
      'Report message',
      name: 'reportMessage',
      desc: '',
      args: [],
    );
  }

  /// `Request permission`
  String get requestPermission {
    return Intl.message(
      'Request permission',
      name: 'requestPermission',
      desc: '',
      args: [],
    );
  }

  /// `Room has been upgraded`
  String get roomHasBeenUpgraded {
    return Intl.message(
      'Room has been upgraded',
      name: 'roomHasBeenUpgraded',
      desc: '',
      args: [],
    );
  }

  /// `Room version`
  String get roomVersion {
    return Intl.message(
      'Room version',
      name: 'roomVersion',
      desc: '',
      args: [],
    );
  }

  /// `Save file`
  String get saveFile {
    return Intl.message(
      'Save file',
      name: 'saveFile',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Recovery key`
  String get recoveryKey {
    return Intl.message(
      'Recovery key',
      name: 'recoveryKey',
      desc: '',
      args: [],
    );
  }

  /// `Recovery key lost?`
  String get recoveryKeyLost {
    return Intl.message(
      'Recovery key lost?',
      name: 'recoveryKeyLost',
      desc: '',
      args: [],
    );
  }

  /// `Seen by {username}`
  String seenByUser(Object username) {
    return Intl.message(
      'Seen by $username',
      name: 'seenByUser',
      desc: '',
      args: [username],
    );
  }

  /// `{count, plural, other{Seen by {username} and {count} others}}`
  String seenByUserAndCountOthers(Object username, num count) {
    return Intl.plural(
      count,
      other: 'Seen by $username and $count others',
      name: 'seenByUserAndCountOthers',
      desc: '',
      args: [username, count],
    );
  }

  /// `Seen by {username} and {username2}`
  String seenByUserAndUser(Object username, Object username2) {
    return Intl.message(
      'Seen by $username and $username2',
      name: 'seenByUserAndUser',
      desc: '',
      args: [username, username2],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Send a message`
  String get sendAMessage {
    return Intl.message(
      'Send a message',
      name: 'sendAMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send as text`
  String get sendAsText {
    return Intl.message(
      'Send as text',
      name: 'sendAsText',
      desc: '',
      args: [],
    );
  }

  /// `Send audio`
  String get sendAudio {
    return Intl.message(
      'Send audio',
      name: 'sendAudio',
      desc: '',
      args: [],
    );
  }

  /// `Send file`
  String get sendFile {
    return Intl.message(
      'Send file',
      name: 'sendFile',
      desc: '',
      args: [],
    );
  }

  /// `Send image`
  String get sendImage {
    return Intl.message(
      'Send image',
      name: 'sendImage',
      desc: '',
      args: [],
    );
  }

  /// `Send messages`
  String get sendMessages {
    return Intl.message(
      'Send messages',
      name: 'sendMessages',
      desc: '',
      args: [],
    );
  }

  /// `Send original`
  String get sendOriginal {
    return Intl.message(
      'Send original',
      name: 'sendOriginal',
      desc: '',
      args: [],
    );
  }

  /// `Send sticker`
  String get sendSticker {
    return Intl.message(
      'Send sticker',
      name: 'sendSticker',
      desc: '',
      args: [],
    );
  }

  /// `Send video`
  String get sendVideo {
    return Intl.message(
      'Send video',
      name: 'sendVideo',
      desc: '',
      args: [],
    );
  }

  /// `📁 {username} sent a file`
  String sentAFile(Object username) {
    return Intl.message(
      '📁 $username sent a file',
      name: 'sentAFile',
      desc: '',
      args: [username],
    );
  }

  /// `🎤 {username} sent an audio`
  String sentAnAudio(Object username) {
    return Intl.message(
      '🎤 $username sent an audio',
      name: 'sentAnAudio',
      desc: '',
      args: [username],
    );
  }

  /// `🖼️ {username} sent a picture`
  String sentAPicture(Object username) {
    return Intl.message(
      '🖼️ $username sent a picture',
      name: 'sentAPicture',
      desc: '',
      args: [username],
    );
  }

  /// `😊 {username} sent a sticker`
  String sentASticker(Object username) {
    return Intl.message(
      '😊 $username sent a sticker',
      name: 'sentASticker',
      desc: '',
      args: [username],
    );
  }

  /// `🎥 {username} sent a video`
  String sentAVideo(Object username) {
    return Intl.message(
      '🎥 $username sent a video',
      name: 'sentAVideo',
      desc: '',
      args: [username],
    );
  }

  /// `{senderName} sent call information`
  String sentCallInformations(Object senderName) {
    return Intl.message(
      '$senderName sent call information',
      name: 'sentCallInformations',
      desc: '',
      args: [senderName],
    );
  }

  /// `Separate Direct Chats and Groups`
  String get separateChatTypes {
    return Intl.message(
      'Separate Direct Chats and Groups',
      name: 'separateChatTypes',
      desc: '',
      args: [],
    );
  }

  /// `Set as main alias`
  String get setAsCanonicalAlias {
    return Intl.message(
      'Set as main alias',
      name: 'setAsCanonicalAlias',
      desc: '',
      args: [],
    );
  }

  /// `Set custom emotes`
  String get setCustomEmotes {
    return Intl.message(
      'Set custom emotes',
      name: 'setCustomEmotes',
      desc: '',
      args: [],
    );
  }

  /// `Set group description`
  String get setGroupDescription {
    return Intl.message(
      'Set group description',
      name: 'setGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Set invitation link`
  String get setInvitationLink {
    return Intl.message(
      'Set invitation link',
      name: 'setInvitationLink',
      desc: '',
      args: [],
    );
  }

  /// `Set permissions level`
  String get setPermissionsLevel {
    return Intl.message(
      'Set permissions level',
      name: 'setPermissionsLevel',
      desc: '',
      args: [],
    );
  }

  /// `Set status`
  String get setStatus {
    return Intl.message(
      'Set status',
      name: 'setStatus',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `{username} shared their location`
  String sharedTheLocation(Object username) {
    return Intl.message(
      '$username shared their location',
      name: 'sharedTheLocation',
      desc: '',
      args: [username],
    );
  }

  /// `Share location`
  String get shareLocation {
    return Intl.message(
      'Share location',
      name: 'shareLocation',
      desc: '',
      args: [],
    );
  }

  /// `Show related Direct Chats in Spaces`
  String get showDirectChatsInSpaces {
    return Intl.message(
      'Show related Direct Chats in Spaces',
      name: 'showDirectChatsInSpaces',
      desc: '',
      args: [],
    );
  }

  /// `Show password`
  String get showPassword {
    return Intl.message(
      'Show password',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Single Sign on`
  String get singlesignon {
    return Intl.message(
      'Single Sign on',
      name: 'singlesignon',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Source code`
  String get sourceCode {
    return Intl.message(
      'Source code',
      name: 'sourceCode',
      desc: '',
      args: [],
    );
  }

  /// `Space is public`
  String get spaceIsPublic {
    return Intl.message(
      'Space is public',
      name: 'spaceIsPublic',
      desc: '',
      args: [],
    );
  }

  /// `Space name`
  String get spaceName {
    return Intl.message(
      'Space name',
      name: 'spaceName',
      desc: '',
      args: [],
    );
  }

  /// `{senderName} started a call`
  String startedACall(Object senderName) {
    return Intl.message(
      '$senderName started a call',
      name: 'startedACall',
      desc: '',
      args: [senderName],
    );
  }

  /// `Start your first chat`
  String get startFirstChat {
    return Intl.message(
      'Start your first chat',
      name: 'startFirstChat',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `How are you today?`
  String get statusExampleMessage {
    return Intl.message(
      'How are you today?',
      name: 'statusExampleMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Synchronizing… Please wait.`
  String get synchronizingPleaseWait {
    return Intl.message(
      'Synchronizing… Please wait.',
      name: 'synchronizingPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get systemTheme {
    return Intl.message(
      'System',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `They Don't Match`
  String get theyDontMatch {
    return Intl.message(
      'They Don\'t Match',
      name: 'theyDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `They Match`
  String get theyMatch {
    return Intl.message(
      'They Match',
      name: 'theyMatch',
      desc: '',
      args: [],
    );
  }

  /// `FluffyChat`
  String get title {
    return Intl.message(
      'FluffyChat',
      name: 'title',
      desc: 'Title for the application',
      args: [],
    );
  }

  /// `Toggle Favorite`
  String get toggleFavorite {
    return Intl.message(
      'Toggle Favorite',
      name: 'toggleFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Toggle Muted`
  String get toggleMuted {
    return Intl.message(
      'Toggle Muted',
      name: 'toggleMuted',
      desc: '',
      args: [],
    );
  }

  /// `Mark Read/Unread`
  String get toggleUnread {
    return Intl.message(
      'Mark Read/Unread',
      name: 'toggleUnread',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests. Please try again later!`
  String get tooManyRequestsWarning {
    return Intl.message(
      'Too many requests. Please try again later!',
      name: 'tooManyRequestsWarning',
      desc: '',
      args: [],
    );
  }

  /// `Transfer from another device`
  String get transferFromAnotherDevice {
    return Intl.message(
      'Transfer from another device',
      name: 'transferFromAnotherDevice',
      desc: '',
      args: [],
    );
  }

  /// `Try to send again`
  String get tryToSendAgain {
    return Intl.message(
      'Try to send again',
      name: 'tryToSendAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get unavailable {
    return Intl.message(
      'Unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `{username} unbanned {targetName}`
  String unbannedUser(Object username, Object targetName) {
    return Intl.message(
      '$username unbanned $targetName',
      name: 'unbannedUser',
      desc: '',
      args: [username, targetName],
    );
  }

  /// `Unblock Device`
  String get unblockDevice {
    return Intl.message(
      'Unblock Device',
      name: 'unblockDevice',
      desc: '',
      args: [],
    );
  }

  /// `Unknown device`
  String get unknownDevice {
    return Intl.message(
      'Unknown device',
      name: 'unknownDevice',
      desc: '',
      args: [],
    );
  }

  /// `Unknown encryption algorithm`
  String get unknownEncryptionAlgorithm {
    return Intl.message(
      'Unknown encryption algorithm',
      name: 'unknownEncryptionAlgorithm',
      desc: '',
      args: [],
    );
  }

  /// `Unmute chat`
  String get unmuteChat {
    return Intl.message(
      'Unmute chat',
      name: 'unmuteChat',
      desc: '',
      args: [],
    );
  }

  /// `Unpin`
  String get unpin {
    return Intl.message(
      'Unpin',
      name: 'unpin',
      desc: '',
      args: [],
    );
  }

  /// `{unreadCount, plural, =1{1 unread chat} other{{unreadCount} unread chats}}`
  String unreadChats(num unreadCount) {
    return Intl.plural(
      unreadCount,
      one: '1 unread chat',
      other: '$unreadCount unread chats',
      name: 'unreadChats',
      desc: '',
      args: [unreadCount],
    );
  }

  /// `{username} and {count} others are typing…`
  String userAndOthersAreTyping(Object username, Object count) {
    return Intl.message(
      '$username and $count others are typing…',
      name: 'userAndOthersAreTyping',
      desc: '',
      args: [username, count],
    );
  }

  /// `{username} and {username2} are typing…`
  String userAndUserAreTyping(Object username, Object username2) {
    return Intl.message(
      '$username and $username2 are typing…',
      name: 'userAndUserAreTyping',
      desc: '',
      args: [username, username2],
    );
  }

  /// `{username} is typing…`
  String userIsTyping(Object username) {
    return Intl.message(
      '$username is typing…',
      name: 'userIsTyping',
      desc: '',
      args: [username],
    );
  }

  /// `🚪 {username} left the chat`
  String userLeftTheChat(Object username) {
    return Intl.message(
      '🚪 $username left the chat',
      name: 'userLeftTheChat',
      desc: '',
      args: [username],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `{username} sent a {type} event`
  String userSentUnknownEvent(Object username, Object type) {
    return Intl.message(
      '$username sent a $type event',
      name: 'userSentUnknownEvent',
      desc: '',
      args: [username, type],
    );
  }

  /// `Unverified`
  String get unverified {
    return Intl.message(
      'Unverified',
      name: 'unverified',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Start Verification`
  String get verifyStart {
    return Intl.message(
      'Start Verification',
      name: 'verifyStart',
      desc: '',
      args: [],
    );
  }

  /// `You successfully verified!`
  String get verifySuccess {
    return Intl.message(
      'You successfully verified!',
      name: 'verifySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Verifying other account`
  String get verifyTitle {
    return Intl.message(
      'Verifying other account',
      name: 'verifyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Video call`
  String get videoCall {
    return Intl.message(
      'Video call',
      name: 'videoCall',
      desc: '',
      args: [],
    );
  }

  /// `Visibility of the chat history`
  String get visibilityOfTheChatHistory {
    return Intl.message(
      'Visibility of the chat history',
      name: 'visibilityOfTheChatHistory',
      desc: '',
      args: [],
    );
  }

  /// `Visible for all participants`
  String get visibleForAllParticipants {
    return Intl.message(
      'Visible for all participants',
      name: 'visibleForAllParticipants',
      desc: '',
      args: [],
    );
  }

  /// `Visible for everyone`
  String get visibleForEveryone {
    return Intl.message(
      'Visible for everyone',
      name: 'visibleForEveryone',
      desc: '',
      args: [],
    );
  }

  /// `Voice message`
  String get voiceMessage {
    return Intl.message(
      'Voice message',
      name: 'voiceMessage',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for partner to accept the request…`
  String get waitingPartnerAcceptRequest {
    return Intl.message(
      'Waiting for partner to accept the request…',
      name: 'waitingPartnerAcceptRequest',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for partner to accept the emoji…`
  String get waitingPartnerEmoji {
    return Intl.message(
      'Waiting for partner to accept the emoji…',
      name: 'waitingPartnerEmoji',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for partner to accept the numbers…`
  String get waitingPartnerNumbers {
    return Intl.message(
      'Waiting for partner to accept the numbers…',
      name: 'waitingPartnerNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Wallpaper`
  String get wallpaper {
    return Intl.message(
      'Wallpaper',
      name: 'wallpaper',
      desc: '',
      args: [],
    );
  }

  /// `Warning!`
  String get warning {
    return Intl.message(
      'Warning!',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `We sent you an email`
  String get weSentYouAnEmail {
    return Intl.message(
      'We sent you an email',
      name: 'weSentYouAnEmail',
      desc: '',
      args: [],
    );
  }

  /// `Who can perform which action`
  String get whoCanPerformWhichAction {
    return Intl.message(
      'Who can perform which action',
      name: 'whoCanPerformWhichAction',
      desc: '',
      args: [],
    );
  }

  /// `Who is allowed to join this group`
  String get whoIsAllowedToJoinThisGroup {
    return Intl.message(
      'Who is allowed to join this group',
      name: 'whoIsAllowedToJoinThisGroup',
      desc: '',
      args: [],
    );
  }

  /// `Why do you want to report this?`
  String get whyDoYouWantToReportThis {
    return Intl.message(
      'Why do you want to report this?',
      name: 'whyDoYouWantToReportThis',
      desc: '',
      args: [],
    );
  }

  /// `Wipe your chat backup to create a new recovery key?`
  String get wipeChatBackup {
    return Intl.message(
      'Wipe your chat backup to create a new recovery key?',
      name: 'wipeChatBackup',
      desc: '',
      args: [],
    );
  }

  /// `With these addresses you can recover your password.`
  String get withTheseAddressesRecoveryDescription {
    return Intl.message(
      'With these addresses you can recover your password.',
      name: 'withTheseAddressesRecoveryDescription',
      desc: '',
      args: [],
    );
  }

  /// `Write a message…`
  String get writeAMessage {
    return Intl.message(
      'Write a message…',
      name: 'writeAMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get you {
    return Intl.message(
      'You',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `You are invited to this chat`
  String get youAreInvitedToThisChat {
    return Intl.message(
      'You are invited to this chat',
      name: 'youAreInvitedToThisChat',
      desc: '',
      args: [],
    );
  }

  /// `You are no longer participating in this chat`
  String get youAreNoLongerParticipatingInThisChat {
    return Intl.message(
      'You are no longer participating in this chat',
      name: 'youAreNoLongerParticipatingInThisChat',
      desc: '',
      args: [],
    );
  }

  /// `You cannot invite yourself`
  String get youCannotInviteYourself {
    return Intl.message(
      'You cannot invite yourself',
      name: 'youCannotInviteYourself',
      desc: '',
      args: [],
    );
  }

  /// `You have been banned from this chat`
  String get youHaveBeenBannedFromThisChat {
    return Intl.message(
      'You have been banned from this chat',
      name: 'youHaveBeenBannedFromThisChat',
      desc: '',
      args: [],
    );
  }

  /// `Your public key`
  String get yourPublicKey {
    return Intl.message(
      'Your public key',
      name: 'yourPublicKey',
      desc: '',
      args: [],
    );
  }

  /// `Message info`
  String get messageInfo {
    return Intl.message(
      'Message info',
      name: 'messageInfo',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Message Type`
  String get messageType {
    return Intl.message(
      'Message Type',
      name: 'messageType',
      desc: '',
      args: [],
    );
  }

  /// `Sender`
  String get sender {
    return Intl.message(
      'Sender',
      name: 'sender',
      desc: '',
      args: [],
    );
  }

  /// `Open gallery`
  String get openGallery {
    return Intl.message(
      'Open gallery',
      name: 'openGallery',
      desc: '',
      args: [],
    );
  }

  /// `Remove from space`
  String get removeFromSpace {
    return Intl.message(
      'Remove from space',
      name: 'removeFromSpace',
      desc: '',
      args: [],
    );
  }

  /// `Select a space to add this chat to it.`
  String get addToSpaceDescription {
    return Intl.message(
      'Select a space to add this chat to it.',
      name: 'addToSpaceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `To unlock your old messages, please enter your recovery key that has been generated in a previous session. Your recovery key is NOT your password.`
  String get pleaseEnterRecoveryKeyDescription {
    return Intl.message(
      'To unlock your old messages, please enter your recovery key that has been generated in a previous session. Your recovery key is NOT your password.',
      name: 'pleaseEnterRecoveryKeyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add to story`
  String get addToStory {
    return Intl.message(
      'Add to story',
      name: 'addToStory',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Who can see my stories?`
  String get whoCanSeeMyStories {
    return Intl.message(
      'Who can see my stories?',
      name: 'whoCanSeeMyStories',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribe stories`
  String get unsubscribeStories {
    return Intl.message(
      'Unsubscribe stories',
      name: 'unsubscribeStories',
      desc: '',
      args: [],
    );
  }

  /// `This user has not posted anything in their story yet`
  String get thisUserHasNotPostedAnythingYet {
    return Intl.message(
      'This user has not posted anything in their story yet',
      name: 'thisUserHasNotPostedAnythingYet',
      desc: '',
      args: [],
    );
  }

  /// `Your story`
  String get yourStory {
    return Intl.message(
      'Your story',
      name: 'yourStory',
      desc: '',
      args: [],
    );
  }

  /// `Reply has been sent`
  String get replyHasBeenSent {
    return Intl.message(
      'Reply has been sent',
      name: 'replyHasBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `Video ({size})`
  String videoWithSize(Object size) {
    return Intl.message(
      'Video ($size)',
      name: 'videoWithSize',
      desc: '',
      args: [size],
    );
  }

  /// `Story from {date}: \n{body}`
  String storyFrom(Object date, Object body) {
    return Intl.message(
      'Story from $date: \n$body',
      name: 'storyFrom',
      desc: '',
      args: [date, body],
    );
  }

  /// `Please note that people can see and contact each other in your story.`
  String get whoCanSeeMyStoriesDesc {
    return Intl.message(
      'Please note that people can see and contact each other in your story.',
      name: 'whoCanSeeMyStoriesDesc',
      desc: '',
      args: [],
    );
  }

  /// `What is going on?`
  String get whatIsGoingOn {
    return Intl.message(
      'What is going on?',
      name: 'whatIsGoingOn',
      desc: '',
      args: [],
    );
  }

  /// `Add description`
  String get addDescription {
    return Intl.message(
      'Add description',
      name: 'addDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please note that people can see and contact each other in your story. Your stories will be visible for 24 hours but there is no guarantee that they will be deleted from all devices and servers.`
  String get storyPrivacyWarning {
    return Intl.message(
      'Please note that people can see and contact each other in your story. Your stories will be visible for 24 hours but there is no guarantee that they will be deleted from all devices and servers.',
      name: 'storyPrivacyWarning',
      desc: '',
      args: [],
    );
  }

  /// `I understand`
  String get iUnderstand {
    return Intl.message(
      'I understand',
      name: 'iUnderstand',
      desc: '',
      args: [],
    );
  }

  /// `Open Chat`
  String get openChat {
    return Intl.message(
      'Open Chat',
      name: 'openChat',
      desc: '',
      args: [],
    );
  }

  /// `Mark as read`
  String get markAsRead {
    return Intl.message(
      'Mark as read',
      name: 'markAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Report user`
  String get reportUser {
    return Intl.message(
      'Report user',
      name: 'reportUser',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Matrix Widgets`
  String get matrixWidgets {
    return Intl.message(
      'Matrix Widgets',
      name: 'matrixWidgets',
      desc: '',
      args: [],
    );
  }

  /// `{sender} reacted with {reaction}`
  String reactedWith(Object sender, Object reaction) {
    return Intl.message(
      '$sender reacted with $reaction',
      name: 'reactedWith',
      desc: '',
      args: [sender, reaction],
    );
  }

  /// `Pin to room`
  String get pinMessage {
    return Intl.message(
      'Pin to room',
      name: 'pinMessage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to permanently unpin the event?`
  String get confirmEventUnpin {
    return Intl.message(
      'Are you sure to permanently unpin the event?',
      name: 'confirmEventUnpin',
      desc: '',
      args: [],
    );
  }

  /// `Emojis`
  String get emojis {
    return Intl.message(
      'Emojis',
      name: 'emojis',
      desc: '',
      args: [],
    );
  }

  /// `Place call`
  String get placeCall {
    return Intl.message(
      'Place call',
      name: 'placeCall',
      desc: '',
      args: [],
    );
  }

  /// `Voice call`
  String get voiceCall {
    return Intl.message(
      'Voice call',
      name: 'voiceCall',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Android version`
  String get unsupportedAndroidVersion {
    return Intl.message(
      'Unsupported Android version',
      name: 'unsupportedAndroidVersion',
      desc: '',
      args: [],
    );
  }

  /// `This feature requires a newer Android version. Please check for updates or Lineage OS support.`
  String get unsupportedAndroidVersionLong {
    return Intl.message(
      'This feature requires a newer Android version. Please check for updates or Lineage OS support.',
      name: 'unsupportedAndroidVersionLong',
      desc: '',
      args: [],
    );
  }

  /// `Please note that video calls are currently in beta. They might not work as expected or work at all on all platforms.`
  String get videoCallsBetaWarning {
    return Intl.message(
      'Please note that video calls are currently in beta. They might not work as expected or work at all on all platforms.',
      name: 'videoCallsBetaWarning',
      desc: '',
      args: [],
    );
  }

  /// `Experimental video calls`
  String get experimentalVideoCalls {
    return Intl.message(
      'Experimental video calls',
      name: 'experimentalVideoCalls',
      desc: '',
      args: [],
    );
  }

  /// `Email or username`
  String get emailOrUsername {
    return Intl.message(
      'Email or username',
      name: 'emailOrUsername',
      desc: '',
      args: [],
    );
  }

  /// `Private mode issues`
  String get indexedDbErrorTitle {
    return Intl.message(
      'Private mode issues',
      name: 'indexedDbErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `The message storage is unfortunately not enabled in private mode by default.\nPlease visit\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\nOtherwise, it is not possible to run FluffyChat.`
  String get indexedDbErrorLong {
    return Intl.message(
      'The message storage is unfortunately not enabled in private mode by default.\nPlease visit\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\nOtherwise, it is not possible to run FluffyChat.',
      name: 'indexedDbErrorLong',
      desc: '',
      args: [],
    );
  }

  /// `Switch to account {number}`
  String switchToAccount(Object number) {
    return Intl.message(
      'Switch to account $number',
      name: 'switchToAccount',
      desc: '',
      args: [number],
    );
  }

  /// `Next account`
  String get nextAccount {
    return Intl.message(
      'Next account',
      name: 'nextAccount',
      desc: '',
      args: [],
    );
  }

  /// `Previous account`
  String get previousAccount {
    return Intl.message(
      'Previous account',
      name: 'previousAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit widgets`
  String get editWidgets {
    return Intl.message(
      'Edit widgets',
      name: 'editWidgets',
      desc: '',
      args: [],
    );
  }

  /// `Add widget`
  String get addWidget {
    return Intl.message(
      'Add widget',
      name: 'addWidget',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get widgetVideo {
    return Intl.message(
      'Video',
      name: 'widgetVideo',
      desc: '',
      args: [],
    );
  }

  /// `Text note`
  String get widgetEtherpad {
    return Intl.message(
      'Text note',
      name: 'widgetEtherpad',
      desc: '',
      args: [],
    );
  }

  /// `Jitsi Meet`
  String get widgetJitsi {
    return Intl.message(
      'Jitsi Meet',
      name: 'widgetJitsi',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get widgetCustom {
    return Intl.message(
      'Custom',
      name: 'widgetCustom',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get widgetName {
    return Intl.message(
      'Name',
      name: 'widgetName',
      desc: '',
      args: [],
    );
  }

  /// `This is not a valid URL.`
  String get widgetUrlError {
    return Intl.message(
      'This is not a valid URL.',
      name: 'widgetUrlError',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a display name.`
  String get widgetNameError {
    return Intl.message(
      'Please provide a display name.',
      name: 'widgetNameError',
      desc: '',
      args: [],
    );
  }

  /// `Error adding the widget.`
  String get errorAddingWidget {
    return Intl.message(
      'Error adding the widget.',
      name: 'errorAddingWidget',
      desc: '',
      args: [],
    );
  }

  /// `You rejected the invitation`
  String get youRejectedTheInvitation {
    return Intl.message(
      'You rejected the invitation',
      name: 'youRejectedTheInvitation',
      desc: '',
      args: [],
    );
  }

  /// `You joined the chat`
  String get youJoinedTheChat {
    return Intl.message(
      'You joined the chat',
      name: 'youJoinedTheChat',
      desc: '',
      args: [],
    );
  }

  /// `👍 You accepted the invitation`
  String get youAcceptedTheInvitation {
    return Intl.message(
      '👍 You accepted the invitation',
      name: 'youAcceptedTheInvitation',
      desc: '',
      args: [],
    );
  }

  /// `You banned {user}`
  String youBannedUser(Object user) {
    return Intl.message(
      'You banned $user',
      name: 'youBannedUser',
      desc: '',
      args: [user],
    );
  }

  /// `You have withdrawn the invitation for {user}`
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return Intl.message(
      'You have withdrawn the invitation for $user',
      name: 'youHaveWithdrawnTheInvitationFor',
      desc: '',
      args: [user],
    );
  }

  /// `📩 You have been invited by {user}`
  String youInvitedBy(Object user) {
    return Intl.message(
      '📩 You have been invited by $user',
      name: 'youInvitedBy',
      desc: '',
      args: [user],
    );
  }

  /// `📩 You invited {user}`
  String youInvitedUser(Object user) {
    return Intl.message(
      '📩 You invited $user',
      name: 'youInvitedUser',
      desc: '',
      args: [user],
    );
  }

  /// `👞 You kicked {user}`
  String youKicked(Object user) {
    return Intl.message(
      '👞 You kicked $user',
      name: 'youKicked',
      desc: '',
      args: [user],
    );
  }

  /// `🙅 You kicked and banned {user}`
  String youKickedAndBanned(Object user) {
    return Intl.message(
      '🙅 You kicked and banned $user',
      name: 'youKickedAndBanned',
      desc: '',
      args: [user],
    );
  }

  /// `You unbanned {user}`
  String youUnbannedUser(Object user) {
    return Intl.message(
      'You unbanned $user',
      name: 'youUnbannedUser',
      desc: '',
      args: [user],
    );
  }

  /// `Please enter a valid email address. Otherwise you won't be able to reset your password. If you don't want to, tap again on the button to continue.`
  String get noEmailWarning {
    return Intl.message(
      'Please enter a valid email address. Otherwise you won\'t be able to reset your password. If you don\'t want to, tap again on the button to continue.',
      name: 'noEmailWarning',
      desc: '',
      args: [],
    );
  }

  /// `Stories`
  String get stories {
    return Intl.message(
      'Stories',
      name: 'stories',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get users {
    return Intl.message(
      'Users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `Unlock old messages`
  String get unlockOldMessages {
    return Intl.message(
      'Unlock old messages',
      name: 'unlockOldMessages',
      desc: '',
      args: [],
    );
  }

  /// `Store the recovery key in the secure storage of this device.`
  String get storeInSecureStorageDescription {
    return Intl.message(
      'Store the recovery key in the secure storage of this device.',
      name: 'storeInSecureStorageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Save this key manually by triggering the system share dialog or clipboard.`
  String get saveKeyManuallyDescription {
    return Intl.message(
      'Save this key manually by triggering the system share dialog or clipboard.',
      name: 'saveKeyManuallyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Store in Android KeyStore`
  String get storeInAndroidKeystore {
    return Intl.message(
      'Store in Android KeyStore',
      name: 'storeInAndroidKeystore',
      desc: '',
      args: [],
    );
  }

  /// `Store in Apple KeyChain`
  String get storeInAppleKeyChain {
    return Intl.message(
      'Store in Apple KeyChain',
      name: 'storeInAppleKeyChain',
      desc: '',
      args: [],
    );
  }

  /// `Store securely on this device`
  String get storeSecurlyOnThisDevice {
    return Intl.message(
      'Store securely on this device',
      name: 'storeSecurlyOnThisDevice',
      desc: '',
      args: [],
    );
  }

  /// `{count} files`
  String countFiles(Object count) {
    return Intl.message(
      '$count files',
      name: 'countFiles',
      desc: '',
      args: [count],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message(
      'Custom',
      name: 'custom',
      desc: '',
      args: [],
    );
  }

  /// `This notification appears when the foreground service is running.`
  String get foregroundServiceRunning {
    return Intl.message(
      'This notification appears when the foreground service is running.',
      name: 'foregroundServiceRunning',
      desc: '',
      args: [],
    );
  }

  /// `screen sharing`
  String get screenSharingTitle {
    return Intl.message(
      'screen sharing',
      name: 'screenSharingTitle',
      desc: '',
      args: [],
    );
  }

  /// `You are sharing your screen in FuffyChat`
  String get screenSharingDetail {
    return Intl.message(
      'You are sharing your screen in FuffyChat',
      name: 'screenSharingDetail',
      desc: '',
      args: [],
    );
  }

  /// `Calling permissions`
  String get callingPermissions {
    return Intl.message(
      'Calling permissions',
      name: 'callingPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Calling account`
  String get callingAccount {
    return Intl.message(
      'Calling account',
      name: 'callingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Allows FluffyChat to use the native android dialer app.`
  String get callingAccountDetails {
    return Intl.message(
      'Allows FluffyChat to use the native android dialer app.',
      name: 'callingAccountDetails',
      desc: '',
      args: [],
    );
  }

  /// `Appear on top`
  String get appearOnTop {
    return Intl.message(
      'Appear on top',
      name: 'appearOnTop',
      desc: '',
      args: [],
    );
  }

  /// `Allows the app to appear on top (not needed if you already have Fluffychat setup as a calling account)`
  String get appearOnTopDetails {
    return Intl.message(
      'Allows the app to appear on top (not needed if you already have Fluffychat setup as a calling account)',
      name: 'appearOnTopDetails',
      desc: '',
      args: [],
    );
  }

  /// `Microphone, camera and other FluffyChat permissions`
  String get otherCallingPermissions {
    return Intl.message(
      'Microphone, camera and other FluffyChat permissions',
      name: 'otherCallingPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Why is this message unreadable?`
  String get whyIsThisMessageEncrypted {
    return Intl.message(
      'Why is this message unreadable?',
      name: 'whyIsThisMessageEncrypted',
      desc: '',
      args: [],
    );
  }

  /// `This can happen if the message was sent before you have signed in to your account at this device.\n\nIt is also possible that the sender has blocked your device or something went wrong with the internet connection.\n\nAre you able to read the message on another session? Then you can transfer the message from it! Go to Settings > Devices and make sure that your devices have verified each other. When you open the room the next time and both sessions are in the foreground, the keys will be transmitted automatically.\n\nDo you not want to lose the keys when logging out or switching devices? Make sure that you have enabled the chat backup in the settings.`
  String get noKeyForThisMessage {
    return Intl.message(
      'This can happen if the message was sent before you have signed in to your account at this device.\n\nIt is also possible that the sender has blocked your device or something went wrong with the internet connection.\n\nAre you able to read the message on another session? Then you can transfer the message from it! Go to Settings > Devices and make sure that your devices have verified each other. When you open the room the next time and both sessions are in the foreground, the keys will be transmitted automatically.\n\nDo you not want to lose the keys when logging out or switching devices? Make sure that you have enabled the chat backup in the settings.',
      name: 'noKeyForThisMessage',
      desc: '',
      args: [],
    );
  }

  /// `New group`
  String get newGroup {
    return Intl.message(
      'New group',
      name: 'newGroup',
      desc: '',
      args: [],
    );
  }

  /// `New space`
  String get newSpace {
    return Intl.message(
      'New space',
      name: 'newSpace',
      desc: '',
      args: [],
    );
  }

  /// `Enter space`
  String get enterSpace {
    return Intl.message(
      'Enter space',
      name: 'enterSpace',
      desc: '',
      args: [],
    );
  }

  /// `Enter room`
  String get enterRoom {
    return Intl.message(
      'Enter room',
      name: 'enterRoom',
      desc: '',
      args: [],
    );
  }

  /// `All spaces`
  String get allSpaces {
    return Intl.message(
      'All spaces',
      name: 'allSpaces',
      desc: '',
      args: [],
    );
  }

  /// `{number} chats`
  String numChats(Object number) {
    return Intl.message(
      '$number chats',
      name: 'numChats',
      desc: '',
      args: [number],
    );
  }

  /// `Hide unimportant state events`
  String get hideUnimportantStateEvents {
    return Intl.message(
      'Hide unimportant state events',
      name: 'hideUnimportantStateEvents',
      desc: '',
      args: [],
    );
  }

  /// `Do not show again`
  String get doNotShowAgain {
    return Intl.message(
      'Do not show again',
      name: 'doNotShowAgain',
      desc: '',
      args: [],
    );
  }

  /// `Empty chat (was {oldDisplayName})`
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return Intl.message(
      'Empty chat (was $oldDisplayName)',
      name: 'wasDirectChatDisplayName',
      desc: '',
      args: [oldDisplayName],
    );
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Search Currency Here`
  String get searchC {
    return Intl.message(
      'Search Currency Here',
      name: 'searchC',
      desc: '',
      args: [],
    );
  }

  /// `Search Language Here`
  String get searchL {
    return Intl.message(
      'Search Language Here',
      name: 'searchL',
      desc: '',
      args: [],
    );
  }

  /// `Currency Converter`
  String get cc {
    return Intl.message(
      'Currency Converter',
      name: 'cc',
      desc: '',
      args: [],
    );
  }

  /// `Convert`
  String get convert {
    return Intl.message(
      'Convert',
      name: 'convert',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enterA {
    return Intl.message(
      'Enter Amount',
      name: 'enterA',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get his {
    return Intl.message(
      'History',
      name: 'his',
      desc: '',
      args: [],
    );
  }

  /// `Currency Rates by Open Exchange Rates`
  String get qou {
    return Intl.message(
      'Currency Rates by Open Exchange Rates',
      name: 'qou',
      desc: '',
      args: [],
    );
  }

  /// `Spaces allows you to consolidate your chats and build private or public communities.`
  String get newSpaceDescription {
    return Intl.message(
      'Spaces allows you to consolidate your chats and build private or public communities.',
      name: 'newSpaceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Encrypt this chat`
  String get encryptThisChat {
    return Intl.message(
      'Encrypt this chat',
      name: 'encryptThisChat',
      desc: '',
      args: [],
    );
  }

  /// `End to end encryption`
  String get endToEndEncryption {
    return Intl.message(
      'End to end encryption',
      name: 'endToEndEncryption',
      desc: '',
      args: [],
    );
  }

  /// `For security reasons you can not disable encryption in a chat, where it has been enabled before.`
  String get disableEncryptionWarning {
    return Intl.message(
      'For security reasons you can not disable encryption in a chat, where it has been enabled before.',
      name: 'disableEncryptionWarning',
      desc: '',
      args: [],
    );
  }

  /// `Sorry... that is not possible`
  String get sorryThatsNotPossible {
    return Intl.message(
      'Sorry... that is not possible',
      name: 'sorryThatsNotPossible',
      desc: '',
      args: [],
    );
  }

  /// `Device keys:`
  String get deviceKeys {
    return Intl.message(
      'Device keys:',
      name: 'deviceKeys',
      desc: '',
      args: [],
    );
  }

  /// `Let's start`
  String get letsStart {
    return Intl.message(
      'Let\'s start',
      name: 'letsStart',
      desc: '',
      args: [],
    );
  }

  /// `Enter invite link or Matrix ID...`
  String get enterInviteLinkOrMatrixId {
    return Intl.message(
      'Enter invite link or Matrix ID...',
      name: 'enterInviteLinkOrMatrixId',
      desc: '',
      args: [],
    );
  }

  /// `Reopen chat`
  String get reopenChat {
    return Intl.message(
      'Reopen chat',
      name: 'reopenChat',
      desc: '',
      args: [],
    );
  }

  /// `Warning! Without enabling chat backup, you will lose access to your encrypted messages. It is highly recommended to enable the chat backup first before logging out.`
  String get noBackupWarning {
    return Intl.message(
      'Warning! Without enabling chat backup, you will lose access to your encrypted messages. It is highly recommended to enable the chat backup first before logging out.',
      name: 'noBackupWarning',
      desc: '',
      args: [],
    );
  }

  /// `No other devices found`
  String get noOtherDevicesFound {
    return Intl.message(
      'No other devices found',
      name: 'noOtherDevicesFound',
      desc: '',
      args: [],
    );
  }

  /// `The server reports that the file is too large to be sent.`
  String get fileIsTooBigForServer {
    return Intl.message(
      'The server reports that the file is too large to be sent.',
      name: 'fileIsTooBigForServer',
      desc: '',
      args: [],
    );
  }

  /// `File has been saved at {path}`
  String fileHasBeenSavedAt(Object path) {
    return Intl.message(
      'File has been saved at $path',
      name: 'fileHasBeenSavedAt',
      desc: '',
      args: [path],
    );
  }

  /// `Jump to last read message`
  String get jumpToLastReadMessage {
    return Intl.message(
      'Jump to last read message',
      name: 'jumpToLastReadMessage',
      desc: '',
      args: [],
    );
  }

  /// `Read up to here`
  String get readUpToHere {
    return Intl.message(
      'Read up to here',
      name: 'readUpToHere',
      desc: '',
      args: [],
    );
  }

  /// `Jump`
  String get jump {
    return Intl.message(
      'Jump',
      name: 'jump',
      desc: '',
      args: [],
    );
  }

  /// `Open link in browser`
  String get openLinkInBrowser {
    return Intl.message(
      'Open link in browser',
      name: 'openLinkInBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Oh no. Something went wrong. Please try again later. If you want, you can report the bug to the developers.`
  String get reportErrorDescription {
    return Intl.message(
      'Oh no. Something went wrong. Please try again later. If you want, you can report the bug to the developers.',
      name: 'reportErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `report`
  String get report {
    return Intl.message(
      'report',
      name: 'report',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'bo'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'eo'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'et'),
      Locale.fromSubtags(languageCode: 'eu'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ga'),
      Locale.fromSubtags(languageCode: 'gl'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'hr'),
      Locale.fromSubtags(languageCode: 'hu'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'ie'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'lt'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'PT'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sk'),
      Locale.fromSubtags(languageCode: 'sl'),
      Locale.fromSubtags(languageCode: 'sr'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
