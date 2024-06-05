// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(username) => "👍 ${username} accepted the invitation";

  static String m1(username) =>
      "🔐 ${username} activated end to end encryption";

  static String m2(senderName) => "${senderName} answered the call";

  static String m3(username) =>
      "Accept this verification request from ${username}?";

  static String m4(username, targetName) => "${username} banned ${targetName}";

  static String m5(uri) => "Can\'t open the URI ${uri}";

  static String m6(username) => "${username} changed the chat avatar";

  static String m7(username, description) =>
      "${username} changed the chat description to: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} changed the chat name to: \'${chatname}\'";

  static String m9(username) => "${username} changed the chat permissions";

  static String m10(username, displayname) =>
      "${username} changed their displayname to: \'${displayname}\'";

  static String m11(username) => "${username} changed the guest access rules";

  static String m12(username, rules) =>
      "${username} changed the guest access rules to: ${rules}";

  static String m13(username) => "${username} changed the history visibility";

  static String m14(username, rules) =>
      "${username} changed the history visibility to: ${rules}";

  static String m15(username) => "${username} changed the join rules";

  static String m16(username, joinRules) =>
      "${username} changed the join rules to: ${joinRules}";

  static String m17(username) => "${username} changed their avatar";

  static String m18(username) => "${username} changed the room aliases";

  static String m19(username) => "${username} changed the invitation link";

  static String m20(command) => "${command} is not a command.";

  static String m21(error) => "Could not decrypt message: ${error}";

  static String m22(count) => "${count} files";

  static String m23(count) => "${count} participants";

  static String m24(username) => "💬 ${username} created the chat";

  static String m25(senderName) => "${senderName} cuddles you";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}-${month}-${day}";

  static String m28(month, day) => "${month}-${day}";

  static String m29(senderName) => "${senderName} ended the call";

  static String m30(error) => "Error obtaining location: ${error}";

  static String m31(path) => "File has been saved at ${path}";

  static String m32(senderName) => "${senderName} sends you googly eyes";

  static String m33(displayname) => "Group with ${displayname}";

  static String m34(username, targetName) =>
      "${username} has withdrawn the invitation for ${targetName}";

  static String m35(senderName) => "${senderName} hugs you";

  static String m36(groupName) => "Invite contact to ${groupName}";

  static String m37(username, link) =>
      "${username} invited you to FluffyChat. \n1. Install FluffyChat: https://fluffychat.im \n2. Sign up or sign in \n3. Open the invite link: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} invited ${targetName}";

  static String m39(username) => "👋 ${username} joined the chat";

  static String m40(username, targetName) =>
      "👞 ${username} kicked ${targetName}";

  static String m41(username, targetName) =>
      "🙅 ${username} kicked and banned ${targetName}";

  static String m42(localizedTimeShort) => "Last active: ${localizedTimeShort}";

  static String m43(count) => "Load ${count} more participants";

  static String m44(homeserver) => "Log in to ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} is no matrix server, use ${server2} instead?";

  static String m46(number) => "${number} chats";

  static String m47(count) => "${count} users are typing…";

  static String m48(fileName) => "Play ${fileName}";

  static String m49(min) => "Please choose at least ${min} characters.";

  static String m50(sender, reaction) => "${sender} reacted with ${reaction}";

  static String m51(username) => "${username} redacted an event";

  static String m52(username) => "${username} rejected the invitation";

  static String m53(username) => "Removed by ${username}";

  static String m54(username) => "Seen by ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Seen by ${username} and ${count} others')}";

  static String m56(username, username2) =>
      "Seen by ${username} and ${username2}";

  static String m57(username) => "📁 ${username} sent a file";

  static String m58(username) => "🖼️ ${username} sent a picture";

  static String m59(username) => "😊 ${username} sent a sticker";

  static String m60(username) => "🎥 ${username} sent a video";

  static String m61(username) => "🎤 ${username} sent an audio";

  static String m62(senderName) => "${senderName} sent call information";

  static String m63(username) => "${username} shared their location";

  static String m64(senderName) => "${senderName} started a call";

  static String m65(date, body) => "Story from ${date}: \n${body}";

  static String m66(mxid) => "This should be ${mxid}";

  static String m67(number) => "Switch to account ${number}";

  static String m68(username, targetName) =>
      "${username} unbanned ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 unread chat', other: '${unreadCount} unread chats')}";

  static String m70(username, count) =>
      "${username} and ${count} others are typing…";

  static String m71(username, username2) =>
      "${username} and ${username2} are typing…";

  static String m72(username) => "${username} is typing…";

  static String m73(username) => "🚪 ${username} left the chat";

  static String m74(username, type) => "${username} sent a ${type} event";

  static String m75(size) => "Video (${size})";

  static String m76(oldDisplayName) => "Empty chat (was ${oldDisplayName})";

  static String m77(user) => "You banned ${user}";

  static String m78(user) => "You have withdrawn the invitation for ${user}";

  static String m79(user) => "📩 You have been invited by ${user}";

  static String m80(user) => "📩 You invited ${user}";

  static String m81(user) => "👞 You kicked ${user}";

  static String m82(user) => "🙅 You kicked and banned ${user}";

  static String m83(user) => "You unbanned ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "aboutCryptoPills":
            MessageLookupByLibrary.simpleMessage("About Crypto-Pills"),
        "aboutUs": MessageLookupByLibrary.simpleMessage("About us"),
        "accelerate": MessageLookupByLibrary.simpleMessage("Accelerate"),
        "accept": MessageLookupByLibrary.simpleMessage("Accept"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "actions": MessageLookupByLibrary.simpleMessage("Actions"),
        "activatedEndToEndEncryption": m1,
        "activities": MessageLookupByLibrary.simpleMessage("Activities"),
        "activity": MessageLookupByLibrary.simpleMessage("Activity"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addAMessage": MessageLookupByLibrary.simpleMessage("Add a message..."),
        "addAccount": MessageLookupByLibrary.simpleMessage("Add account"),
        "addAttributes": MessageLookupByLibrary.simpleMessage("Add attributes"),
        "addContent": MessageLookupByLibrary.simpleMessage("Add Content"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Add description"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Add email"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Add a group description"),
        "addMore": MessageLookupByLibrary.simpleMessage("Add more"),
        "addNewCard": MessageLookupByLibrary.simpleMessage("Add New Card"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("Add to bundle"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("Add to space"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Select a space to add this chat to it."),
        "addToStory": MessageLookupByLibrary.simpleMessage("Add to story"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Add widget"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "admin": MessageLookupByLibrary.simpleMessage("Admin"),
        "afterTx": MessageLookupByLibrary.simpleMessage("After "),
        "agbsImpress":
            MessageLookupByLibrary.simpleMessage("Agbs and Impressum"),
        "alias": MessageLookupByLibrary.simpleMessage("alias"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "allChats": MessageLookupByLibrary.simpleMessage("All chats"),
        "allItems": MessageLookupByLibrary.simpleMessage("All Items"),
        "allRooms": MessageLookupByLibrary.simpleMessage("All Group Chats"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("All spaces"),
        "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
            "You already have an registered Account?"),
        "amount": MessageLookupByLibrary.simpleMessage("Amount"),
        "analysis": MessageLookupByLibrary.simpleMessage("Analysis"),
        "analysisStockCovered": MessageLookupByLibrary.simpleMessage(
            "The stock is covered by 67 analysts. The average assesment is:"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Anyone can join"),
        "appAllowsUsers": MessageLookupByLibrary.simpleMessage(
            "The app allows users to receive, send, and manage Bitcoins.\nThe app is not a bank and does not offer banking services."),
        "appLock": MessageLookupByLibrary.simpleMessage("App lock"),
        "appearOnTop": MessageLookupByLibrary.simpleMessage("Appear on top"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Allows the app to appear on top (not needed if you already have Fluffychat setup as a calling account)"),
        "apply": MessageLookupByLibrary.simpleMessage("Apply"),
        "archive": MessageLookupByLibrary.simpleMessage("Archive"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Are guest users allowed to join"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to log out?"),
        "art": MessageLookupByLibrary.simpleMessage("Art"),
        "askFriendsForRecovery": MessageLookupByLibrary.simpleMessage(
            "Ask your friends to open the app and navigate to Profile > Settings > Security > Social Recovery for friends."),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "To be able to sign the other person, please enter your secure store passphrase or recovery key."),
        "askVerificationRequest": m3,
        "assetMintError": MessageLookupByLibrary.simpleMessage(
            "Failed to mint asset: You might already have an asset with a similar name in your list."),
        "assets": MessageLookupByLibrary.simpleMessage("Assets"),
        "autoLong": MessageLookupByLibrary.simpleMessage("auto long"),
        "autoShort": MessageLookupByLibrary.simpleMessage("auto short"),
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Automatically play animated stickers and emotes"),
        "availabilityProvider": MessageLookupByLibrary.simpleMessage(
            "Availability: The provider expressly reserves the right to \nchange, supplement, delete parts of the pages or the entire offer without \nspecial notice, or to temporarily or permanently cease publication."),
        "badCharacters": MessageLookupByLibrary.simpleMessage("Bad characters"),
        "balance": MessageLookupByLibrary.simpleMessage("Balance"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("Ban from chat"),
        "banned": MessageLookupByLibrary.simpleMessage("Banned"),
        "bannedUser": m4,
        "beAPart": MessageLookupByLibrary.simpleMessage(
            "Be a Part of the Revolution - Download Our App Today!"),
        "beAmongFirst": MessageLookupByLibrary.simpleMessage(
            "Be among the first million users and secure your exclusive early-bird Bitcoin inscription."),
        "bear": MessageLookupByLibrary.simpleMessage("Bear"),
        "bitcoin": MessageLookupByLibrary.simpleMessage("Bitcoin"),
        "bitcoinChart": MessageLookupByLibrary.simpleMessage("Bitcoin chart"),
        "bitcoinDescription": MessageLookupByLibrary.simpleMessage(
            "Bitcoin (BTC) is the first cryptocurrency built. Unlike government-issued or fiat currencies such as US Dollars or Euro which are controlled by central banks, Bitcoin can operate without the need of a central authority like a central bank or a company. Users are able to send funds to each other without going through intermediaries."),
        "bitcoinInfoCard":
            MessageLookupByLibrary.simpleMessage("Bitcoin Card Information"),
        "bitcoinNews": MessageLookupByLibrary.simpleMessage("Bitcoin News"),
        "bitnerGMBH": MessageLookupByLibrary.simpleMessage("BitNet GmbH"),
        "bitnetUsageFee":
            MessageLookupByLibrary.simpleMessage("BitNet usage fee"),
        "block": MessageLookupByLibrary.simpleMessage("Block"),
        "blockChain": MessageLookupByLibrary.simpleMessage("Blockchain"),
        "blockDevice": MessageLookupByLibrary.simpleMessage("Block Device"),
        "blockSize": MessageLookupByLibrary.simpleMessage("Block Size"),
        "blockTransaction":
            MessageLookupByLibrary.simpleMessage("Block Transactions"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blocked"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Bot messages"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Bubble size"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Bundle name"),
        "butBitcoin": MessageLookupByLibrary.simpleMessage(
            "But Bitcoin is more than just a digital asset; it\'s a movement. A movement towards a more open, accessible, and equitable future. \nBitNet wants be at the forefront of the digital age as a pioneer in asset digitization using Bitcoin,\n shaping a metaverse where equality, security, and sustainability\n are not just ideals, but realities. Our vision is to create an\n interconnected digital world where every user can seamlessly and\n fairly access, exchange, and grow their digital assets."),
        "buy": MessageLookupByLibrary.simpleMessage("Buy"),
        "buyBitcoin": MessageLookupByLibrary.simpleMessage("Buy Bitcoin"),
        "buyNow": MessageLookupByLibrary.simpleMessage("Buy Now"),
        "buySell": MessageLookupByLibrary.simpleMessage("Buy & Sell"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Calling account"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Allows FluffyChat to use the native android dialer app."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Calling permissions"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancelDelete":
            MessageLookupByLibrary.simpleMessage("Cancel and delete"),
        "cantOpenUri": m5,
        "cart": MessageLookupByLibrary.simpleMessage("Cart"),
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "cc": MessageLookupByLibrary.simpleMessage("Currency Converter"),
        "certainFeaturesOfApp": MessageLookupByLibrary.simpleMessage(
            "Certain features of the app may incur fees.\nThese fees will be communicated to the user in advance and\nare visible in the app."),
        "chainInfo": MessageLookupByLibrary.simpleMessage("Chain Info"),
        "chains": MessageLookupByLibrary.simpleMessage("Chains"),
        "changeAmount": MessageLookupByLibrary.simpleMessage("Change Amount"),
        "changeCurrency":
            MessageLookupByLibrary.simpleMessage("Change Currency"),
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Change device name"),
        "changeLanguage":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Change the homeserver"),
        "changeTheNameOfTheGroup": MessageLookupByLibrary.simpleMessage(
            "Change the name of the group"),
        "changeTheme":
            MessageLookupByLibrary.simpleMessage("Change your style"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Change wallpaper"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Change your avatar"),
        "changedTheChatAvatar": m6,
        "changedTheChatDescriptionTo": m7,
        "changedTheChatNameTo": m8,
        "changedTheChatPermissions": m9,
        "changedTheDisplaynameTo": m10,
        "changedTheGuestAccessRules": m11,
        "changedTheGuestAccessRulesTo": m12,
        "changedTheHistoryVisibility": m13,
        "changedTheHistoryVisibilityTo": m14,
        "changedTheJoinRules": m15,
        "changedTheJoinRulesTo": m16,
        "changedTheProfileAvatar": m17,
        "changedTheRoomAliases": m18,
        "changedTheRoomInvitationLink": m19,
        "changes": MessageLookupByLibrary.simpleMessage("Changes:"),
        "channelCorruptedDecryptError": MessageLookupByLibrary.simpleMessage(
            "The encryption has been corrupted"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("Chat backup"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Your old messages are secured with a recovery key. Please make sure you don\'t lose it."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Chat details"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "Chat has been added to this space"),
        "chats": MessageLookupByLibrary.simpleMessage("Chats"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Choose a strong password"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Choose a username"),
        "chooseReceipient":
            MessageLookupByLibrary.simpleMessage("Choose Receipient"),
        "claimNFT":
            MessageLookupByLibrary.simpleMessage("Claim your free Bitcoin NFT"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "clearAll": MessageLookupByLibrary.simpleMessage("Clear All"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Clear archive"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "codeAlreadyUsed": MessageLookupByLibrary.simpleMessage(
            "It seems like this code has already been used"),
        "codeNotValid":
            MessageLookupByLibrary.simpleMessage("Code is not valid."),
        "coinBase": MessageLookupByLibrary.simpleMessage(
            "Coinbase (Newly Generated Coins)\n"),
        "collections": MessageLookupByLibrary.simpleMessage("Collections"),
        "color": MessageLookupByLibrary.simpleMessage("Color"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Ban the given user from this room"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Clear cache"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Create an empty group chat\nUse --no-encryption to disable encryption"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Send a cuddle"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Discard session"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Start a direct chat\nUse --no-encryption to disable encryption"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Send some googly eyes"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("Send HTML-formatted text"),
        "commandHint_hug": MessageLookupByLibrary.simpleMessage("Send a hug"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Invite the given user to this room"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Join the given room"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Remove the given user from this room"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Leave this room"),
        "commandHint_markasdm":
            MessageLookupByLibrary.simpleMessage("Mark as direct message room"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Mark as group"),
        "commandHint_me":
            MessageLookupByLibrary.simpleMessage("Describe yourself"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Set your picture for this room (by mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Set your display name for this room"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Set the given user\'s power level (default: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Send unformatted text"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("Send reply as a reaction"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("Send text"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Unban the given user from this room"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Command invalid"),
        "commandMissing": m20,
        "compareEmojiMatch":
            MessageLookupByLibrary.simpleMessage("Please compare the emojis"),
        "compareNumbersMatch":
            MessageLookupByLibrary.simpleMessage("Please compare the numbers"),
        "configureChat": MessageLookupByLibrary.simpleMessage("Configure chat"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Are you sure to permanently unpin the event?"),
        "confirmKey": MessageLookupByLibrary.simpleMessage("Confirm Key"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Please confirm your Matrix ID in order to delete your account."),
        "confirmMnemonic":
            MessageLookupByLibrary.simpleMessage("Confirm your mnemonic"),
        "confirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
        "connect": MessageLookupByLibrary.simpleMessage("Connect"),
        "connectWithOtherDevices":
            MessageLookupByLibrary.simpleMessage("Connect with other device"),
        "contact": MessageLookupByLibrary.simpleMessage("Contact:"),
        "contactFriendsForRecovery": MessageLookupByLibrary.simpleMessage(
            "Contact your friends and tell them to free-up your key! The free-ups will only be valid for 24 hours. After their keys are freed up the login sign will appear green and you\'ll have to wait additional 24hours before you can login to your recovered account."),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Contact has been invited to the group"),
        "contactInfo":
            MessageLookupByLibrary.simpleMessage("Contact information"),
        "contactInfoHint": MessageLookupByLibrary.simpleMessage(
            "Contact information (Email, username, did...)"),
        "contacts": MessageLookupByLibrary.simpleMessage("Contact"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Contains display name"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Contains username"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "The content has been reported to the server admins"),
        "contentOnlineOffer": MessageLookupByLibrary.simpleMessage(
            "Content of the online offer: The provider assumes no responsibility for the timeliness, \ncorrectness, completeness, or quality of the provided \ninformation. Liability claims against the provider relating to \nmaterial or immaterial damage caused by the use or \nnon-use of the provided information or by the use of \nincorrect and incomplete information are \ngenerally excluded, provided that there is no demonstrable \nintentional or grossly negligent fault on the part of the provider."),
        "continues": MessageLookupByLibrary.simpleMessage("Continue"),
        "contractAddress":
            MessageLookupByLibrary.simpleMessage("Contract address"),
        "convert": MessageLookupByLibrary.simpleMessage("Convert"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Copied to clipboard"),
        "copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Copy to clipboard"),
        "costEstimation":
            MessageLookupByLibrary.simpleMessage("Cost Estimation"),
        "coudntChangeUsername":
            MessageLookupByLibrary.simpleMessage("Couldn\'t change username"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Create new group"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("New space"),
        "createPost": MessageLookupByLibrary.simpleMessage("Create Post"),
        "createdBy": MessageLookupByLibrary.simpleMessage("Created By"),
        "createdTheChat": m24,
        "cryptoPills": MessageLookupByLibrary.simpleMessage("Crypto-Pills"),
        "cuddleContent": m25,
        "currentBatches":
            MessageLookupByLibrary.simpleMessage("Current Batches"),
        "currentPrice": MessageLookupByLibrary.simpleMessage("Current Price"),
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Currently active"),
        "custom": MessageLookupByLibrary.simpleMessage("Custom"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark"),
        "dateAndTimeOfDay": m26,
        "dateBehavior": MessageLookupByLibrary.simpleMessage(" DATE"),
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "This will deactivate your user account. This can not be undone! Are you sure?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Default permission level"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Export session and wipe device"),
        "dehydrateTor":
            MessageLookupByLibrary.simpleMessage("TOR Users: Export session"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "For TOR users, it is recommended to export the session before closing the window."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "This action cannot be undone. Ensure you safely store the backup file."),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete account"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("Delete message"),
        "deny": MessageLookupByLibrary.simpleMessage("Deny"),
        "device": MessageLookupByLibrary.simpleMessage("Device"),
        "deviceId": MessageLookupByLibrary.simpleMessage("Device ID"),
        "deviceKeys": MessageLookupByLibrary.simpleMessage("Device keys:"),
        "devices": MessageLookupByLibrary.simpleMessage("Devices"),
        "diDprivateKey":
            MessageLookupByLibrary.simpleMessage("DID and private key"),
        "difficulty": MessageLookupByLibrary.simpleMessage("Difficulty"),
        "difficultyAdjustment":
            MessageLookupByLibrary.simpleMessage("Difficulty Adjustment"),
        "directChats": MessageLookupByLibrary.simpleMessage("Direct Chats"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "For security reasons you can not disable encryption in a chat, where it has been enabled before."),
        "disclaimer": MessageLookupByLibrary.simpleMessage("Disclaimer:"),
        "discover": MessageLookupByLibrary.simpleMessage("Discover"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
        "displaynameHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Displayname has been changed"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Do not show again"),
        "dontShareAnyone": MessageLookupByLibrary.simpleMessage(
            "DON\'T SHARE THIS QR CODE TO ANYONE!"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Download file"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("Edit blocked servers"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Edit bundles for this account"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Edit chat permissions"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Edit displayname"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Edit room aliases"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Edit room avatar"),
        "editWidgets": MessageLookupByLibrary.simpleMessage("Edit widgets"),
        "email": MessageLookupByLibrary.simpleMessage("Email:"),
        "emailOrUsername":
            MessageLookupByLibrary.simpleMessage("Email or username"),
        "emojis": MessageLookupByLibrary.simpleMessage("Emojis"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Emote already exists!"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("Invalid emote shortcode!"),
        "emotePacks":
            MessageLookupByLibrary.simpleMessage("Emote packs for room"),
        "emoteSettings": MessageLookupByLibrary.simpleMessage("Emote Settings"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Emote shortcode"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "You need to pick an emote shortcode and an image!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Empty chat"),
        "enableEmotesGlobally":
            MessageLookupByLibrary.simpleMessage("Enable emote pack globally"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Enable encryption"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "You won\'t be able to disable the encryption anymore. Are you sure?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Enable multi accounts on this device"),
        "encryptThisChat":
            MessageLookupByLibrary.simpleMessage("Encrypt this chat"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Encrypted"),
        "encryption": MessageLookupByLibrary.simpleMessage("Encryption"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Encryption is not enabled"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("End to end encryption"),
        "endedTheCall": m29,
        "enterA": MessageLookupByLibrary.simpleMessage("Enter Amount"),
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Enter a group name"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Enter a space name"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Enter an email address"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "Enter invite link or Matrix ID..."),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Enter room"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Enter space"),
        "enterWordsRightOrder": MessageLookupByLibrary.simpleMessage(
            "Enter your 24 words in the right order"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Enter your homeserver"),
        "errorAddingWidget":
            MessageLookupByLibrary.simpleMessage("Error adding the widget."),
        "errorFinalizingBatch":
            MessageLookupByLibrary.simpleMessage("Error finalizing batch"),
        "errorObtainingLocation": m30,
        "errorSomethingWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "ethereum": MessageLookupByLibrary.simpleMessage("ETHEREUM"),
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Everything ready!"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("Experimental video calls"),
        "exploreBtc": MessageLookupByLibrary.simpleMessage("Explore BTC"),
        "extendedSec": MessageLookupByLibrary.simpleMessage("Extended Sec"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extremely offensive"),
        "failedToLoadCertainData": MessageLookupByLibrary.simpleMessage(
            "Failed to load certain data in this page, please try again later"),
        "failedToLoadLightning": MessageLookupByLibrary.simpleMessage(
            "Failed to load Lightning Invoices"),
        "failedToLoadOnchain": MessageLookupByLibrary.simpleMessage(
            "Failed to load Onchain Transactions"),
        "failedToLoadOperations": MessageLookupByLibrary.simpleMessage(
            "Failed to load Loop Operations"),
        "failedToLoadPayments": MessageLookupByLibrary.simpleMessage(
            "Failed to load Lightning Payments"),
        "fallenBrunnen":
            MessageLookupByLibrary.simpleMessage("Fallenbrunnen 12"),
        "favorite": MessageLookupByLibrary.simpleMessage("Favourite"),
        "fearAndGreed": MessageLookupByLibrary.simpleMessage("Fear and Greed"),
        "fearAndGreedIndex":
            MessageLookupByLibrary.simpleMessage("Fear & Greed Index"),
        "features": MessageLookupByLibrary.simpleMessage("Features"),
        "fee": MessageLookupByLibrary.simpleMessage("Fee"),
        "feeDistribution":
            MessageLookupByLibrary.simpleMessage("Fee Distribution"),
        "feeRate": MessageLookupByLibrary.simpleMessage("Fee rate"),
        "fees": MessageLookupByLibrary.simpleMessage("Fees:"),
        "fianlizePosts": MessageLookupByLibrary.simpleMessage("Finalize Posts"),
        "fileHasBeenSavedAt": m31,
        "fileIsTooBigForServer": MessageLookupByLibrary.simpleMessage(
            "The server reports that the file is too large to be sent."),
        "fileName": MessageLookupByLibrary.simpleMessage("File name"),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "filterOptions": MessageLookupByLibrary.simpleMessage("Filter Options"),
        "finalProvisions":
            MessageLookupByLibrary.simpleMessage("Final Provisions:"),
        "fixed": MessageLookupByLibrary.simpleMessage("fixed"),
        "floorPrice": MessageLookupByLibrary.simpleMessage("Floor Price"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Font size"),
        "forSale": MessageLookupByLibrary.simpleMessage("For Sale"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "This notification appears when the foreground service is running."),
        "forward": MessageLookupByLibrary.simpleMessage("Forward"),
        "foundedIn2023": MessageLookupByLibrary.simpleMessage(
            "Founded in 2023, BitNet was born out of the belief that Bitcoin is not just a digital asset for the tech-savvy and financial experts,\n but a revolutionary tool that has the potential to build the foundations of cyberspace empowering individuals worldwide.\n We recognized the complexity and the mystique surrounding Bitcoin and cryptocurrencies,\n and we decided it was time to demystify it and make it accessible to everyone.\n We are a pioneering platform dedicated to bringing Bitcoin closer to everyday people like you."),
        "friedrichshafen":
            MessageLookupByLibrary.simpleMessage("88405 Friedrichshafen"),
        "friendsKeyIssuers":
            MessageLookupByLibrary.simpleMessage("Friends / Key-Issuers"),
        "from": MessageLookupByLibrary.simpleMessage("From"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("From joining"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("From the invitation"),
        "fullRbf": MessageLookupByLibrary.simpleMessage("Full RBF"),
        "functionality": MessageLookupByLibrary.simpleMessage("Functionality:"),
        "fundUs": MessageLookupByLibrary.simpleMessage("Fund us"),
        "generateInvoice":
            MessageLookupByLibrary.simpleMessage("Generate Invoice"),
        "getAProfile": MessageLookupByLibrary.simpleMessage("Get a profile"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
        "givePowerBack": MessageLookupByLibrary.simpleMessage(
            "Give power back to the people!"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Go to the new room"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Group"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Group description"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Group description changed"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Group is public"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Groups"),
        "growAFair":
            MessageLookupByLibrary.simpleMessage("Grow a fair Cyberspace!"),
        "guardiansDesigned": MessageLookupByLibrary.simpleMessage(
            "Not only are Guardians dope designed character-collectibles, they also serve as your ticket to a world of exclusive content. From developing new collections to fill our universe, to metaverse avatars, we have bundles of awesome features in the pipeline."),
        "guardiansStored": MessageLookupByLibrary.simpleMessage(
            "Guardians are stored as ERC721 tokens on the Ethereum blockchain. Owners can download their Guardians in .png format, they can also request a high resolution image of them, with 3D models coming soon for everyone."),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Guests are forbidden"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Guests can join"),
        "hasWithdrawnTheInvitationFor": m34,
        "hashrate": MessageLookupByLibrary.simpleMessage("Hashrate"),
        "hashrateDifficulty":
            MessageLookupByLibrary.simpleMessage("Hashrate & Difficulty"),
        "health": MessageLookupByLibrary.simpleMessage("Health"),
        "helloWorld": MessageLookupByLibrary.simpleMessage("Hello World!"),
        "help": MessageLookupByLibrary.simpleMessage("Help"),
        "helpCenter": MessageLookupByLibrary.simpleMessage("Help Center"),
        "hideDetails": MessageLookupByLibrary.simpleMessage("Hide Details"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Hide redacted events"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Hide unimportant state events"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("Hide unknown events"),
        "high": MessageLookupByLibrary.simpleMessage("High"),
        "highestAssesment":
            MessageLookupByLibrary.simpleMessage("Highest assesment:"),
        "his": MessageLookupByLibrary.simpleMessage("History"),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "historyClaim": MessageLookupByLibrary.simpleMessage(
            "History in Making: Claim your free Bitcoin NFT."),
        "homeserver": MessageLookupByLibrary.simpleMessage("Homeserver"),
        "hotNewItems": MessageLookupByLibrary.simpleMessage("Hot New Items"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "How offensive is this content?"),
        "hugContent": m35,
        "humanIdentity": MessageLookupByLibrary.simpleMessage("Human Identity"),
        "hydrate":
            MessageLookupByLibrary.simpleMessage("Restore from backup file"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR Users: Import session export"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Did you export your session last time on TOR? Quickly import it and continue chatting."),
        "iHaveAlways": MessageLookupByLibrary.simpleMessage(
            "I have always been a Bitcoin enthusiast, so BitNet was a no-brainer for me. Its great to see how far we have come with Bitcoin."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("I have clicked on the link"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("I understand"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "ideaLeaderboard":
            MessageLookupByLibrary.simpleMessage("Idea Leaderboard"),
        "identity": MessageLookupByLibrary.simpleMessage("Identity"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignore"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "You can ignore users who are disturbing you. You won\'t be able to receive any messages or room invites from the users on your personal ignore list."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignore username"),
        "ignoredUsers": MessageLookupByLibrary.simpleMessage("Ignored users"),
        "imLiterallyOnlyPerson": MessageLookupByLibrary.simpleMessage(
            "I\'m literally the only person who has submitted an idea so far."),
        "imLiterallyOnlyPerson2": MessageLookupByLibrary.simpleMessage(
            "I\'m literally the only submitted an idea so far."),
        "imLiterallyOnlyPerson3": MessageLookupByLibrary.simpleMessage(
            "y the only person who has submitted an idea so far."),
        "imprint": MessageLookupByLibrary.simpleMessage("Imprint"),
        "inSeveralHours":
            MessageLookupByLibrary.simpleMessage("In Several hours (or more)"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Incorrect passphrase or recovery key"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "The message storage is unfortunately not enabled in private mode by default.\nPlease visit\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\nOtherwise, it is not possible to run FluffyChat."),
        "indexedDbErrorTitle":
            MessageLookupByLibrary.simpleMessage("Private mode issues"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Inoffensive"),
        "inputTx": MessageLookupByLibrary.simpleMessage("Inputs\n"),
        "intrinsicValue":
            MessageLookupByLibrary.simpleMessage("Intrinsic Value:"),
        "invitationCode":
            MessageLookupByLibrary.simpleMessage("Invitation Code"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("Invite contact"),
        "inviteContactToGroup": m36,
        "inviteDescription": MessageLookupByLibrary.simpleMessage(
            "Our service is currently in beta and \nlimited to invited users. You can share these invitation \nkeys with your friends and family!"),
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Invite for me"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Invited"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Invited users only"),
        "invoice": MessageLookupByLibrary.simpleMessage("Invoice"),
        "isTyping": MessageLookupByLibrary.simpleMessage("is typing…"),
        "itemsTotal": MessageLookupByLibrary.simpleMessage("Items total"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Join room"),
        "joinUsToday": MessageLookupByLibrary.simpleMessage("Join us Today!"),
        "joinedRevolution": MessageLookupByLibrary.simpleMessage(
            "Hey there Bitcoiners! I joined the revolution!"),
        "joinedTheChat": m39,
        "jump": MessageLookupByLibrary.simpleMessage("Jump"),
        "jumpToLastReadMessage":
            MessageLookupByLibrary.simpleMessage("Jump to last read message"),
        "justJoinedBitnet":
            MessageLookupByLibrary.simpleMessage(" just joined the BitNet!"),
        "keyMetrics": MessageLookupByLibrary.simpleMessage("Key metrics"),
        "kickFromChat": MessageLookupByLibrary.simpleMessage("Kick from chat"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "language": MessageLookupByLibrary.simpleMessage("English"),
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Seen a long time ago"),
        "lastUpdated": MessageLookupByLibrary.simpleMessage("Last updated: "),
        "launchBitnetApp": MessageLookupByLibrary.simpleMessage(
            "Launch the bitnet app on an alternative device where your account is already active and logged in."),
        "leave": MessageLookupByLibrary.simpleMessage("Leave"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Left the chat"),
        "letsStart": MessageLookupByLibrary.simpleMessage("Let\'s start"),
        "license": MessageLookupByLibrary.simpleMessage("License"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light"),
        "lightning": MessageLookupByLibrary.simpleMessage("Lightning"),
        "lightningCardInfo":
            MessageLookupByLibrary.simpleMessage("Lightning Card Information"),
        "lightningOnChain":
            MessageLookupByLibrary.simpleMessage("Lightning to Onchain"),
        "lightningTransactionSettled":
            MessageLookupByLibrary.simpleMessage("Lightning invoice settled"),
        "liked": MessageLookupByLibrary.simpleMessage("Liked"),
        "limitationOfLiability":
            MessageLookupByLibrary.simpleMessage("Limitation of Liability:"),
        "limitedSpotsLeft":
            MessageLookupByLibrary.simpleMessage("limited spots left!"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "listed": MessageLookupByLibrary.simpleMessage("Listed"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Load more…"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Loading… Please wait."),
        "locallySavedAccounts":
            MessageLookupByLibrary.simpleMessage("Locally saved accounts"),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Location services are disabled. Please enable them to be able to share your location."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Location permission denied. Please grant them to be able to share your location."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Sign in with one click"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "loopScreen": MessageLookupByLibrary.simpleMessage("Loop Screen"),
        "low": MessageLookupByLibrary.simpleMessage("Low"),
        "lowestAssesment":
            MessageLookupByLibrary.simpleMessage("Lowest assesment:"),
        "makeBitcoinEasy": MessageLookupByLibrary.simpleMessage(
            "Make Bitcoin easy for everyone!"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Make sure the identifier is valid"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Mark as read"),
        "marketFee": MessageLookupByLibrary.simpleMessage("Market Fee"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Matrix Widgets"),
        "max": MessageLookupByLibrary.simpleMessage("Max"),
        "median": MessageLookupByLibrary.simpleMessage("Median: "),
        "medium": MessageLookupByLibrary.simpleMessage("Medium"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("Member changes"),
        "mempoolBlock": MessageLookupByLibrary.simpleMessage("Mempool block"),
        "mention": MessageLookupByLibrary.simpleMessage("Mention"),
        "messageInfo": MessageLookupByLibrary.simpleMessage("Message info"),
        "messageType": MessageLookupByLibrary.simpleMessage("Message Type"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Message will be removed for all participants"),
        "messages": MessageLookupByLibrary.simpleMessage("Messages"),
        "min": MessageLookupByLibrary.simpleMessage("Min"),
        "mined": MessageLookupByLibrary.simpleMessage("Mined "),
        "minedAt": MessageLookupByLibrary.simpleMessage("Mined at"),
        "miner": MessageLookupByLibrary.simpleMessage("Miner"),
        "minerRewardAndFees": MessageLookupByLibrary.simpleMessage(
            "Miner Reward (Subsidy + fees)"),
        "minutesTx": MessageLookupByLibrary.simpleMessage(" minutes"),
        "mission": MessageLookupByLibrary.simpleMessage("Mission"),
        "mnemonicCorrect": MessageLookupByLibrary.simpleMessage(
            "Your mnemonic is correct! Please keep it safe."),
        "mnemonicInCorrect": MessageLookupByLibrary.simpleMessage(
            "Your mnemonic does not match. Please try again."),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderator"),
        "moreAndMore": MessageLookupByLibrary.simpleMessage(
            "More and more decide to join our community each day! Let\'s build something extraordinary together."),
        "mostHypedNewDeals":
            MessageLookupByLibrary.simpleMessage("Most Hyped New Deals"),
        "mostViewed": MessageLookupByLibrary.simpleMessage("Most Viewed"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Mute chat"),
        "nameBehavior": MessageLookupByLibrary.simpleMessage(" NAME"),
        "nameYourAsset":
            MessageLookupByLibrary.simpleMessage("Name your Asset"),
        "navQrRecovery": MessageLookupByLibrary.simpleMessage(
            "Navigate to Profile > Settings > Security > Scan QR-Code for Recovery. You will need to verify your identity now."),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Please be aware that you need Pantalaimon to use end-to-end encryption for now."),
        "networkFee": MessageLookupByLibrary.simpleMessage("Network Fee"),
        "newChat": MessageLookupByLibrary.simpleMessage("New chat"),
        "newFee": MessageLookupByLibrary.simpleMessage("New Fee"),
        "newGroup": MessageLookupByLibrary.simpleMessage("New group"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 New message in FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("New space"),
        "newSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Spaces allows you to consolidate your chats and build private or public communities."),
        "newTopSellers":
            MessageLookupByLibrary.simpleMessage("New Top Sellers"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("New verification request!"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Next account"),
        "nextBlock": MessageLookupByLibrary.simpleMessage("Next Block"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noAccountYet": MessageLookupByLibrary.simpleMessage(
            "You don\'t have an account yet?"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "Warning! Without enabling chat backup, you will lose access to your encrypted messages. It is highly recommended to enable the chat backup first before logging out."),
        "noCodeFoundOverlayError":
            MessageLookupByLibrary.simpleMessage("No code was found."),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("No connection to the server"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid email address. Otherwise you won\'t be able to reset your password. If you don\'t want to, tap again on the button to continue."),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("No emotes found. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "You can only activate encryption as soon as the room is no longer publicly accessible."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "It seems that you have no google services on your phone. That\'s a good decision for your privacy! To receive push notifications in FluffyChat we recommend using https://microg.org/ or https://unifiedpush.org/."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "This can happen if the message was sent before you have signed in to your account at this device.\n\nIt is also possible that the sender has blocked your device or something went wrong with the internet connection.\n\nAre you able to read the message on another session? Then you can transfer the message from it! Go to Settings > Devices and make sure that your devices have verified each other. When you open the room the next time and both sessions are in the foreground, the keys will be transmitted automatically.\n\nDo you not want to lose the keys when logging out or switching devices? Make sure that you have enabled the chat backup in the settings."),
        "noMatrixServer": m45,
        "noOtherDevicesFound":
            MessageLookupByLibrary.simpleMessage("No other devices found"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "You have not added a way to recover your password yet."),
        "noPermission": MessageLookupByLibrary.simpleMessage("No permission"),
        "noResultsFound":
            MessageLookupByLibrary.simpleMessage(" No results found"),
        "noRoomsFound": MessageLookupByLibrary.simpleMessage("No rooms found…"),
        "noUserFound": MessageLookupByLibrary.simpleMessage("No users found."),
        "noUsersFound":
            MessageLookupByLibrary.simpleMessage("No users could be found"),
        "none": MessageLookupByLibrary.simpleMessage("None"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notifications enabled for this account"),
        "now": MessageLookupByLibrary.simpleMessage("Now: "),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Obtaining location…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Offensive"),
        "offline": MessageLookupByLibrary.simpleMessage("Offline"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "onChainInvoiceSettled":
            MessageLookupByLibrary.simpleMessage("Onchain transaction settled"),
        "onChainLightning":
            MessageLookupByLibrary.simpleMessage("Onchain to Lightning"),
        "onSaleIn": MessageLookupByLibrary.simpleMessage("On Sale In"),
        "onchain": MessageLookupByLibrary.simpleMessage("Onchain"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "One of your clients has been logged out"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Online Key Backup is enabled"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Oops! Unfortunately, an error occurred when setting up the push notifications."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Oops, something went wrong…"),
        "openAppToReadMessages":
            MessageLookupByLibrary.simpleMessage("Open app to read messages"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Open camera"),
        "openChat": MessageLookupByLibrary.simpleMessage("Open Chat"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Open gallery"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Open in maps"),
        "openLinkInBrowser":
            MessageLookupByLibrary.simpleMessage("Open link in browser"),
        "openOnEtherscan":
            MessageLookupByLibrary.simpleMessage("Open On Etherscan"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("Open camera for a video"),
        "optimal": MessageLookupByLibrary.simpleMessage("Optimal"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Optional) Group name"),
        "or": MessageLookupByLibrary.simpleMessage("Or"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Microphone, camera and other FluffyChat permissions"),
        "ourMission": MessageLookupByLibrary.simpleMessage(
            "Our mission is simple but profound: To innovate in the digital \neconomy by integrating blockchain technology with asset digitization, \ncreating a secure and transparent platform that empowers users to engage \nwith the metaverse through Bitcoin. We are dedicated to making digital interactions \nmore accessible, equitable, and efficient for everyone. To accelerate the adoption of Bitcoin and create a world\n where digital assets are accessible, understandable, and beneficial to all. Where people can verify information \n on their own."),
        "ourMissionn": MessageLookupByLibrary.simpleMessage("Our mission."),
        "ourTeam": MessageLookupByLibrary.simpleMessage("Our Team"),
        "outputTx": MessageLookupByLibrary.simpleMessage("Outputs\n"),
        "overlayErrorOccured": MessageLookupByLibrary.simpleMessage(
            "An error occured, please try again later."),
        "overpaid": MessageLookupByLibrary.simpleMessage("Overpaid"),
        "ownSecurity": MessageLookupByLibrary.simpleMessage("Own Security"),
        "owners": MessageLookupByLibrary.simpleMessage("Owners"),
        "participant": MessageLookupByLibrary.simpleMessage("Participant"),
        "passphraseOrKey":
            MessageLookupByLibrary.simpleMessage("passphrase or recovery key"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Password forgotten"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Password has been changed"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Password recovery"),
        "passwordShouldBeSixDig": MessageLookupByLibrary.simpleMessage(
            "The password must contain at least 6 characters"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match!"),
        "payemntMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
        "paymentNetwork":
            MessageLookupByLibrary.simpleMessage("Payment Network"),
        "people": MessageLookupByLibrary.simpleMessage("People"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone:"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Pick an image"),
        "pin": MessageLookupByLibrary.simpleMessage("Pin"),
        "pinCodeVerification":
            MessageLookupByLibrary.simpleMessage("Pin Code Verification"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("Pin to room"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Place call"),
        "plainKeyDID":
            MessageLookupByLibrary.simpleMessage("Plain Key and DID"),
        "platformDemandText": MessageLookupByLibrary.simpleMessage(
            "We\'re thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users."),
        "platformExlusivityText": MessageLookupByLibrary.simpleMessage(
            "We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration."),
        "platformExpandCapacityText": MessageLookupByLibrary.simpleMessage(
            "Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Please choose"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Please choose a pass code"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("Please choose a username"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Please click on the link in the email and then proceed."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Please enter 4 digits or leave empty to disable app lock."),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("Please enter a Matrix ID."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Please enter your recovery key:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "To unlock your old messages, please enter your recovery key that has been generated in a previous session. Your recovery key is NOT your password."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid email address."),
        "pleaseEnterValidUsername": MessageLookupByLibrary.simpleMessage(
            "The username you entered is not valid."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Please enter your pin"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("Please enter your username"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Please follow the instructions on the website and tap on next."),
        "pleaseGiveAccess": MessageLookupByLibrary.simpleMessage(
            "Please give the app photo access to use this feature."),
        "pleaseLetUsKnow": MessageLookupByLibrary.simpleMessage(
            "Please let us know what went wrong..."),
        "pleaseProvideErrorMsg": MessageLookupByLibrary.simpleMessage(
            "Please provide an error message first."),
        "post": MessageLookupByLibrary.simpleMessage("POST"),
        "postContentError": MessageLookupByLibrary.simpleMessage(
            "Please add some content to your post"),
        "powerToThePeople":
            MessageLookupByLibrary.simpleMessage("Power to the people!"),
        "poweredByDIDs":
            MessageLookupByLibrary.simpleMessage("Powered with DIDs by"),
        "pressBtnScanQr": MessageLookupByLibrary.simpleMessage(
            "Press the Button below and scan the QR Code. Wait until the process is finished don\'t leave the app."),
        "pressedFavorite": MessageLookupByLibrary.simpleMessage(
            "Press the Favorites button again to unfavorite"),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Previous account"),
        "previousFee": MessageLookupByLibrary.simpleMessage("Previous fee"),
        "previousOutputScripts":
            MessageLookupByLibrary.simpleMessage("Previous output script"),
        "previousOutputType":
            MessageLookupByLibrary.simpleMessage("Previous output type"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "priceHistory": MessageLookupByLibrary.simpleMessage("Price History"),
        "privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
        "privateKey": MessageLookupByLibrary.simpleMessage("Private Key"),
        "privateKeyLogin":
            MessageLookupByLibrary.simpleMessage("DID and Private Key Login"),
        "product": MessageLookupByLibrary.simpleMessage("Product"),
        "properties": MessageLookupByLibrary.simpleMessage("Properties"),
        "propertiesDescription": MessageLookupByLibrary.simpleMessage(
            "Guardians of the Metaverse are a collection of 10,000 unique 3D hero-like avatars living as NFTs on the blockchain."),
        "provider": MessageLookupByLibrary.simpleMessage("Provider:"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Public Rooms"),
        "publish": MessageLookupByLibrary.simpleMessage("Publish"),
        "purchaseBitcoin":
            MessageLookupByLibrary.simpleMessage("Purchase Bitcoin"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Push rules"),
        "qou": MessageLookupByLibrary.simpleMessage(
            "Currency Rates by Open Exchange Rates"),
        "qrCode": MessageLookupByLibrary.simpleMessage("QR Code"),
        "qrCodeFormatInvalid": MessageLookupByLibrary.simpleMessage(
            "The scanned QR code does not have an approved format"),
        "quickLinks": MessageLookupByLibrary.simpleMessage("Quick Links"),
        "rbf": MessageLookupByLibrary.simpleMessage("RBF"),
        "reactedWith": m50,
        "readUpToHere": MessageLookupByLibrary.simpleMessage("Read up to here"),
        "reason": MessageLookupByLibrary.simpleMessage("Reason"),
        "rebalance": MessageLookupByLibrary.simpleMessage("Rebalance"),
        "receive": MessageLookupByLibrary.simpleMessage("Receive"),
        "receiveBitcoin":
            MessageLookupByLibrary.simpleMessage("Receive Bitcoin"),
        "received": MessageLookupByLibrary.simpleMessage("Received"),
        "recentReplacements":
            MessageLookupByLibrary.simpleMessage("Recent replacements"),
        "recentTransactions":
            MessageLookupByLibrary.simpleMessage("Recent transactions"),
        "recentlyListed":
            MessageLookupByLibrary.simpleMessage("Recently Listed"),
        "recording": MessageLookupByLibrary.simpleMessage("Recording"),
        "recoverAccount":
            MessageLookupByLibrary.simpleMessage("Recovery account"),
        "recoverQrCode":
            MessageLookupByLibrary.simpleMessage("Recover with QR Code"),
        "recoveryKey": MessageLookupByLibrary.simpleMessage("Recovery key"),
        "recoveryKeyLost":
            MessageLookupByLibrary.simpleMessage("Recovery key lost?"),
        "recoveryPhrases":
            MessageLookupByLibrary.simpleMessage("Recovery phrases"),
        "recoverySecurityIncrease": MessageLookupByLibrary.simpleMessage(
            "To increase security, the recovered user will get contacted, if there is no awnser after 24 hours your account will be freed."),
        "recoveryStep2": MessageLookupByLibrary.simpleMessage(
            "Step 2. Contact each of your friends"),
        "recoveryStepThree": MessageLookupByLibrary.simpleMessage(
            "Step 3: Wait 24 hours and then login"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("Redact message"),
        "redactedAnEvent": m51,
        "referencesLinks": MessageLookupByLibrary.simpleMessage(
            "References and links: In the case of direct or indirect references \nto external websites that are outside the provider\'s area of responsibility, \na liability obligation would only come into effect in the event that the provider \nhas knowledge of the content and it is technically possible and reasonable to prevent \nthe use in the case of illegal content. The provider hereby expressly declares \nthat at the time the links were set, no illegal content was recognizable on the linked pages. \nThe provider has no influence on the current and future design, content, or authorship of \nthe linked/connected pages. Therefore, the provider hereby expressly distances himself from all contents \nof all linked/connected pages."),
        "register": MessageLookupByLibrary.simpleMessage("Create Account"),
        "reject": MessageLookupByLibrary.simpleMessage("Reject"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Rejoin"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("Remove all other devices"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("Remove device"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Remove from this bundle"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Remove from space"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Remove your avatar"),
        "removedBy": m53,
        "renderRichContent":
            MessageLookupByLibrary.simpleMessage("Render rich message content"),
        "reopenChat": MessageLookupByLibrary.simpleMessage("Reopen chat"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Repeat password"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Replace room with newer version"),
        "replaced": MessageLookupByLibrary.simpleMessage("Replaced"),
        "reply": MessageLookupByLibrary.simpleMessage("Reply"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Reply has been sent"),
        "report": MessageLookupByLibrary.simpleMessage("report"),
        "reportError": MessageLookupByLibrary.simpleMessage("Report error"),
        "reportErrorDescription": MessageLookupByLibrary.simpleMessage(
            "Oh no. Something went wrong. Please try again later. If you want, you can report the bug to the developers."),
        "reportIssue": MessageLookupByLibrary.simpleMessage("Report Issue"),
        "reportMessage": MessageLookupByLibrary.simpleMessage("Report message"),
        "reportUser": MessageLookupByLibrary.simpleMessage("Report user"),
        "reportWeb": MessageLookupByLibrary.simpleMessage("Report"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Request permission"),
        "responsibleForContent": MessageLookupByLibrary.simpleMessage(
            "Responsible for the content:"),
        "restoreAccount":
            MessageLookupByLibrary.simpleMessage("Restore Account"),
        "restoreOptions":
            MessageLookupByLibrary.simpleMessage("Restore options"),
        "restoreWithSocialRecovery": MessageLookupByLibrary.simpleMessage(
            "Restore with social recovery"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Room has been upgraded"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Room version"),
        "sales": MessageLookupByLibrary.simpleMessage("Sales"),
        "saveCard": MessageLookupByLibrary.simpleMessage("Save Card"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Save file"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Save this key manually by triggering the system share dialog or clipboard."),
        "saveYourmnemonicSecurely": MessageLookupByLibrary.simpleMessage(
            "Save your mnemonic securely!"),
        "saveYourmnemonicSecurelyDescription": MessageLookupByLibrary.simpleMessage(
            "Save this sequence on a piece of paper it acts as your password to your account, a loss of this sequence will result in a loss of your funds."),
        "scanQr": MessageLookupByLibrary.simpleMessage("Scan QR"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Scan QR code"),
        "scanQrStepOne": MessageLookupByLibrary.simpleMessage(
            "Step 1: Open the app on a different device."),
        "scanQrStepThree": MessageLookupByLibrary.simpleMessage(
            "Step 3: Scan the QR-Code with this device"),
        "scanQrStepTwo":
            MessageLookupByLibrary.simpleMessage("Step 2: Open the QR-Code"),
        "scope": MessageLookupByLibrary.simpleMessage("Scope:"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "You are sharing your screen in FuffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("screen sharing"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchC": MessageLookupByLibrary.simpleMessage("Search Currency Here"),
        "searchItemsAndCollections": MessageLookupByLibrary.simpleMessage(
            "Search items and collections"),
        "searchL": MessageLookupByLibrary.simpleMessage("Search Language Here"),
        "searchReceipient":
            MessageLookupByLibrary.simpleMessage("Search for recipients"),
        "security": MessageLookupByLibrary.simpleMessage("Security"),
        "seeMore": MessageLookupByLibrary.simpleMessage("See more"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "selectImageQrCode":
            MessageLookupByLibrary.simpleMessage("Select Image for QR Scan"),
        "sell": MessageLookupByLibrary.simpleMessage("Sell"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("Send a message"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Send as text"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Send audio"),
        "sendBitcoin": MessageLookupByLibrary.simpleMessage(" Send Bitcoin"),
        "sendBtc": MessageLookupByLibrary.simpleMessage("Send BTC"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Send file"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Send image"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("Send messages"),
        "sendNow": MessageLookupByLibrary.simpleMessage("SEND NOW!"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("Send on enter"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("Send original"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Send sticker"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Send video"),
        "sender": MessageLookupByLibrary.simpleMessage("Sender"),
        "sent": MessageLookupByLibrary.simpleMessage("Sent"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Separate Direct Chats and Groups"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "This server needs to validate your email address for registration."),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("Set as main alias"),
        "setCustomEmotes":
            MessageLookupByLibrary.simpleMessage("Set custom emotes"),
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("Set group description"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Set invitation link"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("Set permissions level"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Set status"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "shapeTheFuture": MessageLookupByLibrary.simpleMessage(
            "Shape the Future with us! We Want to Hear Your Brilliant Ideas!"),
        "share": MessageLookupByLibrary.simpleMessage("Share"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("Share location"),
        "shareQrCode":
            MessageLookupByLibrary.simpleMessage("Share Profile QR Code"),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("Share your invite link"),
        "sharedTheLocation": m63,
        "showAll": MessageLookupByLibrary.simpleMessage("Show All"),
        "showDetails": MessageLookupByLibrary.simpleMessage("Show Details"),
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Show related Direct Chats in Spaces"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "singlesignon": MessageLookupByLibrary.simpleMessage("Single Sign on"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "skipAtOwnRisk":
            MessageLookupByLibrary.simpleMessage("Skip at own risk"),
        "soHappy": MessageLookupByLibrary.simpleMessage(
            "So happy to be part of the club 1 million! Lightning is the future."),
        "socialRecovery":
            MessageLookupByLibrary.simpleMessage("Social recovery"),
        "socialRecoveryInfo":
            MessageLookupByLibrary.simpleMessage("Social Recovery Info"),
        "socialRecoveryTrustSettings": MessageLookupByLibrary.simpleMessage(
            "Social recovery needs to activated in Settings by each user manually. You have to choose 3 friends whom you can meet in person and trust."),
        "sold": MessageLookupByLibrary.simpleMessage("Sold"),
        "sorryThatsNotPossible": MessageLookupByLibrary.simpleMessage(
            "Sorry... that is not possible"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort By"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Source code"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Space is public"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Space name"),
        "spotlightProjects":
            MessageLookupByLibrary.simpleMessage("Spotlight Projects"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "startFirstChat":
            MessageLookupByLibrary.simpleMessage("Start your first chat"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("How are you today?"),
        "stepOneSocialRecovery": MessageLookupByLibrary.simpleMessage(
            "Step 1: Activate social recovery"),
        "storeInAndroidKeystore":
            MessageLookupByLibrary.simpleMessage("Store in Android KeyStore"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("Store in Apple KeyChain"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Store the recovery key in the secure storage of this device."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Store securely on this device"),
        "stories": MessageLookupByLibrary.simpleMessage("Stories"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Please note that people can see and contact each other in your story. Your stories will be visible for 24 hours but there is no guarantee that they will be deleted from all devices and servers."),
        "subTotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "submitIdea": MessageLookupByLibrary.simpleMessage("Submit Idea"),
        "submitReport": MessageLookupByLibrary.simpleMessage("Submit report!"),
        "supply": MessageLookupByLibrary.simpleMessage("Supply"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Synchronizing… Please wait."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("System Theme"),
        "termsAndConditions":
            MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
        "termsAndConditionsDescription": MessageLookupByLibrary.simpleMessage(
            "These terms and conditions govern the use of the Bitcoin Wallet App\n(hereinafter referred to as BitNet), which is provided by BitNet GmbH.\nBy using the app, you agree to these terms and conditions."),
        "termsAndConditionsEntire": MessageLookupByLibrary.simpleMessage(
            "These terms and conditions constitute the entire agreement between the user and BitNet.\nShould any provision be ineffective, the remaining provisions shall remain in force."),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("They Don\'t Match"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("They Match"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "This user has not posted anything in their story yet"),
        "time": MessageLookupByLibrary.simpleMessage("Time"),
        "timeAgo": MessageLookupByLibrary.simpleMessage("time ago..."),
        "timeFrame": MessageLookupByLibrary.simpleMessage("TimeFrame"),
        "timestamp": MessageLookupByLibrary.simpleMessage("Timestamp"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "to": MessageLookupByLibrary.simpleMessage("To"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Toggle Favorite"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage("Toggle Muted"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Mark Read/Unread"),
        "tokenId": MessageLookupByLibrary.simpleMessage("Token ID"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Too many requests. Please try again later!"),
        "totalPrice": MessageLookupByLibrary.simpleMessage("Total Price"),
        "totalReceived": MessageLookupByLibrary.simpleMessage("Total Received"),
        "totalSent": MessageLookupByLibrary.simpleMessage("Total Sent"),
        "totalVolume": MessageLookupByLibrary.simpleMessage("Total Volume"),
        "totalWalletBal":
            MessageLookupByLibrary.simpleMessage("Total Wallet Balance"),
        "tradingHistory":
            MessageLookupByLibrary.simpleMessage("Trading History"),
        "transactionFees":
            MessageLookupByLibrary.simpleMessage("Transaction fees"),
        "transactionReplaced": MessageLookupByLibrary.simpleMessage(
            "This transaction has been replaced by:"),
        "transactions": MessageLookupByLibrary.simpleMessage("Transactions"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Transfer from another device"),
        "trendingSellers":
            MessageLookupByLibrary.simpleMessage("Trending Sellers"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Try to send again"),
        "typeBehavior": MessageLookupByLibrary.simpleMessage(" TYPE"),
        "typeMessage": MessageLookupByLibrary.simpleMessage("Type message"),
        "typeTx": MessageLookupByLibrary.simpleMessage("Type"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Unban from chat"),
        "unbannedUser": m68,
        "unblockDevice": MessageLookupByLibrary.simpleMessage("Unblock Device"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("Unknown device"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Unknown encryption algorithm"),
        "unlockOldMessages":
            MessageLookupByLibrary.simpleMessage("Unlock old messages"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage("Unmute chat"),
        "unpin": MessageLookupByLibrary.simpleMessage("Unpin"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Unsubscribe stories"),
        "unsupportedAndroidVersion":
            MessageLookupByLibrary.simpleMessage("Unsupported Android version"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "This feature requires a newer Android version. Please check for updates or Lineage OS support."),
        "unverified": MessageLookupByLibrary.simpleMessage("Unverified"),
        "updateAvailable":
            MessageLookupByLibrary.simpleMessage("FluffyChat update available"),
        "updateNow":
            MessageLookupByLibrary.simpleMessage("Start update in background"),
        "uploadToBlockchain":
            MessageLookupByLibrary.simpleMessage("Upload to Blockchain"),
        "useDidPrivateKey":
            MessageLookupByLibrary.simpleMessage("Use DID and Private Key"),
        "user": MessageLookupByLibrary.simpleMessage("User"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userCharged": MessageLookupByLibrary.simpleMessage(
            " User-change in the last 7 days!"),
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userResponsibility":
            MessageLookupByLibrary.simpleMessage("User Responsibility:"),
        "userSentUnknownEvent": m74,
        "userSolelyResponsible": MessageLookupByLibrary.simpleMessage(
            "The user is solely responsible for the security of their Bitcoins. The app offers security features such as password protection and two-factor authentication,\nbut it is the user\'s responsibility to use these features carefully.\nBitNet is not liable for losses due to negligence, loss of devices, or user access data."),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "usernameOrDID":
            MessageLookupByLibrary.simpleMessage("Username or DID"),
        "usernameTaken": MessageLookupByLibrary.simpleMessage(
            "This username is already taken."),
        "users": MessageLookupByLibrary.simpleMessage("Users"),
        "value": MessageLookupByLibrary.simpleMessage("Value"),
        "valueBehavior": MessageLookupByLibrary.simpleMessage(" VALUE"),
        "verified": MessageLookupByLibrary.simpleMessage("Verified"),
        "verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Start Verification"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("You successfully verified!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Verifying other account"),
        "verifyYourIdentity":
            MessageLookupByLibrary.simpleMessage("Verify your identity"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Video call"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Please note that video calls are currently in beta. They might not work as expected or work at all on all platforms."),
        "videoWithSize": m75,
        "viewOffers": MessageLookupByLibrary.simpleMessage("View Offers"),
        "views": MessageLookupByLibrary.simpleMessage("Views"),
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Visibility of the chat history"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Visible for all participants"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Visible for everyone"),
        "vision": MessageLookupByLibrary.simpleMessage("Vision"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Voice call"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Voice message"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Waiting for partner to accept the request…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Waiting for partner to accept the emoji…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Waiting for partner to accept the numbers…"),
        "walletAddressCopied": MessageLookupByLibrary.simpleMessage(
            "Wallet address copied to clipboard"),
        "walletLiable": MessageLookupByLibrary.simpleMessage(
            "BitNet is only liable for damages caused by intentional or grossly negligent actions by\nBitNet. The company is not liable for damages resulting from the use of the app or the loss of Bitcoins."),
        "walletReserves": MessageLookupByLibrary.simpleMessage(
            "BitNet reserves the right to change these terms and conditions at any time.\nThe user will be informed of such changes and must agree to them in order to continue using the app."),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Wallpaper"),
        "warning": MessageLookupByLibrary.simpleMessage("Warning!"),
        "wasDirectChatDisplayName": m76,
        "weAreGrowingBitcoin": MessageLookupByLibrary.simpleMessage(
            "We are growing a Bitcoin Network that is not only fair and equitable but also liberates us from a dystopian future."),
        "weAreLight": MessageLookupByLibrary.simpleMessage(
            "We are the light that helps others see Bitcoin."),
        "weBelieve": MessageLookupByLibrary.simpleMessage(
            "We believe in empowering our people and building true loyalty!"),
        "weBuildBitcoin": MessageLookupByLibrary.simpleMessage(
            "We build the Bitcoin Network!"),
        "weBuildTransparent": MessageLookupByLibrary.simpleMessage(
            "We build a transparent platform that uses verification - not trust."),
        "weDigitizeAllSorts": MessageLookupByLibrary.simpleMessage(
            "We digitize all sorts of assets on top of the Bitcoin Network."),
        "weEmpowerTomorrow":
            MessageLookupByLibrary.simpleMessage("We empower Our Tomorrow!"),
        "weHaveBetaLiftOff": MessageLookupByLibrary.simpleMessage(
            "We have Beta liftoff! Exclusive Early Access for Invited Users."),
        "weOfferEasiest": MessageLookupByLibrary.simpleMessage(
            "We offer the easiest, most secure, and most advanced web wallet."),
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("We sent you an email"),
        "weUnlockAssets": MessageLookupByLibrary.simpleMessage(
            "We unlock our future of digital assets!"),
        "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back!"),
        "whaleBehavior":
            MessageLookupByLibrary.simpleMessage("Whale Behaviour"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("What is going on?"),
        "whitePaper": MessageLookupByLibrary.simpleMessage("Whitepaper"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Who can perform which action"),
        "whoCanSeeMyStories":
            MessageLookupByLibrary.simpleMessage("Who can see my stories?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Please note that people can see and contact each other in your story."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Who is allowed to join this group"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Why do you want to report this?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "Why is this message unreadable?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Custom"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("Text note"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Name"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage(
            "Please provide a display name."),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("This is not a valid URL."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Wipe your chat backup to create a new recovery key?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "With these addresses you can recover your password."),
        "witness": MessageLookupByLibrary.simpleMessage("Witness"),
        "wordRecovery": MessageLookupByLibrary.simpleMessage("Word recovery"),
        "wowBitnet": MessageLookupByLibrary.simpleMessage(
            "Wow! Bitnet is the part that I was always missing for bitcoin. Now we will only see more and more bitcoin adoption."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Write a message…"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "you": MessageLookupByLibrary.simpleMessage("You"),
        "youAcceptedTheInvitation": MessageLookupByLibrary.simpleMessage(
            "👍 You accepted the invitation"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "You are invited to this chat"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "You are no longer participating in this chat"),
        "youAreOverLimit": MessageLookupByLibrary.simpleMessage(
            "You are over the sending limit."),
        "youAreUnderLimit": MessageLookupByLibrary.simpleMessage(
            "You are under the sending baseline"),
        "youBannedUser": m77,
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("You cannot invite yourself"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "You have been banned from this chat"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("You joined the chat"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("You rejected the invitation"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Your chat backup has been set up."),
        "yourErrorReportForwarded": MessageLookupByLibrary.simpleMessage(
            "Your error report has been forwarded."),
        "yourIdeasGoesHere":
            MessageLookupByLibrary.simpleMessage("Your idea goes here"),
        "yourIssuesGoesHere":
            MessageLookupByLibrary.simpleMessage("Your issue goes here"),
        "yourPassowrdBackup":
            MessageLookupByLibrary.simpleMessage("Your Password & Backup"),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Your public key"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Your story")
      };
}
