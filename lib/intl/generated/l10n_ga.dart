// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Irish (`ga`).
class L10nGa extends L10n {
  L10nGa([String locale = 'ga']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Cláraigh';

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
  String get passwordsDoNotMatch => 'Níl na pasfhocail chéanna!';

  @override
  String get pleaseEnterValidEmail => 'Iontráil ríomhphost bailí le do thoil.';

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
  String get people => 'Daoine';

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
  String get groups => 'Grúpaí';

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
  String get repeatPassword => 'Scríobh an pasfhocal arís';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Roghnaigh $min carachtar ar a laghad.';
  }

  @override
  String get about => 'Faoi';

  @override
  String get updateAvailable => 'FluffyChat update available';

  @override
  String get updateNow => 'Start update in background';

  @override
  String get accept => 'Glac';

  @override
  String acceptedTheInvitation(Object username) {
    return 'Ghlac $username leis an cuireadh';
  }

  @override
  String get account => 'Cuntas';

  @override
  String activatedEndToEndEncryption(Object username) {
    return 'Thosaigh $username an criptiú ó dheireadh go deireadh';
  }

  @override
  String get addEmail => 'Cuir ríomhphoist';

  @override
  String get confirmMatrixId =>
      'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'Cuir tuairisc grúpa';

  @override
  String get addToSpace => 'Cuir go spás';

  @override
  String get admin => 'Riarthóir';

  @override
  String get alias => 'ailias';

  @override
  String get all => 'Gach';

  @override
  String get allChats => 'Gach comhrá';

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
    return 'D\'fhreagair $senderName an glao';
  }

  @override
  String get anyoneCanJoin => 'Is féidir le aon duine dul isteach';

  @override
  String get appLock => 'Bac aip';

  @override
  String get archive => 'Cartlann';

  @override
  String get areGuestsAllowedToJoin =>
      'An bhfuil cead ag aoi-úsáideoirí a bheith páirteach';

  @override
  String get areYouSure => 'An bhfuil tú cinnte?';

  @override
  String get areYouSureYouWantToLogout =>
      'An bhfuil tú cinnte gur mhaith leat logáil amach?';

  @override
  String get askSSSSSign =>
      'Chun a bheith in ann an duine eile a shíniú, cuir isteach do phasfhrása stóir sábháilte nó d\'eochair téarnaimh.';

  @override
  String askVerificationRequest(Object username) {
    return 'Glac leis an iarratas fíoraithe seo ó $username?';
  }

  @override
  String get autoplayImages =>
      'Seinn greamáin agus straoiseog beoite go huathoibríoch';

  @override
  String get sendOnEnter => 'Seol ar iontráil';

  @override
  String get banFromChat => 'Toirmisc ón gcomhrá';

  @override
  String get banned => 'Coiscthe';

  @override
  String bannedUser(Object username, Object targetName) {
    return 'Chuir $username cosc ar $targetName';
  }

  @override
  String get blockDevice => 'Bac Gléas';

  @override
  String get blocked => 'Bactha';

  @override
  String get botMessages => 'Teachtaireachtaí bota';

  @override
  String get bubbleSize => 'Méid na mbolgán cainte';

  @override
  String get cancel => 'Cealaigh';

  @override
  String cantOpenUri(Object uri) {
    return 'Ní féidir an URI $uri a oscailt';
  }

  @override
  String get changeDeviceName => 'Athraigh ainm an ghléis';

  @override
  String changedTheChatAvatar(Object username) {
    return 'D\'athraigh $username abhatár an chomhrá';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return 'D\'athraigh $username an cur síos comhrá go: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return 'D\'athraigh $username an t-ainm comhrá go: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return 'D\'athraigh $username na ceadanna comhrá';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return 'D\'athraigh $username a n-ainm taispeána go: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return 'D\'athraigh $username na rialacha rochtana aoi';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return 'D\'athraigh $username na rialacha maidir le rochtain aoi chuig: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return 'D\'athraigh $username infheictheacht na staire';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return 'D\'athraigh $username infheictheacht na staire go: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return 'D\'athraigh $username na rialacha ceangail';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return 'D\'athraigh $username na rialacha ceangail go: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return 'D\'athraigh $username a n-abhatár';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return 'D\'athraigh $username ailiasanna an tseomra';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return 'D\'athraigh $username nasc an chuiridh';
  }

  @override
  String get changePassword => 'Athraigh an pasfhocal';

  @override
  String get changeTheHomeserver => 'Athraigh an freastalaí baile';

  @override
  String get changeTheme => 'Athraigh do stíl';

  @override
  String get changeTheNameOfTheGroup => 'Athraigh ainm an ghrúpa';

  @override
  String get changeWallpaper => 'Athraigh cúlbhrat';

  @override
  String get changeYourAvatar => 'Athraigh do abhatár';

  @override
  String get channelCorruptedDecryptError => 'Truaillíodh an criptiú';

  @override
  String get chat => 'Comhrá';

  @override
  String get yourChatBackupHasBeenSetUp => 'Bunaíodh do chúltaca comhrá.';

  @override
  String get chatBackup => 'Cúltaca comhrá';

  @override
  String get chatBackupDescription =>
      'Tá do chúltaca comhrá daingnithe le heochair slándála. Déan cinnte nach gcaillfidh tú é.';

  @override
  String get chatDetails => 'Sonraí comhrá';

  @override
  String get chatHasBeenAddedToThisSpace => 'Cuireadh comhrá leis an spás seo';

  @override
  String get chats => 'Comhráite';

  @override
  String get chooseAStrongPassword => 'Roghnaigh pasfhocal láidir';

  @override
  String get chooseAUsername => 'Roghnaigh ainm úsáideora';

  @override
  String get clearArchive => 'Glan an cartlann';

  @override
  String get close => 'Dún';

  @override
  String get commandHint_markasdm => 'Mark as direct message room';

  @override
  String get commandHint_markasgroup => 'Mark as group';

  @override
  String get commandHint_ban =>
      'Cuir cosc ar an úsáideoir áirithe ón seomra seo';

  @override
  String get commandHint_clearcache => 'Glan an taisce';

  @override
  String get commandHint_create =>
      'Cruthaigh comhrá grúpa folamh\nÚsáid --no-encryption chun criptiúchán a dhíchumasú';

  @override
  String get commandHint_discardsession => 'Discard session';

  @override
  String get commandHint_dm =>
      'Start a direct chat\nUse --no-encryption to disable encryption';

  @override
  String get commandHint_html => 'Seol téacs HTML-formáidithe';

  @override
  String get commandHint_invite =>
      'Cuir cosc ar an úsáideoir áirithe ón seomra seo';

  @override
  String get commandHint_join => 'Téigh isteach sa seomra áirithe';

  @override
  String get commandHint_kick => 'Bain an t-úsáideoir áirithe den seomra seo';

  @override
  String get commandHint_leave => 'Fág an seomra seo';

  @override
  String get commandHint_me => 'Déan cur síos ort féin';

  @override
  String get commandHint_myroomavatar =>
      'Cuir do phictiúr don seomra seo (le mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Socraigh d\'ainm taispeána don seomra seo';

  @override
  String get commandHint_op =>
      'Socraigh leibhéal cumhachta an úsáideora áirithe (réamhshocrú: 50)';

  @override
  String get commandHint_plain => 'Seol téacs neamhfhoirmithe';

  @override
  String get commandHint_react => 'Seol freagra mar fhreagairt';

  @override
  String get commandHint_send => 'Seol téacs';

  @override
  String get commandHint_unban =>
      'Cuir deireadh an cosc den úsáideoir áirithe ón seomra seo';

  @override
  String get commandInvalid => 'Ordú neamhbhailí';

  @override
  String commandMissing(Object command) {
    return 'Ní ordú é $command.';
  }

  @override
  String get compareEmojiMatch =>
      'Déan comparáid agus déan cinnte go bhfuil an emoji seo a leanas comhoiriúnach le emoji an ghléis eile:';

  @override
  String get compareNumbersMatch =>
      'Déan comparáid idir na huimhreacha seo a leanas agus déan cinnte go bhfuil na huimhreacha seo a leanas ag teacht le huimhreacha an ghléis eile:';

  @override
  String get configureChat => 'Cumraigh comhrá';

  @override
  String get confirm => 'Deimhnigh';

  @override
  String get connect => 'Ceangail';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Tugadh cuireadh don theagmháil a thar isteach sa grúpa';

  @override
  String get containsDisplayName => 'Coinníonn sé ainm taispeána';

  @override
  String get containsUserName => 'Coinníonn sé ainm úsáideora';

  @override
  String get contentHasBeenReported =>
      'Tuairiscíodh an t-ábhar do lucht riaracháin an fhreastalaí';

  @override
  String get copiedToClipboard => 'Cóipeáilte ar an ghearrthaisce';

  @override
  String get copy => 'Cóipeáil';

  @override
  String get copyToClipboard => 'Cóipeáil ar an ghearrthaisce';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Níorbh fhéidir teachtaireacht a dhíchriptiú: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count rannpháirtithe';
  }

  @override
  String get create => 'Cruthaigh';

  @override
  String createdTheChat(Object username) {
    return 'Rinne $username an comhrá';
  }

  @override
  String get createNewGroup => 'Déan grúpa nua';

  @override
  String get createNewSpace => 'Spás nua';

  @override
  String get currentlyActive => 'Gníomhach faoi láthair';

  @override
  String get darkTheme => 'Dorcha';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$day/$month';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$day/$month/$year';
  }

  @override
  String get deactivateAccountWarning =>
      'Díghníomhachtaeoidh sé seo do chuntas úsáideora. Ní féidir é seo a chealú! An bhfuil tú cinnte?';

  @override
  String get defaultPermissionLevel => 'Leibhéal ceada réamhshocraithe';

  @override
  String get delete => 'Scrios';

  @override
  String get deleteAccount => 'Scrios an cuntas';

  @override
  String get deleteMessage => 'Scrios an teachtaireacht';

  @override
  String get deny => 'Diúltaigh';

  @override
  String get device => 'Gléas';

  @override
  String get deviceId => 'ID gléis';

  @override
  String get devices => 'Gléasanna';

  @override
  String get directChats => 'Comhráite Díreacha';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Athraíodh an t-ainm taispeána';

  @override
  String get downloadFile => 'Íoslódáil comhad';

  @override
  String get edit => 'Cuir in eagar';

  @override
  String get editBlockedServers => 'Cuir freastalaí blocáilte in eagar';

  @override
  String get editChatPermissions => 'Cuir ceadanna an chomhrá in eagar';

  @override
  String get editDisplayname => 'Cuir ainm taispeána in eagar';

  @override
  String get editRoomAliases => 'Cuir ailiasanna an tseomra in eagar';

  @override
  String get editRoomAvatar => 'Cuir in eagar abhatár an tseomra';

  @override
  String get emoteExists => 'Tá iomaite ann cheana féin!';

  @override
  String get emoteInvalid => 'Gearrchód emote neamhbhailí!';

  @override
  String get emotePacks => 'Pacáistí straoiseoige don seomra';

  @override
  String get emoteSettings => 'Socruithe straoiseoige';

  @override
  String get emoteShortcode => 'Gearrchód straoiseoige';

  @override
  String get emoteWarnNeedToPick =>
      'Caithfidh tú gearrchód straoiseoige agus íomhá a roghnú!';

  @override
  String get emptyChat => 'Comhrá folamh';

  @override
  String get enableEmotesGlobally =>
      'Cumasaigh pacáiste straoiseoige go huilíoch';

  @override
  String get enableEncryption => 'Tosaigh criptiú';

  @override
  String get enableEncryptionWarning =>
      'Ní bheidh in ann an criptiú a dhíchumasú níos mó. An bhfuil tú cinnte?';

  @override
  String get encrypted => 'Criptithe';

  @override
  String get encryption => 'Criptiúchán';

  @override
  String get encryptionNotEnabled => 'Ní chumasaítear criptiú';

  @override
  String endedTheCall(Object senderName) {
    return 'Chuir $senderName deireadh leis an nglao';
  }

  @override
  String get enterAGroupName => 'Iontráil ainm grúpa';

  @override
  String get enterAnEmailAddress => 'Cuir isteach seoladh ríomhphoist';

  @override
  String get enterASpacepName => 'Cuir isteach ainm spáis';

  @override
  String get homeserver => 'Freastalaí baile';

  @override
  String get enterYourHomeserver => 'Cuir isteach do fhreastalaí baile';

  @override
  String errorObtainingLocation(Object error) {
    return 'Earráid maidir le suíomh a fháil: $error';
  }

  @override
  String get everythingReady => 'Gach rud réidh!';

  @override
  String get extremeOffensive => 'Fíor-maslach';

  @override
  String get fileName => 'Ainm an chomhaid';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Méid cló';

  @override
  String get forward => 'Seol ar aghaidh';

  @override
  String get fromJoining => 'Ó tar isteach';

  @override
  String get fromTheInvitation => 'Ón gcuireadh';

  @override
  String get goToTheNewRoom => 'Téigh go dtí an seomra nua';

  @override
  String get group => 'Grúpa';

  @override
  String get groupDescription => 'Cur síos ar an ngrúpa';

  @override
  String get groupDescriptionHasBeenChanged => 'D\'athraigh cur síos an ghrúpa';

  @override
  String get groupIsPublic => 'Tá an grúpa poiblí';

  @override
  String groupWith(Object displayname) {
    return 'Grúpa le $displayname';
  }

  @override
  String get guestsAreForbidden => 'Tá cosc ar aíonna';

  @override
  String get guestsCanJoin => 'Is féidir le haíonna páirt a ghlacadh';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return 'Tharraing $username an cuireadh do $targetName siar';
  }

  @override
  String get help => 'Cabhair';

  @override
  String get hideRedactedEvents => 'Folaigh imeachtaí athdhéanta';

  @override
  String get hideUnknownEvents => 'Folaigh imeachtaí anaithnide';

  @override
  String get howOffensiveIsThisContent =>
      'Cé chomh maslach atá an t-ábhar seo?';

  @override
  String get id => 'ID';

  @override
  String get identity => 'Aitheantas';

  @override
  String get ignore => 'Tabhair neamhaird ar';

  @override
  String get ignoredUsers => 'Úsáideoirí a dtugann tú neamhaird orthu';

  @override
  String get ignoreListDescription =>
      'Is féidir leat neamhaird a dhéanamh d\'úsáideoirí atá ag cur isteach ort. Ní bheidh tú in ann aon teachtaireachtaí nó cuireadh seomra a fháil ó na húsáideoirí ar do liosta neamhaird phearsanta.';

  @override
  String get ignoreUsername => 'Tabhair neamhaird ar ainm úsáideora';

  @override
  String get iHaveClickedOnLink => 'Chliceáil mé ar an nasc';

  @override
  String get incorrectPassphraseOrKey =>
      'Pasfhrása nó eochair téarnaimh mícheart';

  @override
  String get inoffensive => 'Neamhurchóideach';

  @override
  String get inviteContact => 'Tabhair cuireadh do theagmháil';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Tabhair cuireadh do theagmháil chuig $groupName';
  }

  @override
  String get invited => 'Le cuireadh';

  @override
  String invitedUser(Object username, Object targetName) {
    return 'Thug $username cuireadh do $targetName';
  }

  @override
  String get invitedUsersOnly => 'Úsáideoirí le cuireadh amháin';

  @override
  String get inviteForMe => 'Tabhair cuireadh dom';

  @override
  String inviteText(Object username, Object link) {
    return 'Thug $username cuireadh duit chuig FluffyChat.\n1. Suiteáil FluffyChat: https://fluffychat.im\n2. Cláraigh nó sínigh isteach\n3. Oscail an nasc cuiridh: $link';
  }

  @override
  String get isTyping => 'ag clóscríobh…';

  @override
  String joinedTheChat(Object username) {
    return 'Tháinig $username isteach sa chomhrá';
  }

  @override
  String get joinRoom => 'Téigh isteach sa seomra';

  @override
  String kicked(Object username, Object targetName) {
    return 'Chaith $username $targetName amach';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return 'Chaith $username amach agus chuir cosc ar $targetName freisin';
  }

  @override
  String get kickFromChat => 'Caith é amach as an comhrá';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Gníomhach deireanach: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Le feiceáil i bhfad ó shin';

  @override
  String get leave => 'Fág';

  @override
  String get leftTheChat => 'Fágadh an comhrá';

  @override
  String get license => 'Ceadúnas';

  @override
  String get lightTheme => 'Solas';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Lódáil $count níos mó rannpháirtithe';
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
  String get loadingPleaseWait => 'Ag lódáil… Fan, le do thoil.';

  @override
  String get loadMore => 'Lódáil níos mó…';

  @override
  String get locationDisabledNotice =>
      'Tá seirbhísí suímh díchumasaithe. Cuir ar a gcumas le do thoil a bheith in ann do shuíomh a roinnt.';

  @override
  String get locationPermissionDeniedNotice =>
      'Diúltaíodh cead suímh. Deonaigh dóibh le do thoil go mbeidh tú in ann do shuíomh a roinnt.';

  @override
  String get login => 'Logáil isteach';

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
    return 'Logáil isteach chuig $homeserver';
  }

  @override
  String get loginWithOneClick => 'Sign in with one click';

  @override
  String get logout => 'Logáil amach';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Cinntigh go bhfuil an t-aitheantóir bailí';

  @override
  String get memberChanges => 'Athruithe ball';

  @override
  String get mention => 'Luaigh';

  @override
  String get messages => 'Teachtaireachtaí';

  @override
  String get messageWillBeRemovedWarning =>
      'Bainfear an teachtaireacht do na rannpháirtithe go léir';

  @override
  String get moderator => 'Modhnóir';

  @override
  String get muteChat => 'Ciúnaigh comhrá';

  @override
  String get needPantalaimonWarning =>
      'Bí ar an eolas go dteastaíonn Pantalaimon uait chun criptiú ó cheann go ceann a úsáid anois.';

  @override
  String get newChat => 'Comhrá nua';

  @override
  String get newMessageInFluffyChat => 'Teachtaireacht nua i FluffyChat';

  @override
  String get newVerificationRequest => 'Iarratas fíoraithe nua!';

  @override
  String get next => 'Ar Aghaidh';

  @override
  String get no => 'Níl';

  @override
  String get noConnectionToTheServer => 'Gan aon nasc leis an bhfreastalaí';

  @override
  String get noEmotesFound => 'Níor aimsíodh aon straoiseoga. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Ní féidir leat criptiú a ghníomhachtú ach a luaithe nach bhfuil an seomra inrochtana go poiblí a thuilleadh.';

  @override
  String get noGoogleServicesWarning =>
      'Dealraíonn sé nach bhfuil aon seirbhísí google agat ar do ghuthán. Sin cinneadh maith le do phríobháideacht! Chun fógraí brú a fháil i FluffyChat molaimid https://microg.org/ nó https://unifiedpush.org/ a úsáid.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return 'Níl $server1 freastalaí Matrix. Úsáid $server2 ina áit sin?';
  }

  @override
  String get shareYourInviteLink => 'Roinn do nasc cuiridh';

  @override
  String get scanQrCode => 'Scan cód QR';

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
  String get none => 'Aon cheann';

  @override
  String get noPasswordRecoveryDescription =>
      'Níor chuir tú bealach leis do phasfhocal a aisghabháil fós.';

  @override
  String get noPermission => 'Gan cead';

  @override
  String get noRoomsFound => 'Níor aimsíodh aon seomraí…';

  @override
  String get notifications => 'Fógraí';

  @override
  String get notificationsEnabledForThisAccount =>
      'Fógraí cumasaithe don chuntas seo';

  @override
  String numUsersTyping(Object count) {
    return 'Tá $count úsáideoirí ag clóscríobh…';
  }

  @override
  String get obtainingLocation => 'ag Aimsiú an suíomh…';

  @override
  String get offensive => 'Maslach';

  @override
  String get offline => 'As líne';

  @override
  String get ok => 'togha';

  @override
  String get online => 'Ar líne';

  @override
  String get onlineKeyBackupEnabled => 'Tá Cúltaca Eochair Ar Líne cumasaithe';

  @override
  String get oopsPushError =>
      'Hoips! Ar an drochuair, tharla earráid nuair a bhí na fógraí brú á mbunú.';

  @override
  String get oopsSomethingWentWrong => 'Úps, chuaigh rud éigin mícheart …';

  @override
  String get openAppToReadMessages =>
      'Oscail an aip chun teachtaireachtaí a léamh';

  @override
  String get openCamera => 'Oscail ceamara';

  @override
  String get openVideoCamera => 'Oscail físcheamara';

  @override
  String get oneClientLoggedOut => 'One of your clients has been logged out';

  @override
  String get addAccount => 'Breisigh cuntas';

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
      '(BÉITE) Cumasaigh cuntais iomadúla ar an gléas seo';

  @override
  String get openInMaps => 'Oscail i léarscáileanna';

  @override
  String get link => 'Nasc';

  @override
  String get serverRequiresEmail =>
      'Ní mór don fhreastalaí seo do sheoladh ríomhphoist a bhailíochtú le haghaidh clárúcháin.';

  @override
  String get optionalGroupName => '(Optional) Ainm an ghrúpa';

  @override
  String get or => 'Nó';

  @override
  String get participant => 'Rannpháirtí';

  @override
  String get passphraseOrKey => 'pasfhrása nó eochair téarnaimh';

  @override
  String get password => 'Pasfhocal';

  @override
  String get passwordForgotten => 'Pasfhocal dearmadta';

  @override
  String get passwordHasBeenChanged => 'Athraíodh an pasfhocal';

  @override
  String get passwordRecovery => 'Aisfháil pasfhocail';

  @override
  String get pickImage => 'Roghnaigh íomhá';

  @override
  String get pin => 'Biorán';

  @override
  String play(Object fileName) {
    return 'Seinn $fileName';
  }

  @override
  String get pleaseChoose => 'Roghnaigh le do thoil';

  @override
  String get pleaseChooseAPasscode => 'Roghnaigh paschód le do thoil';

  @override
  String get pleaseChooseAUsername => 'Roghnaigh ainm úsáideora le do thoil';

  @override
  String get pleaseClickOnLink =>
      'Cliceáil ar an nasc sa ríomhphost agus ansin lean ar aghaidh.';

  @override
  String get pleaseEnter4Digits =>
      'Iontráil 4 dhigit le do thoil nó fág folamh chun glas aipe a dhíchumasú.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Iontráil ID Matrix le do thoil.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => 'Iontráil do phasfhocal le do thoil';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Cuir isteach d\'uimhir PIN le do thoil';

  @override
  String get pleaseEnterYourUsername =>
      'Cuir isteach d\'ainm úsáideora le do thoil';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Lean na treoracha ar an suíomh gréasáin agus tapáil \"ar aghaidh\".';

  @override
  String get privacy => 'Príobháideacht';

  @override
  String get publicRooms => 'Seomraí Poiblí';

  @override
  String get pushRules => 'Rialacha na bhfógraí';

  @override
  String get reason => 'Fáth';

  @override
  String get recording => 'Ag Taifeadadh';

  @override
  String redactedAnEvent(Object username) {
    return 'Rinne $username cinsire imeacht';
  }

  @override
  String get redactMessage => 'Bain teachtaireacht amach';

  @override
  String get reject => 'Diúltaigh';

  @override
  String rejectedTheInvitation(Object username) {
    return 'Dhiúltaigh $username don chuireadh';
  }

  @override
  String get rejoin => 'Téigh ar ais isteach';

  @override
  String get remove => 'Bain';

  @override
  String get removeAllOtherDevices => 'Bain gach gléas eile';

  @override
  String removedBy(Object username) {
    return 'Bainte de ag $username';
  }

  @override
  String get removeDevice => 'Bain gléas';

  @override
  String get unbanFromChat => 'Cuir deireadh an cosc ón gcomhrá';

  @override
  String get removeYourAvatar => 'Bain d\'abhatár';

  @override
  String get renderRichContent => 'Taispeáin ábhar teachtaireachta saibhir';

  @override
  String get replaceRoomWithNewerVersion =>
      'Cuir leagan seomra níos nuaí in ionad an tseomra';

  @override
  String get reply => 'Freagair';

  @override
  String get reportMessage => 'Tuairiscigh teachtaireacht';

  @override
  String get requestPermission => 'Iarr cead';

  @override
  String get roomHasBeenUpgraded => 'Uasghrádaíodh an seomra';

  @override
  String get roomVersion => 'Leagan seomra';

  @override
  String get saveFile => 'Sábháil comhad';

  @override
  String get search => 'Cuardaigh';

  @override
  String get security => 'Slándáil';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return 'Le feiceáil ag $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Feicthe ag $username agus $count duine eile';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Le feiceáil ag $username agus $username2';
  }

  @override
  String get send => 'Seol';

  @override
  String get sendAMessage => 'Seol teachtaireacht';

  @override
  String get sendAsText => 'Seol mar théacs';

  @override
  String get sendAudio => 'Seol fuaim';

  @override
  String get sendFile => 'Seol comhad';

  @override
  String get sendImage => 'Seol íomhá';

  @override
  String get sendMessages => 'Seol teachtaireachtaí';

  @override
  String get sendOriginal => 'Seol an bunchóip';

  @override
  String get sendSticker => 'Seol greamán';

  @override
  String get sendVideo => 'Seol físeán';

  @override
  String sentAFile(Object username) {
    return 'Sheol $username comhad';
  }

  @override
  String sentAnAudio(Object username) {
    return 'Sheol $username fuaim';
  }

  @override
  String sentAPicture(Object username) {
    return 'Sheol $username pictiúr';
  }

  @override
  String sentASticker(Object username) {
    return 'Sheol $username greamán';
  }

  @override
  String sentAVideo(Object username) {
    return 'Sheol $username físeán';
  }

  @override
  String sentCallInformations(Object senderName) {
    return 'Sheol $senderName faisnéis maidir le glaonna';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'Socraigh mar phríomh-ailias';

  @override
  String get setCustomEmotes => 'Socraigh straoiseoga saincheaptha';

  @override
  String get setGroupDescription => 'Socraigh cur síos ar an ngrúpa';

  @override
  String get setInvitationLink => 'Socraigh nasc cuiridh';

  @override
  String get setPermissionsLevel => 'Socraigh leibhéal ceadanna';

  @override
  String get setStatus => 'Cuir stádas';

  @override
  String get settings => 'Socruithe';

  @override
  String get share => 'Roinn';

  @override
  String sharedTheLocation(Object username) {
    return 'Roinn $username an suíomh';
  }

  @override
  String get shareLocation => 'Roinn suíomh';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => 'Taispeáin pasfhocal';

  @override
  String get signUp => 'Cláraigh Cuntas';

  @override
  String get singlesignon => 'Sínigh Aonair ar';

  @override
  String get skip => 'Léim';

  @override
  String get sourceCode => 'Cód foinseach';

  @override
  String get spaceIsPublic => 'Tá an spás poiblí';

  @override
  String get spaceName => 'Ainm an spáis';

  @override
  String startedACall(Object senderName) {
    return 'Thosaigh $senderName glao';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Staid';

  @override
  String get statusExampleMessage => 'Conas atá tú inniu?';

  @override
  String get submit => 'Cuir isteach';

  @override
  String get synchronizingPleaseWait => 'Ag sioncrónú... Fan, le do thoil.';

  @override
  String get systemTheme => 'Córas';

  @override
  String get theyDontMatch => 'Níl siad céanna';

  @override
  String get theyMatch => 'Tá siad céanna';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Scoránaigh mar ceann is fearr leat';

  @override
  String get toggleMuted => 'Scoránaigh mar ciúnaithe';

  @override
  String get toggleUnread => 'Marcáil Léite/Neamhléite';

  @override
  String get tooManyRequestsWarning =>
      'An iomarca iarratas. Bain triail eile as níos déanaí!';

  @override
  String get transferFromAnotherDevice => 'Aistriú ó ghléas eile';

  @override
  String get tryToSendAgain => 'Déan iarracht a sheoladh arís';

  @override
  String get unavailable => 'Níl ar fáil';

  @override
  String unbannedUser(Object username, Object targetName) {
    return 'Chuir $username deireadh an cosc $targetName';
  }

  @override
  String get unblockDevice => 'Díbhlocáil Gléas';

  @override
  String get unknownDevice => 'Gléas anaithnid';

  @override
  String get unknownEncryptionAlgorithm => 'Algartam criptithe anaithnid';

  @override
  String get unmuteChat => 'Neamhciúnaigh comhrá';

  @override
  String get unpin => 'Bain biorán';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount comhráite neamhléite',
      one: '1 comhrá neamhléite',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return 'tá $username agus $count daoine eile ag clóscríobh…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return 'Tá $username agus $username2 ag clóscríobh…';
  }

  @override
  String userIsTyping(Object username) {
    return 'Tá $username ag clóscríobh…';
  }

  @override
  String userLeftTheChat(Object username) {
    return 'D\'fhág $username an comhrá';
  }

  @override
  String get username => 'Ainm úsáideora';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return 'Sheol $username imeacht $type';
  }

  @override
  String get unverified => 'Unverified';

  @override
  String get verified => 'Deimhnithe';

  @override
  String get verify => 'Deimhnigh';

  @override
  String get verifyStart => 'Tosaigh Fíorú';

  @override
  String get verifySuccess => 'D\'fhíoraigh tú go rathúil!';

  @override
  String get verifyTitle => 'Ag fíorú cuntas eile';

  @override
  String get videoCall => 'Físghlao';

  @override
  String get visibilityOfTheChatHistory => 'Infheictheacht stair na comhrá';

  @override
  String get visibleForAllParticipants =>
      'Infheicthe do na rannpháirtithe go léir';

  @override
  String get visibleForEveryone => 'Infheicthe do gach duine';

  @override
  String get voiceMessage => 'Glórphost';

  @override
  String get waitingPartnerAcceptRequest =>
      'Ag fanacht le comhpháirtí glacadh leis an iarratas…';

  @override
  String get waitingPartnerEmoji =>
      'Ag fanacht le comhpháirtí glacadh leis na straoiseoga…';

  @override
  String get waitingPartnerNumbers =>
      'Ag fanacht le comhpháirtí glacadh leis na huimhreacha …';

  @override
  String get wallpaper => 'Cúlbhrat';

  @override
  String get warning => 'Rabhadh!';

  @override
  String get weSentYouAnEmail => 'Sheolamar ríomhphost chugat';

  @override
  String get whoCanPerformWhichAction => 'Cé atá in ann an gníomh a dhéanamh';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Cé a bhfuil cead aige/aici dul isteach sa ghrúpa seo';

  @override
  String get whyDoYouWantToReportThis =>
      'Cén fáth ar mhaith leat é seo a thuairisciú?';

  @override
  String get wipeChatBackup =>
      'Glan do cúltaca comhrá a chruthú eochair slándála nua?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Leis na seoltaí seo is féidir leat do phasfhocal a athshlánú.';

  @override
  String get writeAMessage => 'Scríobh teachtaireacht…';

  @override
  String get yes => 'Tá';

  @override
  String get you => 'Tú';

  @override
  String get youAreInvitedToThisChat =>
      'Tugtar cuireadh duit chuig an gcomhrá seo';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Níl tú ag glacadh páirte sa chomhrá seo a thuilleadh';

  @override
  String get youCannotInviteYourself =>
      'Ní féidir leat cuireadh a thabhairt duit féin';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Cuireadh cosc ort ón gcomhrá seo';

  @override
  String get yourPublicKey => 'D\'eochair phoiblí';

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
      'Tabhair faoi deara go bhfuil físglaonna i béite. B\'fhéidir nach bhfeidhmíonn siad ar gach ardán chomh atá súil aige ná ar bith.';

  @override
  String get experimentalVideoCalls => 'Experimental video calls';

  @override
  String get emailOrUsername => 'Ríomhphost nó ainm úsáideora';

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
