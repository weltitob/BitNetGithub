// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Esperanto (`eo`).
class L10nEo extends L10n {
  L10nEo([String locale = 'eo']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Registriĝi';

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
  String get people => 'Personoj';

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
  String get groups => 'Grupoj';

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
  String get about => 'Prio';

  @override
  String get updateAvailable => 'FluffyChat update available';

  @override
  String get updateNow => 'Start update in background';

  @override
  String get accept => 'Akcepti';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username akceptis la inviton';
  }

  @override
  String get account => 'Konto';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username aktivigis tutvojan ĉifradon';
  }

  @override
  String get addEmail => 'Aldoni retpoŝtadreson';

  @override
  String get confirmMatrixId =>
      'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'Aldoni priskribon de grupo';

  @override
  String get addToSpace => 'Aldoni al aro';

  @override
  String get admin => 'Administranto';

  @override
  String get alias => 'kromnomo';

  @override
  String get all => 'Ĉio';

  @override
  String get allChats => 'Ĉiuj babiloj';

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
    return '$senderName respondis la vokon';
  }

  @override
  String get anyoneCanJoin => 'Ĉiu ajn povas aliĝi';

  @override
  String get appLock => 'Ŝlosado';

  @override
  String get archive => 'Arĥivo';

  @override
  String get areGuestsAllowedToJoin => 'Ĉu gastoj rajtas aliĝi';

  @override
  String get areYouSure => 'Ĉu vi certas?';

  @override
  String get areYouSureYouWantToLogout => 'Ĉu vi certe volas adiaŭi?';

  @override
  String get askSSSSSign =>
      'Por ke vi povu kontroli (subskribi) la alian personon, bonvolu enigi pasfrazon de via sekreta deponejo aŭ vian rehavan ŝlosilon.';

  @override
  String askVerificationRequest(Object username) {
    return 'Ĉu akcepti ĉi tiun kontrolpeton de $username?';
  }

  @override
  String get autoplayImages =>
      'Memage ludi movbildajn glumarkojn kaj mienetojn';

  @override
  String get sendOnEnter => 'Sendi per eniga klavo';

  @override
  String get banFromChat => 'Forbari de babilo';

  @override
  String get banned => 'Forbarita';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username forbaris uzanton $targetName';
  }

  @override
  String get blockDevice => 'Bloki aparaton';

  @override
  String get blocked => 'Blokita';

  @override
  String get botMessages => 'Mesaĝoj de robotoj';

  @override
  String get bubbleSize => 'Bubble size';

  @override
  String get cancel => 'Nuligi';

  @override
  String cantOpenUri(Object uri) {
    return 'Ne povis malfermi URI $uri';
  }

  @override
  String get changeDeviceName => 'Ŝanĝi nomon de aparato';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username ŝanĝis bildon de la babilo';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username ŝanĝis priskribon de la babilo al: «$description»';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username ŝanĝis nomon de la babilo al: «$chatname»';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username ŝanĝis permesojn pri la babilo';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username ŝanĝis sian prezentan nomon al: $username';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username ŝanĝis regulojn pri aliro de gastoj';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username ŝanĝis regulojn pri aliro de gastoj al: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username ŝanĝis videblecon de la historio';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username ŝanĝis videblecon de la historio al: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username ŝanĝis regulojn pri aliĝado';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username ŝanĝis regulojn pri aliĝado al: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username ŝanĝis sian profilbildon';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username ŝanĝis la kromnomojn de la ĉambro';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username ŝanĝis la invitan ligilon';
  }

  @override
  String get changePassword => 'Ŝanĝi pasvorton';

  @override
  String get changeTheHomeserver => 'Ŝanĝi hejmservilon';

  @override
  String get changeTheme => 'Ŝanĝu la haŭton';

  @override
  String get changeTheNameOfTheGroup => 'Ŝanĝi nomon de la grupo';

  @override
  String get changeWallpaper => 'Ŝanĝi fonbildon';

  @override
  String get changeYourAvatar => 'Ŝanĝi vian profilbildon';

  @override
  String get channelCorruptedDecryptError => 'La ĉifrado estas difektita';

  @override
  String get chat => 'Babilo';

  @override
  String get yourChatBackupHasBeenSetUp => 'Your chat backup has been set up.';

  @override
  String get chatBackup => 'Savkopiado de babilo';

  @override
  String get chatBackupDescription =>
      'Via savkopio de babilo estas sekurigita per sekureca ŝlosilo. Bonvolu certigi, ke vi ne perdos ĝin.';

  @override
  String get chatDetails => 'Detaloj pri babilo';

  @override
  String get chatHasBeenAddedToThisSpace => 'Babilo aldoniĝis al ĉi tiu aro';

  @override
  String get chats => 'Babiloj';

  @override
  String get chooseAStrongPassword => 'Elektu fortan pasvorton';

  @override
  String get chooseAUsername => 'Elektu uzantonomon';

  @override
  String get clearArchive => 'Vakigi arĥivon';

  @override
  String get close => 'Fermi';

  @override
  String get commandHint_markasdm => 'Mark as direct message room';

  @override
  String get commandHint_markasgroup => 'Mark as group';

  @override
  String get commandHint_ban => 'Forbari la donitan uzanton de ĉi tiu ĉambro';

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
  String get commandHint_html => 'Sendi tekston formatan je HTML';

  @override
  String get commandHint_invite => 'Inviti la donitan uzanton al ĉi tiu ĉambro';

  @override
  String get commandHint_join => 'Aliĝi al la donita ĉambro';

  @override
  String get commandHint_kick => 'Forigi la donitan uzanton de ĉi tiu ĉambro';

  @override
  String get commandHint_leave => 'Foriri de ĉi tiu ĉambro';

  @override
  String get commandHint_me => 'Priskribu vian agon';

  @override
  String get commandHint_myroomavatar =>
      'Agordi vian profilbildon por ĉi tiu ĉambro (laŭ mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Agordi vian prezentan nomon en ĉi tiu ĉambro';

  @override
  String get commandHint_op =>
      'Agordi povnivelon de la donita uzanto (implicite: 50)';

  @override
  String get commandHint_plain => 'Sendi senformatan tekston';

  @override
  String get commandHint_react => 'Sendi respondon kiel reagon';

  @override
  String get commandHint_send => 'Sendi tekston';

  @override
  String get commandHint_unban =>
      'Malforbari la donitan uzanton de ĉi tiu ĉambro';

  @override
  String get commandInvalid => 'Nevalida ordono';

  @override
  String commandMissing(Object command) {
    return '$command ne estas ordono.';
  }

  @override
  String get compareEmojiMatch =>
      'Komparu kaj certigu, ke la jenaj bildosignoj samas en ambaŭ aparatoj:';

  @override
  String get compareNumbersMatch =>
      'Komparu kaj certigu, ke la jenaj numeroj samas en ambaŭ aparatoj:';

  @override
  String get configureChat => 'Agordi babilon';

  @override
  String get confirm => 'Konfirmi';

  @override
  String get connect => 'Konektiĝi';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Kontakto invitiĝis al la grupo';

  @override
  String get containsDisplayName => 'Enhavas prezentan nomon';

  @override
  String get containsUserName => 'Enhavas uzantonomon';

  @override
  String get contentHasBeenReported =>
      'La enhavo raportiĝis al la administrantoj de la servilo';

  @override
  String get copiedToClipboard => 'Kopiite al tondujo';

  @override
  String get copy => 'Kopii';

  @override
  String get copyToClipboard => 'Kopii al tondujo';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Ne povis malĉifri mesaĝon: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count partoprenantoj';
  }

  @override
  String get create => 'Krei';

  @override
  String createdTheChat(Object username) {
    return '$username kreis la babilon';
  }

  @override
  String get createNewGroup => 'Krei novan grupon';

  @override
  String get createNewSpace => 'Nova aro';

  @override
  String get currentlyActive => 'Nun aktiva';

  @override
  String get darkTheme => 'Malhela';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '${day}a de la ${month}a';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '${day}a de la ${month}a de $year';
  }

  @override
  String get deactivateAccountWarning =>
      'Ĉi tio malaktivigos vian konton de uzanto. Ne eblas tion malfari! Ĉu certe vi certas?';

  @override
  String get defaultPermissionLevel => 'Norma nivelo de permesoj';

  @override
  String get delete => 'Forigi';

  @override
  String get deleteAccount => 'Forigi konton';

  @override
  String get deleteMessage => 'Forigi mesaĝon';

  @override
  String get deny => 'Malakcepti';

  @override
  String get device => 'Aparato';

  @override
  String get deviceId => 'Identigilo de aparato';

  @override
  String get devices => 'Aparatoj';

  @override
  String get directChats => 'Rektaj babiloj';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Prezenta nomo ŝanĝiĝis';

  @override
  String get downloadFile => 'Elŝuti dosieron';

  @override
  String get edit => 'Redakti';

  @override
  String get editBlockedServers => 'Redakti blokitajn servilojn';

  @override
  String get editChatPermissions => 'Redakti permesojn de babilo';

  @override
  String get editDisplayname => 'Redakti prezentan nomon';

  @override
  String get editRoomAliases => 'Ŝanĝi kromnomojn de ĉambro';

  @override
  String get editRoomAvatar => 'Redakti bildon de ĉambro';

  @override
  String get emoteExists => 'Mieneto jam ekzistas!';

  @override
  String get emoteInvalid => 'Nevalida mallongigo de mieneto!';

  @override
  String get emotePacks => 'Mienetaroj por la ĉambro';

  @override
  String get emoteSettings => 'Agordoj pri mienetoj';

  @override
  String get emoteShortcode => 'Mallongigo de mieneto';

  @override
  String get emoteWarnNeedToPick =>
      'Vi devas elekti mallongigon de mieneto kaj bildon!';

  @override
  String get emptyChat => 'Malplena babilo';

  @override
  String get enableEmotesGlobally => 'Ŝalti mienetaron ĉie';

  @override
  String get enableEncryption => 'Ŝalti ĉifradon';

  @override
  String get enableEncryptionWarning =>
      'Vi ne povos malŝalti la ĉifradon. Ĉu vi certas?';

  @override
  String get encrypted => 'Ĉifrite';

  @override
  String get encryption => 'Ĉifrado';

  @override
  String get encryptionNotEnabled => 'Ĉifrado ne estas ŝaltita';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName finis la vokon';
  }

  @override
  String get enterAGroupName => 'Enigu nomon de grupo';

  @override
  String get enterAnEmailAddress => 'Enigu retpoŝtadreson';

  @override
  String get enterASpacepName => 'Enigi nomon de aro';

  @override
  String get homeserver => 'Hejmservilo';

  @override
  String get enterYourHomeserver => 'Enigu vian hejmservilon';

  @override
  String errorObtainingLocation(Object error) {
    return 'Eraris akirado de loko: $error';
  }

  @override
  String get everythingReady => 'Ĉio pretas!';

  @override
  String get extremeOffensive => 'Tre ofenda';

  @override
  String get fileName => 'Dosiernomo';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Grandeco de tiparo';

  @override
  String get forward => 'Plusendi';

  @override
  String get fromJoining => 'Ekde aliĝo';

  @override
  String get fromTheInvitation => 'Ekde la invito';

  @override
  String get goToTheNewRoom => 'Iri al la nova ĉambro';

  @override
  String get group => 'Grupo';

  @override
  String get groupDescription => 'Priskribo de grupo';

  @override
  String get groupDescriptionHasBeenChanged => 'Priskribo de grupo ŝanĝiĝis';

  @override
  String get groupIsPublic => 'Grupo estas publika';

  @override
  String groupWith(Object displayname) {
    return 'Grupo kun $displayname';
  }

  @override
  String get guestsAreForbidden => 'Gastoj estas malpermesitaj';

  @override
  String get guestsCanJoin => 'Gastoj povas aliĝi';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username nuligis la inviton por $targetName';
  }

  @override
  String get help => 'Helpo';

  @override
  String get hideRedactedEvents => 'Kaŝi obskurigitajn eventojn';

  @override
  String get hideUnknownEvents => 'Kaŝi nekonatajn eventojn';

  @override
  String get howOffensiveIsThisContent => 'Kiel ofenda estas ĉi tiu enhavo?';

  @override
  String get id => 'Identigilo';

  @override
  String get identity => 'Identeco';

  @override
  String get ignore => 'Malatenti';

  @override
  String get ignoredUsers => 'Malatentitaj uzantoj';

  @override
  String get ignoreListDescription =>
      'Vi povas malatenti uzantojn, kiuj vin ĝenas. Vi ne povos ricevi mesaĝojn nek invitojn al ĉambroj de la uzantoj sur via listo de malatentatoj.';

  @override
  String get ignoreUsername => 'Malatenti uzantonomon';

  @override
  String get iHaveClickedOnLink => 'Mi klakis la ligilon';

  @override
  String get incorrectPassphraseOrKey => 'Neĝusta pasfrazo aŭ rehava ŝlosilo';

  @override
  String get inoffensive => 'Neofenda';

  @override
  String get inviteContact => 'Inviti kontakton';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Inviti kontakton al $groupName';
  }

  @override
  String get invited => 'Invitita';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username invitis uzanton $targetName';
  }

  @override
  String get invitedUsersOnly => 'Nur invititoj';

  @override
  String get inviteForMe => 'Invito por mi';

  @override
  String inviteText(Object username, Object link) {
    return '$username invitis vin al FluffyChat. \n1. Instalu la aplikaĵon FluffyChat: https://fluffychat.im \n2. Registriĝu aŭ salutu \n3. Malfermu la invitan ligilon: $link';
  }

  @override
  String get isTyping => 'tajpas…';

  @override
  String joinedTheChat(Object username) {
    return '$username aliĝis al la babilo';
  }

  @override
  String get joinRoom => 'Aliĝi al ĉambro';

  @override
  String kicked(Object username, Object targetName) {
    return '$username forpelis uzanton $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username forpelis kaj forbaris uzanton $targetName';
  }

  @override
  String get kickFromChat => 'Forpeli de babilo';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Lastafoje aktiva: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Vidita antaŭ longe';

  @override
  String get leave => 'Foriri';

  @override
  String get leftTheChat => 'Foriris de la ĉambro';

  @override
  String get license => 'Permesilo';

  @override
  String get lightTheme => 'Hela';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Enlegi $count pliajn partoprenantojn';
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
  String get loadingPleaseWait => 'Enlegante… bonvolu atendi.';

  @override
  String get loadMore => 'Enlegi pli…';

  @override
  String get locationDisabledNotice =>
      'Location services are disabled. Please enable them to be able to share your location.';

  @override
  String get locationPermissionDeniedNotice =>
      'Location permission denied. Please grant them to be able to share your location.';

  @override
  String get login => 'Saluti';

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
    return 'Saluti servilon $homeserver';
  }

  @override
  String get loginWithOneClick => 'Sign in with one click';

  @override
  String get logout => 'Adiaŭi';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Certigu, ke la identigilo estas valida';

  @override
  String get memberChanges => 'Ŝanĝoj de anoj';

  @override
  String get mention => 'Mencii';

  @override
  String get messages => 'Mesaĝoj';

  @override
  String get messageWillBeRemovedWarning =>
      'Mesaĝo foriĝos por ĉiuj partoprenantoj';

  @override
  String get moderator => 'Reguligisto';

  @override
  String get muteChat => 'Silentigi babilon';

  @override
  String get needPantalaimonWarning =>
      'Bonvolu scii, ke vi ankoraŭ bezonas la programon Pantalaimon por uzi tutvojan ĉifradon.';

  @override
  String get newChat => 'Nova babilo';

  @override
  String get newMessageInFluffyChat => 'Nova mesaĝo en FluffyChat';

  @override
  String get newVerificationRequest => 'Nova kontrolpeto!';

  @override
  String get next => 'Sekva';

  @override
  String get no => 'Ne';

  @override
  String get noConnectionToTheServer => 'Neniu konekto al la servilo';

  @override
  String get noEmotesFound => 'Neniuj mienetoj troviĝis. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Vi nur povas aktivigi ĉifradon kiam la ĉambro ne plu estas publike alirebla.';

  @override
  String get noGoogleServicesWarning =>
      'Ŝajnas, ke via telefono ne havas servojn de Google. Tio estas bona decido por via privateco! Por ricevadi pasivajn sciigojn en FluffyChat, ni rekomendas, ke vi uzu la https://microg.org/ aŭ https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 ne estas matriksa servilo, eble provu anstataŭe servilon $server2?';
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
  String get none => 'Neniu';

  @override
  String get noPasswordRecoveryDescription =>
      'Vi ankoraŭ ne aldonis manieron rehavi vian pasvorton.';

  @override
  String get noPermission => 'Neniu permeso';

  @override
  String get noRoomsFound => 'Neniuj ĉambroj troviĝis…';

  @override
  String get notifications => 'Sciigoj';

  @override
  String get notificationsEnabledForThisAccount =>
      'Sciigoj ŝaltiĝis por ĉi tiu konto';

  @override
  String numUsersTyping(Object count) {
    return '$count uzantoj tajpas…';
  }

  @override
  String get obtainingLocation => 'Akirante lokon…';

  @override
  String get offensive => 'Ofenda';

  @override
  String get offline => 'Eksterrete';

  @override
  String get ok => 'bone';

  @override
  String get online => 'Enrete';

  @override
  String get onlineKeyBackupEnabled =>
      'Enreta savkopiado de ŝlosiloj estas ŝaltita';

  @override
  String get oopsPushError =>
      'Oj! Bedaŭrinde eraris la agordado de pasivaj sciigoj.';

  @override
  String get oopsSomethingWentWrong => 'Oj! Io misokazis…';

  @override
  String get openAppToReadMessages => 'Malfermu la aplikaĵon por legi mesaĝojn';

  @override
  String get openCamera => 'Malfermi fotilon';

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
  String get optionalGroupName => '(Malnepra) Nomo de grupo';

  @override
  String get or => 'Aŭ';

  @override
  String get participant => 'Partoprenanto';

  @override
  String get passphraseOrKey => 'pasfrazo aŭ rehava ŝlosilo';

  @override
  String get password => 'Pasvorto';

  @override
  String get passwordForgotten => 'Forgesita pasvorto';

  @override
  String get passwordHasBeenChanged => 'Pasvorto ŝanĝiĝis';

  @override
  String get passwordRecovery => 'Rehavo de pasvorto';

  @override
  String get pickImage => 'Elekti bildon';

  @override
  String get pin => 'Fiksi';

  @override
  String play(Object fileName) {
    return 'Ludi $fileName';
  }

  @override
  String get pleaseChoose => 'Bonvolu elekti';

  @override
  String get pleaseChooseAPasscode => 'Bonvolu elekti paskodon';

  @override
  String get pleaseChooseAUsername => 'Bonvolu elekti uzantonomon';

  @override
  String get pleaseClickOnLink =>
      'Bonvolu klaki la ligilon en la retletero kaj pluiĝi.';

  @override
  String get pleaseEnter4Digits =>
      'Bonvolu enigi 4 ciferojn, aŭ nenion por malŝalti ŝlosadon de la aplikaĵo.';

  @override
  String get pleaseEnterAMatrixIdentifier =>
      'Bonvolu enigi identigilon de Matrix.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => 'Bonvolu enigi vian pasvorton';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin =>
      'Bonvolu enigi vian personan identigan numeron';

  @override
  String get pleaseEnterYourUsername => 'Bonvolu enigi vian uzantonomon';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Bonvolu sekvi la instrukciojn de la retejo kaj tuŝetu al «Sekva».';

  @override
  String get privacy => 'Privateco';

  @override
  String get publicRooms => 'Publikaj ĉambroj';

  @override
  String get pushRules => 'Reguloj de pasivaj sciigoj';

  @override
  String get reason => 'Kialo';

  @override
  String get recording => 'Registrante';

  @override
  String redactedAnEvent(Object username) {
    return '$username obskurigis eventon';
  }

  @override
  String get redactMessage => 'Obskurigi mesaĝon';

  @override
  String get reject => 'Rifuzi';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username rifuzis la inviton';
  }

  @override
  String get rejoin => 'Ree aliĝi';

  @override
  String get remove => 'Forigi';

  @override
  String get removeAllOtherDevices => 'Forigi ĉiujn aliajn aparatojn';

  @override
  String removedBy(Object username) {
    return 'Forigita de $username';
  }

  @override
  String get removeDevice => 'Forigi aparaton';

  @override
  String get unbanFromChat => 'Malforbari';

  @override
  String get removeYourAvatar => 'Forigi vian profilbildon';

  @override
  String get renderRichContent => 'Bildigi riĉforman enhavon de mesaĝoj';

  @override
  String get replaceRoomWithNewerVersion =>
      'Anstataŭigi ĉambron per nova versio';

  @override
  String get reply => 'Respondi';

  @override
  String get reportMessage => 'Raporti mesaĝon';

  @override
  String get requestPermission => 'Peti permeson';

  @override
  String get roomHasBeenUpgraded => 'Ĉambro gradaltiĝis';

  @override
  String get roomVersion => 'Versio de ĉambro';

  @override
  String get saveFile => 'Konservi dosieron';

  @override
  String get search => 'Serĉi';

  @override
  String get security => 'Sekureco';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return 'Vidita de $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Vidita de $username kaj $count aliaj';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Vidita de $username kaj $username2';
  }

  @override
  String get send => 'Sendi';

  @override
  String get sendAMessage => 'Sendi mesaĝon';

  @override
  String get sendAsText => 'Sendi kiel tekston';

  @override
  String get sendAudio => 'Sendi sondosieron';

  @override
  String get sendFile => 'Sendi dosieron';

  @override
  String get sendImage => 'Sendi bildon';

  @override
  String get sendMessages => 'Sendi mesaĝojn';

  @override
  String get sendOriginal => 'Sendi originalon';

  @override
  String get sendSticker => 'Sendi glumarkon';

  @override
  String get sendVideo => 'Sendi filmon';

  @override
  String sentAFile(Object username) {
    return '$username sendis dosieron';
  }

  @override
  String sentAnAudio(Object username) {
    return '$username sendis sondosieron';
  }

  @override
  String sentAPicture(Object username) {
    return '$username sendis bildon';
  }

  @override
  String sentASticker(Object username) {
    return '$username sendis glumarkon';
  }

  @override
  String sentAVideo(Object username) {
    return '$username sendis filmon';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName sendis informojn pri voko';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'Agordi kiel ĉefan kromnomon';

  @override
  String get setCustomEmotes => 'Agordi proprajn mienetojn';

  @override
  String get setGroupDescription => 'Agordi priskribon de grupo';

  @override
  String get setInvitationLink => 'Agordi invitan ligilon';

  @override
  String get setPermissionsLevel => 'Agordi nivelon de permesoj';

  @override
  String get setStatus => 'Agordi staton';

  @override
  String get settings => 'Agordoj';

  @override
  String get share => 'Konigi';

  @override
  String sharedTheLocation(Object username) {
    return '$username konigis sian lokon';
  }

  @override
  String get shareLocation => 'Konigi lokon';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => 'Montri pasvorton';

  @override
  String get signUp => 'Registriĝi';

  @override
  String get singlesignon => 'Ununura saluto';

  @override
  String get skip => 'Preterpasi';

  @override
  String get sourceCode => 'Fontkodo';

  @override
  String get spaceIsPublic => 'Aro estas publika';

  @override
  String get spaceName => 'Nomo de aro';

  @override
  String startedACall(Object senderName) {
    return '$senderName komencis vokon';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Stato';

  @override
  String get statusExampleMessage => 'Kiel vi fartas?';

  @override
  String get submit => 'Sendi';

  @override
  String get synchronizingPleaseWait => 'Spegulante… Bonvolu atendi.';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get theyDontMatch => 'Ili ne akordas';

  @override
  String get theyMatch => 'Ili akordas';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Baskuli elstarigon';

  @override
  String get toggleMuted => 'Basklui silentigon';

  @override
  String get toggleUnread => 'Baskuli legitecon';

  @override
  String get tooManyRequestsWarning =>
      'Tro multaj petoj. Bonvolu reprovi poste!';

  @override
  String get transferFromAnotherDevice => 'Transporti de alia aparato';

  @override
  String get tryToSendAgain => 'Reprovi sendi';

  @override
  String get unavailable => 'Nedisponeble';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username malforbaris uzanton $targetName';
  }

  @override
  String get unblockDevice => 'Malbloki aparaton';

  @override
  String get unknownDevice => 'Nekonata aparato';

  @override
  String get unknownEncryptionAlgorithm => 'Nekonata ĉifra algoritmo';

  @override
  String get unmuteChat => 'Malsilentigi babilon';

  @override
  String get unpin => 'Malfiksi';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount nelegitaj babiloj',
      one: '1 nelegita babilo',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username kaj $count aliaj tajpas…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username kaj $username2 tajpas…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username tajpas…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '$username foriris de la babilo';
  }

  @override
  String get username => 'Uzantonomo';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username sendis eventon de speco $type';
  }

  @override
  String get unverified => 'Unverified';

  @override
  String get verified => 'Kontrolita';

  @override
  String get verify => 'Kontroli';

  @override
  String get verifyStart => 'Komenci kontrolon';

  @override
  String get verifySuccess => 'Vi sukcese kontrolis!';

  @override
  String get verifyTitle => 'Kontrolante alian konton';

  @override
  String get videoCall => 'Vidvoko';

  @override
  String get visibilityOfTheChatHistory => 'Videbleco de historio de la babilo';

  @override
  String get visibleForAllParticipants => 'Videbla al ĉiuj partoprenantoj';

  @override
  String get visibleForEveryone => 'Videbla al ĉiuj';

  @override
  String get voiceMessage => 'Voĉmesaĝo';

  @override
  String get waitingPartnerAcceptRequest =>
      'Atendante konfirmon de peto de la kunulo…';

  @override
  String get waitingPartnerEmoji =>
      'Atendante akcepton de la bildosignoj de la kunulo…';

  @override
  String get waitingPartnerNumbers =>
      'Atendante akcepton de la numeroj, de la kunulo…';

  @override
  String get wallpaper => 'Fonbildo';

  @override
  String get warning => 'Averto!';

  @override
  String get weSentYouAnEmail => 'Ni sendis retleteron al vi';

  @override
  String get whoCanPerformWhichAction => 'Kiu povas kion';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Kiu rajtas aliĝi al ĉi tiu grupo';

  @override
  String get whyDoYouWantToReportThis => 'Kial vi volas tion ĉi raporti?';

  @override
  String get wipeChatBackup =>
      'Ĉu forviŝi la savkopion de via babilo por krei novan sekurecan ŝlosilon?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Per tiuj ĉi adresoj vi povas rehavi vian pasvorton.';

  @override
  String get writeAMessage => 'Skribi mesaĝon…';

  @override
  String get yes => 'Jes';

  @override
  String get you => 'Vi';

  @override
  String get youAreInvitedToThisChat => 'Vi estas invitita al ĉi tiu babilo';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Vi ne plu partoprenas ĉi tiun babilon';

  @override
  String get youCannotInviteYourself => 'Vi ne povas inviti vin mem';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Vi estas forbarita de ĉi tiu babilo';

  @override
  String get yourPublicKey => 'Via publika ŝlosilo';

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
