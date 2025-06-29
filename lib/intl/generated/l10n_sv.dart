// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class L10nSv extends L10n {
  L10nSv([String locale = 'sv']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Registrera';

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
  String get passwordsDoNotMatch => 'Lösenorden stämmer inte överens!';

  @override
  String get pleaseEnterValidEmail => 'Vänligen ange en giltig e-postadress.';

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
  String get people => 'Människor';

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
  String get groups => 'Grupper';

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
  String get repeatPassword => 'Upprepa lösenord';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Vänligen ange minst $min tecken.';
  }

  @override
  String get about => 'Om';

  @override
  String get updateAvailable => 'FluffyChat-uppdatering tillgänglig';

  @override
  String get updateNow => 'Påbörja uppdatering i bakgrunden';

  @override
  String get accept => 'Acceptera';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username accepterade inbjudan';
  }

  @override
  String get account => 'Konto';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username aktiverade ändpunktskryptering';
  }

  @override
  String get addEmail => 'Lägg till e-post';

  @override
  String get confirmMatrixId =>
      'Bekräfta ditt Matrix-ID för att radera ditt konto.';

  @override
  String supposedMxid(Object mxid) {
    return 'Detta bör vara $mxid';
  }

  @override
  String get addGroupDescription => 'Lägg till en gruppbeskrivning';

  @override
  String get addToSpace => 'Lägg till i utrymme';

  @override
  String get admin => 'Admin';

  @override
  String get alias => 'alias';

  @override
  String get all => 'Alla';

  @override
  String get allChats => 'Alla chattar';

  @override
  String get commandHint_googly => 'Skicka några googly ögon';

  @override
  String get commandHint_cuddle => 'Skicka en omfamning';

  @override
  String get commandHint_hug => 'Skicka en kram';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName skickar dig googly ögon';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName omfamnar dig';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName kramar dig';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '$senderName besvarade samtalet';
  }

  @override
  String get anyoneCanJoin => 'Vem som helst kan gå med';

  @override
  String get appLock => 'App-lås';

  @override
  String get archive => 'Arkiv';

  @override
  String get areGuestsAllowedToJoin => 'Får gästanvändare gå med';

  @override
  String get areYouSure => 'Är du säker?';

  @override
  String get areYouSureYouWantToLogout =>
      'Är du säker på att du vill logga ut?';

  @override
  String get askSSSSSign =>
      'För att kunna signera den andra personen, vänligen ange din lösenfras eller återställningsnyckel för säker lagring.';

  @override
  String askVerificationRequest(Object username) {
    return 'Acceptera denna verifikationsförfrågan från $username?';
  }

  @override
  String get autoplayImages =>
      'Automatisk spela upp animerade klistermärken och emoji';

  @override
  String get sendOnEnter => 'Skicka med Enter';

  @override
  String get banFromChat => 'Bannlys från chatt';

  @override
  String get banned => 'Bannlyst';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username bannlös $targetName';
  }

  @override
  String get blockDevice => 'Blockera Enhet';

  @override
  String get blocked => 'Blockerad';

  @override
  String get botMessages => 'Bot meddelanden';

  @override
  String get bubbleSize => 'Storlek på bubbla';

  @override
  String get cancel => 'Avbryt';

  @override
  String cantOpenUri(Object uri) {
    return 'Kan inte öppna URL $uri';
  }

  @override
  String get changeDeviceName => 'Ändra enhetsnamn';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username ändrade sin chatt-avatar';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username ändrade chatt-beskrivningen till: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username ändrade sitt chatt-namn till: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username ändrade chatt-rättigheterna';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username ändrade visningsnamnet till: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username ändrade reglerna för gästaccess';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username ändrade reglerna för gästaccess till: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username ändrade historikens synlighet';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username ändrade historikens synlighet till: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username ändrade anslutningsreglerna';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username ändrade anslutningsreglerna till $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username ändrade sin avatar';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username ändrade rummets alias';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username ändrade inbjudningslänken';
  }

  @override
  String get changePassword => 'Ändra lösenord';

  @override
  String get changeTheHomeserver => 'Ändra hemserver';

  @override
  String get changeTheme => 'Ändra din stil';

  @override
  String get changeTheNameOfTheGroup => 'Ändra namn på gruppen';

  @override
  String get changeWallpaper => 'Ändra bakgrund';

  @override
  String get changeYourAvatar => 'Ändra din avatar';

  @override
  String get channelCorruptedDecryptError => 'Krypteringen har blivit korrupt';

  @override
  String get chat => 'Chatt';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'Din chatt-backup har konfigurerats.';

  @override
  String get chatBackup => 'Chatt backup';

  @override
  String get chatBackupDescription =>
      'Din chatt backup är skyddad av en säkerhetsnyckel. Se till att du inte förlorar den.';

  @override
  String get chatDetails => 'Chatt-detaljer';

  @override
  String get chatHasBeenAddedToThisSpace =>
      'Chatt har lagts till i detta utrymme';

  @override
  String get chats => 'Chatter';

  @override
  String get chooseAStrongPassword => 'Välj ett starkt lösenord';

  @override
  String get chooseAUsername => 'Välj ett användarnamn';

  @override
  String get clearArchive => 'Rensa arkiv';

  @override
  String get close => 'Stäng';

  @override
  String get commandHint_markasdm => 'Märk som rum för direktmeddelanden';

  @override
  String get commandHint_markasgroup => 'Märk som grupp';

  @override
  String get commandHint_ban => 'Bannlys användaren från detta rum';

  @override
  String get commandHint_clearcache => 'Rensa cache';

  @override
  String get commandHint_create =>
      'Skapa en tom grupp-chatt\nAnvänd --no-encryption för att inaktivera kryptering';

  @override
  String get commandHint_discardsession => 'Kasta bort sessionen';

  @override
  String get commandHint_dm =>
      'Starta en direkt-chatt\nAnvänd --no-encryption för att inaktivera kryptering';

  @override
  String get commandHint_html => 'Skicka HTML-formatted text';

  @override
  String get commandHint_invite => 'Bjud in användaren till detta rum';

  @override
  String get commandHint_join => 'Gå med i rum';

  @override
  String get commandHint_kick => 'Ta bort användare från detta rum';

  @override
  String get commandHint_leave => 'Lämna detta rum';

  @override
  String get commandHint_me => 'Beskriv dig själv';

  @override
  String get commandHint_myroomavatar =>
      'Sätt din bild för detta rum (by mxc-uri)';

  @override
  String get commandHint_myroomnick => 'Sätt ditt användarnamn för rummet';

  @override
  String get commandHint_op => 'Sätt användarens kraft nivå ( standard: 50)';

  @override
  String get commandHint_plain => 'Skicka oformaterad text';

  @override
  String get commandHint_react => 'Skicka svar som reaktion';

  @override
  String get commandHint_send => 'Skicka text';

  @override
  String get commandHint_unban => 'Tillåt användare i rummet';

  @override
  String get commandInvalid => 'Felaktigt kommando';

  @override
  String commandMissing(Object command) {
    return '$command är inte ett kommando.';
  }

  @override
  String get compareEmojiMatch => 'Vänligen jämför uttryckssymbolerna';

  @override
  String get compareNumbersMatch => 'Vänligen jämför siffrorna';

  @override
  String get configureChat => 'Konfigurera chatt';

  @override
  String get confirm => 'Bekräfta';

  @override
  String get connect => 'Anslut';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Kontakten har blivit inbjuden till gruppen';

  @override
  String get containsDisplayName => 'Innehåller visningsnamn';

  @override
  String get containsUserName => 'Innehåller användarnamn';

  @override
  String get contentHasBeenReported =>
      'Innehållet har rapporterats till server-admins';

  @override
  String get copiedToClipboard => 'Kopierat till urklipp';

  @override
  String get copy => 'Kopiera';

  @override
  String get copyToClipboard => 'Kopiera till urklipp';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Kunde ej avkoda meddelande: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count deltagare';
  }

  @override
  String get create => 'Skapa';

  @override
  String createdTheChat(Object username) {
    return '💬 $username skapade chatten';
  }

  @override
  String get createNewGroup => 'Skapa ny grupp';

  @override
  String get createNewSpace => 'Nytt utrymme';

  @override
  String get currentlyActive => 'För närvarande aktiv';

  @override
  String get darkTheme => 'Mörkt';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$day-$month';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$year-$month-$day';
  }

  @override
  String get deactivateAccountWarning =>
      'Detta kommer att avaktivera ditt konto. Det här går inte att ångra! Är du säker?';

  @override
  String get defaultPermissionLevel => 'Standard behörighetsnivå';

  @override
  String get delete => 'Radera';

  @override
  String get deleteAccount => 'Ta bort konto';

  @override
  String get deleteMessage => 'Ta bort meddelande';

  @override
  String get deny => 'Neka';

  @override
  String get device => 'Enhet';

  @override
  String get deviceId => 'Enhets-ID';

  @override
  String get devices => 'Enheter';

  @override
  String get directChats => 'Direkt Chatt';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Visningsnamn har ändrats';

  @override
  String get downloadFile => 'Ladda ner fil';

  @override
  String get edit => 'Ändra';

  @override
  String get editBlockedServers => 'redigera blockerade servrar';

  @override
  String get editChatPermissions => 'Ändra chatt-rättigheter';

  @override
  String get editDisplayname => 'Ändra visningsnamn';

  @override
  String get editRoomAliases => 'Redigera rum alias';

  @override
  String get editRoomAvatar => 'redigera rumsavatar';

  @override
  String get emoteExists => 'Dekalen existerar redan!';

  @override
  String get emoteInvalid => 'Ogiltig dekal-kod!';

  @override
  String get emotePacks => 'Dekalpaket för rummet';

  @override
  String get emoteSettings => 'Emote inställningar';

  @override
  String get emoteShortcode => 'Dekal kod';

  @override
  String get emoteWarnNeedToPick => 'Du måste välja en dekal-kod och en bild!';

  @override
  String get emptyChat => 'Tom chatt';

  @override
  String get enableEmotesGlobally => 'Aktivera dekal-paket globalt';

  @override
  String get enableEncryption => 'Aktivera kryptering';

  @override
  String get enableEncryptionWarning =>
      'Du kommer inte ha fortsatt möjlighet till att inaktivera krypteringen. Är du säker?';

  @override
  String get encrypted => 'Krypterad';

  @override
  String get encryption => 'Kryptering';

  @override
  String get encryptionNotEnabled => 'Kryptering är ej aktiverad';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName avslutade samtalet';
  }

  @override
  String get enterAGroupName => 'Ange ett gruppnamn';

  @override
  String get enterAnEmailAddress => 'Ange en e-postaddress';

  @override
  String get enterASpacepName => 'Ange utrymmets namn';

  @override
  String get homeserver => 'Hemserver';

  @override
  String get enterYourHomeserver => 'Ange din hemserver';

  @override
  String errorObtainingLocation(Object error) {
    return 'Fel vid erhållande av plats: $error';
  }

  @override
  String get everythingReady => 'Allt är klart!';

  @override
  String get extremeOffensive => 'Extremt stötande';

  @override
  String get fileName => 'Filnamn';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Teckensnitt storlek';

  @override
  String get forward => 'Framåt';

  @override
  String get fromJoining => 'Från att gå med';

  @override
  String get fromTheInvitation => 'Från inbjudan';

  @override
  String get goToTheNewRoom => 'Gå till det nya rummet';

  @override
  String get group => 'Grupp';

  @override
  String get groupDescription => 'Gruppbeskrivning';

  @override
  String get groupDescriptionHasBeenChanged => 'Gruppbeskrivningen ändrad';

  @override
  String get groupIsPublic => 'Gruppen är publik';

  @override
  String groupWith(Object displayname) {
    return 'Gruppen med $displayname';
  }

  @override
  String get guestsAreForbidden => 'Gäster är förbjudna';

  @override
  String get guestsCanJoin => 'Gäster kan ansluta';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username har tagit tillbaka inbjudan för $targetName';
  }

  @override
  String get help => 'Hjälp';

  @override
  String get hideRedactedEvents => 'Göm redigerade händelser';

  @override
  String get hideUnknownEvents => 'Göm okända händelser';

  @override
  String get howOffensiveIsThisContent => 'Hur stötande är detta innehåll?';

  @override
  String get id => 'ID';

  @override
  String get identity => 'Identitet';

  @override
  String get ignore => 'Ignorera';

  @override
  String get ignoredUsers => 'Ignorera användare';

  @override
  String get ignoreListDescription =>
      'Du kan ignorera användare som stör dig. Du kommer inte att ha möjlighet att få några meddelanden eller rums-inbjudningar från användare på din personliga ignoreringslista.';

  @override
  String get ignoreUsername => 'Ignorera användarnamn';

  @override
  String get iHaveClickedOnLink => 'Jag har klickat på länken';

  @override
  String get incorrectPassphraseOrKey =>
      'Felaktig lösenordsfras eller åsterställningsnyckel';

  @override
  String get inoffensive => 'Oförargligt';

  @override
  String get inviteContact => 'Bjud in kontakt';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Bjud in kontakt till $groupName';
  }

  @override
  String get invited => 'Inbjuden';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username bjöd in $targetName';
  }

  @override
  String get invitedUsersOnly => 'Endast inbjudna användare';

  @override
  String get inviteForMe => 'Inbjudning till mig';

  @override
  String inviteText(Object username, Object link) {
    return '$username bjöd in dig till FluffyChat. \n1. Installera FluffyChat: https://fluffychat.im \n2. Registrera dig eller logga in \n3. Öppna inbjudningslänk: $link';
  }

  @override
  String get isTyping => 'skriver…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username anslöt till chatten';
  }

  @override
  String get joinRoom => 'Anslut till rum';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username sparkade ut $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username sparkade och bannade $targetName';
  }

  @override
  String get kickFromChat => 'Sparka från chatt';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Senast aktiv: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Sågs för längesedan';

  @override
  String get leave => 'Lämna';

  @override
  String get leftTheChat => 'Lämnade chatten';

  @override
  String get license => 'Licens';

  @override
  String get lightTheme => 'Ljust';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Ladda $count mer deltagare';
  }

  @override
  String get dehydrate => 'Exportera sessionen och rensa enheten';

  @override
  String get dehydrateWarning =>
      'Denna åtgärd kan inte ångras. Försäkra dig om att backupen är i säkert förvar.';

  @override
  String get dehydrateTor => 'TOR-användare: Exportera session';

  @override
  String get dehydrateTorLong =>
      'TOR-användare rekommenderas att exportera sessionen innan fönstret stängs.';

  @override
  String get hydrateTor =>
      'TOR-användare: Importera session från tidigare export';

  @override
  String get hydrateTorLong =>
      'Exporterade du sessionen när du senast använde TOR? Importera den enkelt och fortsätt chatta.';

  @override
  String get hydrate => 'Återställ från säkerhetskopia';

  @override
  String get loadingPleaseWait => 'Laddar... Var god vänta.';

  @override
  String get loadMore => 'Ladda mer…';

  @override
  String get locationDisabledNotice =>
      'Platstjänster är inaktiverade. Var god aktivera dom för att kunna dela din plats.';

  @override
  String get locationPermissionDeniedNotice =>
      'Plats åtkomst nekad. Var god godkän detta för att kunna dela din plats.';

  @override
  String get login => 'Logga in';

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
    return 'Logga in till $homeserver';
  }

  @override
  String get loginWithOneClick => 'Logga in med ett klick';

  @override
  String get logout => 'Logga ut';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Se till att identifieraren är giltig';

  @override
  String get memberChanges => 'Medlemsändringar';

  @override
  String get mention => 'Nämn';

  @override
  String get messages => 'Meddelanden';

  @override
  String get messageWillBeRemovedWarning =>
      'Meddelandet kommer tas bort för alla deltagare';

  @override
  String get moderator => 'Moderator';

  @override
  String get muteChat => 'Tysta chatt';

  @override
  String get needPantalaimonWarning =>
      'Var medveten om att du behöver Pantalaimon för att använda ändpunktskryptering tillsvidare.';

  @override
  String get newChat => 'Ny chatt';

  @override
  String get newMessageInFluffyChat => '💬 Nya meddelanden i FluffyChat';

  @override
  String get newVerificationRequest => 'Ny verifikationsbegäran!';

  @override
  String get next => 'Nästa';

  @override
  String get no => 'Nej';

  @override
  String get noConnectionToTheServer => 'Ingen anslutning till servern';

  @override
  String get noEmotesFound => 'Hittade inga dekaler. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Du kan endast aktivera kryptering när rummet inte längre är publikt tillgängligt.';

  @override
  String get noGoogleServicesWarning =>
      'De ser ut som att du inte har google-tjänster på din telefon. Det är ett bra beslut för din integritet! För att få push notifikationer i FluffyChat rekommenderar vi att använda https://microg.org/ eller https://unifiedpush.org/ .';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 är inte en matrix server, använd $server2 istället?';
  }

  @override
  String get shareYourInviteLink => 'Dela din inbjudan';

  @override
  String get scanQrCode => 'Skanna QR-kod';

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
  String get none => 'Ingen';

  @override
  String get noPasswordRecoveryDescription =>
      'Du har inte lagt till något sätt för att återställa ditt lösenord än.';

  @override
  String get noPermission => 'Ingen behörighet';

  @override
  String get noRoomsFound => 'Hittade inga rum…';

  @override
  String get notifications => 'Aviseringar';

  @override
  String get notificationsEnabledForThisAccount =>
      'Notifikationer är påslaget för detta konto';

  @override
  String numUsersTyping(Object count) {
    return '$count användare skriver…';
  }

  @override
  String get obtainingLocation => 'Erhåller plats…';

  @override
  String get offensive => 'Stötande';

  @override
  String get offline => 'Offline';

  @override
  String get ok => 'OK';

  @override
  String get online => 'Online';

  @override
  String get onlineKeyBackupEnabled => 'Online Nyckel-backup är aktiverad';

  @override
  String get oopsPushError =>
      'Oj! Tyvärr uppstod ett fel vid upprättande av push notiser.';

  @override
  String get oopsSomethingWentWrong => 'Hoppsan, något gick fel…';

  @override
  String get openAppToReadMessages => 'Öppna app för att lästa meddelanden';

  @override
  String get openCamera => 'Öppna kamera';

  @override
  String get openVideoCamera => 'Aktivera kamera för video';

  @override
  String get oneClientLoggedOut => 'En av dina klienter har loggats ut';

  @override
  String get addAccount => 'Lägg till konto';

  @override
  String get editBundlesForAccount => 'Lägg till paket för detta konto';

  @override
  String get addToBundle => 'Utöka paket';

  @override
  String get removeFromBundle => 'Ta bort från paket';

  @override
  String get bundleName => 'Paketnamn';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Aktivera multi-konton på denna enhet';

  @override
  String get openInMaps => 'Öppna i karta';

  @override
  String get link => 'Länk';

  @override
  String get serverRequiresEmail =>
      'Servern behöver validera din e-postadress för registrering.';

  @override
  String get optionalGroupName => '(Optional) Gruppnamn';

  @override
  String get or => 'Eller';

  @override
  String get participant => 'Deltagare';

  @override
  String get passphraseOrKey => 'lösenord eller återställningsnyckel';

  @override
  String get password => 'Lösenord';

  @override
  String get passwordForgotten => 'Glömt lösenord';

  @override
  String get passwordHasBeenChanged => 'Lösenordet har ändrats';

  @override
  String get passwordRecovery => 'Återställ lösenord';

  @override
  String get pickImage => 'Välj en bild';

  @override
  String get pin => 'Nåla fast';

  @override
  String play(Object fileName) {
    return 'Spela $fileName';
  }

  @override
  String get pleaseChoose => 'Var god välj';

  @override
  String get pleaseChooseAPasscode => 'Ange ett lösenord';

  @override
  String get pleaseChooseAUsername => 'Välj ett användarnamn';

  @override
  String get pleaseClickOnLink =>
      'Klicka på länken i e-postmeddelandet för att sedan fortsätta.';

  @override
  String get pleaseEnter4Digits =>
      'Ange 4 siffror eller lämna tom för att inaktivera app-lås.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Ange ditt Matrix ID.';

  @override
  String get pleaseEnterRecoveryKey => 'Ange din återställningsnyckel:';

  @override
  String get pleaseEnterYourPassword => 'Ange ditt lösenord';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Ange din pin-kod';

  @override
  String get pleaseEnterYourUsername => 'Ange ditt användarnamn';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Följ instruktionerna på hemsidan och tryck på nästa.';

  @override
  String get privacy => 'Integritet';

  @override
  String get publicRooms => 'Publika Rum';

  @override
  String get pushRules => 'Push regler';

  @override
  String get reason => 'Anledning';

  @override
  String get recording => 'Spelar in';

  @override
  String redactedAnEvent(Object username) {
    return '$username redigerade en händelse';
  }

  @override
  String get redactMessage => 'Redigera meddelande';

  @override
  String get reject => 'Avböj';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username avböjde inbjudan';
  }

  @override
  String get rejoin => 'Återanslut';

  @override
  String get remove => 'Ta bort';

  @override
  String get removeAllOtherDevices => 'Ta bort alla andra enheter';

  @override
  String removedBy(Object username) {
    return 'Bortagen av $username';
  }

  @override
  String get removeDevice => 'Ta bort enhet';

  @override
  String get unbanFromChat => 'Ta bort chatt-blockering';

  @override
  String get removeYourAvatar => 'Ta bort din avatar';

  @override
  String get renderRichContent => 'Återge innehåll med rikt meddelande';

  @override
  String get replaceRoomWithNewerVersion => 'Ersätt rum med nyare version';

  @override
  String get reply => 'Svara';

  @override
  String get reportMessage => 'Rapportera meddelande';

  @override
  String get requestPermission => 'Begär behörighet';

  @override
  String get roomHasBeenUpgraded => 'Rummet har blivit uppgraderat';

  @override
  String get roomVersion => 'Rum version';

  @override
  String get saveFile => 'Spara fil';

  @override
  String get search => 'Sök';

  @override
  String get security => 'Säkerhet';

  @override
  String get recoveryKey => 'Återställningsnyckel';

  @override
  String get recoveryKeyLost => 'Borttappad återställningsnyckel?';

  @override
  String seenByUser(Object username) {
    return 'Sedd av $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Sågs av $username och $count andra';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Sedd av $username och $username2';
  }

  @override
  String get send => 'Skicka';

  @override
  String get sendAMessage => 'Skicka ett meddelande';

  @override
  String get sendAsText => 'Skicka som text';

  @override
  String get sendAudio => 'Skicka ljud';

  @override
  String get sendFile => 'Skicka fil';

  @override
  String get sendImage => 'Skicka bild';

  @override
  String get sendMessages => 'Skickade meddelanden';

  @override
  String get sendOriginal => 'Skicka orginal';

  @override
  String get sendSticker => 'Skicka klistermärke';

  @override
  String get sendVideo => 'Skicka video';

  @override
  String sentAFile(Object username) {
    return '📁 $username skickade en fil';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username skickade ett ljudklipp';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username skickade en bild';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username skickade ett klistermärke';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username skickade en video';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName skickade samtalsinformation';
  }

  @override
  String get separateChatTypes => 'Separata direktchattar och grupper';

  @override
  String get setAsCanonicalAlias => 'Sätt som primärt alias';

  @override
  String get setCustomEmotes => 'Ställ in anpassade dekaler';

  @override
  String get setGroupDescription => 'Ställ in gruppbeskrivning';

  @override
  String get setInvitationLink => 'Ställ in inbjudningslänk';

  @override
  String get setPermissionsLevel => 'Ställ in behörighetsnivå';

  @override
  String get setStatus => 'Ställ in status';

  @override
  String get settings => 'Inställningar';

  @override
  String get share => 'Dela';

  @override
  String sharedTheLocation(Object username) {
    return '$username delade sin position';
  }

  @override
  String get shareLocation => 'Dela plats';

  @override
  String get showDirectChatsInSpaces =>
      'Visa relaterade direktchattar i utrymmen';

  @override
  String get showPassword => 'Visa lösenord';

  @override
  String get signUp => 'Registrera';

  @override
  String get singlesignon => 'Single Sign On';

  @override
  String get skip => 'Hoppa över';

  @override
  String get sourceCode => 'Källkod';

  @override
  String get spaceIsPublic => 'Utrymme är publikt';

  @override
  String get spaceName => 'Utrymmes namn';

  @override
  String startedACall(Object senderName) {
    return '$senderName startade ett samtal';
  }

  @override
  String get startFirstChat => 'Starta din första chatt';

  @override
  String get status => 'Status';

  @override
  String get statusExampleMessage => 'Hur mår du i dag?';

  @override
  String get submit => 'Skicka in';

  @override
  String get synchronizingPleaseWait => 'Synkroniserar… Var god vänta.';

  @override
  String get systemTheme => 'System';

  @override
  String get theyDontMatch => 'Dom Matchar Inte';

  @override
  String get theyMatch => 'Dom Matchar';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Växla favorit';

  @override
  String get toggleMuted => 'Växla tystad';

  @override
  String get toggleUnread => 'Markera läst/oläst';

  @override
  String get tooManyRequestsWarning =>
      'För många förfrågningar. Vänligen försök senare!';

  @override
  String get transferFromAnotherDevice => 'Överför till annan enhet';

  @override
  String get tryToSendAgain => 'Försök att skicka igen';

  @override
  String get unavailable => 'Upptagen';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username avbannade $targetName';
  }

  @override
  String get unblockDevice => 'Avblockera enhet';

  @override
  String get unknownDevice => 'Okänd enhet';

  @override
  String get unknownEncryptionAlgorithm => 'Okänd krypteringsalgoritm';

  @override
  String get unmuteChat => 'Slå på ljudet för chatten';

  @override
  String get unpin => 'Avnåla';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount olästa chattar',
      one: 'en oläst chatt',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username och $count andra skriver…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username och $username2 skriver…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username skriver…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username lämnade chatten';
  }

  @override
  String get username => 'Användarnamn';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username skickade en $type händelse';
  }

  @override
  String get unverified => 'Ej verifierad';

  @override
  String get verified => 'Verifierad';

  @override
  String get verify => 'Verifiera';

  @override
  String get verifyStart => 'Starta verifiering';

  @override
  String get verifySuccess => 'Du har lyckats verifiera!';

  @override
  String get verifyTitle => 'Verifiera andra konton';

  @override
  String get videoCall => 'Videosamtal';

  @override
  String get visibilityOfTheChatHistory => 'Chatt-historikens synlighet';

  @override
  String get visibleForAllParticipants => 'Synlig för alla deltagare';

  @override
  String get visibleForEveryone => 'Synlig för alla';

  @override
  String get voiceMessage => 'Röstmeddelande';

  @override
  String get waitingPartnerAcceptRequest =>
      'Väntar på att deltagaren accepterar begäran…';

  @override
  String get waitingPartnerEmoji =>
      'Väntar på att deltagaren accepterar emojien…';

  @override
  String get waitingPartnerNumbers =>
      'Väntar på att deltagaren accepterar nummer…';

  @override
  String get wallpaper => 'Bakgrund';

  @override
  String get warning => 'Varning!';

  @override
  String get weSentYouAnEmail => 'Vi skickade dig ett e-postmeddelande';

  @override
  String get whoCanPerformWhichAction => 'Vem kan utföra vilken åtgärd';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Vilka som är tilllåtna att ansluta till denna grupp';

  @override
  String get whyDoYouWantToReportThis => 'Varför vill du rapportera detta?';

  @override
  String get wipeChatBackup =>
      'Radera din chatt-backup för att skapa en ny återställningsnyckel?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Med dessa addresser kan du återställa ditt lösenord.';

  @override
  String get writeAMessage => 'Skriv ett meddelande…';

  @override
  String get yes => 'Ja';

  @override
  String get you => 'Du';

  @override
  String get youAreInvitedToThisChat => 'Du är inbjuden till denna chatt';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Du deltar inte längre i denna chatt';

  @override
  String get youCannotInviteYourself => 'Du kan inte bjuda in dig själv';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Du har blivit bannad från denna chatt';

  @override
  String get yourPublicKey => 'Din publika nyckel';

  @override
  String get messageInfo => 'Meddelandeinformation';

  @override
  String get time => 'Tid';

  @override
  String get messageType => 'Meddelandetyp';

  @override
  String get sender => 'Avsändare';

  @override
  String get openGallery => 'Öppna galleri';

  @override
  String get removeFromSpace => 'Ta bort från utrymme';

  @override
  String get addToSpaceDescription =>
      'Välj ett utrymme som chatten skall läggas till i.';

  @override
  String get start => 'Starta';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Ange din återställningsnyckel från en tidigare session för att låsa upp äldre meddelanden. Din återställningsnyckel är INTE ditt lösenord.';

  @override
  String get addToStory => 'Addera till berättelse';

  @override
  String get publish => 'Publicera';

  @override
  String get whoCanSeeMyStories => 'Vem kan se mina berättelser?';

  @override
  String get unsubscribeStories => 'Avprenumerera berättelser';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Den här användaren har inte lagt till något till deras berättelse än';

  @override
  String get yourStory => 'Din berättelse';

  @override
  String get replyHasBeenSent => 'Svar har skickats';

  @override
  String videoWithSize(Object size) {
    return 'Video ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Berättelse från $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Notera att användare kan se och kontakta varandra i din berättelse.';

  @override
  String get whatIsGoingOn => 'Vad händer?';

  @override
  String get addDescription => 'Lägg till beskrivning';

  @override
  String get storyPrivacyWarning =>
      'Notera att användare kan se och kontakta varandra i din berättelse. Din berättelse är synlig i 24 timmar, men det finns ingen garanti för att berättelser raderas från alla enheter och servrar.';

  @override
  String get iUnderstand => 'Jag förstår';

  @override
  String get openChat => 'Öppna Chatt';

  @override
  String get markAsRead => 'Markera som läst';

  @override
  String get reportUser => 'Rapportera användare';

  @override
  String get dismiss => 'Avfärda';

  @override
  String get matrixWidgets => 'Matrix widgetar';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender reagerade med $reaction';
  }

  @override
  String get pinMessage => 'Fäst i rum';

  @override
  String get confirmEventUnpin =>
      'Är du säker på att händelsen inte längre skall vara fastnålad?';

  @override
  String get emojis => 'Uttryckssymboler';

  @override
  String get placeCall => 'Ring';

  @override
  String get voiceCall => 'Röstsamtal';

  @override
  String get unsupportedAndroidVersion =>
      'Inget stöd för denna version av Android';

  @override
  String get unsupportedAndroidVersionLong =>
      'Denna funktion kräver en senare version av Android.';

  @override
  String get videoCallsBetaWarning =>
      'Videosamtal är för närvarande under testning. De kanske inte fungerar som det är tänkt eller på alla plattformar.';

  @override
  String get experimentalVideoCalls => 'Experimentella videosamtal';

  @override
  String get emailOrUsername => 'Användarnamn eller e-postadress';

  @override
  String get indexedDbErrorTitle => 'Problem med privat läge';

  @override
  String get indexedDbErrorLong =>
      'Meddelandelagring är tyvärr inte aktiverat i privat läge som standard.\nGå till\n - about:config\n - sätt dom.indexedDB.privateBrowsing.enabled till true\nAnnars går det inte att använda FluffyChat.';

  @override
  String switchToAccount(Object number) {
    return 'Byt till konto $number';
  }

  @override
  String get nextAccount => 'Nästa konto';

  @override
  String get previousAccount => 'Föregående konto';

  @override
  String get editWidgets => 'Redigera widgetar';

  @override
  String get addWidget => 'Lägg till widget';

  @override
  String get widgetVideo => 'Video';

  @override
  String get widgetEtherpad => 'Anteckning';

  @override
  String get widgetJitsi => 'Jitsi-möte';

  @override
  String get widgetCustom => 'Anpassad';

  @override
  String get widgetName => 'Namn';

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
  String get widgetUrlError => 'Detta är inte en giltig URL.';

  @override
  String get widgetNameError => 'Vänligen ange ett visningsnamn.';

  @override
  String get errorAddingWidget =>
      'Ett fel uppstod när widgeten skulle läggas till.';

  @override
  String get youRejectedTheInvitation => 'Du avvisade inbjudan';

  @override
  String get youJoinedTheChat => 'Du gick med i chatten';

  @override
  String get youAcceptedTheInvitation => '👍 Du accepterade inbjudan';

  @override
  String youBannedUser(Object user) {
    return 'Du förbjöd $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Du har återkallat inbjudan till $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 Du har blivit inbjuden av $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 Du bjöd in $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 Du sparkade ut $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 Du sparkade ut och förbjöd $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Du återkallade förbudet för $user';
  }

  @override
  String get noEmailWarning =>
      'Utan en giltig e-postadress kommer du inte kunna återställa ditt lösenord. Om du inte vill ange en e-postadress, tryck på knappen igen för att fortsätta.';

  @override
  String get stories => 'Berättelser';

  @override
  String get users => 'Användare';

  @override
  String get unlockOldMessages => 'Lås upp äldre meddelanden';

  @override
  String get storeInSecureStorageDescription =>
      'Lagra återställningsnyckeln på säker plats på denna enhet.';

  @override
  String get saveKeyManuallyDescription =>
      'Spara nyckeln manuellt genom att aktivera dela-funktionen eller urklippshanteraren på enheten.';

  @override
  String get storeInAndroidKeystore =>
      'Lagra i Androids nyckellagring (KeyStore)';

  @override
  String get storeInAppleKeyChain => 'Lagra i Apples nyckelkedja (KeyChain)';

  @override
  String get storeSecurlyOnThisDevice => 'Lagra säkert på denna enhet';

  @override
  String countFiles(Object count) {
    return '$count filer';
  }

  @override
  String get user => 'Användare';

  @override
  String get custom => 'Anpassad';

  @override
  String get foregroundServiceRunning =>
      'Denna notifikation visas när förgrundstjänsten körs.';

  @override
  String get screenSharingTitle => 'skärmdelning';

  @override
  String get screenSharingDetail => 'Du delar din skärm i FluffyChat';

  @override
  String get callingPermissions => 'Samtalsbehörighet';

  @override
  String get callingAccount => 'Samtalskonto';

  @override
  String get callingAccountDetails =>
      'Tillåt FluffyChat att använda Androids ring-app.';

  @override
  String get appearOnTop => 'Visa ovanpå';

  @override
  String get appearOnTopDetails =>
      'Tillåt att appen visas ovanpå (behövs inte om du redan har FluffyChat konfigurerat som ett samtalskonto)';

  @override
  String get otherCallingPermissions =>
      'Mikrofon, kamera och andra behörigheter för FluffyChat';

  @override
  String get whyIsThisMessageEncrypted =>
      'Varför kan inte detta meddelande läsas?';

  @override
  String get noKeyForThisMessage =>
      'Detta kan hända om meddelandet skickades innan du loggade in på ditt konto i den här enheten.\n\nDet kan också vara så att avsändaren har blockerat din enhet eller att något gick fel med internetanslutningen.\n\nKan du läsa meddelandet i en annan session? I sådana fall kan du överföra meddelandet från den sessionen! Gå till Inställningar > Enhet och säkerställ att dina enheter har verifierat varandra. När du öppnar rummet nästa gång och båda sessionerna är i förgrunden, så kommer nycklarna att överföras automatiskt.\n\nVill du inte förlora nycklarna vid utloggning eller när du byter enhet? Säkerställ att du har aktiverat säkerhetskopiering för chatten i inställningarna.';

  @override
  String get newGroup => 'Ny grupp';

  @override
  String get newSpace => 'Nytt utrymme';

  @override
  String get enterSpace => 'Gå till utrymme';

  @override
  String get enterRoom => 'Gå till rummet';

  @override
  String get allSpaces => 'Alla utrymmen';

  @override
  String numChats(Object number) {
    return '$number chattar';
  }

  @override
  String get hideUnimportantStateEvents => 'Göm oviktiga tillståndshändelser';

  @override
  String get doNotShowAgain => 'Visa inte igen';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Tom chatt (var $oldDisplayName)';
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
      'Utrymmen möjliggör konsolidering av chattar och att bygga privata eller offentliga gemenskaper.';

  @override
  String get encryptThisChat => 'Kryptera denna chatt';

  @override
  String get endToEndEncryption => 'Totalsträckskryptering';

  @override
  String get disableEncryptionWarning =>
      'Av säkerhetsskäl kan du inte stänga av kryptering i en chatt där det tidigare aktiverats.';

  @override
  String get sorryThatsNotPossible => 'Det där är inte möjligt';

  @override
  String get deviceKeys => 'Enhetsnycklar:';

  @override
  String get letsStart => 'Lås oss börja';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Ange länk för inbjudan eller Matrix-ID...';

  @override
  String get reopenChat => 'Återöppna chatt';

  @override
  String get noBackupWarning =>
      'Varning! Om du inte aktiverar säkerhetskopiering av chattar så tappar du åtkomst till krypterade meddelanden. Det är rekommenderat att du aktiverar säkerhetskopiering innan du loggar ut.';

  @override
  String get noOtherDevicesFound => 'Inga andra enheter hittades';

  @override
  String get fileIsTooBigForServer =>
      'Servern informerar om att filen är för stor för att skickas.';

  @override
  String fileHasBeenSavedAt(Object path) {
    return 'Filen har sparats i $path';
  }

  @override
  String get jumpToLastReadMessage => 'Hoppa till det senast lästa meddelandet';

  @override
  String get readUpToHere => 'Läs upp till hit';

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
