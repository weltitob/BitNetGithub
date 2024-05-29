// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a he locale. All the
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
  String get localeName => 'he';

  static String m0(username) => "${username} קיבל את ההזמנה";

  static String m1(username) => "${username} הפעיל הצפנה מקצה לקצה";

  static String m2(senderName) => "${senderName} ענה לשיחה";

  static String m3(username) => "לקבל בקשת אימות זו מ- ${username}?";

  static String m4(username, targetName) => "${username} חסם את ${targetName}";

  static String m5(uri) => "לא ניתן לפתוח את ה-URI ${uri}";

  static String m6(username) => "${username} שינה את האווטאר של הצ\'אט";

  static String m7(username, description) =>
      "${username} שינה את תיאור הצ\'אט ל: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} שינה את שם הצ\'אט ל: \'${chatname}\'";

  static String m9(username) => "${username} שינה את הרשאות הצ\'אט";

  static String m10(username, displayname) =>
      "${username} שינה את שם התצוגה שלו ל: \'${displayname}\'";

  static String m11(username) => "${username} שינה את כללי הגישה לאורחים";

  static String m12(username, rules) =>
      "${username} שינה את כללי הגישה לאורחים ל: ${rules}";

  static String m13(username) => "${username} שינה את נראות ההיסטוריה";

  static String m14(username, rules) =>
      "${username} שינה את נראות ההיסטוריה ל: ${rules}";

  static String m15(username) => "${username} שינה את כללי ההצטרפות";

  static String m16(username, joinRules) =>
      "${username} שינה את כללי ההצטרפות ל: ${joinRules}";

  static String m17(username) => "${username} שינה את האווטאר שלו";

  static String m18(username) => "${username} שינה את כינוי החדר";

  static String m19(username) => "${username} שינה את קישור ההזמנה";

  static String m20(command) => "${command} אינו פקודה.";

  static String m21(error) => "לא ניתן לפענח הודעה: ${error}";

  static String m23(count) => "${count} משתתפים";

  static String m24(username) => "${username} יצר את הצ\'אט";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}-${month}-${day}";

  static String m28(month, day) => "${month}-${day}";

  static String m29(senderName) => "${senderName} סיים את השיחה";

  static String m30(error) => "שגיאה בהשגת מיקום: ${error}";

  static String m33(displayname) => "קבוצה עם ${displayname}";

  static String m34(username, targetName) =>
      "${username} ביטל את ההזמנה עבור ${targetName}";

  static String m36(groupName) => "הזמן איש קשר אל ${groupName}";

  static String m37(username, link) =>
      "${username} הזמין אותך ל-FluffyChat.\n1. התקן את FluffyChat: https://fluffychat.im\n2. הירשם או היכנס\n3. פתח את קישור ההזמנה: ${link}";

  static String m38(username, targetName) =>
      "${username} הזמין את ${targetName}";

  static String m39(username) => "${username} הצטרף לצ\'אט";

  static String m40(username, targetName) => "${username} בעט ב ${targetName}";

  static String m41(username, targetName) =>
      "${username} בעט וחסם ${targetName}";

  static String m42(localizedTimeShort) =>
      "פעילות אחרונה: ${localizedTimeShort}";

  static String m43(count) => "טען ${count} משתתפים נוספים";

  static String m44(homeserver) => "היכנס אל ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} אינו שרת מטריקס, השתמש ב-${server2} במקום זאת?";

  static String m47(count) => "${count} משתמשים מקלידים…";

  static String m48(fileName) => "הפעל ${fileName}";

  static String m49(min) => "אנא כתוב לפחות ${min} תווים";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("אודות"),
        "accept": MessageLookupByLibrary.simpleMessage("קבל"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("חשבון"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("הוסף חשבון"),
        "addEmail": MessageLookupByLibrary.simpleMessage("הוסף מייל"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("הוספת תיאור קבוצה"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("הוסף לחבילה"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("הוסף לחלל"),
        "admin": MessageLookupByLibrary.simpleMessage("מנהל"),
        "alias": MessageLookupByLibrary.simpleMessage("כינוי"),
        "all": MessageLookupByLibrary.simpleMessage("הכל"),
        "allChats": MessageLookupByLibrary.simpleMessage("כל הצ\'אטים"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("כל אחד יכול להצטרף"),
        "appLock": MessageLookupByLibrary.simpleMessage("נעילת אפליקציה"),
        "archive": MessageLookupByLibrary.simpleMessage("ארכיון"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "האם משתמשים אורחים מורשים להצטרף"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("האם אתה בטוח?"),
        "areYouSureYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("האם אתה בטוח שברצונך לצאת?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "כדי שתוכל לחתום על משתמש אחר , הזן את הסיסמה שלך או את מפתח השחזור."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "הפעל אוטומטית מדבקות ואנימציות מונפשים"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("צאט חסום"),
        "banned": MessageLookupByLibrary.simpleMessage("חסום"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("חסום מכשיר"),
        "blocked": MessageLookupByLibrary.simpleMessage("חסום"),
        "botMessages": MessageLookupByLibrary.simpleMessage("הודעות בוט"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("גודל בועות"),
        "bundleName": MessageLookupByLibrary.simpleMessage("שם החבילה"),
        "cancel": MessageLookupByLibrary.simpleMessage("ביטול"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("שנה את שם המכשיר"),
        "changePassword": MessageLookupByLibrary.simpleMessage("שנה סיסמא"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("שנה את שרת הבית"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("שנה את שם הקבוצה"),
        "changeTheme":
            MessageLookupByLibrary.simpleMessage("שנה את הסגנון שלך"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage("שנה טפט"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("שינוי האווטאר שלך"),
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
            MessageLookupByLibrary.simpleMessage("ההצפנה נפגמה"),
        "chat": MessageLookupByLibrary.simpleMessage("צ׳אט"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("גיבוי צ\'אט"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "גיבוי הצ\'אט שלך מאובטח באמצעות מפתח אבטחה. אנא וודא שאתה לא מאבד אותו."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("פרטי צ\'אט"),
        "chatHasBeenAddedToThisSpace":
            MessageLookupByLibrary.simpleMessage("צ\'אט נוסף למרחב הזה"),
        "chats": MessageLookupByLibrary.simpleMessage("צ\'אטים"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("בחר סיסמה חזקה"),
        "chooseAUsername": MessageLookupByLibrary.simpleMessage("בחר שם משתמש"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("נקה ארכיון"),
        "close": MessageLookupByLibrary.simpleMessage("סגור"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "חסום את המשתמש הנתון מהחדר הזה"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("נקה מטמון"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "צור צ\'אט קבוצתי ריק\nהשתמש ב--no-encryption כדי להשבית את ההצפנה"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("התעלם מהסשן"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "התחל צ\'אט ישיר\nהשתמש ב--no-encryption כדי להשבית את ההצפנה"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("שלח טקסט בתבנית HTML"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "הזמן את המשתמש הנתון לחדר זה"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("הצטרף לחדר הנתון"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "הסר את המשתמש הנתון מהחדר הזה"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("עזוב את החדר הזה"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("תאר את עצמך"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "הגדר את התמונה שלך לחדר זה (על ידי mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "הגדר את שם התצוגה שלך עבור חדר זה"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "הגדרת רמת צריכת החשמל של המשתמש הנתון (ברירת מחדל: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("שלח טקסט לא מעוצב"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("שלח תשובה כתגובה"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("שלח טקסט"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "בטל את החסימה של המשתמש הנתון מהחדר הזה"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("הפקודה אינה חוקית"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "השווה וודא שהאימוג\'י הבאים תואמים לאלו של המכשיר השני:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "השווה וודא שהמספרים הבאים תואמים לאלה של המכשיר השני:"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("קביעת תצורה של צ\'אט"),
        "confirm": MessageLookupByLibrary.simpleMessage("לאשר"),
        "connect": MessageLookupByLibrary.simpleMessage("התחבר"),
        "contactHasBeenInvitedToTheGroup":
            MessageLookupByLibrary.simpleMessage("איש הקשר הוזמן לקבוצה"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("מכיל שם תצוגה"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("מכיל שם משתמש"),
        "contentHasBeenReported":
            MessageLookupByLibrary.simpleMessage("התוכן דווח למנהלי השרת"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("הועתק ללוח הגזירים"),
        "copy": MessageLookupByLibrary.simpleMessage("העתק"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage("העתק ללוח"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("צור"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("צור קבוצה חדשה"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("חלל חדש"),
        "createdTheChat": m24,
        "currentlyActive": MessageLookupByLibrary.simpleMessage("פעיל כעת"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("כהה"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "פעולה זו תשבית את חשבון המשתמש שלך. אי אפשר לבטל את זה! האם אתה בטוח?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("רמת הרשאת ברירת מחדל"),
        "delete": MessageLookupByLibrary.simpleMessage("מחיקה"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("מחק חשבון"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("מחק הודעה"),
        "deny": MessageLookupByLibrary.simpleMessage("דחה"),
        "device": MessageLookupByLibrary.simpleMessage("מכשיר"),
        "deviceId": MessageLookupByLibrary.simpleMessage("מזהה מכשיר"),
        "devices": MessageLookupByLibrary.simpleMessage("התקנים"),
        "directChats": MessageLookupByLibrary.simpleMessage("צ\'אטים ישירים"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("שם התצוגה השתנה"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("הורד קובץ"),
        "edit": MessageLookupByLibrary.simpleMessage("ערוך"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("ערוך שרתים חסומים"),
        "editBundlesForAccount":
            MessageLookupByLibrary.simpleMessage("ערוך חבילות עבור חשבון זה"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("ערוך הרשאות צ\'אט"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("ערוך את שם התצוגה"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("ערוך כינויים לחדר"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("עריכת אווטאר של חדר"),
        "emoteExists": MessageLookupByLibrary.simpleMessage("אימוט כבר קיים!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("צ\'אט ריק"),
        "enableEncryption": MessageLookupByLibrary.simpleMessage("אפשר הצפנה"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "לא תוכל לבטל את ההצפנה יותר. האם אתה בטוח?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(בטא) אפשר ריבוי חשבונות במכשיר זה"),
        "encrypted": MessageLookupByLibrary.simpleMessage("מוצפן"),
        "encryption": MessageLookupByLibrary.simpleMessage("הצפנה"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("ההצפנה אינה מופעלת"),
        "endedTheCall": m29,
        "enterAGroupName": MessageLookupByLibrary.simpleMessage("הזן שם קבוצה"),
        "enterASpacepName": MessageLookupByLibrary.simpleMessage("הזן שם חלל"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("הזן כתובת דואר אלקטרוני"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("הזן את שרת הבית שלך"),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("הכל מוכן!"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("פוגעני ביותר"),
        "fileName": MessageLookupByLibrary.simpleMessage("שם קובץ"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("גודל גופן"),
        "forward": MessageLookupByLibrary.simpleMessage("העבר"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("מהצטרפות"),
        "fromTheInvitation": MessageLookupByLibrary.simpleMessage("מההזמנה"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("עבור לחדר החדש"),
        "group": MessageLookupByLibrary.simpleMessage("קבוצה"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("תיאור קבוצה"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("תיאור הקבוצה השתנה"),
        "groupIsPublic": MessageLookupByLibrary.simpleMessage("הקבוצה ציבורית"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("קבוצות"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("אורחים אסורים"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("אורחים יכולים להצטרף"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("עזרה"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("הסתר אירועים מצונזרים"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("הסתר אירועים לא ידועים"),
        "homeserver": MessageLookupByLibrary.simpleMessage("שרת בית"),
        "howOffensiveIsThisContent":
            MessageLookupByLibrary.simpleMessage("עד כמה התוכן הזה פוגעני?"),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("לחצתי על הקישור"),
        "id": MessageLookupByLibrary.simpleMessage("מזהה"),
        "identity": MessageLookupByLibrary.simpleMessage("זהות"),
        "ignore": MessageLookupByLibrary.simpleMessage("התעלם"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "באפשרותך להתעלם ממשתמשים שמפריעים לך. לא תוכל לקבל הודעות או הזמנות לחדר מהמשתמשים ברשימת ההתעלם האישית שלך."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("התעלם משם משתמש"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("משתמשים שהתעלמו מהם"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "ביטוי סיסמה או מפתח שחזור שגויים"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("לֹא פּוֹגֵעַ"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("הזמן איש קשר"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("הזמנה בשבילי"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("הזמין"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("משתמשים מוזמנים בלבד"),
        "isTyping": MessageLookupByLibrary.simpleMessage("מקליד/ה…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("הצטרף לחדר"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("בעיטה מהצ\'אט"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("נראה לפני זמן רב"),
        "leave": MessageLookupByLibrary.simpleMessage("לעזוב"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("עזב את הצ\'אט"),
        "license": MessageLookupByLibrary.simpleMessage("רשיון"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("בהיר"),
        "link": MessageLookupByLibrary.simpleMessage("קישור"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("טען עוד…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("טוען אנא המתן."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "שירותי המיקום מושבתים. אנא הפעל אותם כדי לשתף את המיקום שלך."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "הרשאת המיקום נדחתה. אנא אפשר את היכולת לשתף את מיקומך."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("כניסה"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("היכנס בלחיצה אחת"),
        "logout": MessageLookupByLibrary.simpleMessage("יציאה"),
        "makeSureTheIdentifierIsValid":
            MessageLookupByLibrary.simpleMessage("ודא שהמזהה חוקי"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("שינויים בחבר"),
        "mention": MessageLookupByLibrary.simpleMessage("הזכיר"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "ההודעה תוסר עבור כל המשתתפים"),
        "messages": MessageLookupByLibrary.simpleMessage("הודעות"),
        "moderator": MessageLookupByLibrary.simpleMessage("מנחה"),
        "muteChat": MessageLookupByLibrary.simpleMessage("השתקת הצ\'אט"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "שים לב שאתה צריך Pantalaimon כדי להשתמש בהצפנה מקצה לקצה לעת עתה."),
        "newChat": MessageLookupByLibrary.simpleMessage("צ\'אט חדש"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("הודעה חדשה ב-FluffyChat"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("בקשת אימות חדשה!"),
        "next": MessageLookupByLibrary.simpleMessage("הבא"),
        "no": MessageLookupByLibrary.simpleMessage("לא"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("אין חיבור לשרת"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "אתה יכול להפעיל הצפנה רק כשהחדר כבר לא נגיש לציבור."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "נראה שאין לך שירותי גוגל בטלפון שלך. זו החלטה טובה לפרטיות שלך! כדי לקבל התרעות ב- FluffyChat אנו ממליצים להשתמש https://microg.org/ או https://unifiedpush.org/."),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "עדיין לא הוספת דרך לשחזר את הסיסמה שלך."),
        "noPermission": MessageLookupByLibrary.simpleMessage("אין הרשאה"),
        "noRoomsFound": MessageLookupByLibrary.simpleMessage("לא נמצאו חדרים…"),
        "none": MessageLookupByLibrary.simpleMessage("ללא"),
        "notifications": MessageLookupByLibrary.simpleMessage("התראות"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage("התראות הופעלו עבור חשבון זה"),
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("משיג מיקום…"),
        "offensive": MessageLookupByLibrary.simpleMessage("פוגעני"),
        "offline": MessageLookupByLibrary.simpleMessage("לא מקוון"),
        "oneClientLoggedOut":
            MessageLookupByLibrary.simpleMessage("אחד מהמכשירים שלך התנתק"),
        "online": MessageLookupByLibrary.simpleMessage("מחובר/ת"),
        "onlineKeyBackupEnabled":
            MessageLookupByLibrary.simpleMessage("גיבוי מפתח מקוון מופעל"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "אופס! למרבה הצער, אירעה שגיאה בעת הגדרת התראות."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("אופס, משהו השתבש…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "פתח את האפליקציה לקריאת הודעות"),
        "openCamera": MessageLookupByLibrary.simpleMessage("פתח מצלמה"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("פתיחה במפות"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("פתח את המצלמה לסרטון"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(אופציונלי) שם קבוצה"),
        "or": MessageLookupByLibrary.simpleMessage("או"),
        "participant": MessageLookupByLibrary.simpleMessage("משתתף"),
        "passphraseOrKey":
            MessageLookupByLibrary.simpleMessage("ביטוי סיסמה או מפתח שחזור"),
        "password": MessageLookupByLibrary.simpleMessage("סיסמה"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("שכחתי סיסמה"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("הסיסמה שונתה"),
        "passwordRecovery": MessageLookupByLibrary.simpleMessage("שחזור סיסמה"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("הסיסמאות לא תואמות!"),
        "people": MessageLookupByLibrary.simpleMessage("אנשים"),
        "pickImage": MessageLookupByLibrary.simpleMessage("בחר תמונה"),
        "pin": MessageLookupByLibrary.simpleMessage("קוד pin"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("אנא בחר"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("אנא בחר קוד גישה"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("אנא בחר שם משתמש"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "אנא לחץ על הקישור במייל ולאחר מכן המשך."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "אנא הזן 4 ספרות או השאר ריק כדי להשבית את נעילת האפליקציה."),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("אנא הזן Matrix ID."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "אנא כתוב כתובת אימייל תקינה."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("נא הזן את הסיסמה שלך"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("אנא הזן את קוד הpin שלך"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("אנא הזן שם משתמש"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("הסר מחבילה זו"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("כתוב שוב את הסיסמה"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("סרוק קוד QR"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("שלח בכניסה"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "שרת זה צריך לאמת את כתובת הדואר האלקטרוני שלך לרישום."),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("שתף את קישור ההזמנה שלך"),
        "updateAvailable":
            MessageLookupByLibrary.simpleMessage("עדכון FluffyChat זמין"),
        "updateNow": MessageLookupByLibrary.simpleMessage("התחל עדכון ברקע"),
        "yourChatBackupHasBeenSetUp":
            MessageLookupByLibrary.simpleMessage("גיבוי הצ\'אט שלך הוגדר.")
      };
}
