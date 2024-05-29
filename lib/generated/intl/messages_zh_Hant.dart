// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hant locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_Hant';

  static String m0(username) => "${username}已接受邀請";

  static String m1(username) => "${username}已啟用點對點加密";

  static String m2(senderName) => "已開始與${senderName}通話";

  static String m3(username) => "是否接受來自${username}的驗證申請？";

  static String m4(username, targetName) => "${username}封禁了${targetName}";

  static String m5(uri) => "無法打開URI ${uri}";

  static String m6(username) => "${username}變更了對話頭貼";

  static String m7(username, description) =>
      "${username}變更了對話介紹為：「${description}」";

  static String m8(username, chatname) => "${username}變更了暱稱為：「${chatname}」";

  static String m9(username) => "${username}變更了對話權限";

  static String m10(username, displayname) =>
      "${username} 變更了顯示名稱為：「${displayname}」";

  static String m11(username) => "${username}變更了訪客訪問規則";

  static String m12(username, rules) => "${username}變更了訪客訪問規則為：${rules}";

  static String m13(username) => "${username}變更了歷史記錄觀察狀態";

  static String m14(username, rules) => "${username}變更了歷史紀錄觀察狀態到：${rules}";

  static String m15(username) => "${username}變更了加入的規則";

  static String m16(username, joinRules) => "${username}變更了加入的規則為：${joinRules}";

  static String m17(username) => "${username}變更了頭貼";

  static String m18(username) => "${username}變更了聊天室名";

  static String m19(username) => "${username}變更了邀請連結";

  static String m21(error) => "不能解密訊息：${error}";

  static String m23(count) => "${count}個參與者";

  static String m24(username) => "${username}建立了聊天室";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}-${month}-${day}";

  static String m28(month, day) => "${month}-${day}";

  static String m29(senderName) => "${senderName}結束了通話";

  static String m33(displayname) => "名稱為${displayname}的群組";

  static String m34(username, targetName) => "${username}收回了對${targetName}的邀請";

  static String m36(groupName) => "邀請聯絡人到${groupName}";

  static String m37(username, link) =>
      "${username}邀請您使用FluffyChat\n1. 安裝FluffyChat：https://fluffychat.im\n2. 登入或註冊\n3. 打開該邀請網址：${link}";

  static String m38(username, targetName) => "${username}邀請了${targetName}";

  static String m39(username) => "${username}加入了聊天室";

  static String m40(username, targetName) => "${username}踢了${targetName}";

  static String m41(username, targetName) => "${username}踢了${targetName}並將其封禁";

  static String m42(localizedTimeShort) => "最後活動時間：${localizedTimeShort}";

  static String m43(count) => "載入${count}個更多的參與者";

  static String m44(homeserver) => "登入${homeserver}";

  static String m47(count) => "${count}個人正在輸入…";

  static String m48(fileName) => "播放${fileName}";

  static String m49(min) => "請至少輸入 ${min} 个字元。";

  static String m51(username) => "${username}編輯了一個事件";

  static String m52(username) => "${username}拒絕了邀請";

  static String m53(username) => "被${username}移除";

  static String m54(username) => "${username}已讀";

  static String m55(username, count) =>
      "${Intl.plural(count, other: '${username}和其他${count}個人已讀')}";

  static String m56(username, username2) => "${username}和${username2}已讀";

  static String m57(username) => "${username}傳送了一個文件";

  static String m58(username) => "${username}傳送了一張圖片";

  static String m59(username) => "${username} 傳送了貼圖";

  static String m60(username) => "${username} 傳送了影片";

  static String m61(username) => "${username}傳送了一個音訊";

  static String m62(senderName) => "${senderName} 傳送了通話資訊";

  static String m63(username) => "${username} 分享了位置";

  static String m64(senderName) => "${senderName}開始了通話";

  static String m68(username, targetName) => "${username}解除封禁了${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 unread chat', other: '${unreadCount} 個未讀聊天室')}";

  static String m70(username, count) => "${username}和其他${count}個人正在輸入…";

  static String m71(username, username2) => "${username}和${username2}正在輸入…";

  static String m72(username) => "${username}正在輸入…";

  static String m73(username) => "${username}離開了聊天室";

  static String m74(username, type) => "${username}傳送了一個${type}事件";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("關於"),
        "accept": MessageLookupByLibrary.simpleMessage("接受"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("帳號"),
        "activatedEndToEndEncryption": m1,
        "addEmail": MessageLookupByLibrary.simpleMessage("新增電子郵件"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage("新增一個群組描述"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("加入空間"),
        "admin": MessageLookupByLibrary.simpleMessage("管理員"),
        "alias": MessageLookupByLibrary.simpleMessage("別稱"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "allChats": MessageLookupByLibrary.simpleMessage("所有會話"),
        "answeredTheCall": m2,
        "anyoneCanJoin": MessageLookupByLibrary.simpleMessage("任何人可以加入"),
        "appLock": MessageLookupByLibrary.simpleMessage("密碼鎖定"),
        "archive": MessageLookupByLibrary.simpleMessage("封存"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("是否允許訪客加入"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("您確定嗎？"),
        "areYouSureYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("您確定要登出嗎？"),
        "askSSSSSign":
            MessageLookupByLibrary.simpleMessage("請輸入您安全儲存的密碼短語或恢復金鑰，以向對方簽名。"),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage("自動播放動態貼圖和表情"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("已從聊天室中封禁"),
        "banned": MessageLookupByLibrary.simpleMessage("已被封禁"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("封鎖裝置"),
        "blocked": MessageLookupByLibrary.simpleMessage("已封鎖"),
        "botMessages": MessageLookupByLibrary.simpleMessage("機器人訊息"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage("變更裝置名稱"),
        "changePassword": MessageLookupByLibrary.simpleMessage("變更密碼"),
        "changeTheHomeserver": MessageLookupByLibrary.simpleMessage("變更主機位址"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("變更了群組名稱"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("變更主題"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage("變更聊天背景"),
        "changeYourAvatar": MessageLookupByLibrary.simpleMessage("更改您的大頭貼"),
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
        "channelCorruptedDecryptError":
            MessageLookupByLibrary.simpleMessage("加密已被破壞"),
        "chat": MessageLookupByLibrary.simpleMessage("聊天"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("備份聊天室"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "您的聊天記錄備份已被安全金鑰鑰加密。請您確保不會弄丟它。"),
        "chatDetails": MessageLookupByLibrary.simpleMessage("對話詳細"),
        "chatHasBeenAddedToThisSpace":
            MessageLookupByLibrary.simpleMessage("聊天室已添加到此空間"),
        "chats": MessageLookupByLibrary.simpleMessage("聊天室"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("輸入一個較強的密碼"),
        "chooseAUsername": MessageLookupByLibrary.simpleMessage("輸入您的使用者名稱"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("清除存檔"),
        "close": MessageLookupByLibrary.simpleMessage("關閉"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage("在此聊天室封禁該使用者"),
        "commandHint_clearcache": MessageLookupByLibrary.simpleMessage("清除快取"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "建立一個空的群聊\n使用 --no-encryption 選項來禁用加密"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("丟棄工作階段"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "啟動一對一聊天\n使用 --no-encryption 選項來禁用加密"),
        "commandHint_invite":
            MessageLookupByLibrary.simpleMessage("邀請該使用者加入此聊天室"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage("加入此聊天室"),
        "commandHint_kick":
            MessageLookupByLibrary.simpleMessage("將這個使用者移出此聊天室"),
        "commandHint_leave": MessageLookupByLibrary.simpleMessage("退出此聊天室"),
        "commandHint_myroomavatar":
            MessageLookupByLibrary.simpleMessage("設置您的聊天室頭貼（通過 mxc-uri）"),
        "commandHint_myroomnick":
            MessageLookupByLibrary.simpleMessage("設定您的聊天室暱稱"),
        "commandHint_unban":
            MessageLookupByLibrary.simpleMessage("在此聊天室解封該使用者"),
        "compareEmojiMatch":
            MessageLookupByLibrary.simpleMessage("對比並確認這些表情符合其他那些裝置："),
        "compareNumbersMatch":
            MessageLookupByLibrary.simpleMessage("比較以下數字，確保它們和另一個裝置上的相同："),
        "configureChat": MessageLookupByLibrary.simpleMessage("設定聊天室"),
        "confirm": MessageLookupByLibrary.simpleMessage("確認"),
        "connect": MessageLookupByLibrary.simpleMessage("連接"),
        "contactHasBeenInvitedToTheGroup":
            MessageLookupByLibrary.simpleMessage("聯絡人已被邀請至群組"),
        "containsDisplayName": MessageLookupByLibrary.simpleMessage("包含顯示名稱"),
        "containsUserName": MessageLookupByLibrary.simpleMessage("包含使用者名稱"),
        "contentHasBeenReported":
            MessageLookupByLibrary.simpleMessage("此內容已被回報給伺服器管理員們"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage("已複製到剪貼簿"),
        "copy": MessageLookupByLibrary.simpleMessage("複製"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage("複製到剪貼簿"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("建立"),
        "createNewGroup": MessageLookupByLibrary.simpleMessage("建立新群組"),
        "createdTheChat": m24,
        "currentlyActive": MessageLookupByLibrary.simpleMessage("目前活躍"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("夜間模式"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning":
            MessageLookupByLibrary.simpleMessage("這將停用您的帳號。這個決定是不能挽回的！您確定嗎？"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("預設權限等級"),
        "delete": MessageLookupByLibrary.simpleMessage("刪除"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("刪除帳號"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("刪除訊息"),
        "deny": MessageLookupByLibrary.simpleMessage("否認"),
        "device": MessageLookupByLibrary.simpleMessage("裝置"),
        "deviceId": MessageLookupByLibrary.simpleMessage("裝置ID"),
        "devices": MessageLookupByLibrary.simpleMessage("裝置"),
        "directChats": MessageLookupByLibrary.simpleMessage("直接傳訊"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("顯示名稱已被變更"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("下載文件"),
        "edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage("編輯被封鎖的伺服器"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage("編輯聊天室權限"),
        "editDisplayname": MessageLookupByLibrary.simpleMessage("編輯顯示名稱"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage("編輯聊天室名"),
        "editRoomAvatar": MessageLookupByLibrary.simpleMessage("編輯聊天室頭貼"),
        "emoteExists": MessageLookupByLibrary.simpleMessage("表情已存在！"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage("無效的表情快捷鍵！"),
        "emotePacks": MessageLookupByLibrary.simpleMessage("聊天室的表情符號"),
        "emoteSettings": MessageLookupByLibrary.simpleMessage("表情設定"),
        "emoteShortcode": MessageLookupByLibrary.simpleMessage("表情快捷鍵"),
        "emoteWarnNeedToPick":
            MessageLookupByLibrary.simpleMessage("您需要選取一個表情快捷鍵和一張圖片！"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("空的聊天室"),
        "enableEmotesGlobally":
            MessageLookupByLibrary.simpleMessage("在全域啟用表情符號"),
        "enableEncryption": MessageLookupByLibrary.simpleMessage("啟用加密"),
        "enableEncryptionWarning":
            MessageLookupByLibrary.simpleMessage("您將不能再停用加密，確定嗎？"),
        "encrypted": MessageLookupByLibrary.simpleMessage("加密的"),
        "encryption": MessageLookupByLibrary.simpleMessage("加密"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage("加密未啟用"),
        "endedTheCall": m29,
        "enterAGroupName": MessageLookupByLibrary.simpleMessage("輸入群組名稱"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("輸入一個電子郵件位址"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage("輸入伺服器位址"),
        "everythingReady": MessageLookupByLibrary.simpleMessage("一切就緒！"),
        "extremeOffensive": MessageLookupByLibrary.simpleMessage("極端令人反感"),
        "fileName": MessageLookupByLibrary.simpleMessage("檔案名稱"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("字體大小"),
        "forward": MessageLookupByLibrary.simpleMessage("轉發"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("自加入起"),
        "fromTheInvitation": MessageLookupByLibrary.simpleMessage("自邀請起"),
        "goToTheNewRoom": MessageLookupByLibrary.simpleMessage("前往新聊天室"),
        "group": MessageLookupByLibrary.simpleMessage("群組"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("群組描述"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("群組描述已被變更"),
        "groupIsPublic": MessageLookupByLibrary.simpleMessage("群組是公開的"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("群組"),
        "guestsAreForbidden": MessageLookupByLibrary.simpleMessage("訪客已被禁止"),
        "guestsCanJoin": MessageLookupByLibrary.simpleMessage("訪客可以加入"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("幫助"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage("隱藏編輯過的事件"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage("隱藏未知事件"),
        "howOffensiveIsThisContent":
            MessageLookupByLibrary.simpleMessage("這個內容有多令人反感？"),
        "iHaveClickedOnLink": MessageLookupByLibrary.simpleMessage("我已經點擊了網址"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("身份"),
        "ignore": MessageLookupByLibrary.simpleMessage("無視"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "您可以無視打擾您的使用者。您將不會再收到來自無視列表中使用者的任何消息或聊天室邀請。"),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage("無視使用者名稱"),
        "ignoredUsers": MessageLookupByLibrary.simpleMessage("已無視的使用者"),
        "incorrectPassphraseOrKey":
            MessageLookupByLibrary.simpleMessage("錯誤的密碼短語或恢復金鑰"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("不令人反感"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("邀請聯絡人"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("來自我的邀請"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("已邀請"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage("只有被邀請的使用者"),
        "isTyping": MessageLookupByLibrary.simpleMessage("正在輸入...…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("加入聊天室"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("從聊天室踢出"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("很長一段時間沒有上線了"),
        "leave": MessageLookupByLibrary.simpleMessage("離開"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("離開了聊天室"),
        "license": MessageLookupByLibrary.simpleMessage("授權"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("日間模式"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("載入更多…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage("載入中… 請稍候。"),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("登入"),
        "logout": MessageLookupByLibrary.simpleMessage("登出"),
        "makeSureTheIdentifierIsValid":
            MessageLookupByLibrary.simpleMessage("確保識別碼正確"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("變更成員"),
        "mention": MessageLookupByLibrary.simpleMessage("提及"),
        "messageWillBeRemovedWarning":
            MessageLookupByLibrary.simpleMessage("將移除所有參與者的訊息"),
        "messages": MessageLookupByLibrary.simpleMessage("訊息"),
        "moderator": MessageLookupByLibrary.simpleMessage("版主"),
        "muteChat": MessageLookupByLibrary.simpleMessage("將該聊天室靜音"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "請注意您需要Pantalaimon才能使用點對點加密功能。"),
        "newChat": MessageLookupByLibrary.simpleMessage("新聊天室"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("來自 FluffyChat 的新訊息"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("新的驗證請求！"),
        "next": MessageLookupByLibrary.simpleMessage("下一個"),
        "no": MessageLookupByLibrary.simpleMessage("否"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("無法連接到伺服器"),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage("表情符號不存在。😕"),
        "noEncryptionForPublicRooms":
            MessageLookupByLibrary.simpleMessage("您只能在這個聊天室不再被允許公開訪問後，才能啟用加密。"),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "看起來您手機上沒有Google服務框架。這對於保護您的隱私而言是個好決定！但為了收到FluffyChat的推播通知，我們推薦您使用 https://microg.org/ 或 https://unifiedpush.org/。"),
        "noPasswordRecoveryDescription":
            MessageLookupByLibrary.simpleMessage("您尚未新增恢復密碼的方法。"),
        "noPermission": MessageLookupByLibrary.simpleMessage("沒有權限"),
        "noRoomsFound": MessageLookupByLibrary.simpleMessage("找不到聊天室…"),
        "none": MessageLookupByLibrary.simpleMessage("無"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage("已為此帳號啟用通知"),
        "numUsersTyping": m47,
        "offensive": MessageLookupByLibrary.simpleMessage("令人反感"),
        "offline": MessageLookupByLibrary.simpleMessage("離線"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "online": MessageLookupByLibrary.simpleMessage("線上"),
        "onlineKeyBackupEnabled":
            MessageLookupByLibrary.simpleMessage("線上金鑰備份已啟用"),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("哎呀！出了一點差錯…"),
        "openAppToReadMessages":
            MessageLookupByLibrary.simpleMessage("打開應用程式以讀取訊息"),
        "openCamera": MessageLookupByLibrary.simpleMessage("開啟相機"),
        "optionalGroupName": MessageLookupByLibrary.simpleMessage("（可選）群組名稱"),
        "participant": MessageLookupByLibrary.simpleMessage("參與者"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage("密碼短語或恢復金鑰"),
        "password": MessageLookupByLibrary.simpleMessage("密碼"),
        "passwordForgotten": MessageLookupByLibrary.simpleMessage("忘記密碼"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("密碼已被變更"),
        "passwordRecovery": MessageLookupByLibrary.simpleMessage("恢復密碼"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage("密碼不匹配！"),
        "people": MessageLookupByLibrary.simpleMessage("人"),
        "pickImage": MessageLookupByLibrary.simpleMessage("選擇圖片"),
        "pin": MessageLookupByLibrary.simpleMessage("釘選"),
        "play": m48,
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("請選擇一個密碼"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("請選擇使用者名稱"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink":
            MessageLookupByLibrary.simpleMessage("請點擊電子郵件中的網址，然後繼續。"),
        "pleaseEnter4Digits":
            MessageLookupByLibrary.simpleMessage("請輸入4位數字，或留空以停用密碼鎖定。"),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("請輸入Matrix ID。"),
        "pleaseEnterValidEmail":
            MessageLookupByLibrary.simpleMessage("請輸入一個有效的電子郵件地址。"),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("請輸入您的密碼"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("請輸入您的使用者名稱"),
        "pleaseFollowInstructionsOnWeb":
            MessageLookupByLibrary.simpleMessage("請按照網站上的說明進行操作，然後點擊下一步。"),
        "privacy": MessageLookupByLibrary.simpleMessage("隱私"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("公開的聊天室"),
        "pushRules": MessageLookupByLibrary.simpleMessage("推播規則"),
        "reason": MessageLookupByLibrary.simpleMessage("原因"),
        "recording": MessageLookupByLibrary.simpleMessage("錄音中"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("重新編輯訊息"),
        "redactedAnEvent": m51,
        "reject": MessageLookupByLibrary.simpleMessage("拒絕"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("重新加入"),
        "remove": MessageLookupByLibrary.simpleMessage("移除"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("移除所有其他裝置"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("移除裝置"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage("繪製圖文訊息內容"),
        "repeatPassword": MessageLookupByLibrary.simpleMessage("再次輸入密碼"),
        "replaceRoomWithNewerVersion":
            MessageLookupByLibrary.simpleMessage("用較新的版本取代聊天室"),
        "reply": MessageLookupByLibrary.simpleMessage("回覆"),
        "reportMessage": MessageLookupByLibrary.simpleMessage("檢舉訊息"),
        "requestPermission": MessageLookupByLibrary.simpleMessage("請求權限"),
        "roomHasBeenUpgraded": MessageLookupByLibrary.simpleMessage("聊天室已更新"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("聊天室的版本"),
        "search": MessageLookupByLibrary.simpleMessage("搜尋"),
        "security": MessageLookupByLibrary.simpleMessage("安全"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("傳送"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("傳送訊息"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("傳送音訊"),
        "sendFile": MessageLookupByLibrary.simpleMessage("傳送文件"),
        "sendImage": MessageLookupByLibrary.simpleMessage("傳送圖片"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("傳送訊息"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("按 Enter 鍵發送"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("傳送原始內容"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("傳送影片"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage("自訂表情符號"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage("設定群組描述"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage("設定邀請連結"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage("設定權限級別"),
        "setStatus": MessageLookupByLibrary.simpleMessage("設定狀態"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "share": MessageLookupByLibrary.simpleMessage("分享"),
        "sharedTheLocation": m63,
        "showPassword": MessageLookupByLibrary.simpleMessage("顯示密碼"),
        "signUp": MessageLookupByLibrary.simpleMessage("註冊"),
        "skip": MessageLookupByLibrary.simpleMessage("跳過"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("原始碼"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("狀態"),
        "statusExampleMessage": MessageLookupByLibrary.simpleMessage("今天過得如何？"),
        "submit": MessageLookupByLibrary.simpleMessage("送出"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("自動"),
        "theyDontMatch": MessageLookupByLibrary.simpleMessage("它們不相符"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("它們相符"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite": MessageLookupByLibrary.simpleMessage("切換收藏夾"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage("切換靜音"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage("標記為已讀/未讀"),
        "tooManyRequestsWarning":
            MessageLookupByLibrary.simpleMessage("太多請求了。請稍候再試！"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("從其他裝置傳輸"),
        "tryToSendAgain": MessageLookupByLibrary.simpleMessage("再次嘗試傳送"),
        "unavailable": MessageLookupByLibrary.simpleMessage("無法取得"),
        "unbanFromChat": MessageLookupByLibrary.simpleMessage("解禁聊天"),
        "unbannedUser": m68,
        "unblockDevice": MessageLookupByLibrary.simpleMessage("解除鎖定裝置"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("未知裝置"),
        "unknownEncryptionAlgorithm":
            MessageLookupByLibrary.simpleMessage("未知的加密演算法"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage("取消靜音聊天室"),
        "unpin": MessageLookupByLibrary.simpleMessage("取消釘選"),
        "unreadChats": m69,
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("使用者名稱"),
        "verified": MessageLookupByLibrary.simpleMessage("已驗證"),
        "verify": MessageLookupByLibrary.simpleMessage("驗證"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("開始驗證"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage("您成功驗證了！"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage("正在驗證其他帳號"),
        "videoCall": MessageLookupByLibrary.simpleMessage("視訊通話"),
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("聊天記錄的可見性"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("對所有參與者可見"),
        "visibleForEveryone": MessageLookupByLibrary.simpleMessage("對所有人可見"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("語音訊息"),
        "waitingPartnerAcceptRequest":
            MessageLookupByLibrary.simpleMessage("正在等待夥伴接受請求…"),
        "waitingPartnerEmoji":
            MessageLookupByLibrary.simpleMessage("正在等待夥伴接受表情符號…"),
        "waitingPartnerNumbers":
            MessageLookupByLibrary.simpleMessage("正在等待夥伴接受數字…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("桌布"),
        "warning": MessageLookupByLibrary.simpleMessage("警告！"),
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("我們向您傳送了一封電子郵件"),
        "whoCanPerformWhichAction":
            MessageLookupByLibrary.simpleMessage("誰可以執行這個動作"),
        "whoIsAllowedToJoinThisGroup":
            MessageLookupByLibrary.simpleMessage("誰可以加入這個群組"),
        "whyDoYouWantToReportThis":
            MessageLookupByLibrary.simpleMessage("您檢舉的原因是什麼？"),
        "wipeChatBackup":
            MessageLookupByLibrary.simpleMessage("要清除您的聊天記錄備份以建立新的安全金鑰嗎？"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage("有了這些位址，您就可以恢復密碼。"),
        "writeAMessage": MessageLookupByLibrary.simpleMessage("輸入訊息…"),
        "yes": MessageLookupByLibrary.simpleMessage("是"),
        "you": MessageLookupByLibrary.simpleMessage("您"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("有人邀請您加入這個聊天室"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage("您不再參與這個聊天室了"),
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("您不能邀請您自己"),
        "youHaveBeenBannedFromThisChat":
            MessageLookupByLibrary.simpleMessage("您已經被這個聊天室封禁"),
        "yourChatBackupHasBeenSetUp":
            MessageLookupByLibrary.simpleMessage("您的聊天記錄備份已設定。"),
        "yourPublicKey": MessageLookupByLibrary.simpleMessage("您的公鑰")
      };
}
