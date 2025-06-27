// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class L10nHe extends L10n {
  L10nHe([String locale = 'he']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Create Account';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get poweredByDIDs => 'Powered with DIDs by';

  @override
  String get usernameOrDID => 'Username or DID';

  @override
  String get privateKey => 'Private Key';

  @override
  String get privateKeyLogin => 'DID and Private Key Login';

  @override
  String get restoreWithSocialRecovery => 'Restore with social recovery';

  @override
  String get pinCodeVerification => 'Pin Code Verification';

  @override
  String get invitationCode => 'Invitation Code';

  @override
  String get noAccountYet => 'You don\'t have an account yet?';

  @override
  String get alreadyHaveAccount => 'You already have an registered Account?';

  @override
  String get codeAlreadyUsed => 'It seems like this code has already been used';

  @override
  String get codeNotValid => 'Code is not valid.';

  @override
  String get errorSomethingWrong => 'Something went wrong';

  @override
  String get powerToThePeople => 'Power to the people!';

  @override
  String get platformDemandText =>
      'We\'re thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users.';

  @override
  String get platformExlusivityText =>
      'We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration.';

  @override
  String get platformExpandCapacityText =>
      'Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!';

  @override
  String get passwordsDoNotMatch => 'הסיסמאות לא תואמות!';

  @override
  String get pleaseEnterValidEmail => 'אנא כתוב כתובת אימייל תקינה.';

  @override
  String get pleaseEnterValidUsername =>
      'The username you entered is not valid.';

  @override
  String get usernameTaken => 'This username is already taken.';

  @override
  String get enterWordsRightOrder => 'Enter your 24 words in the right order';

  @override
  String get confirmKey => 'Confirm Key';

  @override
  String get skipAtOwnRisk => 'Skip at own risk';

  @override
  String get yourPassowrdBackup => 'Your Password & Backup';

  @override
  String get saveYourmnemonicSecurely => 'Save your mnemonic securely!';

  @override
  String get continues => 'Continue';

  @override
  String get fixed => 'fixed';

  @override
  String get timeAgo => 'time ago...';

  @override
  String get noUserFound => 'No users found.';

  @override
  String get assets => 'Assets';

  @override
  String get bitcoin => 'Bitcoin';

  @override
  String get whaleBehavior => 'Whale Behaviour';

  @override
  String get nameBehavior => ' NAME';

  @override
  String get dateBehavior => ' DATE';

  @override
  String get valueBehavior => ' VALUE';

  @override
  String get sendBitcoin => ' Send Bitcoin';

  @override
  String get dontShareAnyone => 'DON\'T SHARE THIS QR CODE TO ANYONE!';

  @override
  String get typeBehavior => ' TYPE';

  @override
  String get inviteDescription =>
      'Our service is currently in beta and \nlimited to invited users. You can share these invitation \nkeys with your friends and family!';

  @override
  String get noResultsFound => ' No results found';

  @override
  String get bitcoinNews => 'Bitcoin News';

  @override
  String get quickLinks => 'Quick Links';

  @override
  String get fearAndGreedIndex => 'Fear & Greed Index';

  @override
  String get bitcoinDescription =>
      'Bitcoin (BTC) is the first cryptocurrency built. Unlike government-issued or fiat currencies such as US Dollars or Euro which are controlled by central banks, Bitcoin can operate without the need of a central authority like a central bank or a company. Users are able to send funds to each other without going through intermediaries.';

  @override
  String get people => 'אנשים';

  @override
  String get now => 'Now: ';

  @override
  String get lastUpdated => 'Last updated: ';

  @override
  String get buyBitcoin => 'Buy Bitcoin';

  @override
  String get saveCard => 'Save Card';

  @override
  String get addNewCard => 'Add New Card';

  @override
  String get payemntMethod => 'Payment Method';

  @override
  String get purchaseBitcoin => 'Purchase Bitcoin';

  @override
  String get fearAndGreed => 'Fear and Greed';

  @override
  String get hashrateDifficulty => 'Hashrate & Difficulty';

  @override
  String get groups => 'קבוצות';

  @override
  String get liked => 'Liked';

  @override
  String get swap => 'Swap';

  @override
  String get autoLong => 'auto long';

  @override
  String get autoShort => 'auto short';

  @override
  String get noUsersFound => 'No users could be found';

  @override
  String get joinedRevolution =>
      'Hey there Bitcoiners! I joined the revolution!';

  @override
  String get mnemonicCorrect =>
      'Your mnemonic is correct! Please keep it safe.';

  @override
  String get mnemonicInCorrect =>
      'Your mnemonic does not match. Please try again.';

  @override
  String get saveYourmnemonicSecurelyDescription =>
      'Save this sequence on a piece of paper it acts as your password to your account, a loss of this sequence will result in a loss of your funds.';

  @override
  String get repeatPassword => 'כתוב שוב את הסיסמה';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'אנא כתוב לפחות $min תווים';
  }

  @override
  String get about => 'אודות';

  @override
  String get updateAvailable => 'עדכון FluffyChat זמין';

  @override
  String get updateNow => 'התחל עדכון ברקע';

  @override
  String get accept => 'קבל';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username קיבל את ההזמנה';
  }

  @override
  String get account => 'חשבון';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username הפעיל הצפנה מקצה לקצה';
  }

  @override
  String get addEmail => 'הוסף מייל';

  @override
  String get confirmMatrixId =>
      'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'הוספת תיאור קבוצה';

  @override
  String get addToSpace => 'הוסף לחלל';

  @override
  String get admin => 'מנהל';

  @override
  String get alias => 'כינוי';

  @override
  String get all => 'הכל';

  @override
  String get allChats => 'כל הצ\'אטים';

  @override
  String get commandHint_googly => 'Send some googly eyes';

  @override
  String get commandHint_cuddle => 'Send a cuddle';

  @override
  String get commandHint_hug => 'Send a hug';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName sends you googly eyes';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName cuddles you';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName hugs you';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '$senderName ענה לשיחה';
  }

  @override
  String get anyoneCanJoin => 'כל אחד יכול להצטרף';

  @override
  String get appLock => 'נעילת אפליקציה';

  @override
  String get archive => 'ארכיון';

  @override
  String get areGuestsAllowedToJoin => 'האם משתמשים אורחים מורשים להצטרף';

  @override
  String get areYouSure => 'האם אתה בטוח?';

  @override
  String get areYouSureYouWantToLogout => 'האם אתה בטוח שברצונך לצאת?';

  @override
  String get askSSSSSign =>
      'כדי שתוכל לחתום על משתמש אחר , הזן את הסיסמה שלך או את מפתח השחזור.';

  @override
  String askVerificationRequest(Object username) {
    return 'לקבל בקשת אימות זו מ- $username?';
  }

  @override
  String get autoplayImages => 'הפעל אוטומטית מדבקות ואנימציות מונפשים';

  @override
  String get sendOnEnter => 'שלח בכניסה';

  @override
  String get banFromChat => 'צאט חסום';

  @override
  String get banned => 'חסום';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username חסם את $targetName';
  }

  @override
  String get blockDevice => 'חסום מכשיר';

  @override
  String get blocked => 'חסום';

  @override
  String get botMessages => 'הודעות בוט';

  @override
  String get bubbleSize => 'גודל בועות';

  @override
  String get cancel => 'ביטול';

  @override
  String cantOpenUri(Object uri) {
    return 'לא ניתן לפתוח את ה-URI $uri';
  }

  @override
  String get changeDeviceName => 'שנה את שם המכשיר';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username שינה את האווטאר של הצ\'אט';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username שינה את תיאור הצ\'אט ל: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username שינה את שם הצ\'אט ל: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username שינה את הרשאות הצ\'אט';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username שינה את שם התצוגה שלו ל: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username שינה את כללי הגישה לאורחים';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username שינה את כללי הגישה לאורחים ל: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username שינה את נראות ההיסטוריה';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username שינה את נראות ההיסטוריה ל: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username שינה את כללי ההצטרפות';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username שינה את כללי ההצטרפות ל: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username שינה את האווטאר שלו';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username שינה את כינוי החדר';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username שינה את קישור ההזמנה';
  }

  @override
  String get changePassword => 'שנה סיסמא';

  @override
  String get changeTheHomeserver => 'שנה את שרת הבית';

  @override
  String get changeTheme => 'שנה את הסגנון שלך';

  @override
  String get changeTheNameOfTheGroup => 'שנה את שם הקבוצה';

  @override
  String get changeWallpaper => 'שנה טפט';

  @override
  String get changeYourAvatar => 'שינוי האווטאר שלך';

  @override
  String get channelCorruptedDecryptError => 'ההצפנה נפגמה';

  @override
  String get chat => 'צ׳אט';

  @override
  String get yourChatBackupHasBeenSetUp => 'גיבוי הצ\'אט שלך הוגדר.';

  @override
  String get chatBackup => 'גיבוי צ\'אט';

  @override
  String get chatBackupDescription =>
      'גיבוי הצ\'אט שלך מאובטח באמצעות מפתח אבטחה. אנא וודא שאתה לא מאבד אותו.';

  @override
  String get chatDetails => 'פרטי צ\'אט';

  @override
  String get chatHasBeenAddedToThisSpace => 'צ\'אט נוסף למרחב הזה';

  @override
  String get chats => 'צ\'אטים';

  @override
  String get chooseAStrongPassword => 'בחר סיסמה חזקה';

  @override
  String get chooseAUsername => 'בחר שם משתמש';

  @override
  String get clearArchive => 'נקה ארכיון';

  @override
  String get close => 'סגור';

  @override
  String get commandHint_markasdm => 'Mark as direct message room';

  @override
  String get commandHint_markasgroup => 'Mark as group';

  @override
  String get commandHint_ban => 'חסום את המשתמש הנתון מהחדר הזה';

  @override
  String get commandHint_clearcache => 'נקה מטמון';

  @override
  String get commandHint_create =>
      'צור צ\'אט קבוצתי ריק\nהשתמש ב--no-encryption כדי להשבית את ההצפנה';

  @override
  String get commandHint_discardsession => 'התעלם מהסשן';

  @override
  String get commandHint_dm =>
      'התחל צ\'אט ישיר\nהשתמש ב--no-encryption כדי להשבית את ההצפנה';

  @override
  String get commandHint_html => 'שלח טקסט בתבנית HTML';

  @override
  String get commandHint_invite => 'הזמן את המשתמש הנתון לחדר זה';

  @override
  String get commandHint_join => 'הצטרף לחדר הנתון';

  @override
  String get commandHint_kick => 'הסר את המשתמש הנתון מהחדר הזה';

  @override
  String get commandHint_leave => 'עזוב את החדר הזה';

  @override
  String get commandHint_me => 'תאר את עצמך';

  @override
  String get commandHint_myroomavatar =>
      'הגדר את התמונה שלך לחדר זה (על ידי mxc-uri)';

  @override
  String get commandHint_myroomnick => 'הגדר את שם התצוגה שלך עבור חדר זה';

  @override
  String get commandHint_op =>
      'הגדרת רמת צריכת החשמל של המשתמש הנתון (ברירת מחדל: 50)';

  @override
  String get commandHint_plain => 'שלח טקסט לא מעוצב';

  @override
  String get commandHint_react => 'שלח תשובה כתגובה';

  @override
  String get commandHint_send => 'שלח טקסט';

  @override
  String get commandHint_unban => 'בטל את החסימה של המשתמש הנתון מהחדר הזה';

  @override
  String get commandInvalid => 'הפקודה אינה חוקית';

  @override
  String commandMissing(Object command) {
    return '$command אינו פקודה.';
  }

  @override
  String get compareEmojiMatch =>
      'השווה וודא שהאימוג\'י הבאים תואמים לאלו של המכשיר השני:';

  @override
  String get compareNumbersMatch =>
      'השווה וודא שהמספרים הבאים תואמים לאלה של המכשיר השני:';

  @override
  String get configureChat => 'קביעת תצורה של צ\'אט';

  @override
  String get confirm => 'לאשר';

  @override
  String get connect => 'התחבר';

  @override
  String get contactHasBeenInvitedToTheGroup => 'איש הקשר הוזמן לקבוצה';

  @override
  String get containsDisplayName => 'מכיל שם תצוגה';

  @override
  String get containsUserName => 'מכיל שם משתמש';

  @override
  String get contentHasBeenReported => 'התוכן דווח למנהלי השרת';

  @override
  String get copiedToClipboard => 'הועתק ללוח הגזירים';

  @override
  String get copy => 'העתק';

  @override
  String get copyToClipboard => 'העתק ללוח';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'לא ניתן לפענח הודעה: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count משתתפים';
  }

  @override
  String get create => 'צור';

  @override
  String createdTheChat(Object username) {
    return '$username יצר את הצ\'אט';
  }

  @override
  String get createNewGroup => 'צור קבוצה חדשה';

  @override
  String get createNewSpace => 'חלל חדש';

  @override
  String get currentlyActive => 'פעיל כעת';

  @override
  String get darkTheme => 'כהה';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$month-$day';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$year-$month-$day';
  }

  @override
  String get deactivateAccountWarning =>
      'פעולה זו תשבית את חשבון המשתמש שלך. אי אפשר לבטל את זה! האם אתה בטוח?';

  @override
  String get defaultPermissionLevel => 'רמת הרשאת ברירת מחדל';

  @override
  String get delete => 'מחיקה';

  @override
  String get deleteAccount => 'מחק חשבון';

  @override
  String get deleteMessage => 'מחק הודעה';

  @override
  String get deny => 'דחה';

  @override
  String get device => 'מכשיר';

  @override
  String get deviceId => 'מזהה מכשיר';

  @override
  String get devices => 'התקנים';

  @override
  String get directChats => 'צ\'אטים ישירים';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'שם התצוגה השתנה';

  @override
  String get downloadFile => 'הורד קובץ';

  @override
  String get edit => 'ערוך';

  @override
  String get editBlockedServers => 'ערוך שרתים חסומים';

  @override
  String get editChatPermissions => 'ערוך הרשאות צ\'אט';

  @override
  String get editDisplayname => 'ערוך את שם התצוגה';

  @override
  String get editRoomAliases => 'ערוך כינויים לחדר';

  @override
  String get editRoomAvatar => 'עריכת אווטאר של חדר';

  @override
  String get emoteExists => 'אימוט כבר קיים!';

  @override
  String get emoteInvalid => 'Invalid emote shortcode!';

  @override
  String get emotePacks => 'Emote packs for room';

  @override
  String get emoteSettings => 'Emote Settings';

  @override
  String get emoteShortcode => 'Emote shortcode';

  @override
  String get emoteWarnNeedToPick =>
      'You need to pick an emote shortcode and an image!';

  @override
  String get emptyChat => 'צ\'אט ריק';

  @override
  String get enableEmotesGlobally => 'Enable emote pack globally';

  @override
  String get enableEncryption => 'אפשר הצפנה';

  @override
  String get enableEncryptionWarning =>
      'לא תוכל לבטל את ההצפנה יותר. האם אתה בטוח?';

  @override
  String get encrypted => 'מוצפן';

  @override
  String get encryption => 'הצפנה';

  @override
  String get encryptionNotEnabled => 'ההצפנה אינה מופעלת';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName סיים את השיחה';
  }

  @override
  String get enterAGroupName => 'הזן שם קבוצה';

  @override
  String get enterAnEmailAddress => 'הזן כתובת דואר אלקטרוני';

  @override
  String get enterASpacepName => 'הזן שם חלל';

  @override
  String get homeserver => 'שרת בית';

  @override
  String get enterYourHomeserver => 'הזן את שרת הבית שלך';

  @override
  String errorObtainingLocation(Object error) {
    return 'שגיאה בהשגת מיקום: $error';
  }

  @override
  String get everythingReady => 'הכל מוכן!';

  @override
  String get extremeOffensive => 'פוגעני ביותר';

  @override
  String get fileName => 'שם קובץ';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'גודל גופן';

  @override
  String get forward => 'העבר';

  @override
  String get fromJoining => 'מהצטרפות';

  @override
  String get fromTheInvitation => 'מההזמנה';

  @override
  String get goToTheNewRoom => 'עבור לחדר החדש';

  @override
  String get group => 'קבוצה';

  @override
  String get groupDescription => 'תיאור קבוצה';

  @override
  String get groupDescriptionHasBeenChanged => 'תיאור הקבוצה השתנה';

  @override
  String get groupIsPublic => 'הקבוצה ציבורית';

  @override
  String groupWith(Object displayname) {
    return 'קבוצה עם $displayname';
  }

  @override
  String get guestsAreForbidden => 'אורחים אסורים';

  @override
  String get guestsCanJoin => 'אורחים יכולים להצטרף';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username ביטל את ההזמנה עבור $targetName';
  }

  @override
  String get help => 'עזרה';

  @override
  String get hideRedactedEvents => 'הסתר אירועים מצונזרים';

  @override
  String get hideUnknownEvents => 'הסתר אירועים לא ידועים';

  @override
  String get howOffensiveIsThisContent => 'עד כמה התוכן הזה פוגעני?';

  @override
  String get id => 'מזהה';

  @override
  String get identity => 'זהות';

  @override
  String get ignore => 'התעלם';

  @override
  String get ignoredUsers => 'משתמשים שהתעלמו מהם';

  @override
  String get ignoreListDescription =>
      'באפשרותך להתעלם ממשתמשים שמפריעים לך. לא תוכל לקבל הודעות או הזמנות לחדר מהמשתמשים ברשימת ההתעלם האישית שלך.';

  @override
  String get ignoreUsername => 'התעלם משם משתמש';

  @override
  String get iHaveClickedOnLink => 'לחצתי על הקישור';

  @override
  String get incorrectPassphraseOrKey => 'ביטוי סיסמה או מפתח שחזור שגויים';

  @override
  String get inoffensive => 'לֹא פּוֹגֵעַ';

  @override
  String get inviteContact => 'הזמן איש קשר';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'הזמן איש קשר אל $groupName';
  }

  @override
  String get invited => 'הזמין';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username הזמין את $targetName';
  }

  @override
  String get invitedUsersOnly => 'משתמשים מוזמנים בלבד';

  @override
  String get inviteForMe => 'הזמנה בשבילי';

  @override
  String inviteText(Object username, Object link) {
    return '$username הזמין אותך ל-FluffyChat.\n1. התקן את FluffyChat: https://fluffychat.im\n2. הירשם או היכנס\n3. פתח את קישור ההזמנה: $link';
  }

  @override
  String get isTyping => 'מקליד/ה…';

  @override
  String joinedTheChat(Object username) {
    return '$username הצטרף לצ\'אט';
  }

  @override
  String get joinRoom => 'הצטרף לחדר';

  @override
  String kicked(Object username, Object targetName) {
    return '$username בעט ב $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username בעט וחסם $targetName';
  }

  @override
  String get kickFromChat => 'בעיטה מהצ\'אט';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'פעילות אחרונה: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'נראה לפני זמן רב';

  @override
  String get leave => 'לעזוב';

  @override
  String get leftTheChat => 'עזב את הצ\'אט';

  @override
  String get license => 'רשיון';

  @override
  String get lightTheme => 'בהיר';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'טען $count משתתפים נוספים';
  }

  @override
  String get dehydrate => 'Export session and wipe device';

  @override
  String get dehydrateWarning =>
      'This action cannot be undone. Ensure you safely store the backup file.';

  @override
  String get dehydrateTor => 'TOR Users: Export session';

  @override
  String get dehydrateTorLong =>
      'For TOR users, it is recommended to export the session before closing the window.';

  @override
  String get hydrateTor => 'TOR Users: Import session export';

  @override
  String get hydrateTorLong =>
      'Did you export your session last time on TOR? Quickly import it and continue chatting.';

  @override
  String get hydrate => 'Restore from backup file';

  @override
  String get loadingPleaseWait => 'טוען אנא המתן.';

  @override
  String get loadMore => 'טען עוד…';

  @override
  String get locationDisabledNotice =>
      'שירותי המיקום מושבתים. אנא הפעל אותם כדי לשתף את המיקום שלך.';

  @override
  String get locationPermissionDeniedNotice =>
      'הרשאת המיקום נדחתה. אנא אפשר את היכולת לשתף את מיקומך.';

  @override
  String get login => 'כניסה';

  @override
  String get previousOutputType => 'Previous output type';

  @override
  String get previousOutputScripts => 'Previous output script';

  @override
  String get witness => 'Witness';

  @override
  String get outputTx => 'Outputs\n';

  @override
  String get showDetails => 'Show Details';

  @override
  String get hideDetails => 'Hide Details';

  @override
  String get inputTx => 'Inputs\n';

  @override
  String get transactionReplaced => 'This transaction has been replaced by:';

  @override
  String get loading => 'Loading';

  @override
  String get replaced => 'Replaced';

  @override
  String get paymentNetwork => 'Payment Network';

  @override
  String logInTo(Object homeserver) {
    return 'היכנס אל $homeserver';
  }

  @override
  String get loginWithOneClick => 'היכנס בלחיצה אחת';

  @override
  String get logout => 'יציאה';

  @override
  String get makeSureTheIdentifierIsValid => 'ודא שהמזהה חוקי';

  @override
  String get memberChanges => 'שינויים בחבר';

  @override
  String get mention => 'הזכיר';

  @override
  String get messages => 'הודעות';

  @override
  String get messageWillBeRemovedWarning => 'ההודעה תוסר עבור כל המשתתפים';

  @override
  String get moderator => 'מנחה';

  @override
  String get muteChat => 'השתקת הצ\'אט';

  @override
  String get needPantalaimonWarning =>
      'שים לב שאתה צריך Pantalaimon כדי להשתמש בהצפנה מקצה לקצה לעת עתה.';

  @override
  String get newChat => 'צ\'אט חדש';

  @override
  String get newMessageInFluffyChat => 'הודעה חדשה ב-FluffyChat';

  @override
  String get newVerificationRequest => 'בקשת אימות חדשה!';

  @override
  String get next => 'הבא';

  @override
  String get no => 'לא';

  @override
  String get noConnectionToTheServer => 'אין חיבור לשרת';

  @override
  String get noEmotesFound => 'No emotes found. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'אתה יכול להפעיל הצפנה רק כשהחדר כבר לא נגיש לציבור.';

  @override
  String get noGoogleServicesWarning =>
      'נראה שאין לך שירותי גוגל בטלפון שלך. זו החלטה טובה לפרטיות שלך! כדי לקבל התרעות ב- FluffyChat אנו ממליצים להשתמש https://microg.org/ או https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 אינו שרת מטריקס, השתמש ב-$server2 במקום זאת?';
  }

  @override
  String get shareYourInviteLink => 'שתף את קישור ההזמנה שלך';

  @override
  String get scanQrCode => 'סרוק קוד QR';

  @override
  String get scanQr => 'Scan QR';

  @override
  String get filter => 'Filter';

  @override
  String get art => 'Art';

  @override
  String get supply => 'Supply';

  @override
  String get subTotal => 'Subtotal';

  @override
  String get favorite => 'Favourite';

  @override
  String get price => 'Price';

  @override
  String get pressedFavorite =>
      'Press the Favorites button again to unfavorite';

  @override
  String get networkFee => 'Network Fee';

  @override
  String get marketFee => 'Market Fee';

  @override
  String get buyNow => 'Buy Now';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get forSale => 'For Sale';

  @override
  String get owners => 'Owners';

  @override
  String get searchItemsAndCollections => 'Search items and collections';

  @override
  String get cryptoPills => 'Crypto-Pills';

  @override
  String get createdBy => 'Created By';

  @override
  String get viewOffers => 'View Offers';

  @override
  String get itemsTotal => 'Items total';

  @override
  String get newTopSellers => 'New Top Sellers';

  @override
  String get mostHypedNewDeals => 'Most Hyped New Deals';

  @override
  String get sold => 'Sold';

  @override
  String get cart => 'Cart';

  @override
  String get chains => 'Chains';

  @override
  String get collections => 'Collections';

  @override
  String get sortBy => 'Sort By';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get clearAll => 'Clear All';

  @override
  String get showAll => 'Show All';

  @override
  String get totalVolume => 'Total Volume';

  @override
  String get sales => 'Sales';

  @override
  String get listed => 'Listed';

  @override
  String get views => 'Views';

  @override
  String get currentPrice => 'Current Price';

  @override
  String get hotNewItems => 'Hot New Items';

  @override
  String get mostViewed => 'Most Viewed';

  @override
  String get floorPrice => 'Floor Price';

  @override
  String get recentlyListed => 'Recently Listed';

  @override
  String get tradingHistory => 'Trading History';

  @override
  String get priceHistory => 'Price History';

  @override
  String get activities => 'Activities';

  @override
  String get chainInfo => 'Chain Info';

  @override
  String get properties => 'Properties';

  @override
  String get ethereum => 'ETHEREUM';

  @override
  String get mission => 'Mission';

  @override
  String get download => 'Download';

  @override
  String get wowBitnet =>
      'Wow! Bitnet is the part that I was always missing for bitcoin. Now we will only see more and more bitcoin adoption.';

  @override
  String get soHappy =>
      'So happy to be part of the club 1 million! Lightning is the future.';

  @override
  String get iHaveAlways =>
      'I have always been a Bitcoin enthusiast, so BitNet was a no-brainer for me. Its great to see how far we have come with Bitcoin.';

  @override
  String get justJoinedBitnet => ' just joined the BitNet!';

  @override
  String get userCharged => ' User-change in the last 7 days!';

  @override
  String get weHaveBetaLiftOff =>
      'We have Beta liftoff! Exclusive Early Access for Invited Users.';

  @override
  String get joinUsToday => 'Join us Today!';

  @override
  String get weEmpowerTomorrow => 'Building Bitcoin, Together.';

  @override
  String get historyClaim => 'History in Making: Claim your free Bitcoin NFT.';

  @override
  String get claimNFT => 'Claim your free Bitcoin NFT';

  @override
  String get beAmongFirst =>
      'Be among the first million users and secure your exclusive early-bird Bitcoin inscription.';

  @override
  String get weUnlockAssets => 'We unlock our future of digital assets!';

  @override
  String get exploreBtc => 'Explore BTC';

  @override
  String get weBuildTransparent =>
      'We build a transparent platform that uses verification - not trust.';

  @override
  String get givePowerBack => 'Give power back to the people!';

  @override
  String get getAProfile => 'Get a profile';

  @override
  String get weDigitizeAllSorts =>
      'We digitize all sorts of assets on top of the Bitcoin Network.';

  @override
  String get growAFair => 'Grow a fair Cyberspace!';

  @override
  String get sendBtc => 'Send BTC';

  @override
  String get weOfferEasiest =>
      'We offer the easiest, most secure, and most advanced web wallet.';

  @override
  String get makeBitcoinEasy => 'Make Bitcoin easy for everyone!';

  @override
  String get ourMissionn => 'Our mission.';

  @override
  String get limitedSpotsLeft => 'limited spots left!';

  @override
  String get weAreGrowingBitcoin => 'Let\'s bring Bitcoin to the future.';

  @override
  String get weBuildBitcoin => 'We build the Bitcoin Network!';

  @override
  String get ourMission =>
      'Our mission is simple but profound: To innovate in the digital \neconomy by integrating blockchain technology with asset digitization, \ncreating a secure and transparent platform that empowers users to engage \nwith the metaverse through Bitcoin. We are dedicated to making digital interactions \nmore accessible, equitable, and efficient for everyone. To accelerate the adoption of Bitcoin and create a world\n where digital assets are accessible, understandable, and beneficial to all. Where people can verify information \n on their own.';

  @override
  String get openOnEtherscan => 'Open On Etherscan';

  @override
  String get tokenId => 'Token ID';

  @override
  String get contractAddress => 'Contract address';

  @override
  String get guardiansDesigned =>
      'Not only are Guardians dope designed character-collectibles, they also serve as your ticket to a world of exclusive content. From developing new collections to fill our universe, to metaverse avatars, we have bundles of awesome features in the pipeline.';

  @override
  String get guardiansStored =>
      'Guardians are stored as ERC721 tokens on the Ethereum blockchain. Owners can download their Guardians in .png format, they can also request a high resolution image of them, with 3D models coming soon for everyone.';

  @override
  String get propertiesDescription =>
      'Guardians of the Metaverse are a collection of 10,000 unique 3D hero-like avatars living as NFTs on the blockchain.';

  @override
  String get aboutCryptoPills => 'About Crypto-Pills';

  @override
  String get categories => 'Categories';

  @override
  String get spotlightProjects => 'Spotlight Projects';

  @override
  String get onSaleIn => 'On Sale In';

  @override
  String get allItems => 'All Items';

  @override
  String get trendingSellers => 'Trending Sellers';

  @override
  String get lightning => 'Lightning';

  @override
  String get onchain => 'Onchain';

  @override
  String get failedToLoadCertainData =>
      'Failed to load certain data in this page, please try again later';

  @override
  String get timeFrame => 'TimeFrame';

  @override
  String get failedToLoadOnchain => 'Failed to load Onchain Transactions';

  @override
  String get failedToLoadPayments => 'Failed to load Lightning Payments';

  @override
  String get failedToLoadLightning => 'Failed to load Lightning Invoices';

  @override
  String get failedToLoadOperations => 'Failed to load Loop Operations';

  @override
  String get clear => 'Clear';

  @override
  String get apply => 'Apply';

  @override
  String get sent => 'Sent';

  @override
  String get foundedIn2023 =>
      'Founded in 2023, BitNet was born out of the belief that Bitcoin is not just a digital asset for the tech-savvy and financial experts,\n but a revolutionary tool that has the potential to build the foundations of cyberspace empowering individuals worldwide.\n We recognized the complexity and the mystique surrounding Bitcoin and cryptocurrencies,\n and we decided it was time to demystify it and make it accessible to everyone.\n We are a pioneering platform dedicated to bringing Bitcoin closer to everyday people like you.';

  @override
  String get history => 'History';

  @override
  String get received => 'Received';

  @override
  String get pleaseGiveAccess =>
      'Please give the app photo access to use this feature.';

  @override
  String get noCodeFoundOverlayError => 'No code was found.';

  @override
  String get badCharacters => 'Bad characters';

  @override
  String get filterOptions => 'Filter Options';

  @override
  String get bitcoinInfoCard => 'Bitcoin Card Information';

  @override
  String get lightningCardInfo => 'Lightning Card Information';

  @override
  String get totalReceived => 'Total Received';

  @override
  String get totalSent => 'Total Sent';

  @override
  String get qrCode => 'QR Code';

  @override
  String get keyMetrics => 'Key metrics';

  @override
  String get intrinsicValue => 'Intrinsic Value:';

  @override
  String get hashrate => 'Hashrate';

  @override
  String get bear => 'Bear';

  @override
  String get coinBase => 'Coinbase (Newly Generated Coins)\n';

  @override
  String get transactions => 'Transactions';

  @override
  String get seeMore => 'See more';

  @override
  String get blockTransaction => 'Block Transactions';

  @override
  String get qrCodeFormatInvalid =>
      'The scanned QR code does not have an approved format';

  @override
  String get selectImageQrCode => 'Select Image for QR Scan';

  @override
  String get coudntChangeUsername => 'Couldn\'t change username';

  @override
  String get recoverAccount => 'Recovery account';

  @override
  String get contactFriendsForRecovery =>
      'Contact your friends and tell them to free-up your key! The free-ups will only be valid for 24 hours. After their keys are freed up the login sign will appear green and you\'ll have to wait additional 24hours before you can login to your recovered account.';

  @override
  String get friendsKeyIssuers => 'Friends / Key-Issuers';

  @override
  String get socialRecoveryInfo => 'Social Recovery Info';

  @override
  String get stepOneSocialRecovery => 'Step 1: Activate social recovery';

  @override
  String get socialRecoveryTrustSettings =>
      'Social recovery needs to activated in Settings by each user manually. You have to choose 3 friends whom you can meet in person and trust.';

  @override
  String get recoveryStep2 => 'Step 2. Contact each of your friends';

  @override
  String get askFriendsForRecovery =>
      'Ask your friends to open the app and navigate to Profile > Settings > Security > Social Recovery for friends.';

  @override
  String get recoveryStepThree => 'Step 3: Wait 24 hours and then login';

  @override
  String get recoverySecurityIncrease =>
      'To increase security, the recovered user will get contacted, if there is no awnser after 24 hours your account will be freed.';

  @override
  String get connectWithOtherDevices => 'Connect with other device';

  @override
  String get scanQrStepOne => 'Step 1: Open the app on a different device.';

  @override
  String get launchBitnetApp =>
      'Launch the bitnet app on an alternative device where your account is already active and logged in.';

  @override
  String get scanQrStepTwo => 'Step 2: Open the QR-Code';

  @override
  String get navQrRecovery =>
      'Navigate to Profile > Settings > Security > Scan QR-Code for Recovery. You will need to verify your identity now.';

  @override
  String get scanQrStepThree => 'Step 3: Scan the QR-Code with this device';

  @override
  String get pressBtnScanQr =>
      'Press the Button below and scan the QR Code. Wait until the process is finished don\'t leave the app.';

  @override
  String get none => 'ללא';

  @override
  String get noPasswordRecoveryDescription =>
      'עדיין לא הוספת דרך לשחזר את הסיסמה שלך.';

  @override
  String get noPermission => 'אין הרשאה';

  @override
  String get noRoomsFound => 'לא נמצאו חדרים…';

  @override
  String get notifications => 'התראות';

  @override
  String get notificationsEnabledForThisAccount =>
      'התראות הופעלו עבור חשבון זה';

  @override
  String numUsersTyping(Object count) {
    return '$count משתמשים מקלידים…';
  }

  @override
  String get obtainingLocation => 'משיג מיקום…';

  @override
  String get offensive => 'פוגעני';

  @override
  String get offline => 'לא מקוון';

  @override
  String get ok => 'Ok';

  @override
  String get online => 'מחובר/ת';

  @override
  String get onlineKeyBackupEnabled => 'גיבוי מפתח מקוון מופעל';

  @override
  String get oopsPushError => 'אופס! למרבה הצער, אירעה שגיאה בעת הגדרת התראות.';

  @override
  String get oopsSomethingWentWrong => 'אופס, משהו השתבש…';

  @override
  String get openAppToReadMessages => 'פתח את האפליקציה לקריאת הודעות';

  @override
  String get openCamera => 'פתח מצלמה';

  @override
  String get openVideoCamera => 'פתח את המצלמה לסרטון';

  @override
  String get oneClientLoggedOut => 'אחד מהמכשירים שלך התנתק';

  @override
  String get addAccount => 'הוסף חשבון';

  @override
  String get editBundlesForAccount => 'ערוך חבילות עבור חשבון זה';

  @override
  String get addToBundle => 'הוסף לחבילה';

  @override
  String get removeFromBundle => 'הסר מחבילה זו';

  @override
  String get bundleName => 'שם החבילה';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts => '(בטא) אפשר ריבוי חשבונות במכשיר זה';

  @override
  String get openInMaps => 'פתיחה במפות';

  @override
  String get link => 'קישור';

  @override
  String get serverRequiresEmail =>
      'שרת זה צריך לאמת את כתובת הדואר האלקטרוני שלך לרישום.';

  @override
  String get optionalGroupName => '(אופציונלי) שם קבוצה';

  @override
  String get or => 'או';

  @override
  String get participant => 'משתתף';

  @override
  String get passphraseOrKey => 'ביטוי סיסמה או מפתח שחזור';

  @override
  String get password => 'סיסמה';

  @override
  String get passwordForgotten => 'שכחתי סיסמה';

  @override
  String get passwordHasBeenChanged => 'הסיסמה שונתה';

  @override
  String get passwordRecovery => 'שחזור סיסמה';

  @override
  String get pickImage => 'בחר תמונה';

  @override
  String get pin => 'קוד pin';

  @override
  String play(Object fileName) {
    return 'הפעל $fileName';
  }

  @override
  String get pleaseChoose => 'אנא בחר';

  @override
  String get pleaseChooseAPasscode => 'אנא בחר קוד גישה';

  @override
  String get pleaseChooseAUsername => 'אנא בחר שם משתמש';

  @override
  String get pleaseClickOnLink => 'אנא לחץ על הקישור במייל ולאחר מכן המשך.';

  @override
  String get pleaseEnter4Digits =>
      'אנא הזן 4 ספרות או השאר ריק כדי להשבית את נעילת האפליקציה.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'אנא הזן Matrix ID.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => 'נא הזן את הסיסמה שלך';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'אנא הזן את קוד הpin שלך';

  @override
  String get pleaseEnterYourUsername => 'אנא הזן שם משתמש';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Please follow the instructions on the website and tap on next.';

  @override
  String get privacy => 'Privacy';

  @override
  String get publicRooms => 'Public Rooms';

  @override
  String get pushRules => 'Push rules';

  @override
  String get reason => 'Reason';

  @override
  String get recording => 'Recording';

  @override
  String redactedAnEvent(Object username) {
    return '$username redacted an event';
  }

  @override
  String get redactMessage => 'Redact message';

  @override
  String get reject => 'Reject';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username rejected the invitation';
  }

  @override
  String get rejoin => 'Rejoin';

  @override
  String get remove => 'Remove';

  @override
  String get removeAllOtherDevices => 'Remove all other devices';

  @override
  String removedBy(Object username) {
    return 'Removed by $username';
  }

  @override
  String get removeDevice => 'Remove device';

  @override
  String get unbanFromChat => 'Unban from chat';

  @override
  String get removeYourAvatar => 'Remove your avatar';

  @override
  String get renderRichContent => 'Render rich message content';

  @override
  String get replaceRoomWithNewerVersion => 'Replace room with newer version';

  @override
  String get reply => 'Reply';

  @override
  String get reportMessage => 'Report message';

  @override
  String get requestPermission => 'Request permission';

  @override
  String get roomHasBeenUpgraded => 'Room has been upgraded';

  @override
  String get roomVersion => 'Room version';

  @override
  String get saveFile => 'Save file';

  @override
  String get search => 'Search';

  @override
  String get security => 'Security';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return 'Seen by $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Seen by $username and $count others';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Seen by $username and $username2';
  }

  @override
  String get send => 'Send';

  @override
  String get sendAMessage => 'Send a message';

  @override
  String get sendAsText => 'Send as text';

  @override
  String get sendAudio => 'Send audio';

  @override
  String get sendFile => 'Send file';

  @override
  String get sendImage => 'Send image';

  @override
  String get sendMessages => 'Send messages';

  @override
  String get sendOriginal => 'Send original';

  @override
  String get sendSticker => 'Send sticker';

  @override
  String get sendVideo => 'Send video';

  @override
  String sentAFile(Object username) {
    return '📁 $username sent a file';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username sent an audio';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username sent a picture';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username sent a sticker';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username sent a video';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName sent call information';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'Set as main alias';

  @override
  String get setCustomEmotes => 'Set custom emotes';

  @override
  String get setGroupDescription => 'Set group description';

  @override
  String get setInvitationLink => 'Set invitation link';

  @override
  String get setPermissionsLevel => 'Set permissions level';

  @override
  String get setStatus => 'Set status';

  @override
  String get settings => 'Settings';

  @override
  String get share => 'Share';

  @override
  String sharedTheLocation(Object username) {
    return '$username shared their location';
  }

  @override
  String get shareLocation => 'Share location';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => 'Show password';

  @override
  String get signUp => 'Sign up';

  @override
  String get singlesignon => 'Single Sign on';

  @override
  String get skip => 'Skip';

  @override
  String get sourceCode => 'Source code';

  @override
  String get spaceIsPublic => 'Space is public';

  @override
  String get spaceName => 'Space name';

  @override
  String startedACall(Object senderName) {
    return '$senderName started a call';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Status';

  @override
  String get statusExampleMessage => 'How are you today?';

  @override
  String get submit => 'Submit';

  @override
  String get synchronizingPleaseWait => 'Synchronizing… Please wait.';

  @override
  String get systemTheme => 'System Theme';

  @override
  String get theyDontMatch => 'They Don\'t Match';

  @override
  String get theyMatch => 'They Match';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Toggle Favorite';

  @override
  String get toggleMuted => 'Toggle Muted';

  @override
  String get toggleUnread => 'Mark Read/Unread';

  @override
  String get tooManyRequestsWarning =>
      'Too many requests. Please try again later!';

  @override
  String get transferFromAnotherDevice => 'Transfer from another device';

  @override
  String get tryToSendAgain => 'Try to send again';

  @override
  String get unavailable => 'Unavailable';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username unbanned $targetName';
  }

  @override
  String get unblockDevice => 'Unblock Device';

  @override
  String get unknownDevice => 'Unknown device';

  @override
  String get unknownEncryptionAlgorithm => 'Unknown encryption algorithm';

  @override
  String get unmuteChat => 'Unmute chat';

  @override
  String get unpin => 'Unpin';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount unread chats',
      one: '1 unread chat',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username and $count others are typing…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username and $username2 are typing…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username is typing…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username left the chat';
  }

  @override
  String get username => 'Username';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username sent a $type event';
  }

  @override
  String get unverified => 'Unverified';

  @override
  String get verified => 'Verified';

  @override
  String get verify => 'Verify';

  @override
  String get verifyStart => 'Start Verification';

  @override
  String get verifySuccess => 'You successfully verified!';

  @override
  String get verifyTitle => 'Verifying other account';

  @override
  String get videoCall => 'Video call';

  @override
  String get visibilityOfTheChatHistory => 'Visibility of the chat history';

  @override
  String get visibleForAllParticipants => 'Visible for all participants';

  @override
  String get visibleForEveryone => 'Visible for everyone';

  @override
  String get voiceMessage => 'Voice message';

  @override
  String get waitingPartnerAcceptRequest =>
      'Waiting for partner to accept the request…';

  @override
  String get waitingPartnerEmoji => 'Waiting for partner to accept the emoji…';

  @override
  String get waitingPartnerNumbers =>
      'Waiting for partner to accept the numbers…';

  @override
  String get wallpaper => 'Wallpaper';

  @override
  String get warning => 'Warning!';

  @override
  String get weSentYouAnEmail => 'We sent you an email';

  @override
  String get whoCanPerformWhichAction => 'Who can perform which action';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Who is allowed to join this group';

  @override
  String get whyDoYouWantToReportThis => 'Why do you want to report this?';

  @override
  String get wipeChatBackup =>
      'Wipe your chat backup to create a new recovery key?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'With these addresses you can recover your password.';

  @override
  String get writeAMessage => 'Write a message…';

  @override
  String get yes => 'Yes';

  @override
  String get you => 'You';

  @override
  String get youAreInvitedToThisChat => 'You are invited to this chat';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'You are no longer participating in this chat';

  @override
  String get youCannotInviteYourself => 'You cannot invite yourself';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'You have been banned from this chat';

  @override
  String get yourPublicKey => 'Your public key';

  @override
  String get messageInfo => 'Message info';

  @override
  String get time => 'Time';

  @override
  String get messageType => 'Message Type';

  @override
  String get sender => 'Sender';

  @override
  String get openGallery => 'Open gallery';

  @override
  String get removeFromSpace => 'Remove from space';

  @override
  String get addToSpaceDescription => 'Select a space to add this chat to it.';

  @override
  String get start => 'Start';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'To unlock your old messages, please enter your recovery key that has been generated in a previous session. Your recovery key is NOT your password.';

  @override
  String get addToStory => 'Add to story';

  @override
  String get publish => 'Publish';

  @override
  String get whoCanSeeMyStories => 'Who can see my stories?';

  @override
  String get unsubscribeStories => 'Unsubscribe stories';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'This user has not posted anything in their story yet';

  @override
  String get yourStory => 'Your story';

  @override
  String get replyHasBeenSent => 'Reply has been sent';

  @override
  String videoWithSize(Object size) {
    return 'Video ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Story from $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Please note that people can see and contact each other in your story.';

  @override
  String get whatIsGoingOn => 'What is going on?';

  @override
  String get addDescription => 'Add description';

  @override
  String get storyPrivacyWarning =>
      'Please note that people can see and contact each other in your story. Your stories will be visible for 24 hours but there is no guarantee that they will be deleted from all devices and servers.';

  @override
  String get iUnderstand => 'I understand';

  @override
  String get openChat => 'Open Chat';

  @override
  String get markAsRead => 'Mark as read';

  @override
  String get reportUser => 'Report user';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get matrixWidgets => 'Matrix Widgets';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender reacted with $reaction';
  }

  @override
  String get pinMessage => 'Pin to room';

  @override
  String get confirmEventUnpin =>
      'Are you sure to permanently unpin the event?';

  @override
  String get emojis => 'Emojis';

  @override
  String get placeCall => 'Place call';

  @override
  String get voiceCall => 'Voice call';

  @override
  String get unsupportedAndroidVersion => 'Unsupported Android version';

  @override
  String get unsupportedAndroidVersionLong =>
      'This feature requires a newer Android version. Please check for updates or Lineage OS support.';

  @override
  String get videoCallsBetaWarning =>
      'Please note that video calls are currently in beta. They might not work as expected or work at all on all platforms.';

  @override
  String get experimentalVideoCalls => 'Experimental video calls';

  @override
  String get emailOrUsername => 'Email or username';

  @override
  String get indexedDbErrorTitle => 'Private mode issues';

  @override
  String get indexedDbErrorLong =>
      'The message storage is unfortunately not enabled in private mode by default.\nPlease visit\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\nOtherwise, it is not possible to run FluffyChat.';

  @override
  String switchToAccount(Object number) {
    return 'Switch to account $number';
  }

  @override
  String get nextAccount => 'Next account';

  @override
  String get previousAccount => 'Previous account';

  @override
  String get editWidgets => 'Edit widgets';

  @override
  String get addWidget => 'Add widget';

  @override
  String get widgetVideo => 'Video';

  @override
  String get widgetEtherpad => 'Text note';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Custom';

  @override
  String get widgetName => 'Name';

  @override
  String get value => 'Value';

  @override
  String get currentBatches => 'Current Batches';

  @override
  String get createPost => 'Create Post';

  @override
  String get post => 'POST';

  @override
  String get nextBlock => 'Next Block';

  @override
  String get mempoolBlock => 'Mempool block';

  @override
  String get block => 'Block';

  @override
  String get minedAt => 'Mined at';

  @override
  String get miner => 'Miner';

  @override
  String get minerRewardAndFees => 'Miner Reward (Subsidy + fees)';

  @override
  String get blockChain => 'Blockchain';

  @override
  String get cancelDelete => 'Cancel and delete';

  @override
  String get uploadToBlockchain => 'Upload to Blockchain';

  @override
  String get bitnetUsageFee => 'BitNet usage fee';

  @override
  String get transactionFees => 'Transaction fees';

  @override
  String get costEstimation => 'Cost Estimation';

  @override
  String get addMore => 'Add more';

  @override
  String get errorFinalizingBatch => 'Error finalizing batch';

  @override
  String get fianlizePosts => 'Finalize Posts';

  @override
  String get assetMintError =>
      'Failed to mint asset: You might already have an asset with a similar name in your list.';

  @override
  String get addContent => 'Add Content';

  @override
  String get typeMessage => 'Type message';

  @override
  String get postContentError => 'Please add some content to your post';

  @override
  String get nameYourAsset => 'Name your Asset';

  @override
  String get widgetUrlError => 'This is not a valid URL.';

  @override
  String get widgetNameError => 'Please provide a display name.';

  @override
  String get errorAddingWidget => 'Error adding the widget.';

  @override
  String get youRejectedTheInvitation => 'You rejected the invitation';

  @override
  String get youJoinedTheChat => 'You joined the chat';

  @override
  String get youAcceptedTheInvitation => '👍 You accepted the invitation';

  @override
  String youBannedUser(Object user) {
    return 'You banned $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'You have withdrawn the invitation for $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 You have been invited by $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 You invited $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 You kicked $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 You kicked and banned $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'You unbanned $user';
  }

  @override
  String get noEmailWarning =>
      'Please enter a valid email address. Otherwise you won\'t be able to reset your password. If you don\'t want to, tap again on the button to continue.';

  @override
  String get stories => 'Stories';

  @override
  String get users => 'Users';

  @override
  String get unlockOldMessages => 'Unlock old messages';

  @override
  String get storeInSecureStorageDescription =>
      'Store the recovery key in the secure storage of this device.';

  @override
  String get saveKeyManuallyDescription =>
      'Save this key manually by triggering the system share dialog or clipboard.';

  @override
  String get storeInAndroidKeystore => 'Store in Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Store in Apple KeyChain';

  @override
  String get storeSecurlyOnThisDevice => 'Store securely on this device';

  @override
  String countFiles(Object count) {
    return '$count files';
  }

  @override
  String get user => 'User';

  @override
  String get custom => 'Custom';

  @override
  String get foregroundServiceRunning =>
      'This notification appears when the foreground service is running.';

  @override
  String get screenSharingTitle => 'screen sharing';

  @override
  String get screenSharingDetail => 'You are sharing your screen in FuffyChat';

  @override
  String get callingPermissions => 'Calling permissions';

  @override
  String get callingAccount => 'Calling account';

  @override
  String get callingAccountDetails =>
      'Allows FluffyChat to use the native android dialer app.';

  @override
  String get appearOnTop => 'Appear on top';

  @override
  String get appearOnTopDetails =>
      'Allows the app to appear on top (not needed if you already have Fluffychat setup as a calling account)';

  @override
  String get otherCallingPermissions =>
      'Microphone, camera and other FluffyChat permissions';

  @override
  String get whyIsThisMessageEncrypted => 'Why is this message unreadable?';

  @override
  String get noKeyForThisMessage =>
      'This can happen if the message was sent before you have signed in to your account at this device.\n\nIt is also possible that the sender has blocked your device or something went wrong with the internet connection.\n\nAre you able to read the message on another session? Then you can transfer the message from it! Go to Settings > Devices and make sure that your devices have verified each other. When you open the room the next time and both sessions are in the foreground, the keys will be transmitted automatically.\n\nDo you not want to lose the keys when logging out or switching devices? Make sure that you have enabled the chat backup in the settings.';

  @override
  String get newGroup => 'New group';

  @override
  String get newSpace => 'New space';

  @override
  String get enterSpace => 'Enter space';

  @override
  String get enterRoom => 'Enter room';

  @override
  String get allSpaces => 'All spaces';

  @override
  String numChats(Object number) {
    return '$number chats';
  }

  @override
  String get hideUnimportantStateEvents => 'Hide unimportant state events';

  @override
  String get doNotShowAgain => 'Do not show again';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Empty chat (was $oldDisplayName)';
  }

  @override
  String get language => 'English';

  @override
  String get searchC => 'Search Currency Here';

  @override
  String get searchL => 'Search Language Here';

  @override
  String get cc => 'Currency Converter';

  @override
  String get convert => 'Convert';

  @override
  String get enterA => 'Enter Amount';

  @override
  String get from => 'From';

  @override
  String get amount => 'Amount';

  @override
  String get bitcoinChart => 'Bitcoin chart';

  @override
  String get to => 'To';

  @override
  String get recentTransactions => 'Recent transactions';

  @override
  String get fee => 'Fee';

  @override
  String get analysis => 'Analysis';

  @override
  String get addAMessage => 'Add a message...';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get accelerate => 'Accelerate';

  @override
  String get generateInvoice => 'Generate Invoice';

  @override
  String get features => 'Features';

  @override
  String get sendNow => 'SEND NOW!';

  @override
  String get youAreOverLimit => 'You are over the sending limit.';

  @override
  String get youAreUnderLimit => 'You are under the sending baseline';

  @override
  String get walletAddressCopied => 'Wallet address copied to clipboard';

  @override
  String get invoice => 'Invoice';

  @override
  String get receiveBitcoin => 'Receive Bitcoin';

  @override
  String get changeAmount => 'Change Amount';

  @override
  String get optimal => 'Optimal';

  @override
  String get overpaid => 'Overpaid';

  @override
  String get searchReceipient => 'Search for recipients';

  @override
  String get chooseReceipient => 'Choose Receipient';

  @override
  String get feeRate => 'Fee rate';

  @override
  String get afterTx => 'After ';

  @override
  String get highestAssesment => 'Highest assesment:';

  @override
  String get lowestAssesment => 'Lowest assesment:';

  @override
  String get inSeveralHours => 'In Several hours (or more)';

  @override
  String get minutesTx => ' minutes';

  @override
  String get analysisStockCovered =>
      'The stock is covered by 67 analysts. The average assesment is:';

  @override
  String get low => 'Low';

  @override
  String get unknown => 'Unknown';

  @override
  String get timestamp => 'Timestamp';

  @override
  String get typeTx => 'Type';

  @override
  String get address => 'Address';

  @override
  String get rbf => 'RBF';

  @override
  String get mined => 'Mined ';

  @override
  String get fullRbf => 'Full RBF';

  @override
  String get newFee => 'New Fee';

  @override
  String get previousFee => 'Previous fee';

  @override
  String get recentReplacements => 'Recent replacements';

  @override
  String get median => 'Median: ';

  @override
  String get feeDistribution => 'Fee Distribution';

  @override
  String get blockSize => 'Block Size';

  @override
  String get health => 'Health';

  @override
  String get difficultyAdjustment => 'Difficulty Adjustment';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get his => 'History';

  @override
  String get qou => 'Currency Rates by Open Exchange Rates';

  @override
  String get newSpaceDescription =>
      'Spaces allows you to consolidate your chats and build private or public communities.';

  @override
  String get encryptThisChat => 'Encrypt this chat';

  @override
  String get endToEndEncryption => 'End to end encryption';

  @override
  String get disableEncryptionWarning =>
      'For security reasons you can not disable encryption in a chat, where it has been enabled before.';

  @override
  String get sorryThatsNotPossible => 'Sorry... that is not possible';

  @override
  String get deviceKeys => 'Device keys:';

  @override
  String get letsStart => 'Let\'s start';

  @override
  String get enterInviteLinkOrMatrixId => 'Enter invite link or Matrix ID...';

  @override
  String get reopenChat => 'Reopen chat';

  @override
  String get noBackupWarning =>
      'Warning! Without enabling chat backup, you will lose access to your encrypted messages. It is highly recommended to enable the chat backup first before logging out.';

  @override
  String get noOtherDevicesFound => 'No other devices found';

  @override
  String get fileIsTooBigForServer =>
      'The server reports that the file is too large to be sent.';

  @override
  String fileHasBeenSavedAt(Object path) {
    return 'File has been saved at $path';
  }

  @override
  String get jumpToLastReadMessage => 'Jump to last read message';

  @override
  String get readUpToHere => 'Read up to here';

  @override
  String get jump => 'Jump';

  @override
  String get openLinkInBrowser => 'Open link in browser';

  @override
  String get reportErrorDescription =>
      'Oh no. Something went wrong. Please try again later. If you want, you can report the bug to the developers.';

  @override
  String get report => 'report';

  @override
  String get totalWalletBal => 'Total Wallet Balance';

  @override
  String get actions => 'Actions';

  @override
  String get buy => 'Buy';

  @override
  String get sell => 'Sell';

  @override
  String get balance => 'Balance';

  @override
  String get receive => 'Receive';

  @override
  String get rebalance => 'Rebalance';

  @override
  String get buySell => 'Buy & Sell';

  @override
  String get activity => 'Activity';

  @override
  String get add => 'Add';

  @override
  String get whitePaper => 'Whitepaper';

  @override
  String get fundUs => 'Fund us';

  @override
  String get ourTeam => 'Our Team';

  @override
  String get weAreLight => 'We are the light that helps others see Bitcoin.';

  @override
  String get aboutUs => 'About us';

  @override
  String get reportWeb => 'Report';

  @override
  String get beAPart => 'Be a Part of the Revolution - Download Our App Today!';

  @override
  String get moreAndMore =>
      'More and more decide to join our community each day! Let\'s build something extraordinary together.';

  @override
  String get pleaseLetUsKnow => 'Please let us know what went wrong...';

  @override
  String get reportError => 'Report error';

  @override
  String get pleaseProvideErrorMsg => 'Please provide an error message first.';

  @override
  String get yourErrorReportForwarded =>
      'Your error report has been forwarded.';

  @override
  String get imLiterallyOnlyPerson =>
      'I\'m literally the only person who has submitted an idea so far.';

  @override
  String get imLiterallyOnlyPerson2 =>
      'I\'m literally the only submitted an idea so far.';

  @override
  String get imLiterallyOnlyPerson3 =>
      'y the only person who has submitted an idea so far.';

  @override
  String get submitIdea => 'Submit Idea';

  @override
  String get ideaLeaderboard => 'Idea Leaderboard';

  @override
  String get shapeTheFuture =>
      'Shape the Future with us! We Want to Hear Your Brilliant Ideas!';

  @override
  String get submitReport => 'Submit report!';

  @override
  String get yourIssuesGoesHere => 'Your issue goes here';

  @override
  String get yourIdeasGoesHere => 'Your idea goes here';

  @override
  String get contactInfoHint => 'Contact information (Email, username, did...)';

  @override
  String get contactInfo => 'Contact information';

  @override
  String get reportIssue => 'Report Issue';

  @override
  String get email => 'Email:';

  @override
  String get phone => 'Phone:';

  @override
  String get disclaimer => 'Disclaimer:';

  @override
  String get referencesLinks =>
      'References and links: In the case of direct or indirect references \nto external websites that are outside the provider\'s area of responsibility, \na liability obligation would only come into effect in the event that the provider \nhas knowledge of the content and it is technically possible and reasonable to prevent \nthe use in the case of illegal content. The provider hereby expressly declares \nthat at the time the links were set, no illegal content was recognizable on the linked pages. \nThe provider has no influence on the current and future design, content, or authorship of \nthe linked/connected pages. Therefore, the provider hereby expressly distances himself from all contents \nof all linked/connected pages.';

  @override
  String get availabilityProvider =>
      'Availability: The provider expressly reserves the right to \nchange, supplement, delete parts of the pages or the entire offer without \nspecial notice, or to temporarily or permanently cease publication.';

  @override
  String get contentOnlineOffer =>
      'Content of the online offer: The provider assumes no responsibility for the timeliness, \ncorrectness, completeness, or quality of the provided \ninformation. Liability claims against the provider relating to \nmaterial or immaterial damage caused by the use or \nnon-use of the provided information or by the use of \nincorrect and incomplete information are \ngenerally excluded, provided that there is no demonstrable \nintentional or grossly negligent fault on the part of the provider.';

  @override
  String get responsibleForContent => 'Responsible for the content:';

  @override
  String get contact => 'Contact:';

  @override
  String get contacts => 'Contact';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get friedrichshafen => '88405 Friedrichshafen';

  @override
  String get imprint => 'Imprint';

  @override
  String get vision => 'Vision';

  @override
  String get product => 'Product';

  @override
  String get getStarted => 'Get Started';

  @override
  String get weBelieve =>
      'We believe in empowering our people and building true loyalty!';

  @override
  String get butBitcoin =>
      'But Bitcoin is more than just a digital asset; it\'s a movement. A movement towards a more open, accessible, and equitable future. \nBitNet wants be at the forefront of the digital age as a pioneer in asset digitization using Bitcoin,\n shaping a metaverse where equality, security, and sustainability\n are not just ideals, but realities. Our vision is to create an\n interconnected digital world where every user can seamlessly and\n fairly access, exchange, and grow their digital assets.';

  @override
  String get fallenBrunnen => 'Fallenbrunnen 12';

  @override
  String get bitnerGMBH => 'BitNet GmbH';

  @override
  String get functionality => 'Functionality:';

  @override
  String get termsAndConditionsDescription =>
      'These terms and conditions govern the use of the Bitcoin Wallet App\n(hereinafter referred to as BitNet), which is provided by BitNet GmbH.\nBy using the app, you agree to these terms and conditions.';

  @override
  String get scope => 'Scope:';

  @override
  String get provider => 'Provider:';

  @override
  String get fees => 'Fees:';

  @override
  String get changes => 'Changes:';

  @override
  String get termsAndConditionsEntire =>
      'These terms and conditions constitute the entire agreement between the user and BitNet.\nShould any provision be ineffective, the remaining provisions shall remain in force.';

  @override
  String get finalProvisions => 'Final Provisions:';

  @override
  String get walletReserves =>
      'BitNet reserves the right to change these terms and conditions at any time.\nThe user will be informed of such changes and must agree to them in order to continue using the app.';

  @override
  String get walletLiable =>
      'BitNet is only liable for damages caused by intentional or grossly negligent actions by\nBitNet. The company is not liable for damages resulting from the use of the app or the loss of Bitcoins.';

  @override
  String get limitationOfLiability => 'Limitation of Liability:';

  @override
  String get certainFeaturesOfApp =>
      'Certain features of the app may incur fees.\nThese fees will be communicated to the user in advance and\nare visible in the app.';

  @override
  String get userSolelyResponsible =>
      'The user is solely responsible for the security of their Bitcoins. The app offers security features such as password protection and two-factor authentication,\nbut it is the user\'s responsibility to use these features carefully.\nBitNet is not liable for losses due to negligence, loss of devices, or user access data.';

  @override
  String get userResponsibility => 'User Responsibility:';

  @override
  String get appAllowsUsers =>
      'The app allows users to receive, send, and manage Bitcoins.\nThe app is not a bank and does not offer banking services.';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get loopScreen => 'Loop Screen';

  @override
  String get onChainLightning => 'Onchain to Lightning';

  @override
  String get lightningTransactionSettled => 'Lightning invoice settled';

  @override
  String get onChainInvoiceSettled => 'Onchain transaction settled';

  @override
  String get lightningOnChain => 'Lightning to Onchain';

  @override
  String get shareQrCode => 'Share Profile QR Code';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get changeCurrency => 'Change Currency';

  @override
  String get plainKeyDID => 'Plain Key and DID';

  @override
  String get recoverQrCode => 'Recover with QR Code';

  @override
  String get recoveryPhrases => 'Recovery phrases';

  @override
  String get socialRecovery => 'Social recovery';

  @override
  String get humanIdentity => 'Human Identity';

  @override
  String get extendedSec => 'Extended Sec';

  @override
  String get verifyYourIdentity => 'Verify your identity';

  @override
  String get diDprivateKey => 'DID and private key';

  @override
  String get wordRecovery => 'Word recovery';

  @override
  String get color => 'Color';

  @override
  String get addAttributes => 'Add attributes';

  @override
  String get overlayErrorOccured => 'An error occured, please try again later.';

  @override
  String get restoreOptions => 'Restore options';

  @override
  String get useDidPrivateKey => 'Use DID and Private Key';

  @override
  String get locallySavedAccounts => 'Locally saved accounts';

  @override
  String get confirmMnemonic => 'Confirm your mnemonic';

  @override
  String get ownSecurity => 'Own Security';

  @override
  String get agbsImpress => 'Agbs and Impressum';
}
