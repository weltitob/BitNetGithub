// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class L10nEu extends L10n {
  L10nEu([String locale = 'eu']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Eman izena';

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
  String get passwordsDoNotMatch => 'Pasahitzak ez datoz bat!';

  @override
  String get pleaseEnterValidEmail => 'Sartu baliozko ePosta helbide bat.';

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
  String get people => 'Jendea';

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
  String get groups => 'Taldeak';

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
  String get repeatPassword => 'Idatzi berriro pasahitza';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Aukeratu gutxienez $min karaktere.';
  }

  @override
  String get about => 'Honi buruz';

  @override
  String get updateAvailable => 'FluffyChaten eguneraketa bat dago';

  @override
  String get updateNow => 'Abiarazi eguneraketa atzeko planoan';

  @override
  String get accept => 'Ados';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username-(e)k gonbidapena onartu du';
  }

  @override
  String get account => 'Kontua';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username(e)k puntuz puntuko zifraketa gaitu du';
  }

  @override
  String get addEmail => 'Gehitu eposta';

  @override
  String get confirmMatrixId => 'Baieztatu zure Matrix IDa kontua ezabatzeko.';

  @override
  String supposedMxid(Object mxid) {
    return 'Hau $mxid izan behar da';
  }

  @override
  String get addGroupDescription => 'Gehitu taldearen deskribapena';

  @override
  String get addToSpace => 'Gehitu gunera';

  @override
  String get admin => 'Administratzailea';

  @override
  String get alias => 'ezizena';

  @override
  String get all => 'Guztia';

  @override
  String get allChats => 'Txat guztiak';

  @override
  String get commandHint_googly => 'Send some googly eyes';

  @override
  String get commandHint_cuddle => 'Send a cuddle';

  @override
  String get commandHint_hug => 'Bidali besarkada';

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
    return '$senderName(e)k besarkatu zaitu';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '$senderName(e)k deia erantzun du';
  }

  @override
  String get anyoneCanJoin => 'Edonork egin dezake bat';

  @override
  String get appLock => 'Blokeatu aplikazioa';

  @override
  String get archive => 'Artxibatu';

  @override
  String get areGuestsAllowedToJoin =>
      'Ba al dute gonbidatutako erabiltzaileek bat egiteko baimenik?';

  @override
  String get areYouSure => 'Ziur al zaude?';

  @override
  String get areYouSureYouWantToLogout =>
      'Ziur zaude saioa amaitu nahi duzula?';

  @override
  String get askSSSSSign =>
      'Beste pertsona ziurtatzeko, sartu zure biltegiratze segururako pasaesaldia edo berreskuratze gakoa.';

  @override
  String askVerificationRequest(Object username) {
    return '$username(r)en egiaztatze eskaera onartu?';
  }

  @override
  String get autoplayImages =>
      'Automatikoki abiarazi sticker eta emote animatuak';

  @override
  String get sendOnEnter => 'Bidali enter sakatuz';

  @override
  String get banFromChat => 'Berriketa debekatu';

  @override
  String get banned => 'Debekatuta';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username(e)k $targetName debekatu du';
  }

  @override
  String get blockDevice => 'Blokeatu gailua';

  @override
  String get blocked => 'Blokeatuta';

  @override
  String get botMessages => 'Boten mezuak';

  @override
  String get bubbleSize => 'Puxiken tamaina';

  @override
  String get cancel => 'Utzi';

  @override
  String cantOpenUri(Object uri) {
    return 'Ezin da $uri URIa ireki';
  }

  @override
  String get changeDeviceName => 'Aldatu gailuaren izena';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username(e)k berriketako abatarra aldatu du';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username(e)k txataren deskribapena aldatu du: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username(e)k berriketaren izena \'$chatname\'-(e)ra aldatu du';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username(e)k berriketaren baimenak aldatu ditu';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username(e)k bere izena aldatu du. Aurrerantzean \'$displayname\' izango da';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username(e)k gonbidatuen sarbide-arauak aldatu ditu';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username(e)k gonbidatuen arauak aldatu ditu: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username(e)k historiaren ikusgarritasuna aldatu du';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username(e)k historiaren ikusgarritasuna $rules-(e)ra aldatu du';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username(e)k batze arauak aldatu ditu';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username(e)k batzeko arauak $joinRules-(e)ra aldatu ditu';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username(e)k profileko abatarra aldatu du';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username(e)k gelaren ezizena aldatu du';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username(e)k gonbidapen esteka aldatu du';
  }

  @override
  String get changePassword => 'Aldatu pasahitza';

  @override
  String get changeTheHomeserver => 'Aldatu zerbitzaria';

  @override
  String get changeTheme => 'Aldatu itxura';

  @override
  String get changeTheNameOfTheGroup => 'Aldatu taldearen izena';

  @override
  String get changeWallpaper => 'Aldatu atzekaldea';

  @override
  String get changeYourAvatar => 'Aldatu abatarra';

  @override
  String get channelCorruptedDecryptError => 'Zifraketa hondatu egin da';

  @override
  String get chat => 'Berriketa';

  @override
  String get yourChatBackupHasBeenSetUp => 'Txaten babeskopiak ezarri dira.';

  @override
  String get chatBackup => 'Txataren babeskopia';

  @override
  String get chatBackupDescription =>
      'Txat zaharrak berreskuratze-gako batekin daude babestuta. Ez galdu gako hori.';

  @override
  String get chatDetails => 'Berriketaren xehetasunak';

  @override
  String get chatHasBeenAddedToThisSpace => 'Berriketa gune honetara gehitu da';

  @override
  String get chats => 'Berriketak';

  @override
  String get chooseAStrongPassword => 'Aukeratu pasahitz sendo bat';

  @override
  String get chooseAUsername => 'Aukeratu erabiltzaile izen bat';

  @override
  String get clearArchive => 'Ezabatu artxiboa';

  @override
  String get close => 'Itxi';

  @override
  String get commandHint_markasdm => 'Markatu mezu-zuzen gela bezala';

  @override
  String get commandHint_markasgroup => 'Markatu talde bezala';

  @override
  String get commandHint_ban => 'Debekatu erabiltzailea gela honetan';

  @override
  String get commandHint_clearcache => 'Ezabatu cachea';

  @override
  String get commandHint_create =>
      'Sortu taldeko-gela huts bat\nErabili --no-encyption zifratzea desgaitzeko';

  @override
  String get commandHint_discardsession => 'Baztertu saioa';

  @override
  String get commandHint_dm =>
      'Hasi berriketa bat\nErabili --no-encryption zifratzea desgaitu nahi baduzu';

  @override
  String get commandHint_html => 'Bidali testua HTML formatuan';

  @override
  String get commandHint_invite => 'Gonbidatu erabiltzailea gela honetara';

  @override
  String get commandHint_join => 'Batu gela horretara';

  @override
  String get commandHint_kick => 'Kendu erabiltzaile hori gela honetatik';

  @override
  String get commandHint_leave => 'Utzi gela hau';

  @override
  String get commandHint_me => 'Deskribatu zure burua';

  @override
  String get commandHint_myroomavatar =>
      'Ezarri zure irudia gela honetarako (mxc-uri bidez)';

  @override
  String get commandHint_myroomnick => 'Ezarri zure izengoitia gela honetarako';

  @override
  String get commandHint_op =>
      'Zehaztu erabiltzaile honen botere-maila (lehenetsia: 50)';

  @override
  String get commandHint_plain => 'Bidali formaturik gabeko testua';

  @override
  String get commandHint_react => 'Bidali erantzuna erreakzioa bailitzan';

  @override
  String get commandHint_send => 'Bidali testua';

  @override
  String get commandHint_unban => 'Baimendu erabiltzailea gela honetan';

  @override
  String get commandInvalid => 'Komandoa ez da baliozkoa';

  @override
  String commandMissing(Object command) {
    return '$command ez da komandoa.';
  }

  @override
  String get compareEmojiMatch =>
      'Konparatu eta egiaztatu ondorengo emojiak beste gailukoarekin bat datozela:';

  @override
  String get compareNumbersMatch =>
      'Konparatu eta egiaztatu ondorengo zenbakiak beste gailukoarekin bat datozela:';

  @override
  String get configureChat => 'Konfiguratu berriketa';

  @override
  String get confirm => 'Baieztatu';

  @override
  String get connect => 'Konektatu';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Kontaktua taldera gonbidatua izan da';

  @override
  String get containsDisplayName => 'Pantaila-izena dauka';

  @override
  String get containsUserName => 'Erabiltzaile izena dauka';

  @override
  String get contentHasBeenReported =>
      'Edukia zerbitzariko administrariei jakinarazi zaie';

  @override
  String get copiedToClipboard => 'Arbelera kopiatua';

  @override
  String get copy => 'Kopiatu';

  @override
  String get copyToClipboard => 'Kopiatu arbelera';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Ezin izan da mezua deszifratu: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count partaide';
  }

  @override
  String get create => 'Sortu';

  @override
  String createdTheChat(Object username) {
    return '💬 $username(e)k berriketa sortu du';
  }

  @override
  String get createNewGroup => 'Sortu talde berria';

  @override
  String get createNewSpace => 'Gune berria';

  @override
  String get currentlyActive => 'Unean aktibo';

  @override
  String get darkTheme => 'Iluna';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$month/$day';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$year/$month/$day';
  }

  @override
  String get deactivateAccountWarning =>
      'Honek zure kontua desaktibatuko du. Ezin da desegin! Ziur zaude?';

  @override
  String get defaultPermissionLevel => 'Defektuzko botere-maila';

  @override
  String get delete => 'Ezabatu';

  @override
  String get deleteAccount => 'Ezabatu kontua';

  @override
  String get deleteMessage => 'Ezabatu mezua';

  @override
  String get deny => 'Ukatu';

  @override
  String get device => 'Gailua';

  @override
  String get deviceId => 'Gailuaren IDa';

  @override
  String get devices => 'Gailuak';

  @override
  String get directChats => 'Berriketa zuzenak';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Pantaila-izena aldatu da';

  @override
  String get downloadFile => 'Deskargatu fitxategia';

  @override
  String get edit => 'Editatu';

  @override
  String get editBlockedServers => 'Editatu blokeatutako zerbitzariak';

  @override
  String get editChatPermissions => 'Editatu berriketa-baimenak';

  @override
  String get editDisplayname => 'Editatu ezizena';

  @override
  String get editRoomAliases => 'Editatu gelako goitizenak';

  @override
  String get editRoomAvatar => 'Editatu gelaren abatarra';

  @override
  String get emoteExists => 'Emotea badago lehendik ere!';

  @override
  String get emoteInvalid => 'Emotearen laburdura ez da baliozkoa!';

  @override
  String get emotePacks => 'Emote sortak gelarako';

  @override
  String get emoteSettings => 'Emote ezarpenak';

  @override
  String get emoteShortcode => 'Emote laburdurak';

  @override
  String get emoteWarnNeedToPick =>
      'Emote laburdura eta irudi bat aukeratu behar dituzu!';

  @override
  String get emptyChat => 'Hutsik dago';

  @override
  String get enableEmotesGlobally => 'Gaitu emote sorta berriketa guztietarako';

  @override
  String get enableEncryption => 'Gaitu zifraketa';

  @override
  String get enableEncryptionWarning =>
      'Ezingo duzu zifraketa desgaitu. Ziur zaude?';

  @override
  String get encrypted => 'Zifratuta';

  @override
  String get encryption => 'Zifraketa';

  @override
  String get encryptionNotEnabled => 'Zifraketa ez dago gaituta';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName(e)k deia amaitu du';
  }

  @override
  String get enterAGroupName => 'Sartu talderako izena';

  @override
  String get enterAnEmailAddress => 'Sartu helbide elektroniko bat';

  @override
  String get enterASpacepName => 'Sartu gunerako izena';

  @override
  String get homeserver => 'Zerbitzaria';

  @override
  String get enterYourHomeserver => 'Sartu zure zerbitzaria';

  @override
  String errorObtainingLocation(Object error) {
    return 'Errorea kokapena lortzerakoan: $error';
  }

  @override
  String get everythingReady => 'Dena prest!';

  @override
  String get extremeOffensive => 'Izugarri iraingarria';

  @override
  String get fileName => 'Fitxategiaren izena';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Letraren tamaina';

  @override
  String get forward => 'Berbidali';

  @override
  String get fromJoining => 'sartzeaz';

  @override
  String get fromTheInvitation => 'gonbidapenaz';

  @override
  String get goToTheNewRoom => 'Joan gela berrira';

  @override
  String get group => 'Taldea';

  @override
  String get groupDescription => 'Taldearen deskribapena';

  @override
  String get groupDescriptionHasBeenChanged =>
      'Taldearen deskribapena aldatu da';

  @override
  String get groupIsPublic => 'Taldea publikoa da';

  @override
  String groupWith(Object displayname) {
    return '$displayname duen taldea';
  }

  @override
  String get guestsAreForbidden => 'Gonbidatuak debekatuta daude';

  @override
  String get guestsCanJoin => 'Gonbidatuak batu daitezke';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username(e)k $targetName(r)en gonbidapena baliogabetu du';
  }

  @override
  String get help => 'Laguntza';

  @override
  String get hideRedactedEvents => 'Izkutatu ezabatutako gertaerak';

  @override
  String get hideUnknownEvents => 'Izkutatu gertaera ezezagunak';

  @override
  String get howOffensiveIsThisContent =>
      'Zenbaterainoko iraingarria da eduki hau?';

  @override
  String get id => 'IDa';

  @override
  String get identity => 'Nortasuna';

  @override
  String get ignore => 'Ezikusi';

  @override
  String get ignoredUsers => 'Ez ikusia egindako erabiltzaileak';

  @override
  String get ignoreListDescription =>
      'Molestatzen zaituzten erabiltzaileak ezikusi ditzakezu. Ez duzu ezikusitako pertsonen zerrendan daudenen mezurik edota gonbidapenik jasoko.';

  @override
  String get ignoreUsername => 'Ezikusi erabiltzailea';

  @override
  String get iHaveClickedOnLink => 'Estekan sakatu dut';

  @override
  String get incorrectPassphraseOrKey =>
      'Pasaesaldi edo segurtasun gakoa ez da zuzena';

  @override
  String get inoffensive => 'Ez da iraingarria';

  @override
  String get inviteContact => 'Gonbidatu kontaktua';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Gonbidatu kontaktua $groupName(e)ra';
  }

  @override
  String get invited => 'Gonbidatuta';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username(e)k $targetName gonbidatu du';
  }

  @override
  String get invitedUsersOnly => 'Gonbidatutako erabiltzaileak solik';

  @override
  String get inviteForMe => 'Niretzako gonbidapenak';

  @override
  String inviteText(Object username, Object link) {
    return '$username(e)k FluffyChatera gonbidatu zaitu.\n1. Instalatu FluffyChat: https://fluffychat.im\n2. Eman izena edo hasi saioa\n3. Ireki gonbidapen esteka: $link';
  }

  @override
  String get isTyping => 'idazten ari da…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username berriketara batu da';
  }

  @override
  String get joinRoom => 'Batu gelara';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username(e)k $targetName kaleratu du';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username(e)k $targetName kaleratu eta debekua ezarri dio';
  }

  @override
  String get kickFromChat => 'Kaleratu berriketatik';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Azkenekoz aktibo: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Duela denbora luze';

  @override
  String get leave => 'Irten';

  @override
  String get leftTheChat => 'Berriketatik irten da';

  @override
  String get license => 'Lizentzia';

  @override
  String get lightTheme => 'Argia';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Kargatu $count partehartzaile gehiago';
  }

  @override
  String get dehydrate => 'Esportatu saioa eta ezabatu gailua';

  @override
  String get dehydrateWarning =>
      'Ekintza hau ezin da desegin. Egiaztatu babeskopia toki seguruan gorde duzula.';

  @override
  String get dehydrateTor => 'TOR Erabiltzaileak: Esportatu saioa';

  @override
  String get dehydrateTorLong =>
      'TOR erabiltzaileentzat gomendioa leihoa itxi baino lehen saioa esportatzea da.';

  @override
  String get hydrateTor => 'TOR Erabiltzaileak: Inportatu esportatutako saioa';

  @override
  String get hydrateTorLong =>
      'Esportatu al zenuen zure saioa TOR erabili zenuen azken aldian? Inportatu segidan eta jarraitu txateatzen.';

  @override
  String get hydrate => 'Berreskuratu babeskopia bat erabiliz';

  @override
  String get loadingPleaseWait => 'Kargatzen… itxaron.';

  @override
  String get loadMore => 'Kargatu gehiago…';

  @override
  String get locationDisabledNotice =>
      'Kokapen zerbitzuak ez daude gaituta. Gaitu zure kokapena partekatu ahal izateko.';

  @override
  String get locationPermissionDeniedNotice =>
      'Kokapen baimena ukatu da. Eman ezazu zure kokapena partekatzeko baimena.';

  @override
  String get login => 'Hasi saioa';

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
    return 'Hasi saioa $homeserver(e)n';
  }

  @override
  String get loginWithOneClick => 'Hasi saioa klik bakarrarekin';

  @override
  String get logout => 'Amaitu saioa';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Egiaztatu identifikazioa baliozkoa dela';

  @override
  String get memberChanges => 'Kideen aldaketak';

  @override
  String get mention => 'Aipamena';

  @override
  String get messages => 'Mezuak';

  @override
  String get messageWillBeRemovedWarning =>
      'Mezua partehartzaile guztientzat ezabatuko da';

  @override
  String get moderator => 'Moderatzailea';

  @override
  String get muteChat => 'Mututu berriketa';

  @override
  String get needPantalaimonWarning =>
      'Kontuan izan oraingoz Pantalaimon behar duzula puntuz puntuko zifraketarako.';

  @override
  String get newChat => 'Berriketa berria';

  @override
  String get newMessageInFluffyChat => '💬 Mezu berria FluffyChaten';

  @override
  String get newVerificationRequest => 'Egiaztaketa eskaera berria!';

  @override
  String get next => 'Hurrengoa';

  @override
  String get no => 'Ez';

  @override
  String get noConnectionToTheServer => 'Ez dago konexiorik zerbitzariarekin';

  @override
  String get noEmotesFound => 'Ez da emoterik aurkitu. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Zifraketa aktiba dezakezu soilik gela publikoa ez bada.';

  @override
  String get noGoogleServicesWarning =>
      'Dirudienez ez daukazu Googleren zerbitzurik zure mugikorrean. Primerako erabakia zure pribatutasunerako! FluffyChaten jakinarazpenak jasotzeko https://microg.org/ edo https://unifiedpush.org/ erabiltzea gomendatzen dugu.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 ez da matrix zerbitzari bat, $server2 erabili nahi duzu haren ordez?';
  }

  @override
  String get shareYourInviteLink => 'Partekatu gonbidapen esteka';

  @override
  String get scanQrCode => 'Eskaneatu QR kodea';

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
  String get none => 'Bat ere ez';

  @override
  String get noPasswordRecoveryDescription =>
      'Oraindik ez duzu pasahitza berreskuratzeko modurik gehitu.';

  @override
  String get noPermission => 'Baimenik ez';

  @override
  String get noRoomsFound => 'Ez da gelarik aurkitu…';

  @override
  String get notifications => 'Jakinarazpenak';

  @override
  String get notificationsEnabledForThisAccount =>
      'Kontu honentzat gaitutako jakinarazpenak';

  @override
  String numUsersTyping(Object count) {
    return '$count erabiltzaile idazten ari dira…';
  }

  @override
  String get obtainingLocation => 'Kokapena atzitzen…';

  @override
  String get offensive => 'Iraingarria';

  @override
  String get offline => 'Lineaz kanpo';

  @override
  String get ok => 'Ados';

  @override
  String get online => 'Linean';

  @override
  String get onlineKeyBackupEnabled => 'Gakoen online babeskopia gaituta dago';

  @override
  String get oopsPushError =>
      'Hara! Zoritxarrez, errore bat gertatu da jakinarazpenak ezartzerakoan.';

  @override
  String get oopsSomethingWentWrong => 'Hara, zerbaitek huts egin du…';

  @override
  String get openAppToReadMessages => 'Ireki aplikazioa mezuak irakurtzeko';

  @override
  String get openCamera => 'Ireki kamera';

  @override
  String get openVideoCamera => 'Ireki kamera bideorako';

  @override
  String get oneClientLoggedOut => 'Zure gailuetako batek saioa itxi du';

  @override
  String get addAccount => 'Gehitu kontua';

  @override
  String get editBundlesForAccount => 'Moldatu kontu honetarako sortak';

  @override
  String get addToBundle => 'Gehitu sortara';

  @override
  String get removeFromBundle => 'Kendu sorta honetatik';

  @override
  String get bundleName => 'Sortaren izena';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Gaitu kontu bat baino gehiago gailu honetan';

  @override
  String get openInMaps => 'Ireki mapen aplikazioan';

  @override
  String get link => 'Esteka';

  @override
  String get serverRequiresEmail =>
      'Zerbitzari honek zure posta elektronikoa egiaztatu behar du izena eman dezazun.';

  @override
  String get optionalGroupName => '(Hautazkoa) Taldearen izena';

  @override
  String get or => 'Edo';

  @override
  String get participant => 'Partehartzailea';

  @override
  String get passphraseOrKey => 'pasaesaldia edo berreskuratzeko gakoa';

  @override
  String get password => 'Pasahitza';

  @override
  String get passwordForgotten => 'Ahaztu zait pasahitza';

  @override
  String get passwordHasBeenChanged => 'Pasahitza aldatu da';

  @override
  String get passwordRecovery => 'Pasahitzaren berreskurapena';

  @override
  String get pickImage => 'Aukeratu irudi bat';

  @override
  String get pin => 'Iltzatu';

  @override
  String play(Object fileName) {
    return 'Abiarazi $fileName';
  }

  @override
  String get pleaseChoose => 'Aukeratu';

  @override
  String get pleaseChooseAPasscode => 'Aukeratu kode bat';

  @override
  String get pleaseChooseAUsername => 'Aukeratu erabiltzaile-izen bat';

  @override
  String get pleaseClickOnLink =>
      'Sakatu epostako estekan eta ondoren jarraitu.';

  @override
  String get pleaseEnter4Digits =>
      'Sartu lau zenbaki edo utzi hutsik aplikazioa babestu nahi ez baduzu.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Sartu Matrix ID bat.';

  @override
  String get pleaseEnterRecoveryKey => 'Idatzi berreskuratze-gakoa:';

  @override
  String get pleaseEnterYourPassword => 'Sartu zure pasahitza';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Sartu zure zenbakia';

  @override
  String get pleaseEnterYourUsername => 'Sartu zure erabiltzaile-izena';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Jarrai itzazu webguneko argibideak eta sakatu \'Hurrengoa\'.';

  @override
  String get privacy => 'Pribatutasuna';

  @override
  String get publicRooms => 'Gela publikoak';

  @override
  String get pushRules => 'Push arauak';

  @override
  String get reason => 'Zergatia';

  @override
  String get recording => 'Grabatzen';

  @override
  String redactedAnEvent(Object username) {
    return '$username(e)k gertaera bat izkutatu du';
  }

  @override
  String get redactMessage => 'Izkutatu mezua';

  @override
  String get reject => 'Baztertu';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username(e)k gonbidapena baztertu du';
  }

  @override
  String get rejoin => 'Batu berriro';

  @override
  String get remove => 'Kendu';

  @override
  String get removeAllOtherDevices => 'Kendu gainerako gailu guztiak';

  @override
  String removedBy(Object username) {
    return '$username(e)k kendu du';
  }

  @override
  String get removeDevice => 'Kendu gailua';

  @override
  String get unbanFromChat => 'Baimendu berriketan';

  @override
  String get removeYourAvatar => 'Kendu zure abatarra';

  @override
  String get renderRichContent => 'Kargatu mezu aberatseko edukia';

  @override
  String get replaceRoomWithNewerVersion =>
      'Ordezkatu gela bertsio berriago batekin';

  @override
  String get reply => 'Erantzun';

  @override
  String get reportMessage => 'Salatu mezua';

  @override
  String get requestPermission => 'Eskatu baimena';

  @override
  String get roomHasBeenUpgraded => 'Gela bertsio-berritu da';

  @override
  String get roomVersion => 'Gelaren bertsioa';

  @override
  String get saveFile => 'Gorde fitxategia';

  @override
  String get search => 'Bilatu';

  @override
  String get security => 'Segurtasuna';

  @override
  String get recoveryKey => 'Berreskuratze-gakoa';

  @override
  String get recoveryKeyLost => 'Berreskuratze-gakoa galdu al duzu?';

  @override
  String seenByUser(Object username) {
    return '$username(e)k ikusi du';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return '$username eta beste $count pertsonak ikusi dute';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return '$username(e)k eta $username2(e)k ikusi dute';
  }

  @override
  String get send => 'Bidali';

  @override
  String get sendAMessage => 'Bidali mezua';

  @override
  String get sendAsText => 'Bidali testu bezala';

  @override
  String get sendAudio => 'Bidali audioa';

  @override
  String get sendFile => 'Bidali fitxategia';

  @override
  String get sendImage => 'Bidali irudia';

  @override
  String get sendMessages => 'Bidali mezuak';

  @override
  String get sendOriginal => 'Bidali jatorrizkoa';

  @override
  String get sendSticker => 'Bidali stickerra';

  @override
  String get sendVideo => 'Bidali bideoa';

  @override
  String sentAFile(Object username) {
    return '📁 $username(e)k fitxategia bidali du';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username(e)k audioa bidali du';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username(e)k irudia bidali du';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username(e)k stickerra bidali du';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username(e)k bideoa bidali du';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName(e)k deiaren informazioa bidali du';
  }

  @override
  String get separateChatTypes => 'Bereizi zuzeneko mezuak eta taldeak';

  @override
  String get setAsCanonicalAlias => 'Ezarri goitizen nagusi bezala';

  @override
  String get setCustomEmotes => 'Ezarri neurrira egindako emoteak';

  @override
  String get setGroupDescription => 'Ezarri taldeko deskribapena';

  @override
  String get setInvitationLink => 'Ezarri gonbidapen esteka';

  @override
  String get setPermissionsLevel => 'Ezarri baimen maila';

  @override
  String get setStatus => 'Ezarri egoera';

  @override
  String get settings => 'Ezarpenak';

  @override
  String get share => 'Partekatu';

  @override
  String sharedTheLocation(Object username) {
    return '$username(e)k kokapena partekatu du';
  }

  @override
  String get shareLocation => 'Partekatu kokapena';

  @override
  String get showDirectChatsInSpaces =>
      'Erakutsi zerikusia duten Mezu Zuzenak guneetan';

  @override
  String get showPassword => 'Erakutsi pasahitza';

  @override
  String get signUp => 'Eman izena';

  @override
  String get singlesignon => 'Single Sign on';

  @override
  String get skip => 'Saltatu';

  @override
  String get sourceCode => 'Iturburu kodea';

  @override
  String get spaceIsPublic => 'Gunea publikoa da';

  @override
  String get spaceName => 'Gunearen izena';

  @override
  String startedACall(Object senderName) {
    return '$senderName(e)k deia hasi du';
  }

  @override
  String get startFirstChat => 'Hasi zure lehen txata';

  @override
  String get status => 'Egoera';

  @override
  String get statusExampleMessage => 'Zer moduz zaude gaur?';

  @override
  String get submit => 'Bidali';

  @override
  String get synchronizingPleaseWait => 'Sinkronizatzen… itxaron.';

  @override
  String get systemTheme => 'Sistemak darabilena';

  @override
  String get theyDontMatch => 'Ez datoz bat';

  @override
  String get theyMatch => 'Bat datoz';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Ikusi / Ezkutatu gogokoak';

  @override
  String get toggleMuted => 'Ikusi / Ezkutatu mutututakoak';

  @override
  String get toggleUnread => 'Markatu irakurrita / irakurri gabe gisa';

  @override
  String get tooManyRequestsWarning =>
      'Eskaera gehiegi. Saiatu berriro geroago!';

  @override
  String get transferFromAnotherDevice => 'Beste gailu batetik transferitu';

  @override
  String get tryToSendAgain => 'Saiatu berriro bidaltzen';

  @override
  String get unavailable => 'Ez dago eskuragai';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username(e)k $targetName baimendu du';
  }

  @override
  String get unblockDevice => 'Desblokeatu gailua';

  @override
  String get unknownDevice => 'Gailu ezezaguna';

  @override
  String get unknownEncryptionAlgorithm => 'Zifraketa-algoritmo ezezaguna';

  @override
  String get unmuteChat => 'Utzi txata mututzeari';

  @override
  String get unpin => 'Kendu iltzea';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount txat irakurri gabe',
      one: 'irakurri gabeko txat 1',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username eta beste $count idazten ari dira…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username eta $username2 idazten ari dira…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username idazten ari da…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username berriketatik irten da';
  }

  @override
  String get username => 'Erabiltzaile-izena';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username(e)k $type gertaera bat bidali du';
  }

  @override
  String get unverified => 'Egiaztatu gabe';

  @override
  String get verified => 'Egiaztatuta';

  @override
  String get verify => 'Egiaztatu';

  @override
  String get verifyStart => 'Abiarazi egiaztaketa';

  @override
  String get verifySuccess => 'Ondo egiaztatu duzu!';

  @override
  String get verifyTitle => 'Beste kontua egiaztatzen';

  @override
  String get videoCall => 'Bideo-deia';

  @override
  String get visibilityOfTheChatHistory =>
      'Berriketa-historiaren ikusgarritasuna';

  @override
  String get visibleForAllParticipants => 'Partehartzaile guztientzat ikusgai';

  @override
  String get visibleForEveryone => 'Edonorentzat ikusgai';

  @override
  String get voiceMessage => 'Ahozko mezua';

  @override
  String get waitingPartnerAcceptRequest =>
      'Bikotearen zain eskaera onartu dezan…';

  @override
  String get waitingPartnerEmoji => 'Bikotearen zain emojia onartu dezan…';

  @override
  String get waitingPartnerNumbers =>
      'Bikotearen zain zenbakiak onartu ditzan…';

  @override
  String get wallpaper => 'Horma-irudia';

  @override
  String get warning => 'Kontuz!';

  @override
  String get weSentYouAnEmail => 'ePosta bat bidali dizugu';

  @override
  String get whoCanPerformWhichAction => 'Nork egin dezakeen zer';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Nork duen baimena talde honetara batzeko';

  @override
  String get whyDoYouWantToReportThis => 'Zergatik salatu nahi duzu?';

  @override
  String get wipeChatBackup =>
      'Ezabatu txataren babeskopia berreskuratze-gako berria sortzeko?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Helbide hauekin pasahitza berreskuratu dezakezu.';

  @override
  String get writeAMessage => 'Idatzi mezua…';

  @override
  String get yes => 'Bai';

  @override
  String get you => 'Zeu';

  @override
  String get youAreInvitedToThisChat => 'Berriketa honetara gonbidatu zaituzte';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Ez duzu berriketa honetan parte hartzen honezkero';

  @override
  String get youCannotInviteYourself => 'Ezin duzu zure burua gonbidatu';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Berriketa honetan debekatu zaituzte';

  @override
  String get yourPublicKey => 'Zure gako publikoa';

  @override
  String get messageInfo => 'Mezuaren xehetasunak';

  @override
  String get time => 'Ordua';

  @override
  String get messageType => 'Mezu mota';

  @override
  String get sender => 'Igorlea';

  @override
  String get openGallery => 'Ireki galeria';

  @override
  String get removeFromSpace => 'Kendu gunetik';

  @override
  String get addToSpaceDescription =>
      'Aukeratu gune bat berriketa hau gehitzeko.';

  @override
  String get start => 'Hasi';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Mezu zaharrak ikusi ahal izateko, sartu aurreko saioan sortu zen berreskuratze-gakoa. Berreskuratze-gakoa EZ da zure pasahitza.';

  @override
  String get addToStory => 'Gehitu storyra';

  @override
  String get publish => 'Argitaratu';

  @override
  String get whoCanSeeMyStories => 'Nork ikus ditzazke nire storyak?';

  @override
  String get unsubscribeStories => 'Storyak jasotzeari utzi';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Erabiltzaile honek oraindik ez du ezer argitaratu bere storyetan';

  @override
  String get yourStory => 'Zure storya';

  @override
  String get replyHasBeenSent => 'Erantzuna bidali da';

  @override
  String videoWithSize(Object size) {
    return 'Bideoa ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return '${date}ko storya:\n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Kontuan izan jendeak bata bestea ikusi eta harremanetan jar daitekeela zure storyan.';

  @override
  String get whatIsGoingOn => 'Zertan zabiltza?';

  @override
  String get addDescription => 'Gehitu deskribapena';

  @override
  String get storyPrivacyWarning =>
      'Kontuan izan jendeak bata bestea ikus dezakeela eta bata bestearekin harremanetan jar daitekeela. Zure storya 24 orduz egongo da ikusgai baina ezin da ziurtatu gailu eta zerbitzari guztietatik ezabatuko denik denbora pasatakoan.';

  @override
  String get iUnderstand => 'Ulertzen dut';

  @override
  String get openChat => 'Ireki berriketa';

  @override
  String get markAsRead => 'Markatu irakurrita gisa';

  @override
  String get reportUser => 'Salatu erabiltzailea';

  @override
  String get dismiss => 'Baztertu';

  @override
  String get matrixWidgets => 'Matrixen widgetak';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender(e)k $reaction(r)ekin erreakzionatu du';
  }

  @override
  String get pinMessage => 'Iltzatu gelan';

  @override
  String get confirmEventUnpin =>
      'Ziur zaude gertaerari iltzea kendu nahi diozula?';

  @override
  String get emojis => 'Emojiak';

  @override
  String get placeCall => 'Egin deia';

  @override
  String get voiceCall => 'Ahozko deia';

  @override
  String get unsupportedAndroidVersion => 'Android bertsioa ez da bateragarria';

  @override
  String get unsupportedAndroidVersionLong =>
      'Funtzio honek Android bertsio berriago bat behar du. Egiaztatu eguneraketak ote dauden edo begiratu Lineage OS-ek zure gailuarentzat aukerarik eskaintzen duen.';

  @override
  String get videoCallsBetaWarning =>
      'Kontuan izan bideo deiak beta fasean daudela. Litekeena da behar bezala erabili ezin izatea —erabili ahal badira—.';

  @override
  String get experimentalVideoCalls => 'Bideo-dei esperimentalak';

  @override
  String get emailOrUsername => 'ePosta edo erabiltzaile-izena';

  @override
  String get indexedDbErrorTitle => 'Modu pribatuaren arazoak';

  @override
  String get indexedDbErrorLong =>
      'Mezuen artxibatzea ez dago defektuz gaituta modu pribatua erabiltzean.\nGaitzeko:\n - about:config\n - dom.indexedDB.privateBrowsing.enabled aukerak true erakutsi dezala\nBestela ezin da FluffyChat erabili.';

  @override
  String switchToAccount(Object number) {
    return 'Aldatu $number kontura';
  }

  @override
  String get nextAccount => 'Hurrengo kontua';

  @override
  String get previousAccount => 'Aurreko kontua';

  @override
  String get editWidgets => 'Editatu widgetak';

  @override
  String get addWidget => 'Gehitu widgeta';

  @override
  String get widgetVideo => 'Bideoa';

  @override
  String get widgetEtherpad => 'Testu-oharra';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Neurrira egindakoa';

  @override
  String get widgetName => 'Izena';

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
  String get widgetUrlError => 'Ez da baliozko URL bat.';

  @override
  String get widgetNameError => 'Zehaztu goitizen bat.';

  @override
  String get errorAddingWidget => 'Errorea widgeta gehitzerakoan.';

  @override
  String get youRejectedTheInvitation => 'Gonbidapena baztertu duzu';

  @override
  String get youJoinedTheChat => 'Berriketara batu zara';

  @override
  String get youAcceptedTheInvitation => '👍 Gonbidapena onartu duzu';

  @override
  String youBannedUser(Object user) {
    return '$user(r)i debekua ezarri diozu';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return '$user(r)i luzatutako gonbidapena baliogabetu duzu';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 $user(e)k gonbidatu zaitu';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 $user gonbidatu duzu';
  }

  @override
  String youKicked(Object user) {
    return '👞 $user kanporatu duzu';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 $user kanporatu eta debekua ezarri diozu';
  }

  @override
  String youUnbannedUser(Object user) {
    return '$user(r)i debekua kendu diozu';
  }

  @override
  String get noEmailWarning =>
      'Sartu baliozko posta helbide bat. Bestela ezingo duzu pasahitza berrezarri. Hala ere nahi ez baduzu, sakatu berriro botoia aurrera egiteko.';

  @override
  String get stories => 'Storyak';

  @override
  String get users => 'Erabiltzaileak';

  @override
  String get unlockOldMessages => 'Desblokeatu mezu zaharrak';

  @override
  String get storeInSecureStorageDescription =>
      'Gorde berreskuratze-gakoa gailu honetako biltegiratze seguruan.';

  @override
  String get saveKeyManuallyDescription =>
      'Gorde eskuz gako hau gailuko partekatze-menua edo arbela erabiliz.';

  @override
  String get storeInAndroidKeystore => 'Gorde Android KeyStore-n';

  @override
  String get storeInAppleKeyChain => 'Gorde Apple KeyChain-en';

  @override
  String get storeSecurlyOnThisDevice => 'Gorde gailu honetan modu seguruan';

  @override
  String countFiles(Object count) {
    return '$count fitxategi';
  }

  @override
  String get user => 'Erabiltzailea';

  @override
  String get custom => 'Neurrira egindakoa';

  @override
  String get foregroundServiceRunning =>
      'Jakinarazpen hau zerbitzua martxan dagoenean agertzen da.';

  @override
  String get screenSharingTitle => 'pantaila partekatzen';

  @override
  String get screenSharingDetail =>
      'Pantaila FluffyChaten partekatzen ari zara';

  @override
  String get callingPermissions => 'Deiak egiteko baimenak';

  @override
  String get callingAccount => 'Deia egiteko kontua';

  @override
  String get callingAccountDetails =>
      'Baimendu FluffyCaht Android gailuko telefono markagailua erabiltzea.';

  @override
  String get appearOnTop => 'Gainean erakutsi';

  @override
  String get appearOnTopDetails =>
      'Aplikazioa goikaldean agertzea baimentzen du (ez da beharrezkoa FluffyChat dei egiteko kontua bezala ezarri baduzu)';

  @override
  String get otherCallingPermissions =>
      'Mikrofono, kamera eta FluffyChaten beste baimen batzuk';

  @override
  String get whyIsThisMessageEncrypted => 'Zergatik ezin da mezu hau irakurri?';

  @override
  String get noKeyForThisMessage =>
      'Mezua gailu honetan saioa hasi baino lehen bidali bazen gertatu daiteke.\n\nBeste aukera bat igorleak zure gailua blokeatu izana da, edo zerbaitek huts egin izana interneteko konexioan.\n\nMezua beste saio batean irakur dezakezu? Hala bada, mezua transferitu dezakezu! Zoaz Ezrpenetara > Gailuak eta baieztatu zure gailuek bata bestea egiaztatu dutela. Gela irakiko duzun hurrengo aldian eta bi saioak aurreko planoan irekita daudenean, gakoak automatikoki partekatuko dira.\n\nEz duzu gakorik galdu nahi saioa amaitu edo gailuak aldatzen dituzunean? Baieztatu ezarpenetan berriketen babeskopiak gaituta dituzula.';

  @override
  String get newGroup => 'Talde berria';

  @override
  String get newSpace => 'Gune berria';

  @override
  String get enterSpace => 'Batu gunera';

  @override
  String get enterRoom => 'Batu gelara';

  @override
  String get allSpaces => 'Gune guztiak';

  @override
  String numChats(Object number) {
    return '$number berriketa';
  }

  @override
  String get hideUnimportantStateEvents =>
      'Izkutatu garrantzirik gabeko gertaerak';

  @override
  String get doNotShowAgain => 'Ez erakutsi berriro';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Txata hutsik dago ($oldDisplayName zen lehen)';
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
      'Guneek txatak taldekatzea ahalbidetzen dute eta komunitate pribatu edo publikoak osatzea.';

  @override
  String get encryptThisChat => 'Zifratu txata';

  @override
  String get endToEndEncryption => 'Puntuz puntuko zifraketa';

  @override
  String get disableEncryptionWarning =>
      'Segurtasun arrazoiak direla-eta, ezin duzu lehendik zifratuta zegoen txat bateko zifraketa ezgaitu.';

  @override
  String get sorryThatsNotPossible => 'Barka… hori ez da posible';

  @override
  String get deviceKeys => 'Gailuaren gakoak:';

  @override
  String get letsStart => 'Has gaitezen';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Sartu gonbidapen-esteka edo Matrix IDa…';

  @override
  String get reopenChat => 'Ireki txata berriro';

  @override
  String get noBackupWarning =>
      'Adi! Txataren babeskopia gaitzen ez baduzu, ezingo dituzu zifratutako txatak atzitu. Oso gomendagarria da txaten babeskopia gaitzea saioa amaitu baino lehen.';

  @override
  String get noOtherDevicesFound => 'Ez da beste gailurik aurkitu';

  @override
  String get fileIsTooBigForServer =>
      'Zerbitzariak dio fitxategia handiegia dela bidali ahal izateko.';

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
