// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class L10nCa extends L10n {
  L10nCa([String locale = 'ca']) : super(locale);

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
  String get passwordsDoNotMatch => 'Les contrasenyes no coincideixen!';

  @override
  String get pleaseEnterValidEmail =>
      'Introduïu una adreça electrònica vàlida.';

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
  String get people => 'Gent';

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
  String get groups => 'Grups';

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
  String get repeatPassword => 'Repetiu la contrasenya';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Seleccioneu almenys $min caràcters.';
  }

  @override
  String get about => 'Quant a';

  @override
  String get updateAvailable => 'FluffyChat update available';

  @override
  String get updateNow => 'Start update in background';

  @override
  String get accept => 'Accepta';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username ha acceptat la invitació';
  }

  @override
  String get account => 'Compte';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username ha activat el xifratge d’extrem a extrem';
  }

  @override
  String get addEmail => 'Afegeix una adreça electrònica';

  @override
  String get confirmMatrixId =>
      'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'Afegeix descripció de grup';

  @override
  String get addToSpace => 'Afegeix a un espai';

  @override
  String get admin => 'Administració';

  @override
  String get alias => 'àlies';

  @override
  String get all => 'Tot';

  @override
  String get allChats => 'Tots els xats';

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
    return '$senderName ha respost a la trucada';
  }

  @override
  String get anyoneCanJoin => 'Qualsevol pot unir-se';

  @override
  String get appLock => 'Blocatge de l’aplicació';

  @override
  String get archive => 'Arxiu';

  @override
  String get areGuestsAllowedToJoin => 'Accés dels usuaris convidats';

  @override
  String get areYouSure => 'N’esteu segur?';

  @override
  String get areYouSureYouWantToLogout =>
      'Segur que voleu finalitzar la sessió?';

  @override
  String get askSSSSSign =>
      'Per a poder donar accés a l’altra persona, introduïu la frase de seguretat o clau de recuperació.';

  @override
  String askVerificationRequest(Object username) {
    return 'Voleu acceptar aquesta sol·licitud de verificació de: $username?';
  }

  @override
  String get autoplayImages =>
      'Reprodueix automàticament enganxines i emoticones animades';

  @override
  String get sendOnEnter => 'Envia en prémer Retorn';

  @override
  String get banFromChat => 'Veta del xat';

  @override
  String get banned => 'Vetat';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username ha vetat a $targetName';
  }

  @override
  String get blockDevice => 'Bloca el dispositiu';

  @override
  String get blocked => 'Blocat';

  @override
  String get botMessages => 'Missatges del bot';

  @override
  String get bubbleSize => 'Mida de la bombolla';

  @override
  String get cancel => 'Cancel·la';

  @override
  String cantOpenUri(Object uri) {
    return 'No es pot obrir l’URI $uri';
  }

  @override
  String get changeDeviceName => 'Canvia el nom del dispositiu';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username ha canviat la imatge del xat';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username ha canviat la descripció del xat a: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username ha canviat el nom del xat a: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username ha canviat els permisos del xat';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username ha canviat el seu àlies a: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username ha canviat les normes d’accés dels convidats';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username ha canviat les normes d’accés dels convidats a: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username ha canviat la visibilitat de l’historial';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username ha canviat la visibilitat de l’historial a: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username ha canviat les normes d’unió';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username ha canviat les normes d’unió a: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username ha canviat la seva imatge de perfil';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username ha canviat l’àlies de la sala';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username ha canviat l’enllaç per a convidar';
  }

  @override
  String get changePassword => 'Canvia la contrasenya';

  @override
  String get changeTheHomeserver => 'Canvia el servidor';

  @override
  String get changeTheme => 'Canvia l’estil';

  @override
  String get changeTheNameOfTheGroup => 'Canvia el nom del grup';

  @override
  String get changeWallpaper => 'Canvia el fons';

  @override
  String get changeYourAvatar => 'Canvia l’avatar';

  @override
  String get channelCorruptedDecryptError => 'El xifratge s’ha corromput';

  @override
  String get chat => 'Xat';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'S’ha configurat la còpia de seguretat del xat.';

  @override
  String get chatBackup => 'Còpia de seguretat del xat';

  @override
  String get chatBackupDescription =>
      'La còpia de seguretat dels xats és protegida amb una clau. Assegureu-vos de no perdre-la.';

  @override
  String get chatDetails => 'Detalls del xat';

  @override
  String get chatHasBeenAddedToThisSpace => 'El xat s’ha afegit a aquest espai';

  @override
  String get chats => 'Xats';

  @override
  String get chooseAStrongPassword => 'Trieu una contrasenya forta';

  @override
  String get chooseAUsername => 'Trieu un nom d’usuari';

  @override
  String get clearArchive => 'Neteja l’arxiu';

  @override
  String get close => 'Tanca';

  @override
  String get commandHint_markasdm => 'Mark as direct message room';

  @override
  String get commandHint_markasgroup => 'Mark as group';

  @override
  String get commandHint_ban => 'Prohibeix l\'usuari indicat d\'aquesta sala';

  @override
  String get commandHint_clearcache => 'Neteja la memòria cau';

  @override
  String get commandHint_create =>
      'Crea un xat de grup buit\nUsa --no-encryption per desactivar l\'encriptatge';

  @override
  String get commandHint_discardsession => 'Descarta la sessió';

  @override
  String get commandHint_dm =>
      'Inicia un xat directe\nUsa --no-encryption per desactivar l\'encriptatge';

  @override
  String get commandHint_html => 'Envia text en format HTML';

  @override
  String get commandHint_invite => 'Convida l\'usuari indicat a aquesta sala';

  @override
  String get commandHint_join => 'Uneix-te a la sala';

  @override
  String get commandHint_kick => 'Elimina l\'usuari indicat d\'aquesta sala';

  @override
  String get commandHint_leave => 'Abandona aquesta sala';

  @override
  String get commandHint_me => 'Descriviu-vos';

  @override
  String get commandHint_myroomavatar =>
      'Establiu la imatge per a aquesta sala (per mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Estableix el teu àlies per a aquesta sala';

  @override
  String get commandHint_op =>
      'Estableix el nivell d\'autoritat de l\'usuari (per defecte: 50)';

  @override
  String get commandHint_plain => 'Envia text sense format';

  @override
  String get commandHint_react => 'Envia una resposta com a reacció';

  @override
  String get commandHint_send => 'Envia text';

  @override
  String get commandHint_unban => 'Unban the given user from this room';

  @override
  String get commandInvalid => 'L’ordre no és vàlida';

  @override
  String commandMissing(Object command) {
    return '$command no és una ordre.';
  }

  @override
  String get compareEmojiMatch =>
      'Compareu i assegureu-vos que els emojis següents coincideixen amb els de l’altre dispositiu:';

  @override
  String get compareNumbersMatch =>
      'Compareu i assegureu-vos que els nombres següents coincideixen amb els de l’altre dispositiu:';

  @override
  String get configureChat => 'Configura el xat';

  @override
  String get confirm => 'Confirma';

  @override
  String get connect => 'Connecta';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'El contacte ha estat convidat al grup';

  @override
  String get containsDisplayName => 'Conté l\'àlies';

  @override
  String get containsUserName => 'Conté el nom d’usuari';

  @override
  String get contentHasBeenReported =>
      'El contingut s’ha denunciat als administradors del servidor';

  @override
  String get copiedToClipboard => 'S’ha copiat al porta-retalls';

  @override
  String get copy => 'Copia';

  @override
  String get copyToClipboard => 'Copia al porta-retalls';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'No s\'ha pogut desxifrar el missatge: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count participants';
  }

  @override
  String get create => 'Crea';

  @override
  String createdTheChat(Object username) {
    return '$username ha creat el xat';
  }

  @override
  String get createNewGroup => 'Crea un grup nou';

  @override
  String get createNewSpace => 'Espai nou';

  @override
  String get currentlyActive => 'Actiu actualment';

  @override
  String get darkTheme => 'Fosc';

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
    return '$day-$month-$year';
  }

  @override
  String get deactivateAccountWarning =>
      'Es desactivarà el vostre compte d’usuari. Això no es pot desfer! Esteu segur de fer-ho?';

  @override
  String get defaultPermissionLevel => 'Nivell de permisos per defecte';

  @override
  String get delete => 'Suprimeix';

  @override
  String get deleteAccount => 'Suprimeix el compte';

  @override
  String get deleteMessage => 'Suprimeix el missatge';

  @override
  String get deny => 'Denega';

  @override
  String get device => 'Dispositiu';

  @override
  String get deviceId => 'Id. de dispositiu';

  @override
  String get devices => 'Dispositius';

  @override
  String get directChats => 'Xats directes';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Ha canviat l\'àlies';

  @override
  String get downloadFile => 'Baixa el fitxer';

  @override
  String get edit => 'Edita';

  @override
  String get editBlockedServers => 'Edita els servidors bloquejats';

  @override
  String get editChatPermissions => 'Edita els permisos del xat';

  @override
  String get editDisplayname => 'Edita l\'àlies';

  @override
  String get editRoomAliases => 'Edit room aliases';

  @override
  String get editRoomAvatar => 'Edit room avatar';

  @override
  String get emoteExists => 'L\'emoticona ja existeix!';

  @override
  String get emoteInvalid => 'Codi d\'emoticona invàlid!';

  @override
  String get emotePacks => 'Paquet d\'emoticones de la sala';

  @override
  String get emoteSettings => 'Paràmetres de les emoticones';

  @override
  String get emoteShortcode => 'Codi d\'emoticona';

  @override
  String get emoteWarnNeedToPick =>
      'Has de seleccionar un codi d\'emoticona i una imatge!';

  @override
  String get emptyChat => 'Xat buit';

  @override
  String get enableEmotesGlobally => 'Activa el paquet d\'emoticones global';

  @override
  String get enableEncryption => 'Activa el xifratge';

  @override
  String get enableEncryptionWarning =>
      'No podreu desactivar el xifratge mai més. N’esteu segur?';

  @override
  String get encrypted => 'Xifrat';

  @override
  String get encryption => 'Xifratge';

  @override
  String get encryptionNotEnabled => 'El xifratge no s’ha activat';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName ha finalitzat la trucada';
  }

  @override
  String get enterAGroupName => 'Introduïu un nom de grup';

  @override
  String get enterAnEmailAddress => 'Introduïu una adreça electrònica';

  @override
  String get enterASpacepName => 'Introduïu un nom d’espai';

  @override
  String get homeserver => 'Homeserver';

  @override
  String get enterYourHomeserver => 'Introdueix el teu servidor';

  @override
  String errorObtainingLocation(Object error) {
    return 'S’ha produït un error en obtenir la ubicació: $error';
  }

  @override
  String get everythingReady => 'Tot és a punt!';

  @override
  String get extremeOffensive => 'Extremadament ofensiu';

  @override
  String get fileName => 'Nom del fitxer';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Mida de la lletra';

  @override
  String get forward => 'Reenvia';

  @override
  String get fromJoining => 'Des de la unió';

  @override
  String get fromTheInvitation => 'Des de la invitació';

  @override
  String get goToTheNewRoom => 'Ves a la sala nova';

  @override
  String get group => 'Grup';

  @override
  String get groupDescription => 'Descripció de grup';

  @override
  String get groupDescriptionHasBeenChanged => 'Descripció de grup canviada';

  @override
  String get groupIsPublic => 'El grup és públic';

  @override
  String groupWith(Object displayname) {
    return 'Grup amb $displayname';
  }

  @override
  String get guestsAreForbidden => 'Els convidats no poden unir-se';

  @override
  String get guestsCanJoin => 'Els convidats es poden unir';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username ha retirat la invitació de $targetName';
  }

  @override
  String get help => 'Ajuda';

  @override
  String get hideRedactedEvents => 'Amaga els esdeveniments velats';

  @override
  String get hideUnknownEvents => 'Amaga els esdeveniments desconeguts';

  @override
  String get howOffensiveIsThisContent => 'Com d’ofensiu és aquest contingut?';

  @override
  String get id => 'Id.';

  @override
  String get identity => 'Identitat';

  @override
  String get ignore => 'Ignora';

  @override
  String get ignoredUsers => 'Usuaris ignorats';

  @override
  String get ignoreListDescription =>
      'Pots ignorar els usuaris que et molestin. No rebràs els missatges ni les invitacions dels usuaris que es trobin a la teva llista personal d\'ignorats.';

  @override
  String get ignoreUsername => 'Ignora nom d\'usuari';

  @override
  String get iHaveClickedOnLink => 'He fet clic a l\'enllaç';

  @override
  String get incorrectPassphraseOrKey =>
      'Frase de seguretat o clau de recuperació incorrecta';

  @override
  String get inoffensive => 'Inoffensive';

  @override
  String get inviteContact => 'Convida contacte';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Convida contacte a $groupName';
  }

  @override
  String get invited => 'Convidat';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username ha convidat a $targetName';
  }

  @override
  String get invitedUsersOnly => 'Només usuaris convidats';

  @override
  String get inviteForMe => 'Invitació per a mi';

  @override
  String inviteText(Object username, Object link) {
    return '$username t\'ha convidat a FluffyChat.\n1. Instal·la FluffyChat: https://fluffychat.im\n2. Registra\'t o inicia sessió\n3. Obre l\'enllaç d\'invitació: $link';
  }

  @override
  String get isTyping => 'escrivint…';

  @override
  String joinedTheChat(Object username) {
    return '$username s\'ha unit al xat';
  }

  @override
  String get joinRoom => 'Uneix-te a la sala';

  @override
  String kicked(Object username, Object targetName) {
    return '$username ha expulsat a $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username ha expulsat i vetat a $targetName';
  }

  @override
  String get kickFromChat => 'Expulsa del xat';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Actiu per última vegada: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Vist va molt de temps';

  @override
  String get leave => 'Abandona';

  @override
  String get leftTheChat => 'Ha marxat del xat';

  @override
  String get license => 'Llicència';

  @override
  String get lightTheme => 'Clar';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Carrega $count participants més';
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
  String get loadingPleaseWait => 'S’està carregant… Espereu.';

  @override
  String get loadMore => 'Carrega’n més…';

  @override
  String get locationDisabledNotice =>
      'S’han desactivat els serveis d’ubicació. Activeu-los per a compartir la vostra ubicació.';

  @override
  String get locationPermissionDeniedNotice =>
      'S’ha rebutjat el permís d’ubicació. Atorgueu-lo per a poder compartir la vostra ubicació.';

  @override
  String get login => 'Inicia la sessió';

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
    return 'Inicia sessió a $homeserver';
  }

  @override
  String get loginWithOneClick => 'Sign in with one click';

  @override
  String get logout => 'Finalitza la sessió';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Assegura\'t que l\'identificador sigui vàlid';

  @override
  String get memberChanges => 'Canvis de participants';

  @override
  String get mention => 'Menciona';

  @override
  String get messages => 'Missatges';

  @override
  String get messageWillBeRemovedWarning =>
      'El missatge s\'eliminarà per a tots els participants';

  @override
  String get moderator => 'Moderador';

  @override
  String get muteChat => 'Silencia el xat';

  @override
  String get needPantalaimonWarning =>
      'Tingueu en compte que, ara per ara, us cal el Pantalaimon per a poder utilitzar el xifratge d’extrem a extrem.';

  @override
  String get newChat => 'Xat nou';

  @override
  String get newMessageInFluffyChat => 'Missatge nou al FluffyChat';

  @override
  String get newVerificationRequest => 'Nova sol·licitud de verificació!';

  @override
  String get next => 'Següent';

  @override
  String get no => 'No';

  @override
  String get noConnectionToTheServer => 'Sense connexió al servidor';

  @override
  String get noEmotesFound => 'No s’ha trobat cap emoticona. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Només podreu activar el xifratge quan la sala ja no sigui accessible públicament.';

  @override
  String get noGoogleServicesWarning =>
      'Sembla que no teniu els Serveis de Google al telèfon. Això és una bona decisió respecte a la vostra privadesa! Per a rebre notificacions automàtiques del FluffyChat, us recomanem utilitzar https://microg.org/ o https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 is no matrix server, use $server2 instead?';
  }

  @override
  String get shareYourInviteLink => 'Share your invite link';

  @override
  String get scanQrCode => 'Escaneja un codi QR';

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
  String get none => 'Cap';

  @override
  String get noPasswordRecoveryDescription =>
      'Encara no heu afegit cap mètode per a poder recuperar la contrasenya.';

  @override
  String get noPermission => 'Sense permís';

  @override
  String get noRoomsFound => 'No s’ha trobat cap sala…';

  @override
  String get notifications => 'Notificacions';

  @override
  String get notificationsEnabledForThisAccount =>
      'Notificacions activades per a aquest compte';

  @override
  String numUsersTyping(Object count) {
    return '$count usuaris escrivint…';
  }

  @override
  String get obtainingLocation => 'S’està obtenint la ubicació…';

  @override
  String get offensive => 'Offensive';

  @override
  String get offline => 'Fora de línia';

  @override
  String get ok => 'D\'acord';

  @override
  String get online => 'En línia';

  @override
  String get onlineKeyBackupEnabled =>
      'La còpia de seguretat de claus en línia està activada';

  @override
  String get oopsPushError =>
      'Oops! Unfortunately, an error occurred when setting up the push notifications.';

  @override
  String get oopsSomethingWentWrong => 'Alguna cosa ha anat malament…';

  @override
  String get openAppToReadMessages =>
      'Obre l\'aplicació per llegir els missatges';

  @override
  String get openCamera => 'Obre la càmera';

  @override
  String get openVideoCamera => 'Open camera for a video';

  @override
  String get oneClientLoggedOut => 'One of your clients has been logged out';

  @override
  String get addAccount => 'Afegeix un compte';

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
  String get link => 'Enllaç';

  @override
  String get serverRequiresEmail =>
      'This server needs to validate your email address for registration.';

  @override
  String get optionalGroupName => '(Opcional) Nom del grup';

  @override
  String get or => 'O';

  @override
  String get participant => 'Participant';

  @override
  String get passphraseOrKey => 'contrasenya o clau de recuperació';

  @override
  String get password => 'Contrasenya';

  @override
  String get passwordForgotten => 'Contrasenya oblidada';

  @override
  String get passwordHasBeenChanged => 'La contrasenya ha canviat';

  @override
  String get passwordRecovery => 'Recuperació de contrassenya';

  @override
  String get pickImage => 'Selecciona una imatge';

  @override
  String get pin => 'Fixa';

  @override
  String play(Object fileName) {
    return 'Reproduir $fileName';
  }

  @override
  String get pleaseChoose => 'Please choose';

  @override
  String get pleaseChooseAPasscode => 'Tria un codi d\'accés';

  @override
  String get pleaseChooseAUsername => 'Tria un nom d\'usuari';

  @override
  String get pleaseClickOnLink =>
      'Fes clic a l\'enllaç del correu i, després, segueix.';

  @override
  String get pleaseEnter4Digits =>
      'Introdueix 4 dígits o deixa-ho buit per desactivar el bloqueig.';

  @override
  String get pleaseEnterAMatrixIdentifier =>
      'Introdueix un identificador de Matrix.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => 'Introdueix la teva contrasenya';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Please enter your pin';

  @override
  String get pleaseEnterYourUsername => 'Introdueix el teu nom d\'usuari';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Seguiu les instruccions al lloc web i toqueu «Següent».';

  @override
  String get privacy => 'Privadesa';

  @override
  String get publicRooms => 'Sales públiques';

  @override
  String get pushRules => 'Regles push';

  @override
  String get reason => 'Raó';

  @override
  String get recording => 'Enregistrant';

  @override
  String redactedAnEvent(Object username) {
    return '$username ha velat un esdeveniment';
  }

  @override
  String get redactMessage => 'Vela el missatge';

  @override
  String get reject => 'Rebutja';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username ha rebutjat la invitació';
  }

  @override
  String get rejoin => 'Torna-t\'hi a unir';

  @override
  String get remove => 'Elimina';

  @override
  String get removeAllOtherDevices => 'Elimina tots els altres dispositius';

  @override
  String removedBy(Object username) {
    return 'Eliminat per $username';
  }

  @override
  String get removeDevice => 'Elimina dispositiu';

  @override
  String get unbanFromChat => 'Desfés l\'expulsió';

  @override
  String get removeYourAvatar => 'Remove your avatar';

  @override
  String get renderRichContent => 'Mostra el contingut enriquit dels missatges';

  @override
  String get replaceRoomWithNewerVersion => 'Replace room with newer version';

  @override
  String get reply => 'Respon';

  @override
  String get reportMessage => 'Denuncia el missatge';

  @override
  String get requestPermission => 'Sol·licita permís';

  @override
  String get roomHasBeenUpgraded => 'La sala s\'ha actualitzat';

  @override
  String get roomVersion => 'Versió de la sala';

  @override
  String get saveFile => 'Desa el fitxer';

  @override
  String get search => 'Cerca';

  @override
  String get security => 'Seguretat';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return 'Vist per $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Vist per $username i $count més';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Vist per $username i $username2';
  }

  @override
  String get send => 'Envia';

  @override
  String get sendAMessage => 'Envia un missatge';

  @override
  String get sendAsText => 'Envia com a text';

  @override
  String get sendAudio => 'Envia un àudio';

  @override
  String get sendFile => 'Envia un fitxer';

  @override
  String get sendImage => 'Envia una imatge';

  @override
  String get sendMessages => 'Envia missatges';

  @override
  String get sendOriginal => 'Envia l’original';

  @override
  String get sendSticker => 'Envia adhesiu';

  @override
  String get sendVideo => 'Envia un vídeo';

  @override
  String sentAFile(Object username) {
    return '$username ha enviat un fitxer';
  }

  @override
  String sentAnAudio(Object username) {
    return '$username ha enviat un àudio';
  }

  @override
  String sentAPicture(Object username) {
    return '$username ha enviat una imatge';
  }

  @override
  String sentASticker(Object username) {
    return '$username ha enviat un adhesiu';
  }

  @override
  String sentAVideo(Object username) {
    return '$username ha enviat un vídeo';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName ha enviat informació de trucada';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'Defineix com a àlies principal';

  @override
  String get setCustomEmotes => 'Defineix emoticones personalitzades';

  @override
  String get setGroupDescription => 'Defineix la descripció del grup';

  @override
  String get setInvitationLink => 'Defineix l’enllaç per a convidar';

  @override
  String get setPermissionsLevel => 'Defineix el nivell de permisos';

  @override
  String get setStatus => 'Defineix l’estat';

  @override
  String get settings => 'Paràmetres';

  @override
  String get share => 'Comparteix';

  @override
  String sharedTheLocation(Object username) {
    return '$username n’ha compartit la ubicació';
  }

  @override
  String get shareLocation => 'Comparteix la ubicació';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => 'Mostra la contrasenya';

  @override
  String get signUp => 'Registre';

  @override
  String get singlesignon => 'Autenticació única';

  @override
  String get skip => 'Omet';

  @override
  String get sourceCode => 'Codi font';

  @override
  String get spaceIsPublic => 'L’espai és públic';

  @override
  String get spaceName => 'Nom de l’espai';

  @override
  String startedACall(Object senderName) {
    return '$senderName ha iniciat una trucada';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Estat';

  @override
  String get statusExampleMessage => 'Com us sentiu avui?';

  @override
  String get submit => 'Envia';

  @override
  String get synchronizingPleaseWait => 'S’està sincronitzant… Espereu.';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get theyDontMatch => 'No coincideixen';

  @override
  String get theyMatch => 'Coincideixen';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Commuta l’estat «preferit»';

  @override
  String get toggleMuted => 'Commuta l’estat «silenci»';

  @override
  String get toggleUnread => 'Marca com a llegit/sense llegir';

  @override
  String get tooManyRequestsWarning =>
      'Massa sol·licituds. Torna-ho a provar més tard!';

  @override
  String get transferFromAnotherDevice =>
      'Transfereix des d’un altre dispositiu';

  @override
  String get tryToSendAgain => 'Intenta tornar a enviar';

  @override
  String get unavailable => 'No disponible';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username ha tret el veto a $targetName';
  }

  @override
  String get unblockDevice => 'Desbloqueja dispositiu';

  @override
  String get unknownDevice => 'Dispositiu desconegut';

  @override
  String get unknownEncryptionAlgorithm =>
      'L’algorisme de xifratge és desconegut';

  @override
  String get unmuteChat => 'Deixa de silenciar el xat';

  @override
  String get unpin => 'Deixa de fixar';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount xats no llegits',
      one: '1 xat no llegit',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username i $count més estan escrivint…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username i $username2 estan escrivint…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username està escrivint…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '$username ha marxat del xat';
  }

  @override
  String get username => 'Nom d’usuari';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username ha enviat un esdeveniment $type';
  }

  @override
  String get unverified => 'No verificat';

  @override
  String get verified => 'Verificat';

  @override
  String get verify => 'Verifica';

  @override
  String get verifyStart => 'Inicia la verificació';

  @override
  String get verifySuccess => 'T\'has verificat correctament!';

  @override
  String get verifyTitle => 'Verificant un altre compte';

  @override
  String get videoCall => 'Videotrucada';

  @override
  String get visibilityOfTheChatHistory => 'Visibilitat de l’historial del xat';

  @override
  String get visibleForAllParticipants => 'Visible per a tots els participants';

  @override
  String get visibleForEveryone => 'Visible per a tothom';

  @override
  String get voiceMessage => 'Missatge de veu';

  @override
  String get waitingPartnerAcceptRequest =>
      'S’està esperant que l’altre accepti la sol·licitud…';

  @override
  String get waitingPartnerEmoji =>
      'S’està esperant que l’altre accepti l’emoji…';

  @override
  String get waitingPartnerNumbers =>
      'S’està esperant que l’altre accepti els nombres…';

  @override
  String get wallpaper => 'Fons';

  @override
  String get warning => 'Atenció!';

  @override
  String get weSentYouAnEmail =>
      'Us hem enviat un missatge de correu electrònic';

  @override
  String get whoCanPerformWhichAction => 'Qui pot efectuar quina acció';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Qui pot unir-se a aquest grup';

  @override
  String get whyDoYouWantToReportThis => 'Per què voleu denunciar això?';

  @override
  String get wipeChatBackup =>
      'Voleu suprimir la còpia de seguretat dels xats per a crear una clau de seguretat nova?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Amb aquestes adreces, si ho necessiteu, podeu recuperar la vostra contrasenya.';

  @override
  String get writeAMessage => 'Escriviu un missatge…';

  @override
  String get yes => 'Sí';

  @override
  String get you => 'Vós';

  @override
  String get youAreInvitedToThisChat => 'Us han convidat a aquest xat';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Ja no participeu en aquest xat';

  @override
  String get youCannotInviteYourself => 'No us podeu convidar a vós mateix';

  @override
  String get youHaveBeenBannedFromThisChat => 'Has estat vetat d\'aquest xat';

  @override
  String get yourPublicKey => 'La vostra clau pública';

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
