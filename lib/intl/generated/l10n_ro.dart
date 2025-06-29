// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class L10nRo extends L10n {
  L10nRo([String locale = 'ro']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Înregistrați-vă';

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
  String get passwordsDoNotMatch => 'Parolele nu corespund!';

  @override
  String get pleaseEnterValidEmail =>
      'Vă rugăm să introduceți o adresă de email validă.';

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
  String get people => 'Persoane';

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
  String get groups => 'Grupuri';

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
  String get repeatPassword => 'Repetați parola';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Vă rugăm să alegeți cel puțin $min caractere.';
  }

  @override
  String get about => 'Despre';

  @override
  String get updateAvailable => 'Actualizare FluffyChat disponibil';

  @override
  String get updateNow => 'Începeți actualizare în fundal';

  @override
  String get accept => 'Accept';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username a aceptat invitați';
  }

  @override
  String get account => 'Cont';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username a activat criptarea end-to-end';
  }

  @override
  String get addEmail => 'Adăugați email';

  @override
  String get confirmMatrixId =>
      'Vă rugăm să confirmați Matrix ID-ul vostru să ștergeți contul vostru.';

  @override
  String supposedMxid(Object mxid) {
    return 'ID-ul ar trebuii să fie $mxid';
  }

  @override
  String get addGroupDescription => 'Adaugă o descriere de';

  @override
  String get addToSpace => 'Adăugați la spațiu';

  @override
  String get admin => 'Administrator';

  @override
  String get alias => 'poreclă';

  @override
  String get all => 'Toate';

  @override
  String get allChats => 'Toate Chaturile';

  @override
  String get commandHint_googly => 'Trimiteți câțiva ochi googly';

  @override
  String get commandHint_cuddle => 'Trimiteți o îmbrățișare';

  @override
  String get commandHint_hug => 'Trimiteți o îmbrățișare';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName v-a trimis ochi googly';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName vă îmbrățișează';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName vă îmbrățișează';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '$senderName a acceptat apelul';
  }

  @override
  String get anyoneCanJoin => 'Oricine se poate alătura';

  @override
  String get appLock => 'Lacăt aplicație';

  @override
  String get archive => 'Arhivă';

  @override
  String get areGuestsAllowedToJoin => 'Vizitatorii \"guest\" se pot alătura';

  @override
  String get areYouSure => 'Ești sigur?';

  @override
  String get areYouSureYouWantToLogout =>
      'Sunteți sigur că doriți să vă deconectați?';

  @override
  String get askSSSSSign =>
      'Pentru a putea conecta cealaltă persoană, te rog introdu parola sau cheia ta de recuperare.';

  @override
  String askVerificationRequest(Object username) {
    return 'Accepți cererea de verificare de la $username?';
  }

  @override
  String get autoplayImages => 'Anima automatic stickere și emote animate';

  @override
  String get sendOnEnter => 'Trimite cu tasta enter';

  @override
  String get banFromChat => 'Interzis din conversație';

  @override
  String get banned => 'Interzis';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username a interzis pe $targetName';
  }

  @override
  String get blockDevice => 'Blochează dispozitiv';

  @override
  String get blocked => 'Blocat';

  @override
  String get botMessages => 'Mesaje Bot';

  @override
  String get bubbleSize => 'Mărimea bulelor';

  @override
  String get cancel => 'Anulează';

  @override
  String cantOpenUri(Object uri) {
    return 'Nu se poate deschide URI-ul $uri';
  }

  @override
  String get changeDeviceName => 'Schimbă numele dispozitiv';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username a schimbat poza conversați';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username a schimbat descrierea grupului în \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username a schimbat porecla în \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username a schimbat permisiunile chatului';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username s-a schimbat displayname la: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username a schimbat regulile pentru acesul musafirilor';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username a schimbat regulile pentru acesul musafirilor la: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username a schimbat vizibilitatea istoriei chatului';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username a schimbat vizibilitatea istoriei chatului la: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username a schimbat regulile de alăturare';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username a schimbat regulile de alăturare la: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username s-a schimbat avatarul';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username a schimbat pseudonimele camerei';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username a schimbat linkul de invitație';
  }

  @override
  String get changePassword => 'Schimbați parola';

  @override
  String get changeTheHomeserver => 'Schimbați homeserver-ul';

  @override
  String get changeTheme => 'Schimbați tema aplicației';

  @override
  String get changeTheNameOfTheGroup => 'Schimbați numele grupului';

  @override
  String get changeWallpaper => 'Schimbați imaginea de fundal';

  @override
  String get changeYourAvatar => 'Schimbați avatarul vostru';

  @override
  String get channelCorruptedDecryptError => 'Criptarea a fost corupată';

  @override
  String get chat => 'Chat';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'Backup-ul vostru de chat a fost configurat.';

  @override
  String get chatBackup => 'Backup de chat';

  @override
  String get chatBackupDescription =>
      'Mesajele voastre vechi sunt sigurate cu o cheie de recuperare. Vă rugăm să nu o pierdeți.';

  @override
  String get chatDetails => 'Detalii de chat';

  @override
  String get chatHasBeenAddedToThisSpace =>
      'Chatul a fost adăugat la acest spațiu';

  @override
  String get chats => 'Chaturi';

  @override
  String get chooseAStrongPassword => 'Alegeți o parolă robustă';

  @override
  String get chooseAUsername => 'Alegeți un username';

  @override
  String get clearArchive => 'Ștergeți arhiva';

  @override
  String get close => 'Închideți';

  @override
  String get commandHint_markasdm => 'Marcați ca cameră de mesaje directe';

  @override
  String get commandHint_markasgroup => 'Marcați ca grup';

  @override
  String get commandHint_ban =>
      'Interziceți acesul utilizatorului ales din această cameră';

  @override
  String get commandHint_clearcache => 'Ștergeți cache';

  @override
  String get commandHint_create =>
      'Creați un grup de chat gol\nFolosiți --no-encryption să dezactivați criptare';

  @override
  String get commandHint_discardsession => 'Renunțați sesiunea';

  @override
  String get commandHint_dm =>
      'Porniți un chat direct\nFolosiți --no-encryption să dezactivați criptare';

  @override
  String get commandHint_html => 'Trimiteți text format ca HTML';

  @override
  String get commandHint_invite =>
      'Invitați utilizatorul ales la această cameră';

  @override
  String get commandHint_join => 'Alăturați-vă la camera alesă';

  @override
  String get commandHint_kick =>
      'Dați afară pe utilizatorul ales din această cameră';

  @override
  String get commandHint_leave => 'Renunțați la această cameră';

  @override
  String get commandHint_me => 'Descrieți-vă';

  @override
  String get commandHint_myroomavatar =>
      'Alegeți un avatar pentru această cameră (foloșește mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Alegeți un displayname pentru această cameră';

  @override
  String get commandHint_op =>
      'Stabiliți nivelul de putere a utilizatorul ales (implicit: 50)';

  @override
  String get commandHint_plain => 'Trimiteți text simplu/neformatat';

  @override
  String get commandHint_react => 'Trimiteți răspuns ca reacție';

  @override
  String get commandHint_send => 'Trimiteți text';

  @override
  String get commandHint_unban =>
      'Dezinterziceți utilizatorul ales din această cameră';

  @override
  String get commandInvalid => 'Comandă nevalibilă';

  @override
  String commandMissing(Object command) {
    return '$command nu este o comandă.';
  }

  @override
  String get compareEmojiMatch => 'Vă rugăm să comparați emoji-urile';

  @override
  String get compareNumbersMatch => 'Vă rugăm să comparați numerele';

  @override
  String get configureChat => 'Configurați chat';

  @override
  String get confirm => 'Confirmați';

  @override
  String get connect => 'Conectați';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Contactul a fost invitat la grup';

  @override
  String get containsDisplayName => 'Conține displayname';

  @override
  String get containsUserName => 'Conține nume de utilizator';

  @override
  String get contentHasBeenReported =>
      'Conținutul a fost reportat la administratori serverului';

  @override
  String get copiedToClipboard => 'Copiat în clipboard';

  @override
  String get copy => 'Copiați';

  @override
  String get copyToClipboard => 'Copiați în clipboard';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Dezcriptarea mesajului a eșuat: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count participanți';
  }

  @override
  String get create => 'Creați';

  @override
  String createdTheChat(Object username) {
    return '💬$username a creat chatul';
  }

  @override
  String get createNewGroup => 'Creați grup nou';

  @override
  String get createNewSpace => 'Spațiu nou';

  @override
  String get currentlyActive => 'Activ acum';

  @override
  String get darkTheme => 'Întunecat';

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
      'Această acțiune va dezactiva contul vostru. Nu poate fi anulat! Sunteți sigur?';

  @override
  String get defaultPermissionLevel => 'Nivel de permisiuni implicită';

  @override
  String get delete => 'Ștergeți';

  @override
  String get deleteAccount => 'Ștergeți contul';

  @override
  String get deleteMessage => 'Ștergeți mesajul';

  @override
  String get deny => 'Refuza';

  @override
  String get device => 'Dispozitiv';

  @override
  String get deviceId => 'ID-ul Dispozitiv';

  @override
  String get devices => 'Dispozitive';

  @override
  String get directChats => 'Chaturi directe';

  @override
  String get allRooms => 'Toate chaturi de grup';

  @override
  String get discover => 'Descoperă';

  @override
  String get displaynameHasBeenChanged => 'Displayname a fost schimbat';

  @override
  String get downloadFile => 'Descărcați fișierul';

  @override
  String get edit => 'Editați';

  @override
  String get editBlockedServers => 'Editați servere blocate';

  @override
  String get editChatPermissions => 'Schimbați permisiunele chatului';

  @override
  String get editDisplayname => 'Schimbați displayname';

  @override
  String get editRoomAliases => 'Schimbați pseudonimele camerei';

  @override
  String get editRoomAvatar => 'Schimbați avatarul din cameră';

  @override
  String get emoteExists => 'Emote deja există!';

  @override
  String get emoteInvalid => 'Shortcode de emote nevalibil!';

  @override
  String get emotePacks => 'Pachete de emoturi din cameră';

  @override
  String get emoteSettings => 'Configurări Emote';

  @override
  String get emoteShortcode => 'Shortcode de emote';

  @override
  String get emoteWarnNeedToPick =>
      'Trebuie să alegeți shortcode pentru emote și o imagine!';

  @override
  String get emptyChat => 'Chat gol';

  @override
  String get enableEmotesGlobally => 'Activați pachet de emote global';

  @override
  String get enableEncryption => 'Activați criptare';

  @override
  String get enableEncryptionWarning =>
      'Activând criptare, nu mai puteți să o dezactivați în viitor. Sunteți sigur?';

  @override
  String get encrypted => 'Criptat';

  @override
  String get encryption => 'Criptare';

  @override
  String get encryptionNotEnabled => 'Criptare nu e activată';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName a terminat apelul';
  }

  @override
  String get enterAGroupName => 'Introduceți nume pentru grup';

  @override
  String get enterAnEmailAddress => 'Introduceți o adresă email';

  @override
  String get enterASpacepName => 'Introduceți nume pentru spațiu';

  @override
  String get homeserver => 'Homeserver';

  @override
  String get enterYourHomeserver => 'Introduceți homeserverul vostru';

  @override
  String errorObtainingLocation(Object error) {
    return 'Obținerea locației a eșuat: $error';
  }

  @override
  String get everythingReady => 'Totul e gata!';

  @override
  String get extremeOffensive => 'De foarte mare ofensă';

  @override
  String get fileName => 'Nume de fișier';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Mărimea fontului';

  @override
  String get forward => 'Înainte';

  @override
  String get fromJoining => 'De la alăturare';

  @override
  String get fromTheInvitation => 'De la invitația';

  @override
  String get goToTheNewRoom => 'Mergeți la camera nouă';

  @override
  String get group => 'Grup';

  @override
  String get groupDescription => 'Descrierea grupului';

  @override
  String get groupDescriptionHasBeenChanged =>
      'Descrierea grupului a fost schimbat';

  @override
  String get groupIsPublic => 'Grupul este public';

  @override
  String groupWith(Object displayname) {
    return 'Grup cu $displayname';
  }

  @override
  String get guestsAreForbidden => 'Musafiri sunt interziși';

  @override
  String get guestsCanJoin => 'Musafiri pot să se alăture';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username a retras invitația pentru $targetName';
  }

  @override
  String get help => 'Ajutor';

  @override
  String get hideRedactedEvents => 'Ascunde evenimente redactate';

  @override
  String get hideUnknownEvents => 'Ascunde evenimente necunoscute';

  @override
  String get howOffensiveIsThisContent => 'Cât de ofensiv este acest conținut?';

  @override
  String get id => 'ID';

  @override
  String get identity => 'Identitate';

  @override
  String get ignore => 'Ignorați';

  @override
  String get ignoredUsers => 'Utilizatori ignorați';

  @override
  String get ignoreListDescription =>
      'Puteți să ignorați utilizatori care vă deranjează. Nu ați să primiți mesaje sau invitații de cameră de la utilizatori pe lista voastră de ignorați.';

  @override
  String get ignoreUsername => 'Ignorați numele de utilizator';

  @override
  String get iHaveClickedOnLink => 'Am făcut click pe link';

  @override
  String get incorrectPassphraseOrKey =>
      'Parolă sau cheie de recuperare incorectă';

  @override
  String get inoffensive => 'Inofensiv';

  @override
  String get inviteContact => 'Invitați contact';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Invitați contact la $groupName';
  }

  @override
  String get invited => 'Invitat';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩$username a invitat $targetName';
  }

  @override
  String get invitedUsersOnly => 'Numai utilizatori invitați';

  @override
  String get inviteForMe => 'Invitați pentru mine';

  @override
  String inviteText(Object username, Object link) {
    return '$username v-a invitat la FluffyChat.\n1. Instalați FluffyChat: https://fluffychat.im\n2. Înregistrați-vă sau conectați-vă\n3. Deschideți invitația: $link';
  }

  @override
  String get isTyping => 'tastează…';

  @override
  String joinedTheChat(Object username) {
    return '👋$username a intrat în chat';
  }

  @override
  String get joinRoom => 'Alăturați la cameră';

  @override
  String kicked(Object username, Object targetName) {
    return '👞$username a dat afară pe $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅$username a dat afară și a interzis pe $targetName din cameră';
  }

  @override
  String get kickFromChat => 'Dați afară din chat';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Ultima dată activ: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Văzut de ultima dată cu mult timp în urmă';

  @override
  String get leave => 'Renunțați';

  @override
  String get leftTheChat => 'A plecat din chat';

  @override
  String get license => 'Permis';

  @override
  String get lightTheme => 'Luminat';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Încărcați încă mai $count participanți';
  }

  @override
  String get dehydrate => 'Exportați sesiunea și ștergeți dispozitivul';

  @override
  String get dehydrateWarning =>
      'Această actiune nu poate fi anulată. Asigurați-vă că păstrați fișierul backup.';

  @override
  String get dehydrateTor => 'Utilizatori de TOR: Exportați sesiunea';

  @override
  String get dehydrateTorLong =>
      'Pentru utilizatori de TOR, este recomandat să exportați sesiunea înainte de a închideți fereastra.';

  @override
  String get hydrateTor => 'Utilizatori TOR: Importați sesiune exportată';

  @override
  String get hydrateTorLong =>
      'Ați exportat sesiunea vostră ultima dată pe TOR? Importați-o repede și continuați să conversați.';

  @override
  String get hydrate => 'Restaurați din fișier backup';

  @override
  String get loadingPleaseWait => 'Încărcând... Vă rugăm să așteptați.';

  @override
  String get loadMore => 'Încarcă mai multe…';

  @override
  String get locationDisabledNotice =>
      'Servicile de locație sunt dezactivate. Vă rugăm să le activați să împărțiți locația voastră.';

  @override
  String get locationPermissionDeniedNotice =>
      'Permisiunea locației blocată. Vă rugăm să o dezblocați să împărțiți locația voastră.';

  @override
  String get login => 'Conectați-vă';

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
    return 'Conectați-vă la $homeserver';
  }

  @override
  String get loginWithOneClick => 'Conectați-vă cu un click';

  @override
  String get logout => 'Deconectați-vă';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Verificați că identificatorul este valabil';

  @override
  String get memberChanges => 'Schimbări de membri';

  @override
  String get mention => 'Menționați';

  @override
  String get messages => 'Mesaje';

  @override
  String get messageWillBeRemovedWarning =>
      'Mesajul va fi șters pentru toți participanți';

  @override
  String get moderator => 'Moderator';

  @override
  String get muteChat => 'Amuțați chatul';

  @override
  String get needPantalaimonWarning =>
      'Vă rugăm să fiți conștienți că e nevoie de Pantalaimon să folosiți criptare end-to-end deocamdată.';

  @override
  String get newChat => 'Chat nou';

  @override
  String get newMessageInFluffyChat => '💬 Mesaj nou în FluffyChat';

  @override
  String get newVerificationRequest => 'Cerere de verificare nouă!';

  @override
  String get next => 'Următor';

  @override
  String get no => 'Nu';

  @override
  String get noConnectionToTheServer => 'Fără conexiune la server';

  @override
  String get noEmotesFound => 'Nu s-a găsit nici un emote. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Criptare nu poate fi activată până când camera este accesibilă public.';

  @override
  String get noGoogleServicesWarning =>
      'Se pare că nu aveți serviciile google pe dispozitivul vostru. Această decizie este bună pentru confidențialitatea voastră! Să primiți notificari push în FluffyChat vă recomandăm https://microg.org/ sau https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 nu este server matrix, înlocuiți cu $server2?';
  }

  @override
  String get shareYourInviteLink => 'Partajați linkul de invitație';

  @override
  String get scanQrCode => 'Scanați cod QR';

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
  String get none => 'Niciunul';

  @override
  String get noPasswordRecoveryDescription =>
      'Nu ați adăugat încă nici un mod de recuperare pentru parola voastră.';

  @override
  String get noPermission => 'Fără permisie';

  @override
  String get noRoomsFound => 'Nici o cameră nu s-a găsit…';

  @override
  String get notifications => 'Notificări';

  @override
  String get notificationsEnabledForThisAccount =>
      'Notificări activate pentru acest cont';

  @override
  String numUsersTyping(Object count) {
    return '$count utilizatori tastează…';
  }

  @override
  String get obtainingLocation => 'Obținând locație…';

  @override
  String get offensive => 'Ofensiv';

  @override
  String get offline => 'Offline';

  @override
  String get ok => 'Ok';

  @override
  String get online => 'Online';

  @override
  String get onlineKeyBackupEnabled => 'Backup de cheie online este activat';

  @override
  String get oopsPushError =>
      'Ups! Din păcate, o eroare s-a întâmplat cu stabilirea de notificări push.';

  @override
  String get oopsSomethingWentWrong => 'Ups, ceva a eșuat…';

  @override
  String get openAppToReadMessages => 'Deschideți aplicația să citiți mesajele';

  @override
  String get openCamera => 'Deschideți camera';

  @override
  String get openVideoCamera => 'Deschideți camera pentru video';

  @override
  String get oneClientLoggedOut =>
      'Unul dintre clienților voștri a fost deconectat';

  @override
  String get addAccount => 'Adăugați cont';

  @override
  String get editBundlesForAccount => 'Editați pachetele pentru acest cont';

  @override
  String get addToBundle => 'Adăugați în pachet';

  @override
  String get removeFromBundle => 'Stergeți din acest pachet';

  @override
  String get bundleName => 'Numele pachetului';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Activați multiple conturi pe acest dispozitiv';

  @override
  String get openInMaps => 'Deschideți pe hartă';

  @override
  String get link => 'Link';

  @override
  String get serverRequiresEmail =>
      'Acest server trebuie să valideze emailul vostru pentru înregistrare.';

  @override
  String get optionalGroupName => '(Opțional) Numele grupului';

  @override
  String get or => 'Sau';

  @override
  String get participant => 'Participant';

  @override
  String get passphraseOrKey => 'frază de acces sau cheie de recuperare';

  @override
  String get password => 'Parolă';

  @override
  String get passwordForgotten => 'Parola uitată';

  @override
  String get passwordHasBeenChanged => 'Parola a fost schimbată';

  @override
  String get passwordRecovery => 'Recuperare parolei';

  @override
  String get pickImage => 'Alegeți o imagine';

  @override
  String get pin => 'Fixați';

  @override
  String play(Object fileName) {
    return 'Redați $fileName';
  }

  @override
  String get pleaseChoose => 'Vă rugăm să alegeți';

  @override
  String get pleaseChooseAPasscode => 'Vă rugăm să alegeți un passcode';

  @override
  String get pleaseChooseAUsername => 'Vă rugăm să alegeți un username';

  @override
  String get pleaseClickOnLink =>
      'Vă rugăm să deschideți linkul din email și apoi să procedați.';

  @override
  String get pleaseEnter4Digits =>
      'Vă rugăm să introduceți 4 cifre sau puteți să lăsați gol să dezactivați lacătul aplicației.';

  @override
  String get pleaseEnterAMatrixIdentifier =>
      'Vă rugăm să introduceți un ID Matrix.';

  @override
  String get pleaseEnterRecoveryKey =>
      'Vă rugăm să introduceți cheia voastră de recuperare:';

  @override
  String get pleaseEnterYourPassword =>
      'Vă rugăm să introduceți parola voastră';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Vă rugăm să introduceți pinul vostru';

  @override
  String get pleaseEnterYourUsername =>
      'Vă rugăm să introduceți username-ul vostru';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Vă rugăm să urmați instrucțiunele pe website și apoi să apăsați pe următor.';

  @override
  String get privacy => 'Confidențialitate';

  @override
  String get publicRooms => 'Camere Publice';

  @override
  String get pushRules => 'Regulile Push';

  @override
  String get reason => 'Motiv';

  @override
  String get recording => 'Înregistrare';

  @override
  String redactedAnEvent(Object username) {
    return '$username a redactat un eveniment';
  }

  @override
  String get redactMessage => 'Redactați mesaj';

  @override
  String get reject => 'Respingeți';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username a respins invitația';
  }

  @override
  String get rejoin => 'Reintrați';

  @override
  String get remove => 'Eliminați';

  @override
  String get removeAllOtherDevices => 'Eliminați toate celelalte dispozitive';

  @override
  String removedBy(Object username) {
    return 'Eliminat de $username';
  }

  @override
  String get removeDevice => 'Eliminați dispozitivul';

  @override
  String get unbanFromChat => 'Revoca interzicerea din chat';

  @override
  String get removeYourAvatar => 'Ștergeți avatarul';

  @override
  String get renderRichContent => 'Reda conținut bogat al mesajelor';

  @override
  String get replaceRoomWithNewerVersion =>
      'Înlocuiți camera cu versiune mai nouă';

  @override
  String get reply => 'Răspundeți';

  @override
  String get reportMessage => 'Raportați mesajul';

  @override
  String get requestPermission => 'Cereți permisiune';

  @override
  String get roomHasBeenUpgraded => 'Camera a fost actualizată';

  @override
  String get roomVersion => 'Versiunea camerei';

  @override
  String get saveFile => 'Salvați fișierul';

  @override
  String get search => 'Căutați';

  @override
  String get security => 'Securitate';

  @override
  String get recoveryKey => 'Cheie de recuperare';

  @override
  String get recoveryKeyLost => 'Cheia de recuperare pierdută?';

  @override
  String seenByUser(Object username) {
    return 'Văzut de $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Văzut de $username și alți $count';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Văzut de $username și $username2';
  }

  @override
  String get send => 'Trimiteți';

  @override
  String get sendAMessage => 'Trimiteți un mesaj';

  @override
  String get sendAsText => 'Trimiteți ca text';

  @override
  String get sendAudio => 'Trimiteți audio';

  @override
  String get sendFile => 'Trimiteți fișier';

  @override
  String get sendImage => 'Trimiteți imagine';

  @override
  String get sendMessages => 'Trimiteți mesaje';

  @override
  String get sendOriginal => 'Trimiteți original';

  @override
  String get sendSticker => 'Trimiteți sticker';

  @override
  String get sendVideo => 'Trimiteți video';

  @override
  String sentAFile(Object username) {
    return '📁$username a trimis un fișier';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤$username a trimis audio';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username a trimis o poză';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username a trimis un sticker';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥$username a trimis un video';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName a trimis informație de apel';
  }

  @override
  String get separateChatTypes => 'Afișați chaturi directe și grupuri separat';

  @override
  String get setAsCanonicalAlias => 'Stabiliți ca pseudonimul primar';

  @override
  String get setCustomEmotes => 'Stabiliți emoji-uri personalizate';

  @override
  String get setGroupDescription => 'Stabiliți descrierea grupului';

  @override
  String get setInvitationLink => 'Stabiliți linkul de invitație';

  @override
  String get setPermissionsLevel => 'Stabiliți nivelul de permisii';

  @override
  String get setStatus => 'Stabiliți status';

  @override
  String get settings => 'Configurări';

  @override
  String get share => 'Partajați';

  @override
  String sharedTheLocation(Object username) {
    return '$username sa partajat locația';
  }

  @override
  String get shareLocation => 'Partajați locația';

  @override
  String get showDirectChatsInSpaces =>
      'Afișați chaturi directe relate în spatiuri';

  @override
  String get showPassword => 'Afișați parola';

  @override
  String get signUp => 'Înregistrați-vă';

  @override
  String get singlesignon => 'Autentificare unică';

  @override
  String get skip => 'Săriți peste';

  @override
  String get sourceCode => 'Codul surs';

  @override
  String get spaceIsPublic => 'Spațiul este public';

  @override
  String get spaceName => 'Numele spațiului';

  @override
  String startedACall(Object senderName) {
    return '$senderName a început un apel';
  }

  @override
  String get startFirstChat => 'Începeți primul chatul vostru';

  @override
  String get status => 'Status';

  @override
  String get statusExampleMessage => 'Ce faceți?';

  @override
  String get submit => 'Trimiteți';

  @override
  String get synchronizingPleaseWait =>
      'Sincronizează... Vă rugăm să așteptați.';

  @override
  String get systemTheme => 'Sistem';

  @override
  String get theyDontMatch => 'Nu sunt asemănători';

  @override
  String get theyMatch => 'Sunt asemănători';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Comutați favoritul';

  @override
  String get toggleMuted => 'Comutați amuțeștarea';

  @override
  String get toggleUnread => 'Marcați Citit/Necitit';

  @override
  String get tooManyRequestsWarning =>
      'Prea multe cereri. Vă rugăm să încercați din nou mai tărziu!';

  @override
  String get transferFromAnotherDevice => 'Transfera de la alt dispozitiv';

  @override
  String get tryToSendAgain => 'Încercați să trimiteți din nou';

  @override
  String get unavailable => 'Nedisponibil';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username a ridicat interzicerea lui $targetName';
  }

  @override
  String get unblockDevice => 'Debloca dispozitiv';

  @override
  String get unknownDevice => 'Dispozitiv necunoscut';

  @override
  String get unknownEncryptionAlgorithm => 'Algoritm de criptare necunoscut';

  @override
  String get unmuteChat => 'Dezamuțați chat';

  @override
  String get unpin => 'Anulează fixarea';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount chaturi necitite',
      one: 'Un chat necitit',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username și $count alți tastează…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username și $username2 tastează…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username tastează…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪$username a plecat din chat';
  }

  @override
  String get username => 'Nume de utilizator';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username a trimis un eveniment $type';
  }

  @override
  String get unverified => 'Neverificat';

  @override
  String get verified => 'Verificat';

  @override
  String get verify => 'Verificați';

  @override
  String get verifyStart => 'Începeți verificare';

  @override
  String get verifySuccess => 'A reușit verificarea!';

  @override
  String get verifyTitle => 'Verificând celălalt cont';

  @override
  String get videoCall => 'Apel video';

  @override
  String get visibilityOfTheChatHistory => 'Vizibilitatea istoria chatului';

  @override
  String get visibleForAllParticipants => 'Vizibil pentru toți participanți';

  @override
  String get visibleForEveryone => 'Vizibil pentru toți';

  @override
  String get voiceMessage => 'Mesaj vocal';

  @override
  String get waitingPartnerAcceptRequest =>
      'Așteptând pe partenerul să accepte cererea…';

  @override
  String get waitingPartnerEmoji =>
      'Așteptând pe partenerul să accepte emoji-ul…';

  @override
  String get waitingPartnerNumbers =>
      'Așteptând pe partenerul să accepte numerele…';

  @override
  String get wallpaper => 'Imagine de fundal';

  @override
  String get warning => 'Avertizment!';

  @override
  String get weSentYouAnEmail => 'V-am trimis un email';

  @override
  String get whoCanPerformWhichAction => 'Cine poate face care acțiune';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Cine se poate alătura la acest grup';

  @override
  String get whyDoYouWantToReportThis =>
      'De ce doriți să reportați acest conținut?';

  @override
  String get wipeChatBackup =>
      'Ștergeți backup-ul vostru de chat să creați o nouă cheie de recuperare?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Cu acestea adrese puteți să vă recuperați parola.';

  @override
  String get writeAMessage => 'Scrieți un mesaj…';

  @override
  String get yes => 'Da';

  @override
  String get you => 'Voi';

  @override
  String get youAreInvitedToThisChat => 'Sunteți invitați la acest chat';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Nu mai participați în acest chat';

  @override
  String get youCannotInviteYourself => 'Nu puteți să vă invitați voi însivă';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Ați fost interzis din acest chat';

  @override
  String get yourPublicKey => 'Cheia voastră publică';

  @override
  String get messageInfo => 'Info mesajului';

  @override
  String get time => 'Timp';

  @override
  String get messageType => 'Fel de mesaj';

  @override
  String get sender => 'Trimițător';

  @override
  String get openGallery => 'Deschideți galeria';

  @override
  String get removeFromSpace => 'Eliminați din spațiu';

  @override
  String get addToSpaceDescription =>
      'Alegeți un spațiu în care să adăugați acest chat.';

  @override
  String get start => 'Începeți';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Să vă deblocați mesajele vechi, vă rugăm să introduceți cheia de recuperare creată de o seșiune anterioră. Cheia de recuperare NU este parola voastră.';

  @override
  String get addToStory => 'Adăugați la story';

  @override
  String get publish => 'Publicați';

  @override
  String get whoCanSeeMyStories => 'Cine poate să-mi vadă stories?';

  @override
  String get unsubscribeStories => 'Dezabonați stories';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Acest utilizator nu a postat nimic încă pe story';

  @override
  String get yourStory => 'Story-ul vostru';

  @override
  String get replyHasBeenSent => 'Răspunsul a fost trimis';

  @override
  String videoWithSize(Object size) {
    return 'Video ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Story de $date:\n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Vă rugăm să țineți în minte că utilizatori pot să se vadă și contacta pe story-ul vostru.';

  @override
  String get whatIsGoingOn => 'Ce se întâmplă?';

  @override
  String get addDescription => 'Adăugați descriere';

  @override
  String get storyPrivacyWarning =>
      'Vă rugăm să țineți în minte că utilizatori poate să se vadă și contacta pe story-ul vostru. Story-urile voastre va fi disponibile pentru 24 de ore dar nu se poate garanta că va fi șterse de pe fie care dispozitiv și server.';

  @override
  String get iUnderstand => 'Am înțeles';

  @override
  String get openChat => 'Deschideți Chat';

  @override
  String get markAsRead => 'Marcați ca citit';

  @override
  String get reportUser => 'Reportați utilizator';

  @override
  String get dismiss => 'Respingeți';

  @override
  String get matrixWidgets => 'Widget-uri Matrix';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender a reacționat cu $reaction';
  }

  @override
  String get pinMessage => 'Fixați în cameră';

  @override
  String get confirmEventUnpin =>
      'Sunteți sigur că doriți să anulați permanent fixarea evenimentului?';

  @override
  String get emojis => 'Emoji-uri';

  @override
  String get placeCall => 'Faceți apel';

  @override
  String get voiceCall => 'Apel vocal';

  @override
  String get unsupportedAndroidVersion => 'Versiune de Android nesuportat';

  @override
  String get unsupportedAndroidVersionLong =>
      'Această funcție are nevoie de o versiune de Android mai nouă. Vă rugăm să verificați dacă sunt actualizări sau suport de la Lineage OS.';

  @override
  String get videoCallsBetaWarning =>
      'Vă rugăm să luați notă că apeluri video sunt în beta. Se poate că nu funcționează normal sau de loc pe fie care platformă.';

  @override
  String get experimentalVideoCalls => 'Apeluri video experimentale';

  @override
  String get emailOrUsername => 'Email sau nume de utilizator';

  @override
  String get indexedDbErrorTitle => 'Probleme cu modul privat';

  @override
  String get indexedDbErrorLong =>
      'Stocarea de mesaje nu este activat implicit în modul privat.\nVă rugăm să vizitați\n- about:config\n- stabiliți dom.indexedDB.privateBrowsing.enabled la true\nAstfel, nu este posibil să folosiți FluffyChat.';

  @override
  String switchToAccount(Object number) {
    return 'Schimbați la contul $number';
  }

  @override
  String get nextAccount => 'Contul următor';

  @override
  String get previousAccount => 'Contul anterior';

  @override
  String get editWidgets => 'Editați widget-uri';

  @override
  String get addWidget => 'Adăugați widget';

  @override
  String get widgetVideo => 'Video';

  @override
  String get widgetEtherpad => 'Notiță text';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Personalizat';

  @override
  String get widgetName => 'Nume';

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
  String get widgetUrlError => 'Acest URL nu este valibil.';

  @override
  String get widgetNameError => 'Vă rugăm să introduceți un nume de afișare.';

  @override
  String get errorAddingWidget => 'Adăugarea widget-ului a eșuat.';

  @override
  String get youRejectedTheInvitation => 'Ați respins invitația';

  @override
  String get youJoinedTheChat => 'Va-ți alăturat la chat';

  @override
  String get youAcceptedTheInvitation => '👍Ați acceptat invitația';

  @override
  String youBannedUser(Object user) {
    return 'Ați interzis pe $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Ați retras invitația pentru $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩Ați fost invitat de $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩Ați invitat pe $user';
  }

  @override
  String youKicked(Object user) {
    return '👞Ați dat afară pe $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅Ați dat afară și interzis pe $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Ați ridicat interzicerea lui $user';
  }

  @override
  String get noEmailWarning =>
      'Vă rugăm să introduceți o adresă de email valibilă. Altfel nu veți putea reseta parola. Dacă totuși nu doriți să introduceți, apăsați din nou pe buton să continuați.';

  @override
  String get stories => 'Povești';

  @override
  String get users => 'Utilizatori';

  @override
  String get unlockOldMessages => 'Deblocați mesajele vechi';

  @override
  String get storeInSecureStorageDescription =>
      'Păstrați cheia de recuperare în stocarea sigură a acestui dispozitiv.';

  @override
  String get saveKeyManuallyDescription =>
      'Activați dialogul de partajare sistemului sau folosiți clipboard-ul să salvați manual această cheie.';

  @override
  String get storeInAndroidKeystore => 'Stoca în Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Stoca în Apple KeyChain';

  @override
  String get storeSecurlyOnThisDevice => 'Stoca sigur pe acest dispozitiv';

  @override
  String countFiles(Object count) {
    return '$count fișiere';
  }

  @override
  String get user => 'Utilizator';

  @override
  String get custom => 'Personalizat';

  @override
  String get foregroundServiceRunning =>
      'Această notificare apare când serviciul de foreground rulează.';

  @override
  String get screenSharingTitle => 'partajarea de ecran';

  @override
  String get screenSharingDetail => 'Partajați ecranul în FluffyChat';

  @override
  String get callingPermissions => 'Permisiuni de apel';

  @override
  String get callingAccount => 'Cont de apel';

  @override
  String get callingAccountDetails =>
      'Permite FluffyChat să folosească aplicația de apeluri nativă android.';

  @override
  String get appearOnTop => 'Apare deasupra';

  @override
  String get appearOnTopDetails =>
      'Permite aplicația să apare deasupra (nu este necesar dacă aveți FluffyChat stabilit ca cont de apeluri)';

  @override
  String get otherCallingPermissions =>
      'Microfon, cameră și alte permisiuni lui FluffyChat';

  @override
  String get whyIsThisMessageEncrypted => 'De ce este acest mesaj ilizibil?';

  @override
  String get noKeyForThisMessage =>
      'Această chestie poate să se întâmple când mesajul a fost trimis înainte să vă conectați contul cu acest dispozitiv.\n\nO altă explicație ar fi dacă trimițătorul a blocat dispozitivul vostru sau ceva s-a întâmplat cu conexiunea la internet\n\nPuteți să citiți mesajul în o altă seșiune? Atunci puteți să transferați mesajul de acolo! Mergeți la Configurări > Dispozitive și verificați că dispozitivele s-au verificat. Când deschideți camera în viitor și ambele seșiune sunt în foreground, cheile va fi transmise automat. \n\nDoriți să îți păstrați cheile când deconectați sau schimbați dispozitive? Fiți atenți să activați backup de chat în configurări.';

  @override
  String get newGroup => 'Grup nou';

  @override
  String get newSpace => 'Spațiu nou';

  @override
  String get enterSpace => 'Intrați în spațiu';

  @override
  String get enterRoom => 'Intrați în cameră';

  @override
  String get allSpaces => 'Toate spațiile';

  @override
  String numChats(Object number) {
    return '$number chaturi';
  }

  @override
  String get hideUnimportantStateEvents =>
      'Ascundeți evenimente de stare neimportante';

  @override
  String get doNotShowAgain => 'Nu se mai apară din nou';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Chat gol (a fost $oldDisplayName)';
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
      'Spațiile vă permit să vă consolidați chaturile și să stabiliți comunități private sau publice.';

  @override
  String get encryptThisChat => 'Criptați acest chat';

  @override
  String get endToEndEncryption => 'Criptare end-to-end';

  @override
  String get disableEncryptionWarning =>
      'Pentru motive de securitate, nu este posibil să dezactivați criptarea unui chat în care criptare este activată.';

  @override
  String get sorryThatsNotPossible => 'Scuze... acest nu este posibil';

  @override
  String get deviceKeys => 'Cheile dispozitivului:';

  @override
  String get letsStart => 'Hai să începem';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Introduceți link de invitație sau ID Matrix...';

  @override
  String get reopenChat => 'Deschide din nou chatul';

  @override
  String get noBackupWarning =>
      'Avertisment! Fără să activați backup de chat, veți pierde accesul la mesajele voastre criptate. E foarte recomandat să activați backup de chat înainte să vă deconectați.';

  @override
  String get noOtherDevicesFound => 'Nu s-a găsit alte dispozitive';

  @override
  String get fileIsTooBigForServer =>
      'Serverul reportează că fișierul este prea mare să fie trimis.';

  @override
  String fileHasBeenSavedAt(Object path) {
    return 'Fișierul a fost salvat la $path';
  }

  @override
  String get jumpToLastReadMessage => 'Săriți la ultimul citit mesaj';

  @override
  String get readUpToHere => 'Citit până aici';

  @override
  String get jump => 'Săriți';

  @override
  String get openLinkInBrowser => 'Deschideți linkul în browser';

  @override
  String get reportErrorDescription =>
      'Ceva a eșuat. Vă rugăm să încercați din nou mai tărziu. Dacă doriți, puteți să reportați problema la dezvoltatori.';

  @override
  String get report => 'reportați';

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
