// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class L10nLt extends L10n {
  L10nLt([String locale = 'lt']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Registruotis';

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
  String get passwordsDoNotMatch => 'Slaptažodžiai nesutampa!';

  @override
  String get pleaseEnterValidEmail => 'Įveskite teisingą el. pašto adresą.';

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
  String get people => 'Žmonės';

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
  String get groups => 'Grupės';

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
  String get repeatPassword => 'Pakartokite slaptažodį';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Pasirinkite bent $min simbolius.';
  }

  @override
  String get about => 'Apie';

  @override
  String get updateAvailable => 'Galimas FluffyChat atnaujinimas';

  @override
  String get updateNow => 'Pradėti atnaujinimą fone';

  @override
  String get accept => 'Sutinku';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username priėmė kvietimą';
  }

  @override
  String get account => 'Paskyra';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username aktyvavo visapusį šifravimą';
  }

  @override
  String get addEmail => 'Pridėti el. paštą';

  @override
  String get confirmMatrixId =>
      'Norėdami ištrinti savo paskyrą, patvirtinkite savo Matrix ID.';

  @override
  String supposedMxid(Object mxid) {
    return 'Tai turėtų būti $mxid';
  }

  @override
  String get addGroupDescription => 'Pridėkite grupės aprašymą';

  @override
  String get addToSpace => 'Pridėti į erdvę';

  @override
  String get admin => 'Administratorius';

  @override
  String get alias => 'slapyvardis';

  @override
  String get all => 'Visi';

  @override
  String get allChats => 'Visi pokalbiai';

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
    return '$senderName atsiliepė į skambutį';
  }

  @override
  String get anyoneCanJoin => 'Bet kas gali prisijungti';

  @override
  String get appLock => 'Programos užraktas';

  @override
  String get archive => 'Archyvas';

  @override
  String get areGuestsAllowedToJoin => 'Ar svečiams leidžiama prisijungti';

  @override
  String get areYouSure => 'Ar esate tikri?';

  @override
  String get areYouSureYouWantToLogout => 'Ar tikrai norite atsijungti?';

  @override
  String get askSSSSSign =>
      'Kad galėtumėte prijungti kitą asmenį, įveskite savo saugyklos slaptafrazę arba atkūrimo raktą.';

  @override
  String askVerificationRequest(Object username) {
    return 'Priimti šią patvirtinimo užklausą iš $username?';
  }

  @override
  String get autoplayImages =>
      'Automatiškai leisti animuotus lipdukus ir jaustukus';

  @override
  String get sendOnEnter => 'Išsiųsti paspaudus Enter';

  @override
  String get banFromChat => 'Užblokuoti iš pokalbio';

  @override
  String get banned => 'Užblokuotas';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username užblokavo $targetName';
  }

  @override
  String get blockDevice => 'Blokuoti įrenginį';

  @override
  String get blocked => 'Užblokuotas';

  @override
  String get botMessages => 'Botų žinutės';

  @override
  String get bubbleSize => 'Burbulo dydis';

  @override
  String get cancel => 'Atšaukti';

  @override
  String cantOpenUri(Object uri) {
    return 'Nepavyksta atidaryti URI $uri';
  }

  @override
  String get changeDeviceName => 'Pakeisti įrenginio vardą';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username pakeitė pokalbio avatarą';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username pakeitė pokalbio aprašymą į: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username pakeitė pokalbio pavadinimą į: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username pakeitė pokalbių leidimus';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username pakeitė rodomą vardą į: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username pakeitė svečio prieigos taisykles';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username pakeitė svečio prieigos taisykles į: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username pakeitė istorijos matomumą';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username pakeitė istorijos matomumą į: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username pakeitė prisijungimo taisykles';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username pakeitė prisijungimo taisykles į: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username pakeitė savo avatarą';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username pakeitė kambario pseudonimus';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username pakeitė pakvietimo nuorodą';
  }

  @override
  String get changePassword => 'Keisti slaptažodį';

  @override
  String get changeTheHomeserver => 'Pakeisti namų serverį';

  @override
  String get changeTheme => 'Keisti savo stilių';

  @override
  String get changeTheNameOfTheGroup => 'Keisti grupės pavadinimą';

  @override
  String get changeWallpaper => 'Keisti ekrano užsklandą';

  @override
  String get changeYourAvatar => 'Keisti savo avatarą';

  @override
  String get channelCorruptedDecryptError => 'Šifravimas buvo sugadintas';

  @override
  String get chat => 'Pokalbis';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'Jūsų pokalbio atsarginė kopija buvo nustatyta.';

  @override
  String get chatBackup => 'Pokalbio atsargine kopija';

  @override
  String get chatBackupDescription =>
      'Jūsų senos žinutės yra apsaugotos atkūrimo raktu. Pasirūpinkite, kad jo neprarastumėte.';

  @override
  String get chatDetails => 'Pokalbio detalės';

  @override
  String get chatHasBeenAddedToThisSpace =>
      'Pokalbis buvo pridėtas prie šios erdvės';

  @override
  String get chats => 'Pokalbiai';

  @override
  String get chooseAStrongPassword => 'Pasirinkite saugų slaptažodį';

  @override
  String get chooseAUsername => 'Pasirinkite vartotojo vardą';

  @override
  String get clearArchive => 'Išvalyti archyvą';

  @override
  String get close => 'Uždaryti';

  @override
  String get commandHint_markasdm =>
      'Pažymėti kaip tiesioginio pokalbio kambarį';

  @override
  String get commandHint_markasgroup => 'Pažymėti kaip grupę';

  @override
  String get commandHint_ban => 'Užblokuoti vartotoją šiame kambaryje';

  @override
  String get commandHint_clearcache => 'Išvalyti laikiną talpyklą';

  @override
  String get commandHint_create =>
      'Sukurti tuščią grupinį pokalbį\nNaudokite --no-encryption kad išjungti šifravimą';

  @override
  String get commandHint_discardsession => 'Atmesti sesiją';

  @override
  String get commandHint_dm =>
      'Pradėti tiesioginį pokalbį\nNaudokite --no-encryption kad išjungti šifravimą';

  @override
  String get commandHint_html => 'Siųsti tekstą HTML formatu';

  @override
  String get commandHint_invite => 'Pakviesti vartotoją į šitą kambarį';

  @override
  String get commandHint_join => 'Prisijungti prie nurodyto kambario';

  @override
  String get commandHint_kick => 'Pašalinti vartotoja iš šito kambario';

  @override
  String get commandHint_leave => 'Palikti pokalbių kambarį';

  @override
  String get commandHint_me => 'Apibūdinkite save';

  @override
  String get commandHint_myroomavatar =>
      'Nustatyti savo nuotrauką šiame kambaryje (su mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Nustatyti savo rodomą vardą šiame kambaryje';

  @override
  String get commandHint_op =>
      'Nustatyti naudotojo galios lygį (numatytasis: 50)';

  @override
  String get commandHint_plain => 'Siųsti neformatuotą tekstą';

  @override
  String get commandHint_react => 'Siųsti atsakymą kaip reakciją';

  @override
  String get commandHint_send => 'Siųsti tekstą';

  @override
  String get commandHint_unban => 'Atblokuoti vartotoją šiame kambaryje';

  @override
  String get commandInvalid => 'Neteisinga komanda';

  @override
  String commandMissing(Object command) {
    return '$command nėra komanda.';
  }

  @override
  String get compareEmojiMatch => 'Palyginkite jaustukus';

  @override
  String get compareNumbersMatch => 'Palyginkite skaičius';

  @override
  String get configureChat => 'Konfigūruoti pokalbį';

  @override
  String get confirm => 'Patvirtinti';

  @override
  String get connect => 'Prisijungti';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Kontaktas buvo pakviestas į grupę';

  @override
  String get containsDisplayName => 'Turi rodomą vardą';

  @override
  String get containsUserName => 'Turi vartotojo vardą';

  @override
  String get contentHasBeenReported =>
      'Apie turinį pranešta serverio administratoriams';

  @override
  String get copiedToClipboard => 'Nukopijuota į iškarpinę';

  @override
  String get copy => 'Kopijuoti';

  @override
  String get copyToClipboard => 'Koipjuoti į iškarpinę';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Nepavyko iššifruoti pranešimo: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count dalyviai';
  }

  @override
  String get create => 'Sukurti';

  @override
  String createdTheChat(Object username) {
    return '💬 $username sukūrė pokalbį';
  }

  @override
  String get createNewGroup => 'Sukurti naują grupę';

  @override
  String get createNewSpace => 'Nauja erdvė';

  @override
  String get currentlyActive => 'Šiuo metu aktyvus';

  @override
  String get darkTheme => 'Tamsi';

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
      'Tai deaktyvuos jūsų vartotojo paskyrą. Tai negali būti atšaukta! Ar jūs tuo tikri?';

  @override
  String get defaultPermissionLevel => 'Numatytasis teisių lygis';

  @override
  String get delete => 'Ištrinti';

  @override
  String get deleteAccount => 'Panaikinti paskyra';

  @override
  String get deleteMessage => 'Ištrinti žinutę';

  @override
  String get deny => 'Atmesti';

  @override
  String get device => 'Įrenginys';

  @override
  String get deviceId => 'Įrenginio ID';

  @override
  String get devices => 'Įrenginiai';

  @override
  String get directChats => 'Tiesioginiai pokalbiai';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Rodomas vardas buvo pakeistas';

  @override
  String get downloadFile => 'Atsisiųsti failą';

  @override
  String get edit => 'Redaguoti';

  @override
  String get editBlockedServers => 'Redaguoti blokuotus serverius';

  @override
  String get editChatPermissions => 'Redaguoti pokalbio leidimus';

  @override
  String get editDisplayname => 'Redaguoti rodomą vardą';

  @override
  String get editRoomAliases => 'Redaguoti kambario pseudonimus';

  @override
  String get editRoomAvatar => 'Redaguoti kambario avatarą';

  @override
  String get emoteExists => 'Jaustukas jau egzistuoja!';

  @override
  String get emoteInvalid => 'Neteisingas jaustuko trumpasis kodas!';

  @override
  String get emotePacks => 'Jaustukų paketai kambariui';

  @override
  String get emoteSettings => 'Jaustukų nustatymai';

  @override
  String get emoteShortcode => 'Jaustuko trumpasis kodas';

  @override
  String get emoteWarnNeedToPick =>
      'Turite pasirinkti jaustuko trumpąjį kodą ir paveiksliuką!';

  @override
  String get emptyChat => 'Tuščias pokalbis';

  @override
  String get enableEmotesGlobally => 'Įgalinti jaustukų paketą visur';

  @override
  String get enableEncryption => 'Aktyvuoti šifravimą';

  @override
  String get enableEncryptionWarning =>
      'Šifravimo nebegalėsite išjungti. Ar jūs tuo tikri?';

  @override
  String get encrypted => 'Užšifruotas';

  @override
  String get encryption => 'Šifravimas';

  @override
  String get encryptionNotEnabled => 'Šifravimas aktyvuotas';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName baigė skambutį';
  }

  @override
  String get enterAGroupName => 'Įveskite grupės vardą';

  @override
  String get enterAnEmailAddress => 'Įveskite el. pašto adresą';

  @override
  String get enterASpacepName => 'Įveskite erdvės vardą';

  @override
  String get homeserver => 'Namų serveris';

  @override
  String get enterYourHomeserver => 'Įveskite namų serverį';

  @override
  String errorObtainingLocation(Object error) {
    return 'Klaida nustatant vietą: $error';
  }

  @override
  String get everythingReady => 'Viskas paruošta!';

  @override
  String get extremeOffensive => 'Itin įžeidžiantis';

  @override
  String get fileName => 'Failo vardas';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Šrifto dydis';

  @override
  String get forward => 'Toliau';

  @override
  String get fromJoining => 'Nuo prisijungimo';

  @override
  String get fromTheInvitation => 'Nuo pakvietimo';

  @override
  String get goToTheNewRoom => 'Eiti į naują kambarį';

  @override
  String get group => 'Grupė';

  @override
  String get groupDescription => 'Grupės aprašymas';

  @override
  String get groupDescriptionHasBeenChanged => 'Grupės aprašymas pakeistas';

  @override
  String get groupIsPublic => 'Grupė yra vieša';

  @override
  String groupWith(Object displayname) {
    return 'Grupė su $displayname';
  }

  @override
  String get guestsAreForbidden => 'Svečiams draudžiama';

  @override
  String get guestsCanJoin => 'Svečiai gali prisijungti';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username atšaukė $targetName kvietimą';
  }

  @override
  String get help => 'Pagalba';

  @override
  String get hideRedactedEvents => 'Slėpti pašalintus įvykius';

  @override
  String get hideUnknownEvents => 'Slėpti nežinomus įvykius';

  @override
  String get howOffensiveIsThisContent => 'Kiek įžeižiantis šis turinys?';

  @override
  String get id => 'ID';

  @override
  String get identity => 'Tapatybė';

  @override
  String get ignore => 'Ignoruoti';

  @override
  String get ignoredUsers => 'Ignoruoti vartotojai';

  @override
  String get ignoreListDescription =>
      'Galite ignoruoti vartotojus, kurie jums trukdo. Negalėsite gauti jokių pranešimų ar kvietimų į kambarį iš vartotojų, įtrauktų į asmeninį ignoruojamųjų sąrašą.';

  @override
  String get ignoreUsername => 'Ignoruoti vartotoją';

  @override
  String get iHaveClickedOnLink => 'Aš paspaudžiau nuorodą';

  @override
  String get incorrectPassphraseOrKey =>
      'Neteisinga slaptafrazė arba atkūrimo raktas';

  @override
  String get inoffensive => 'Neįžeidžiantis';

  @override
  String get inviteContact => 'Pakviesti kontaktą';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Pakviesti kontaktą į $groupName';
  }

  @override
  String get invited => 'Pakviestas';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username pakvietė $targetName';
  }

  @override
  String get invitedUsersOnly => 'Tik pakviesti vartotojai';

  @override
  String get inviteForMe => 'Pakvietimas man';

  @override
  String inviteText(Object username, Object link) {
    return '$username pakvietė jus prisijungti prie FluffyChat. \n1. Įdiekite FluffyChat: https://fluffychat.im \n2. Prisiregistruokite arba prisijunkite \n3. Atidarykite pakvietimo nuorodą: $link';
  }

  @override
  String get isTyping => 'rašo…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username prisijungė prie pokalbio';
  }

  @override
  String get joinRoom => 'Prisijungti prie kambario';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username išmetė $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username išmetė ir užblokavo $targetName';
  }

  @override
  String get kickFromChat => 'Išmesti iš pokalbio';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Paskutinis aktyvumas: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Seniai matytas';

  @override
  String get leave => 'Palikti';

  @override
  String get leftTheChat => 'Paliko pokalbį';

  @override
  String get license => 'Licencija';

  @override
  String get lightTheme => 'Šviesi';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Įkelti dar $count dalyvius';
  }

  @override
  String get dehydrate => 'Eksportuoti sesiją ir išvalyti įrenginį';

  @override
  String get dehydrateWarning =>
      'Šio veiksmo negalima atšaukti. Įsitikinkite, kad saugiai saugote atsarginę kopiją.';

  @override
  String get dehydrateTor => 'TOR Naudotojai: Eksportuoti sesiją';

  @override
  String get dehydrateTorLong =>
      'TOR naudotojams rekomenduojama eksportuoti sesiją prieš uždarant langą.';

  @override
  String get hydrateTor => 'TOR Naudotojai: Importuoti sesijos eksportą';

  @override
  String get hydrateTorLong =>
      'Ar paskutinį kartą eksportavote savo sesiją naudodami TOR? Greitai ją importuokite ir tęskite pokalbį.';

  @override
  String get hydrate => 'Atkurti iš atsarginės kopijos failo';

  @override
  String get loadingPleaseWait => 'Kraunama… Prašome palaukti.';

  @override
  String get loadMore => 'Rodyti daugiau…';

  @override
  String get locationDisabledNotice =>
      'Vietos nustatymo paslaugos yra išjungtos. Kad galėtumėte bendrinti savo buvimo vietą, įjunkite jas.';

  @override
  String get locationPermissionDeniedNotice =>
      'Vietos leidimas atmestas. Suteikite leidimą kad galėtumėte bendrinti savo vietą.';

  @override
  String get login => 'Prisijungti';

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
    return 'Prisijungti prie $homeserver';
  }

  @override
  String get loginWithOneClick => 'Prisijungti vienu paspaudimu';

  @override
  String get logout => 'Atsijungti';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Įsitikinkite, kad indentifikatorius galiojantis';

  @override
  String get memberChanges => 'Narių pokyčiai';

  @override
  String get mention => 'Paminėti';

  @override
  String get messages => 'Žinutės';

  @override
  String get messageWillBeRemovedWarning =>
      'Žinutė bus pašalinta visiem dalyviams';

  @override
  String get moderator => 'Moderatorius';

  @override
  String get muteChat => 'Nutildyti pokalbį';

  @override
  String get needPantalaimonWarning =>
      'Atminkite, kad norint naudoti end-to-end šifravimą, reikalingas Pantalaimon.';

  @override
  String get newChat => 'Naujas pokalbis';

  @override
  String get newMessageInFluffyChat => '💬 Nauja žinutė FluffyChat\'e';

  @override
  String get newVerificationRequest => 'Nauja patvirtinimo užklausa!';

  @override
  String get next => 'Toliau';

  @override
  String get no => 'Ne';

  @override
  String get noConnectionToTheServer => 'Nėra ryšio su serveriu';

  @override
  String get noEmotesFound => 'Nerasta jaustukų. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Šifravimą galite suaktyvinti tik tada, kai kambarys nebebus viešai pasiekiamas.';

  @override
  String get noGoogleServicesWarning =>
      'Atrodo, kad jūsų telefone nėra Google Services. Tai geras sprendimas jūsų privatumui! Norėdami gauti tiesioginius pranešimus FluffyChat, rekomenduojame naudoti https://microg.org/ arba https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 nėra Matrix serveris, ar vietoj jo naudoti $server2?';
  }

  @override
  String get shareYourInviteLink => 'Bendrinti savo pakvietimo nuorodą';

  @override
  String get scanQrCode => 'Nuskanuokite QR kodą';

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
  String get none => 'Nė vienas';

  @override
  String get noPasswordRecoveryDescription =>
      'Dar nepridėjote slaptažodžio atkūrimo būdo.';

  @override
  String get noPermission => 'Nėra leidimo';

  @override
  String get noRoomsFound => 'Nerasta kambarių…';

  @override
  String get notifications => 'Pranešimai';

  @override
  String get notificationsEnabledForThisAccount =>
      'Pranešimai aktyvuoti šitai paskyrai';

  @override
  String numUsersTyping(Object count) {
    return '$count vartotojai rašo…';
  }

  @override
  String get obtainingLocation => 'Gaunama vieta…';

  @override
  String get offensive => 'Agresyvus';

  @override
  String get offline => 'Neprisijungta';

  @override
  String get ok => 'OK';

  @override
  String get online => 'Prisijungta';

  @override
  String get onlineKeyBackupEnabled =>
      'Internetinė atsarginė raktų kopija įjungta';

  @override
  String get oopsPushError =>
      'Oi! Deja, nustatant tiesioginius pranešimus įvyko klaida.';

  @override
  String get oopsSomethingWentWrong => 'Oi, kažkas nutiko ne taip…';

  @override
  String get openAppToReadMessages =>
      'Atidarykite programėlę, kad perskaityti žinutes';

  @override
  String get openCamera => 'Atidarykite kamerą';

  @override
  String get openVideoCamera => 'Atidarykite kamerą vaizdo įrašui';

  @override
  String get oneClientLoggedOut => 'Vienas iš jūsų klientų atsijungė';

  @override
  String get addAccount => 'Pridėti paskyrą';

  @override
  String get editBundlesForAccount => 'Redaguoti šios paskyros paketus';

  @override
  String get addToBundle => 'Pridėti prie paketų';

  @override
  String get removeFromBundle => 'Pašalinkite iš šio paketo';

  @override
  String get bundleName => 'Paketo vardas';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Įgalinkite kelias paskyras šiame įrenginyje';

  @override
  String get openInMaps => 'Atidaryti žemėlapiuose';

  @override
  String get link => 'Nuoroda';

  @override
  String get serverRequiresEmail =>
      'Šis serveris turi patvirtinti jūsų el. pašto adresą registracijai.';

  @override
  String get optionalGroupName => '(Nebūtina) Grupės pavadinimas';

  @override
  String get or => 'Arba';

  @override
  String get participant => 'Dalyvis';

  @override
  String get passphraseOrKey => 'Slapta frazė arba atkūrimo raktas';

  @override
  String get password => 'Slaptažodis';

  @override
  String get passwordForgotten => 'Slaptažodis užmirštas';

  @override
  String get passwordHasBeenChanged => 'Slaptažodis pakeistas';

  @override
  String get passwordRecovery => 'Slaptažodžio atkūrimas';

  @override
  String get pickImage => 'Pasirinkite paveiksliuką';

  @override
  String get pin => 'Prisegti';

  @override
  String play(Object fileName) {
    return 'Groti $fileName';
  }

  @override
  String get pleaseChoose => 'Prašome pasirinkti';

  @override
  String get pleaseChooseAPasscode => 'Pasirinkite slaptą kodą';

  @override
  String get pleaseChooseAUsername => 'Pasirinkite vartotojo vardą';

  @override
  String get pleaseClickOnLink =>
      'Paspauskite nuorodą el. pašte ir tęskite toliau.';

  @override
  String get pleaseEnter4Digits =>
      'Įveskite 4 skaitmenis arba palikite tuščią, jei norite išjungti programėlės užraktą.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Įveskite Matrix ID.';

  @override
  String get pleaseEnterRecoveryKey => 'Įveskite savo atkūrimo raktą:';

  @override
  String get pleaseEnterYourPassword => 'Įveskite savo slaptažodį';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Įveskite savo PIN kodą';

  @override
  String get pleaseEnterYourUsername => 'Įveskite savo vartotojo vardą';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Vadovaukitės svetainėje pateiktais nurodymais ir bakstelėkite Toliau.';

  @override
  String get privacy => 'Privatumas';

  @override
  String get publicRooms => 'Vieši kambariai';

  @override
  String get pushRules => 'Tiesioginių pranešimų taisyklės';

  @override
  String get reason => 'Priežastis';

  @override
  String get recording => 'Įrašymas';

  @override
  String redactedAnEvent(Object username) {
    return '$username pašalino įvykį';
  }

  @override
  String get redactMessage => 'Pašalinti žinutę';

  @override
  String get reject => 'Atmesti';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username atmetė kvietimą';
  }

  @override
  String get rejoin => 'Vėl prisijungti';

  @override
  String get remove => 'Pašalinti';

  @override
  String get removeAllOtherDevices => 'Pašalinti visus kitus įrenginius';

  @override
  String removedBy(Object username) {
    return 'Pašalino vartotojas $username';
  }

  @override
  String get removeDevice => 'Pašalinti įrenginį';

  @override
  String get unbanFromChat => 'Atblokuoti pokalbyje';

  @override
  String get removeYourAvatar => 'Pašalinti savo avatarą';

  @override
  String get renderRichContent => 'Atvaizduoti turtingą žinutės turinį';

  @override
  String get replaceRoomWithNewerVersion => 'Pakeisti kambarį naujesne versija';

  @override
  String get reply => 'Atsakyti';

  @override
  String get reportMessage => 'Pranešti apie žinutę';

  @override
  String get requestPermission => 'Prašyti leidimo';

  @override
  String get roomHasBeenUpgraded => 'Kambarys buvo atnaujintas';

  @override
  String get roomVersion => 'Kambario versija';

  @override
  String get saveFile => 'Išsaugoti failą';

  @override
  String get search => 'Ieškoti';

  @override
  String get security => 'Apsauga';

  @override
  String get recoveryKey => 'Atkūrimo raktas';

  @override
  String get recoveryKeyLost => 'Pamestas atkūrimo raktas?';

  @override
  String seenByUser(Object username) {
    return 'Matė $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return '$username ir dar $count žmonės matė';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Matė $username ir $username2';
  }

  @override
  String get send => 'Siųsti';

  @override
  String get sendAMessage => 'Siųsti žinutę';

  @override
  String get sendAsText => 'Siųsti kaip tekstą';

  @override
  String get sendAudio => 'Siųsti garso įrašą';

  @override
  String get sendFile => 'Sųsti bylą';

  @override
  String get sendImage => 'Siųsti paveiksliuką';

  @override
  String get sendMessages => 'Siųsti žinutes';

  @override
  String get sendOriginal => 'Siųsti originalą';

  @override
  String get sendSticker => 'Siųsti lipduką';

  @override
  String get sendVideo => 'Siųsti video';

  @override
  String sentAFile(Object username) {
    return '📁 $username atsiuntė failą';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username atsiuntė garso įrašą';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username atsiuntė nuotrauką';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username atsiuntė lipduką';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username atsiuntė vaizdo įrašą';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName išsiuntė skambučio informaciją';
  }

  @override
  String get separateChatTypes => 'Atskirti tiesioginius pokalbius ir grupes';

  @override
  String get setAsCanonicalAlias => 'Nustatyti kaip pagrindinį slapyvardį';

  @override
  String get setCustomEmotes => 'Nustatyti pasirinktinius jaustukus';

  @override
  String get setGroupDescription => 'Nustatyti grupės aprašymą';

  @override
  String get setInvitationLink => 'Nustatyti pakvietimo nuorodą';

  @override
  String get setPermissionsLevel => 'Nustatyti leidimų lygį';

  @override
  String get setStatus => 'Nustatyti būseną';

  @override
  String get settings => 'Nustatytmai';

  @override
  String get share => 'Bendrinti';

  @override
  String sharedTheLocation(Object username) {
    return '$username bendrino savo vietą';
  }

  @override
  String get shareLocation => 'Bendrinti vietą';

  @override
  String get showDirectChatsInSpaces =>
      'Rodyti susijusius tiesioginius pokalbius erdvėse';

  @override
  String get showPassword => 'Rodyti slaptažodį';

  @override
  String get signUp => 'Registruotis';

  @override
  String get singlesignon => 'Vienkartinis prisijungimas';

  @override
  String get skip => 'Praleisti';

  @override
  String get sourceCode => 'Programinis kodas';

  @override
  String get spaceIsPublic => 'Erdvė yra vieša';

  @override
  String get spaceName => 'Erdvės pavadinimas';

  @override
  String startedACall(Object senderName) {
    return '$senderName pradėjo skambutį';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Būsena';

  @override
  String get statusExampleMessage => 'Kaip sekasi šiandien?';

  @override
  String get submit => 'Pateikti';

  @override
  String get synchronizingPleaseWait => 'Sinchronizuojama… Prašome palaukti.';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get theyDontMatch => 'Jie nesutampa';

  @override
  String get theyMatch => 'Jie sutampa';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Perjungti parankinius';

  @override
  String get toggleMuted => 'Perjungti nutildytą';

  @override
  String get toggleUnread => 'Pažymėti kaip skaitytą/neskaitytą';

  @override
  String get tooManyRequestsWarning =>
      'Per daug užklausų. Pabandykite dar kartą vėliau!';

  @override
  String get transferFromAnotherDevice => 'Perkėlimas iš kito įrenginio';

  @override
  String get tryToSendAgain => 'Pabandykite išsiųsti dar kartą';

  @override
  String get unavailable => 'Nepasiekiamas';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username atblokavo $targetName';
  }

  @override
  String get unblockDevice => 'Atblokuoti įrenginį';

  @override
  String get unknownDevice => 'Nežinomas įrenginys';

  @override
  String get unknownEncryptionAlgorithm => 'Nežinomas šifravimo algoritmas';

  @override
  String get unmuteChat => 'Įjungti pokalbio garsą';

  @override
  String get unpin => 'Atsegti';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount neperskaityti pokalbiai',
      one: '1 unread chat',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username ir dar $count kiti rašo…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username ir $username2 rašo…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username rašo…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username paliko pokalbį';
  }

  @override
  String get username => 'Vartotojo vardas';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username išsiuntė $type įvykį';
  }

  @override
  String get unverified => 'Nepatvirtinta';

  @override
  String get verified => 'Patvirtinta';

  @override
  String get verify => 'Patvirtinti';

  @override
  String get verifyStart => 'Pradėti patvirtinimą';

  @override
  String get verifySuccess => 'Jūs sėkmingai patvirtinote!';

  @override
  String get verifyTitle => 'Patvirtinama kita paskyra';

  @override
  String get videoCall => 'Vaizdo skambutis';

  @override
  String get visibilityOfTheChatHistory => 'Pokalbių istorijos matomumas';

  @override
  String get visibleForAllParticipants => 'Matoma visiems dalyviams';

  @override
  String get visibleForEveryone => 'Matoma visiems';

  @override
  String get voiceMessage => 'Balso žinutė';

  @override
  String get waitingPartnerAcceptRequest =>
      'Laukiama, kol dalyvis priims užklausą…';

  @override
  String get waitingPartnerEmoji => 'Laukiama, kol dalyvis priims jaustukus…';

  @override
  String get waitingPartnerNumbers => 'Laukiama, kol dalyvis priims skaičius…';

  @override
  String get wallpaper => 'Užsklanda';

  @override
  String get warning => 'Įspėjimas!';

  @override
  String get weSentYouAnEmail => 'Išsiuntėme jums el. laišką';

  @override
  String get whoCanPerformWhichAction => 'Kas gali atlikti kokį veiksmą';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Kam leidžiama prisijungti prie šios grupės';

  @override
  String get whyDoYouWantToReportThis => 'Kodėl norite apie tai pranešti?';

  @override
  String get wipeChatBackup =>
      'Ištrinti atsarginę pokalbių kopiją, kad sukurti naują atkūrimo raktą?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Naudodami šiuos adresus galite atkurti savo slaptažodį.';

  @override
  String get writeAMessage => 'Rašyti žinutę…';

  @override
  String get yes => 'Taip';

  @override
  String get you => 'Jūs';

  @override
  String get youAreInvitedToThisChat => 'Esate pakviesti į šį pokalbį';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Jūs nebedalyvaujate šiame pokalbyje';

  @override
  String get youCannotInviteYourself => 'Jūs negalite pakviesti savęs';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Jums buvo uždrausta dalyvauti šiame pokalbyje';

  @override
  String get yourPublicKey => 'Jūsų viešasis raktas';

  @override
  String get messageInfo => 'Žinutės informacija';

  @override
  String get time => 'Laikas';

  @override
  String get messageType => 'Žinutės tipas';

  @override
  String get sender => 'Siuntėjas';

  @override
  String get openGallery => 'Atverti galeriją';

  @override
  String get removeFromSpace => 'Pašalinti iš erdvės';

  @override
  String get addToSpaceDescription =>
      'Pasirinkite erdvę, kad prie jos pridėtumėte šį pokalbį.';

  @override
  String get start => 'Pradžia';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Norėdami atrakinti senas žinutes, įveskite atkūrimo raktą, kuris buvo sukurtas ankstesnės sesijos metu. Atkūrimo raktas NĖRA jūsų slaptažodis.';

  @override
  String get addToStory => 'Pridėti prie istorijos';

  @override
  String get publish => 'Paskelbti';

  @override
  String get whoCanSeeMyStories => 'Kas gali matyti mano istorijas?';

  @override
  String get unsubscribeStories => 'Atsisakyti istorijų prenumeratos';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Šis vartotojas dar nieko nepaskelbė savo istorijoje';

  @override
  String get yourStory => 'Tavo istorija';

  @override
  String get replyHasBeenSent => 'Atsakymas išsiųstas';

  @override
  String videoWithSize(Object size) {
    return 'Vaizdo įrašas ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Istorija nuo $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Atminkite, kad žmonės gali matyti vienas kitą ir susisiekti tarpusavyje jūsų istorijoje.';

  @override
  String get whatIsGoingOn => 'Kas vyksta?';

  @override
  String get addDescription => 'Pridėti aprašymą';

  @override
  String get storyPrivacyWarning =>
      'Atminkite, kad žmonės gali matyti vienas kitą ir susisiekti tarpusavyje jūsų istorijoje. Jūsų istorijos bus matomos 24 valandas, tačiau nėra garantijos, kad jos bus ištrintos iš visų įrenginių ir serverių.';

  @override
  String get iUnderstand => 'Aš suprantu';

  @override
  String get openChat => 'Atverti pokalbį';

  @override
  String get markAsRead => 'Žymėti kaip skaitytą';

  @override
  String get reportUser => 'Pranešti apie vartotoją';

  @override
  String get dismiss => 'Atsisakyti';

  @override
  String get matrixWidgets => 'Matrix valdikliai';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender sureagavo su $reaction';
  }

  @override
  String get pinMessage => 'Prisegti prie kambario';

  @override
  String get confirmEventUnpin =>
      'Ar tikrai norite visam laikui atsegti įvykį?';

  @override
  String get emojis => 'Jaustukai';

  @override
  String get placeCall => 'Skambinti';

  @override
  String get voiceCall => 'Balso skambutis';

  @override
  String get unsupportedAndroidVersion => 'Nepalaikoma Android versija';

  @override
  String get unsupportedAndroidVersionLong =>
      'Šiai funkcijai reikalinga naujesnė Android versija. Patikrinkite, ar nėra naujinimų arba Lineage OS palaikymo.';

  @override
  String get videoCallsBetaWarning =>
      'Atminkite, kad vaizdo skambučiai šiuo metu yra beta versijos. Jie gali neveikti taip kaip tikėtasi, arba iš viso neveikti visose platformose.';

  @override
  String get experimentalVideoCalls => 'Eksperimentiniai vaizdo skambučiai';

  @override
  String get emailOrUsername => 'El. paštas arba vartotojo vardas';

  @override
  String get indexedDbErrorTitle => 'Privataus režimo problemos';

  @override
  String get indexedDbErrorLong =>
      'Deja, pagal numatytuosius nustatymus žinučių saugojimas privačiame režime nėra įjungtas.\nPrašome apsilankyti\n - about:config\n - nustatykite dom.indexedDB.privateBrowsing.enabled į true\nPriešingu atveju FluffyChat paleisti neįmanoma.';

  @override
  String switchToAccount(Object number) {
    return 'Perjungti paskyrą į $number';
  }

  @override
  String get nextAccount => 'Kita paskyra';

  @override
  String get previousAccount => 'Ankstesnė paskyra';

  @override
  String get editWidgets => 'Redaguoti programėles';

  @override
  String get addWidget => 'Pridėti programėlę';

  @override
  String get widgetVideo => 'Video';

  @override
  String get widgetEtherpad => 'Teksto pastaba';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Pasirinktinis';

  @override
  String get widgetName => 'Vardas';

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
  String get widgetUrlError => 'Netinkamas URL.';

  @override
  String get widgetNameError => 'Pateikite rodomą vardą.';

  @override
  String get errorAddingWidget => 'Pridedant valdiklį įvyko klaida.';

  @override
  String get youRejectedTheInvitation => 'Jūs atmetėte kvietimą';

  @override
  String get youJoinedTheChat => 'Jūs prisijungėte prie pokalbio';

  @override
  String get youAcceptedTheInvitation => '👍 Jūs priėmėte kvietimą';

  @override
  String youBannedUser(Object user) {
    return 'Jūs užblokavote $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Jūs atšaukėte kvietimą $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 Jus pakvietė $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 Pakvietėte $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 Jūs išmetėte $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 Jūs išmetėte ir užblokavote $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Jūs atblokavote $user';
  }

  @override
  String get noEmailWarning =>
      'Įveskite galiojantį el. pašto adresą. Priešingu atveju negalėsite iš naujo nustatyti slaptažodžio. Jei nenorite, dar kartą bakstelėkite mygtuką, kad galėtumėte tęsti.';

  @override
  String get stories => 'Istorijos';

  @override
  String get users => 'Vartotojai';

  @override
  String get unlockOldMessages => 'Atrakinti senas žinutes';

  @override
  String get storeInSecureStorageDescription =>
      'Atkūrimo raktą laikyti saugioje šio prietaiso saugykloje.';

  @override
  String get saveKeyManuallyDescription =>
      'Įrašykite šį raktą rankiniu būdu, įjungę sistemos bendrinimo dialogo langą arba iškarpinę.';

  @override
  String get storeInAndroidKeystore => 'Saugoti Android raktų saugykloje';

  @override
  String get storeInAppleKeyChain => 'Saugoti Apple raktų grandinėje';

  @override
  String get storeSecurlyOnThisDevice => 'Saugiai laikyti šiame prietaise';

  @override
  String countFiles(Object count) {
    return '$count failai';
  }

  @override
  String get user => 'Vartotojas';

  @override
  String get custom => 'Pasirinktinis';

  @override
  String get foregroundServiceRunning =>
      'Šis pranešimas rodomas, kai veikia pirmojo plano paslauga.';

  @override
  String get screenSharingTitle => 'ekrano bendrinimas';

  @override
  String get screenSharingDetail => 'Bendrinate savo ekraną per FuffyChat';

  @override
  String get callingPermissions => 'Skambinimo leidimai';

  @override
  String get callingAccount => 'Skambinimo paskyra';

  @override
  String get callingAccountDetails =>
      'Leidžia FluffyChat naudoti vietinę Android rinkiklio programą.';

  @override
  String get appearOnTop => 'Rodyti viršuje';

  @override
  String get appearOnTopDetails =>
      'Leidžia programėlę rodyti viršuje (nebūtina, jei jau esate nustatę Fluffychat kaip skambinimo paskyrą)';

  @override
  String get otherCallingPermissions =>
      'Mikrofonas, kamera ir kiti FluffyChat leidimai';

  @override
  String get whyIsThisMessageEncrypted => 'Kodėl ši žinutė neperskaitoma?';

  @override
  String get noKeyForThisMessage =>
      'Taip gali atsitikti, jei žinutė buvo išsiųsta prieš prisijungiant prie paskyros šiame prietaise.\n\nTaip pat gali būti, kad siuntėjas užblokavo jūsų prietaisą arba kažkas sutriko su interneto ryšiu.\n\nAr galite perskaityti žinutę kitoje sesijoje? Tada galite perkelti žinutę iš jos! Eikite į Nustatymai > Prietaisai ir įsitikinkite, kad jūsų prietaisai patvirtino vienas kitą. Kai kitą kartą atidarysite kambarį ir abi sesijos bus pirmame plane, raktai bus perduoti automatiškai.\n\nNenorite prarasti raktų atsijungdami arba keisdami įrenginius? Įsitikinkite, kad nustatymuose įjungėte pokalbių atsarginę kopiją.';

  @override
  String get newGroup => 'Nauja grupė';

  @override
  String get newSpace => 'Nauja erdvė';

  @override
  String get enterSpace => 'Įeiti į erdvę';

  @override
  String get enterRoom => 'Įeiti į kambarį';

  @override
  String get allSpaces => 'Visos erdvės';

  @override
  String numChats(Object number) {
    return '$number pokalbiai';
  }

  @override
  String get hideUnimportantStateEvents => 'Slėpti nesvarbius būsenos įvykius';

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
