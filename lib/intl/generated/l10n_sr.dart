// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class L10nSr extends L10n {
  L10nSr([String locale = 'sr']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Регистрација';

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
  String get passwordsDoNotMatch => 'Passwords do not match!';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email address.';

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
  String get people => 'Људи';

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
  String get groups => 'Групе';

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
  String get repeatPassword => 'Repeat password';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Please choose at least $min characters.';
  }

  @override
  String get about => 'О програму';

  @override
  String get updateAvailable => 'FluffyChat update available';

  @override
  String get updateNow => 'Start update in background';

  @override
  String get accept => 'Прихвати';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username прихвата позивницу';
  }

  @override
  String get account => 'Налог';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username укључи шифровање с краја на крај';
  }

  @override
  String get addEmail => 'Додај е-адресу';

  @override
  String get confirmMatrixId =>
      'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'Додај опис групе';

  @override
  String get addToSpace => 'Add to space';

  @override
  String get admin => 'Админ';

  @override
  String get alias => 'алијас';

  @override
  String get all => 'Сви';

  @override
  String get allChats => 'All chats';

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
    return '$senderName одговори на позив';
  }

  @override
  String get anyoneCanJoin => 'свако може да се придружи';

  @override
  String get appLock => 'Закључавање апликације';

  @override
  String get archive => 'Архива';

  @override
  String get areGuestsAllowedToJoin => 'Да ли је гостима дозвољен приступ';

  @override
  String get areYouSure => 'Сигурни сте?';

  @override
  String get areYouSureYouWantToLogout => 'Заиста желите да се одјавите?';

  @override
  String get askSSSSSign =>
      'Да бисте могли да пријавите другу особу, унесите своју безбедносну фразу или кључ опоравка.';

  @override
  String askVerificationRequest(Object username) {
    return 'Прихватате ли захтев за верификацију од корисника $username?';
  }

  @override
  String get autoplayImages =>
      'Automatically play animated stickers and emotes';

  @override
  String get sendOnEnter => 'Send on enter';

  @override
  String get banFromChat => 'Забрани у ћаскању';

  @override
  String get banned => 'Забрањен';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username забрани корисника $targetName';
  }

  @override
  String get blockDevice => 'Блокирај уређај';

  @override
  String get blocked => 'Блокиран';

  @override
  String get botMessages => 'Поруке Бота';

  @override
  String get bubbleSize => 'Bubble size';

  @override
  String get cancel => 'Откажи';

  @override
  String cantOpenUri(Object uri) {
    return 'Can\'t open the URI $uri';
  }

  @override
  String get changeDeviceName => 'Промени назив уређаја';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username промени аватар ћаскања';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username промени опис ћаскања у: „$description“';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username промени назив ћаскања у: „$chatname“';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username измени дозволе ћаскања';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username промени приказно име на: „$displayname“';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username измени правила за приступ гостију';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username измени правила за приступ гостију на: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username измени видљивост историје';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username измени видљивост историје на: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username измени правила приступања';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username измени правила приступања на: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username измени свој аватар';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username измени алијас собе';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username измени везу позивнице';
  }

  @override
  String get changePassword => 'Измени лозинку';

  @override
  String get changeTheHomeserver => 'Промени домаћи сервер';

  @override
  String get changeTheme => 'Измените изглед';

  @override
  String get changeTheNameOfTheGroup => 'Измени назив групе';

  @override
  String get changeWallpaper => 'Измени тапет';

  @override
  String get changeYourAvatar => 'Измените свој аватар';

  @override
  String get channelCorruptedDecryptError => 'Шифровање је покварено';

  @override
  String get chat => 'Ћаскање';

  @override
  String get yourChatBackupHasBeenSetUp => 'Your chat backup has been set up.';

  @override
  String get chatBackup => 'Копија ћаскања';

  @override
  String get chatBackupDescription =>
      'Ваша резервна копија ћаскања је обезбеђена кључем. Немојте да га изгубите.';

  @override
  String get chatDetails => 'Детаљи ћаскања';

  @override
  String get chatHasBeenAddedToThisSpace => 'Chat has been added to this space';

  @override
  String get chats => 'Ћаскања';

  @override
  String get chooseAStrongPassword => 'Изаберите јаку лозинку';

  @override
  String get chooseAUsername => 'Изаберите корисничко име';

  @override
  String get clearArchive => 'Очисти архиву';

  @override
  String get close => 'Затвори';

  @override
  String get commandHint_markasdm => 'Mark as direct message room';

  @override
  String get commandHint_markasgroup => 'Mark as group';

  @override
  String get commandHint_ban => 'Блокирај задатог корисника за ову собу';

  @override
  String get commandHint_clearcache => 'Clear cache';

  @override
  String get commandHint_create =>
      'Create an empty group chat\nUse --no-encryption to disable encryption';

  @override
  String get commandHint_discardsession => 'Discard session';

  @override
  String get commandHint_dm =>
      'Start a direct chat\nUse --no-encryption to disable encryption';

  @override
  String get commandHint_html => 'Шаљи ХТМЛ обликован текст';

  @override
  String get commandHint_invite => 'Позови задатог корисника у собу';

  @override
  String get commandHint_join => 'Придружи се наведеној соби';

  @override
  String get commandHint_kick => 'Уклони задатог корисника из собе';

  @override
  String get commandHint_leave => 'Напусти ову собу';

  @override
  String get commandHint_me => 'Опишите себе';

  @override
  String get commandHint_myroomavatar =>
      'Set your picture for this room (by mxc-uri)';

  @override
  String get commandHint_myroomnick => 'Поставља ваш надимак за ову собу';

  @override
  String get commandHint_op =>
      'Подеси ниво задатог корисника (подразумевано: 50)';

  @override
  String get commandHint_plain => 'Шаљи неформатиран текст';

  @override
  String get commandHint_react => 'Шаљи одговор као реакцију';

  @override
  String get commandHint_send => 'Пошаљи текст';

  @override
  String get commandHint_unban => 'Скини забрану задатом кориснику за ову собу';

  @override
  String get commandInvalid => 'Command invalid';

  @override
  String commandMissing(Object command) {
    return '$command is not a command.';
  }

  @override
  String get compareEmojiMatch =>
      'Упоредите и проверите да су емоџији идентични као на другом уређају:';

  @override
  String get compareNumbersMatch =>
      'Упоредите и проверите да су следећи бројеви идентични као на другом уређају:';

  @override
  String get configureChat => 'Подешавање ћаскања';

  @override
  String get confirm => 'Потврди';

  @override
  String get connect => 'Повежи се';

  @override
  String get contactHasBeenInvitedToTheGroup => 'Особа је позвана у групу';

  @override
  String get containsDisplayName => 'Садржи приказно име';

  @override
  String get containsUserName => 'Садржи корисничко име';

  @override
  String get contentHasBeenReported =>
      'Садржај је пријављен администраторима сервера';

  @override
  String get copiedToClipboard => 'Копирано у клипборд';

  @override
  String get copy => 'Копирај';

  @override
  String get copyToClipboard => 'Копирај у клипборд';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Не могу да дешифрујем поруку: $error';
  }

  @override
  String countParticipants(Object count) {
    return 'учесника: $count';
  }

  @override
  String get create => 'Направи';

  @override
  String createdTheChat(Object username) {
    return '$username направи ћаскање';
  }

  @override
  String get createNewGroup => 'Направи нову групу';

  @override
  String get createNewSpace => 'New space';

  @override
  String get currentlyActive => 'Тренутно активно';

  @override
  String get darkTheme => 'тамни';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$day $month';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$day $month $year';
  }

  @override
  String get deactivateAccountWarning =>
      'Ово ће деактивирати ваш кориснички налог. Не може се повратити! Сигурни сте?';

  @override
  String get defaultPermissionLevel => 'Подразумевани ниво приступа';

  @override
  String get delete => 'Обриши';

  @override
  String get deleteAccount => 'Обриши налог';

  @override
  String get deleteMessage => 'Брисање поруке';

  @override
  String get deny => 'Одбиј';

  @override
  String get device => 'Уређај';

  @override
  String get deviceId => 'ИД уређаја';

  @override
  String get devices => 'Уређаји';

  @override
  String get directChats => 'Директна ћаскања';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Име за приказ је измењено';

  @override
  String get downloadFile => 'Преузми фајл';

  @override
  String get edit => 'Уреди';

  @override
  String get editBlockedServers => 'Уреди блокиране сервере';

  @override
  String get editChatPermissions => 'Уредите дозволе ћаскања';

  @override
  String get editDisplayname => 'Уреди име за приказ';

  @override
  String get editRoomAliases => 'Уреди алијасе собе';

  @override
  String get editRoomAvatar => 'Уређује аватар собе';

  @override
  String get emoteExists => 'Емоти већ постоји!';

  @override
  String get emoteInvalid => 'Неисправна скраћеница за емоти!';

  @override
  String get emotePacks => 'Пакети емотија за собу';

  @override
  String get emoteSettings => 'Поставке емотија';

  @override
  String get emoteShortcode => 'скраћеница';

  @override
  String get emoteWarnNeedToPick =>
      'Морате да изаберете скраћеницу и слику за емоти!';

  @override
  String get emptyChat => 'празно ћаскање';

  @override
  String get enableEmotesGlobally => 'Глобално укључи пакет емотија';

  @override
  String get enableEncryption => 'Укључује шифровање';

  @override
  String get enableEncryptionWarning =>
      'Шифровање више нећете моћи да искључите. Сигурни сте?';

  @override
  String get encrypted => 'Шифровано';

  @override
  String get encryption => 'Шифровање';

  @override
  String get encryptionNotEnabled => 'Шифровање није укључено';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName заврши позив';
  }

  @override
  String get enterAGroupName => 'унесите назив групе';

  @override
  String get enterAnEmailAddress => 'Унесите адресу е-поште';

  @override
  String get enterASpacepName => 'Enter a space name';

  @override
  String get homeserver => 'Homeserver';

  @override
  String get enterYourHomeserver => 'Унесите свој домаћи сервер';

  @override
  String errorObtainingLocation(Object error) {
    return 'Error obtaining location: $error';
  }

  @override
  String get everythingReady => 'Све је спремно!';

  @override
  String get extremeOffensive => 'Екстремно увредљив';

  @override
  String get fileName => 'Назив фајла';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Величина фонта';

  @override
  String get forward => 'Напред';

  @override
  String get fromJoining => 'од приступања';

  @override
  String get fromTheInvitation => 'од позивања';

  @override
  String get goToTheNewRoom => 'Иди у нову собу';

  @override
  String get group => 'Група';

  @override
  String get groupDescription => 'Опис групе';

  @override
  String get groupDescriptionHasBeenChanged => 'Опис групе измењен';

  @override
  String get groupIsPublic => 'Група је јавна';

  @override
  String groupWith(Object displayname) {
    return 'Група са корисником $displayname';
  }

  @override
  String get guestsAreForbidden => 'гости су забрањени';

  @override
  String get guestsCanJoin => 'гости могу приступити';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username поништи позивницу за корисника $targetName';
  }

  @override
  String get help => 'Помоћ';

  @override
  String get hideRedactedEvents => 'Сакриј редиговане догађаје';

  @override
  String get hideUnknownEvents => 'Сакриј непознате догађаје';

  @override
  String get howOffensiveIsThisContent => 'Колико је увредљив овај садржај?';

  @override
  String get id => 'ИД';

  @override
  String get identity => 'Идентитет';

  @override
  String get ignore => 'Игнориши';

  @override
  String get ignoredUsers => 'Игнорисани корисници';

  @override
  String get ignoreListDescription =>
      'Можете игнорисати кориснике који вас нервирају. Нећете примати никакве поруке нити позивнице од корисника са ваше листе за игнорисање.';

  @override
  String get ignoreUsername => 'Игнориши корисника';

  @override
  String get iHaveClickedOnLink => 'Кликнуо сам на везу';

  @override
  String get incorrectPassphraseOrKey => 'Неисправна фраза или кључ опоравка';

  @override
  String get inoffensive => 'Није увредљив';

  @override
  String get inviteContact => 'Позивање особа';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Позови особу у групу $groupName';
  }

  @override
  String get invited => 'Позван';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username позва корисника $targetName';
  }

  @override
  String get invitedUsersOnly => 'само позвани корисници';

  @override
  String get inviteForMe => 'Позивнице за мене';

  @override
  String inviteText(Object username, Object link) {
    return '$username вас позива у FluffyChat. \n1. Инсталирајте FluffyChat: https://fluffychat.im \n2. Региструјте се или пријавите \n3. Отворите везу позивнице: $link';
  }

  @override
  String get isTyping => 'куца…';

  @override
  String joinedTheChat(Object username) {
    return '$username се придружи ћаскању';
  }

  @override
  String get joinRoom => 'Придружи се соби';

  @override
  String kicked(Object username, Object targetName) {
    return '$username избаци корисника $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username избаци и забрани корисника $targetName';
  }

  @override
  String get kickFromChat => 'Избаци из ћаскања';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Последња активност: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'одавно није на мрежи';

  @override
  String get leave => 'Напусти';

  @override
  String get leftTheChat => 'Напусти ћаскање';

  @override
  String get license => 'Лиценца';

  @override
  String get lightTheme => 'светли';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Учитај још $count учесника';
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
  String get loadingPleaseWait => 'Учитавам… Сачекајте.';

  @override
  String get loadMore => 'Учитај још…';

  @override
  String get locationDisabledNotice =>
      'Location services are disabled. Please enable them to be able to share your location.';

  @override
  String get locationPermissionDeniedNotice =>
      'Location permission denied. Please grant them to be able to share your location.';

  @override
  String get login => 'Пријава';

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
    return 'Пријава на $homeserver';
  }

  @override
  String get loginWithOneClick => 'Sign in with one click';

  @override
  String get logout => 'Одјава';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Проверите да је идентификатор исправан';

  @override
  String get memberChanges => 'Измене чланова';

  @override
  String get mention => 'Спомени';

  @override
  String get messages => 'Поруке';

  @override
  String get messageWillBeRemovedWarning =>
      'Поруке ће бити уклоњене за све учеснике';

  @override
  String get moderator => 'Модератор';

  @override
  String get muteChat => 'Ућуткај ћаскање';

  @override
  String get needPantalaimonWarning =>
      'За сада, потребан је Пантелејмон (Pantalaimon) да бисте користили шифровање с краја на крај.';

  @override
  String get newChat => 'Ново ћаскање';

  @override
  String get newMessageInFluffyChat => 'Нова порука — FluffyChat';

  @override
  String get newVerificationRequest => 'Нови захтев за верификацију!';

  @override
  String get next => 'Следеће';

  @override
  String get no => 'Не';

  @override
  String get noConnectionToTheServer => 'Нема везе са сервером';

  @override
  String get noEmotesFound => 'Нема емотија. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Шифровање се може активирати након што соба престане да буде јавно доступна.';

  @override
  String get noGoogleServicesWarning =>
      'Чини се да немате Гугл услуге на телефону. То је добра одлука за вашу приватност! Да би се протурале нотификације у FluffyChat, препоручујемо коришћење https://microg.org/ или https://unifiedpush.org/';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 is no matrix server, use $server2 instead?';
  }

  @override
  String get shareYourInviteLink => 'Share your invite link';

  @override
  String get scanQrCode => 'Scan QR code';

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
  String get none => 'Ништа';

  @override
  String get noPasswordRecoveryDescription =>
      'Још нисте одредили начин за опоравак лозинке.';

  @override
  String get noPermission => 'Нема дозвола';

  @override
  String get noRoomsFound => 'Нисам нашао собе…';

  @override
  String get notifications => 'Обавештења';

  @override
  String get notificationsEnabledForThisAccount =>
      'Обавештења укључена за овај налог';

  @override
  String numUsersTyping(Object count) {
    return '$count корисника куца…';
  }

  @override
  String get obtainingLocation => 'Obtaining location…';

  @override
  String get offensive => 'Увредљив';

  @override
  String get offline => 'Ван везе';

  @override
  String get ok => 'у реду';

  @override
  String get online => 'На вези';

  @override
  String get onlineKeyBackupEnabled => 'Резерва кључева на мрежи је укључена';

  @override
  String get oopsPushError =>
      'Нажалост, дошло је до грешке при подешавању дотурања обавештења.';

  @override
  String get oopsSomethingWentWrong => 'Нешто је пошло наопако…';

  @override
  String get openAppToReadMessages => 'Отворите апликацију да прочитате поруке';

  @override
  String get openCamera => 'Отвори камеру';

  @override
  String get openVideoCamera => 'Open camera for a video';

  @override
  String get oneClientLoggedOut => 'One of your clients has been logged out';

  @override
  String get addAccount => 'Add account';

  @override
  String get editBundlesForAccount => 'Edit bundles for this account';

  @override
  String get addToBundle => 'Add to bundle';

  @override
  String get removeFromBundle => 'Remove from this bundle';

  @override
  String get bundleName => 'Bundle name';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Enable multi accounts on this device';

  @override
  String get openInMaps => 'Open in maps';

  @override
  String get link => 'Link';

  @override
  String get serverRequiresEmail =>
      'This server needs to validate your email address for registration.';

  @override
  String get optionalGroupName => '(опционо) назив групе';

  @override
  String get or => 'или';

  @override
  String get participant => 'Учесник';

  @override
  String get passphraseOrKey => 'фраза или кључ опоравка';

  @override
  String get password => 'Лозинка';

  @override
  String get passwordForgotten => 'Заборављена лозинка';

  @override
  String get passwordHasBeenChanged => 'Лозинка је промењена';

  @override
  String get passwordRecovery => 'Опоравак лозинке';

  @override
  String get pickImage => 'Избор слике';

  @override
  String get pin => 'Закачи';

  @override
  String play(Object fileName) {
    return 'Пусти $fileName';
  }

  @override
  String get pleaseChoose => 'Изаберите';

  @override
  String get pleaseChooseAPasscode => 'Изаберите код за пролаз';

  @override
  String get pleaseChooseAUsername => 'Изаберите корисничко име';

  @override
  String get pleaseClickOnLink =>
      'Кликните на везу у примљеној е-пошти па наставите.';

  @override
  String get pleaseEnter4Digits =>
      'Унесите 4 цифре или оставите празно да не закључавате апликацију.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Унесите ИД са Матрикса.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => 'Унесите своју лозинку';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Унесите свој пин';

  @override
  String get pleaseEnterYourUsername => 'Унесите своје корисничко име';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Испратите упутства на веб сајту и тапните на „Следеће“.';

  @override
  String get privacy => 'Приватност';

  @override
  String get publicRooms => 'Јавне собе';

  @override
  String get pushRules => 'Правила протурања';

  @override
  String get reason => 'Разлог';

  @override
  String get recording => 'Снимам';

  @override
  String redactedAnEvent(Object username) {
    return '$username редигова догађај';
  }

  @override
  String get redactMessage => 'Редигуј поруку';

  @override
  String get reject => 'Одбиј';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username одби позивницу';
  }

  @override
  String get rejoin => 'Поново се придружи';

  @override
  String get remove => 'Уклони';

  @override
  String get removeAllOtherDevices => 'Уклони све остале уређаје';

  @override
  String removedBy(Object username) {
    return 'Уклонио корисник $username';
  }

  @override
  String get removeDevice => 'Уклони уређај';

  @override
  String get unbanFromChat => 'Уклони изгнанство';

  @override
  String get removeYourAvatar => 'Уклоните свој аватар';

  @override
  String get renderRichContent => 'Приказуј обогаћен садржај поруке';

  @override
  String get replaceRoomWithNewerVersion => 'Замени собу новијом верзијом';

  @override
  String get reply => 'Одговори';

  @override
  String get reportMessage => 'Пријави поруку';

  @override
  String get requestPermission => 'Затражи дозволу';

  @override
  String get roomHasBeenUpgraded => 'Соба је надограђена';

  @override
  String get roomVersion => 'Верзија собе';

  @override
  String get saveFile => 'Save file';

  @override
  String get search => 'Претражи';

  @override
  String get security => 'Безбедност';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return '$username прегледа';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Видео $username и још $count људи';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Прегледали $username и $username2';
  }

  @override
  String get send => 'Пошаљи';

  @override
  String get sendAMessage => 'Пошаљи поруку';

  @override
  String get sendAsText => 'Send as text';

  @override
  String get sendAudio => 'Пошаљи аудио';

  @override
  String get sendFile => 'Пошаљи фајл';

  @override
  String get sendImage => 'Пошаљи слику';

  @override
  String get sendMessages => 'Слање порука';

  @override
  String get sendOriginal => 'Пошаљи оригинал';

  @override
  String get sendSticker => 'Send sticker';

  @override
  String get sendVideo => 'Пошаљи видео';

  @override
  String sentAFile(Object username) {
    return '$username посла фајл';
  }

  @override
  String sentAnAudio(Object username) {
    return '$username посла аудио';
  }

  @override
  String sentAPicture(Object username) {
    return '$username посла слику';
  }

  @override
  String sentASticker(Object username) {
    return '$username посла налепницу';
  }

  @override
  String sentAVideo(Object username) {
    return '$username посла видео';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName посла податке о позиву';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'Постави као главни алијас';

  @override
  String get setCustomEmotes => 'постави посебне емотије';

  @override
  String get setGroupDescription => 'Постави опис групе';

  @override
  String get setInvitationLink => 'Поставља везу позивнице';

  @override
  String get setPermissionsLevel => 'Одреди ниво дозволе';

  @override
  String get setStatus => 'Постави статус';

  @override
  String get settings => 'Поставке';

  @override
  String get share => 'Подели';

  @override
  String sharedTheLocation(Object username) {
    return '$username подели локацију';
  }

  @override
  String get shareLocation => 'Share location';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => 'Прикажи лозинку';

  @override
  String get signUp => 'Регистрација';

  @override
  String get singlesignon => 'Јединствена пријава';

  @override
  String get skip => 'Прескочи';

  @override
  String get sourceCode => 'Изворни код';

  @override
  String get spaceIsPublic => 'Space is public';

  @override
  String get spaceName => 'Space name';

  @override
  String startedACall(Object senderName) {
    return '$senderName започе позив';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Стање';

  @override
  String get statusExampleMessage => 'Како сте данас?';

  @override
  String get submit => 'Пошаљи';

  @override
  String get synchronizingPleaseWait => 'Synchronizing… Please wait.';

  @override
  String get systemTheme => 'системски';

  @override
  String get theyDontMatch => 'Не поклапају се';

  @override
  String get theyMatch => 'Поклапају се';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Мењај омиљеност';

  @override
  String get toggleMuted => 'Мењај ућутканост';

  @override
  String get toggleUnread => 'Означи не/прочитано';

  @override
  String get tooManyRequestsWarning => 'Превише упита. Покушајте касније!';

  @override
  String get transferFromAnotherDevice => 'Пренос са другог уређаја';

  @override
  String get tryToSendAgain => 'Покушај слање поново';

  @override
  String get unavailable => 'Недоступно';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username одблокира корисника $targetName';
  }

  @override
  String get unblockDevice => 'Одблокирај уређај';

  @override
  String get unknownDevice => 'Непознат уређај';

  @override
  String get unknownEncryptionAlgorithm => 'Непознат алгоритам шифровања';

  @override
  String get unmuteChat => 'Врати обавештења';

  @override
  String get unpin => 'Откачи';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: 'непрочитаних ћаскања: $unreadCount',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username и $count корисника куцају…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username и $username2 куцају…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username куца…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '$username напусти ћаскање';
  }

  @override
  String get username => 'Корисничко име';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username посла $type догађај';
  }

  @override
  String get unverified => 'Unverified';

  @override
  String get verified => 'Оверен';

  @override
  String get verify => 'Верификуј';

  @override
  String get verifyStart => 'Покрени верификацију';

  @override
  String get verifySuccess => 'Успешно сте верификовали!';

  @override
  String get verifyTitle => 'Верификујем други налог';

  @override
  String get videoCall => 'Видео позив';

  @override
  String get visibilityOfTheChatHistory => 'Одреди видљивост историје';

  @override
  String get visibleForAllParticipants => 'видљиво свим учесницима';

  @override
  String get visibleForEveryone => 'видљиво свима';

  @override
  String get voiceMessage => 'Гласовна порука';

  @override
  String get waitingPartnerAcceptRequest =>
      'Чекам да саговорник прихвати захтев…';

  @override
  String get waitingPartnerEmoji => 'Чекам да саговорник прихвати емоџије…';

  @override
  String get waitingPartnerNumbers => 'Чекам да саговорник прихвати бројеве…';

  @override
  String get wallpaper => 'Тапета';

  @override
  String get warning => 'Упозорење!';

  @override
  String get weSentYouAnEmail => 'Послали смо вам е-пошту';

  @override
  String get whoCanPerformWhichAction => 'ко може шта да ради';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Ко може да се придружи групи';

  @override
  String get whyDoYouWantToReportThis => 'Зашто желите ово да пријавите?';

  @override
  String get wipeChatBackup =>
      'Да обришем резервну копију како би направио нови сигурносни кључ?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Са овим адресама можете опоравити своју лозинку.';

  @override
  String get writeAMessage => 'напишите поруку…';

  @override
  String get yes => 'Да';

  @override
  String get you => 'Ви';

  @override
  String get youAreInvitedToThisChat => 'Позвани сте у ово ћаскање';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Више не учествујете у овом ћаскању';

  @override
  String get youCannotInviteYourself => 'Не можете позвати себе';

  @override
  String get youHaveBeenBannedFromThisChat => 'Забрањено вам је ово ћаскање';

  @override
  String get yourPublicKey => 'Ваш јавни кључ';

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
