// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class L10nPl extends L10n {
  L10nPl([String locale = 'pl']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Zarejestruj';

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
  String get passwordsDoNotMatch => 'Hasła nie pasują!';

  @override
  String get pleaseEnterValidEmail => 'Proszę podaj poprawny adres email.';

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
  String get people => 'Osoby';

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
  String get groups => 'Grupy';

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
  String get repeatPassword => 'Powtórz hasło';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Proszę podaj przynajmniej $min znaków.';
  }

  @override
  String get about => 'O aplikacji';

  @override
  String get updateAvailable => 'Aktualizacja FluffyChat jest dostępna';

  @override
  String get updateNow => 'Rozpocznij aktualizację w tle';

  @override
  String get accept => 'Akceptuj';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username zaakceptował/-a zaproszenie';
  }

  @override
  String get account => 'Konto';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username aktywował/-a szyfrowanie od końca do końca';
  }

  @override
  String get addEmail => 'Dodaj adres email';

  @override
  String get confirmMatrixId =>
      'Potwierdź swój identyfikator Matrix w celu usunięcia konta.';

  @override
  String supposedMxid(Object mxid) {
    return 'To powinno być $mxid';
  }

  @override
  String get addGroupDescription => 'Dodaj opis grupy';

  @override
  String get addToSpace => 'Dodaj do przestrzeni';

  @override
  String get admin => 'Administrator';

  @override
  String get alias => 'alias';

  @override
  String get all => 'Wszystkie';

  @override
  String get allChats => 'Wszystkie';

  @override
  String get commandHint_googly => 'Wyślij kręcące się oczka';

  @override
  String get commandHint_cuddle => 'Wyślij przytulenie';

  @override
  String get commandHint_hug => 'Wyślij uścisk';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName wysyła ci kręcące się oczka';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName przytula cię';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName uściska cię';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '$senderName odebrał połączenie';
  }

  @override
  String get anyoneCanJoin => 'Każdy może dołączyć';

  @override
  String get appLock => 'Blokada aplikacji';

  @override
  String get archive => 'Archiwum';

  @override
  String get areGuestsAllowedToJoin => 'Czy użytkownicy-goście mogą dołączyć';

  @override
  String get areYouSure => 'Czy na pewno?';

  @override
  String get areYouSureYouWantToLogout => 'Czy na pewno chcesz się wylogować?';

  @override
  String get askSSSSSign =>
      'Aby zalogować inną osobę, proszę wpisać hasło przechowywania lub klucz odzyskiwania.';

  @override
  String askVerificationRequest(Object username) {
    return 'Zaakceptować tą prośbę weryfikacji od $username?';
  }

  @override
  String get autoplayImages =>
      'Automatycznie odtwarzaj animowane naklejki i emotki';

  @override
  String get sendOnEnter => 'Wyślij enterem';

  @override
  String get banFromChat => 'Ban na czacie';

  @override
  String get banned => 'Zbanowany/-a';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username zbanował/-a $targetName';
  }

  @override
  String get blockDevice => 'Zablokuj Urządzenie';

  @override
  String get blocked => 'Zablokowane';

  @override
  String get botMessages => 'Wiadomości Botów';

  @override
  String get bubbleSize => 'Rozmiar bąbelków';

  @override
  String get cancel => 'Anuluj';

  @override
  String cantOpenUri(Object uri) {
    return 'Nie można otworzyć linku $uri';
  }

  @override
  String get changeDeviceName => 'Zmień nazwę urządzenia';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username zmienił/-a zdjęcie profilowe';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username zmienił/-a opis czatu na: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username zmienił/-a nick na: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username zmienił/-a uprawnienia czatu';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username zmienił/-a swój nick na: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username zmienił/-a zasady dostępu dla gości';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username zmienił/-a zasady dostępu dla gości na: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username zmienił/-a widoczność historii';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username zmienił/-a widoczność historii na: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username zmienił/-a zasady wejścia';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username zmienił/-a zasady wejścia na: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username zmienił/-a zdjęcie profilowe';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username zmienił/-a skrót pokoju';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username zmienił/-a link do zaproszenia do pokoju';
  }

  @override
  String get changePassword => 'Zmień hasło';

  @override
  String get changeTheHomeserver => 'Zmień serwer domyślny';

  @override
  String get changeTheme => 'Zmień swój styl';

  @override
  String get changeTheNameOfTheGroup => 'Zmień nazwę grupy';

  @override
  String get changeWallpaper => 'Zmień tapetę';

  @override
  String get changeYourAvatar => 'Zmień avatar';

  @override
  String get channelCorruptedDecryptError => 'Szyfrowanie zostało uszkodzone';

  @override
  String get chat => 'Rozmowa';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'Twoja kopia zapasowa chatu została ustawiona.';

  @override
  String get chatBackup => 'Kopia zapasowa Rozmów';

  @override
  String get chatBackupDescription =>
      'Twoje stare wiadomości są zabezpieczone kluczem odzyskiwania. Uważaj żeby go nie zgubić.';

  @override
  String get chatDetails => 'Szczegóły czatu';

  @override
  String get chatHasBeenAddedToThisSpace =>
      'Chat został dodany do tej przestrzeni';

  @override
  String get chats => 'Rozmowy';

  @override
  String get chooseAStrongPassword => 'Wybierz silne hasło';

  @override
  String get chooseAUsername => 'Wybierz nick';

  @override
  String get clearArchive => 'Wyczyść archiwum';

  @override
  String get close => 'Zamknij';

  @override
  String get commandHint_markasdm =>
      'Oznacz jako pokój wiadomości bezpośrednich';

  @override
  String get commandHint_markasgroup => 'Oznacz jako grupę';

  @override
  String get commandHint_ban => 'Zablokuj użytkownika w tym pokoju';

  @override
  String get commandHint_clearcache => 'Wyczyść pamięć podręczną';

  @override
  String get commandHint_create =>
      'Stwórz pusty chat\nUżyj --no-encryption by wyłączyć szyfrowanie';

  @override
  String get commandHint_discardsession => 'Odrzuć sesję';

  @override
  String get commandHint_dm =>
      'Rozpocznij bezpośredni chat\nUżyj --no-encryption by wyłączyć szyfrowanie';

  @override
  String get commandHint_html => 'Wyślij tekst sformatowany w HTML';

  @override
  String get commandHint_invite => 'Zaproś użytkownika do pokoju';

  @override
  String get commandHint_join => 'Dołącz do podanego pokoju';

  @override
  String get commandHint_kick => 'Usuń tego użytkownika z tego pokoju';

  @override
  String get commandHint_leave => 'Wyjdź z tego pokoju';

  @override
  String get commandHint_me => 'Opisz siebie';

  @override
  String get commandHint_myroomavatar =>
      'Ustaw awatar dla tego pokoju (przez mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Ustaw nazwę wyświetlaną dla tego pokoju';

  @override
  String get commandHint_op =>
      'Ustaw moc uprawnień użytkownika (domyślnie: 50)';

  @override
  String get commandHint_plain => 'Wyślij niesformatowany tekst';

  @override
  String get commandHint_react => 'Wyślij odpowiedź jako reakcję';

  @override
  String get commandHint_send => 'Wyślij wiadomość';

  @override
  String get commandHint_unban => 'Odblokuj użytkownika w tym pokoju';

  @override
  String get commandInvalid => 'Nieprawidłowe polecenie';

  @override
  String commandMissing(Object command) {
    return '$command nie jest poleceniem.';
  }

  @override
  String get compareEmojiMatch => 'Porównaj emoji';

  @override
  String get compareNumbersMatch => 'Porównaj cyfry';

  @override
  String get configureChat => 'Konfiguruj chat';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get connect => 'Połącz';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Kontakt został zaproszony do grupy';

  @override
  String get containsDisplayName => 'Posiada wyświetlaną nazwę';

  @override
  String get containsUserName => 'Posiada nazwę użytkownika';

  @override
  String get contentHasBeenReported =>
      'Zawartość została zgłoszona administratorom serwera';

  @override
  String get copiedToClipboard => 'Skopiowano do schowka';

  @override
  String get copy => 'Kopiuj';

  @override
  String get copyToClipboard => 'Skopiuj do schowka';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Nie można odszyfrować wiadomości: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count uczestników';
  }

  @override
  String get create => 'Stwórz';

  @override
  String createdTheChat(Object username) {
    return '💬 $username zaczął/-ęła rozmowę';
  }

  @override
  String get createNewGroup => 'Stwórz nową grupę';

  @override
  String get createNewSpace => 'Nowa przestrzeń';

  @override
  String get currentlyActive => 'Obecnie aktywny/-a';

  @override
  String get darkTheme => 'Ciemny';

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
    return '$day.$month.$year';
  }

  @override
  String get deactivateAccountWarning =>
      'To zdezaktywuje twoje konto. To jest nieodwracalne! Na pewno chcesz to zrobić?';

  @override
  String get defaultPermissionLevel => 'Domyślny poziom uprawnień';

  @override
  String get delete => 'Usuń';

  @override
  String get deleteAccount => 'Usuń konto';

  @override
  String get deleteMessage => 'Usuń wiadomość';

  @override
  String get deny => 'Odrzuć';

  @override
  String get device => 'Urządzenie';

  @override
  String get deviceId => 'ID Urządzenia';

  @override
  String get devices => 'Urządzenia';

  @override
  String get directChats => 'Rozmowy bezpośrednie';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Wyświetlany nick został zmieniony';

  @override
  String get downloadFile => 'Pobierz plik';

  @override
  String get edit => 'Edytuj';

  @override
  String get editBlockedServers => 'Edytuj blokowane serwery';

  @override
  String get editChatPermissions => 'Edytuj uprawnienia';

  @override
  String get editDisplayname => 'Edytuj wyświetlany nick';

  @override
  String get editRoomAliases => 'Zmień aliasy pokoju';

  @override
  String get editRoomAvatar => 'Edytuj zdjęcie pokoju';

  @override
  String get emoteExists => 'Emotikon już istnieje!';

  @override
  String get emoteInvalid => 'Nieprawidłowy kod emotikony!';

  @override
  String get emotePacks => 'Paczki emotikon dla pokoju';

  @override
  String get emoteSettings => 'Ustawienia Emotikon';

  @override
  String get emoteShortcode => 'Kod Emotikony';

  @override
  String get emoteWarnNeedToPick => 'Musisz wybrać kod emotikony oraz obraz!';

  @override
  String get emptyChat => 'Pusty czat';

  @override
  String get enableEmotesGlobally => 'Włącz paczkę emotikon globalnie';

  @override
  String get enableEncryption => 'Aktywuj szyfowanie';

  @override
  String get enableEncryptionWarning =>
      'Nie będziesz już mógł wyłączyć szyfrowania. Jesteś pewny?';

  @override
  String get encrypted => 'Szyfrowane';

  @override
  String get encryption => 'Szyfrowanie';

  @override
  String get encryptionNotEnabled => 'Szyfrowanie nie jest włączone';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName zakończył połączenie';
  }

  @override
  String get enterAGroupName => 'Wpisz nazwę grupy';

  @override
  String get enterAnEmailAddress => 'Wpisz adres email';

  @override
  String get enterASpacepName => 'Podaj nazwę przestrzeni';

  @override
  String get homeserver => 'Adres serwera';

  @override
  String get enterYourHomeserver => 'Wpisz swój serwer domowy';

  @override
  String errorObtainingLocation(Object error) {
    return 'Błąd w ustalaniu lokalizacji: $error';
  }

  @override
  String get everythingReady => 'Wszystko gotowe!';

  @override
  String get extremeOffensive => 'Bardzo obraźliwe';

  @override
  String get fileName => 'Nazwa pliku';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Rozmiar czcionki';

  @override
  String get forward => 'Przekaż';

  @override
  String get fromJoining => 'Od dołączenia';

  @override
  String get fromTheInvitation => 'Od zaproszenia';

  @override
  String get goToTheNewRoom => 'Przejdź do nowego pokoju';

  @override
  String get group => 'Grupa';

  @override
  String get groupDescription => 'Opis grupy';

  @override
  String get groupDescriptionHasBeenChanged => 'Opis grupy został zmieniony';

  @override
  String get groupIsPublic => 'Grupa jest publiczna';

  @override
  String groupWith(Object displayname) {
    return 'Grupa z $displayname';
  }

  @override
  String get guestsAreForbidden => 'Goście są zabronieni';

  @override
  String get guestsCanJoin => 'Goście mogą dołączyć';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username wycofał/-a zaproszenie dla $targetName';
  }

  @override
  String get help => 'Pomoc';

  @override
  String get hideRedactedEvents => 'Ukryj informacje o zredagowaniu';

  @override
  String get hideUnknownEvents => 'Ukryj nieznane wdarzenia';

  @override
  String get howOffensiveIsThisContent => 'Jak bardzo obraźliwe są te treści?';

  @override
  String get id => 'ID';

  @override
  String get identity => 'Tożsamość';

  @override
  String get ignore => 'Ignoruj';

  @override
  String get ignoredUsers => 'Ignorowani użytkownicy';

  @override
  String get ignoreListDescription =>
      'Możesz ignorować użytkowników którzy cię irytują. Nie będziesz odbierać od nich wiadomości ani żadnych zaproszeń od użytkowników na tej liście.';

  @override
  String get ignoreUsername => 'Ignoruj użytkownika';

  @override
  String get iHaveClickedOnLink => 'Nacisnąłem na link';

  @override
  String get incorrectPassphraseOrKey =>
      'Złe hasło bezpieczeństwa lub klucz odzyskiwania';

  @override
  String get inoffensive => 'Nieobraźliwe';

  @override
  String get inviteContact => 'Zaproś kontakty';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Zaproś kontakty do $groupName';
  }

  @override
  String get invited => 'Zaproszono';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username zaprosił/-a $targetName';
  }

  @override
  String get invitedUsersOnly => 'Tylko zaproszeni użytkownicy';

  @override
  String get inviteForMe => 'Zaproszenie dla mnie';

  @override
  String inviteText(Object username, Object link) {
    return '$username zaprosił/-a cię do FluffyChat. \n1. Zainstaluj FluffyChat: https://fluffychat.im \n2. Zarejestuj się lub zaloguj \n3. Otwórz link zaproszenia: $link';
  }

  @override
  String get isTyping => 'pisze…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username dołączył/-a do czatu';
  }

  @override
  String get joinRoom => 'Dołącz do pokoju';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username wyrzucił/-a $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username wyrzucił/-a i zbanował/-a $targetName';
  }

  @override
  String get kickFromChat => 'Wyrzuć z czatu';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Ostatnio widziano: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Widziany/-a dawno temu';

  @override
  String get leave => 'Opuść';

  @override
  String get leftTheChat => 'Opuścił/-a czat';

  @override
  String get license => 'Licencja';

  @override
  String get lightTheme => 'Jasny';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Załaduj jeszcze $count uczestników';
  }

  @override
  String get dehydrate => 'Eksportuj sesję i wymaż urządzenie';

  @override
  String get dehydrateWarning =>
      'Tego nie można cofnąć. Upewnij się, że plik kopii zapasowej jest bezpiecznie przechowywany.';

  @override
  String get dehydrateTor => 'Użytkownicy TOR-a: Eksportuj sesję';

  @override
  String get dehydrateTorLong =>
      'W przypadku użytkowników sieci TOR zaleca się eksportowanie sesji przed zamknięciem okna.';

  @override
  String get hydrateTor => 'Użytkownicy TOR-a: Importuj eksport sesji';

  @override
  String get hydrateTorLong =>
      'Czy ostatnio eksportowałeś/-aś swoją sesję na TOR? Szybko ją zaimportuj i kontynuuj rozmowy.';

  @override
  String get hydrate => 'Przywracanie z pliku kopii zapasowej';

  @override
  String get loadingPleaseWait => 'Ładowanie… Proszę czekać.';

  @override
  String get loadMore => 'Załaduj więcej…';

  @override
  String get locationDisabledNotice =>
      'Usługi lokalizacji są wyłączone. Proszę włącz je aby móc udostępnić swoją lokalizację.';

  @override
  String get locationPermissionDeniedNotice =>
      'Brak uprawnień. Proszę zezwól aplikacji na dostęp do lokalizacji aby móc ją udostępnić.';

  @override
  String get login => 'Zaloguj się';

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
    return 'Zaloguj się do $homeserver';
  }

  @override
  String get loginWithOneClick => 'Zaloguj się jednym kliknięciem';

  @override
  String get logout => 'Wyloguj się';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Upewnij się, że identyfikator jest prawidłowy';

  @override
  String get memberChanges => 'Zmiany członków';

  @override
  String get mention => 'Wzmianka';

  @override
  String get messages => 'Wiadomości';

  @override
  String get messageWillBeRemovedWarning =>
      'Wiadomość zostanie usunięta dla wszystkich użytkowników';

  @override
  String get moderator => 'Moderator';

  @override
  String get muteChat => 'Wycisz czat';

  @override
  String get needPantalaimonWarning =>
      'Należy pamiętać, że Pantalaimon wymaga na razie szyfrowania end-to-end.';

  @override
  String get newChat => 'Nowa rozmowa';

  @override
  String get newMessageInFluffyChat => '💬 Nowa wiadomość w FluffyChat';

  @override
  String get newVerificationRequest => 'Nowa prośba o weryfikację!';

  @override
  String get next => 'Dalej';

  @override
  String get no => 'Nie';

  @override
  String get noConnectionToTheServer => 'Brak połączenia z serwerem';

  @override
  String get noEmotesFound => 'Nie znaleziono żadnych emotek. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Możesz aktywować szyfrowanie dopiero kiedy pokój nie będzie publicznie dostępny.';

  @override
  String get noGoogleServicesWarning =>
      'Wygląda na to, że nie masz usług Google w swoim telefonie. To dobra decyzja dla twojej prywatności! Aby otrzymywać powiadomienia wysyłane w FluffyChat, zalecamy korzystanie z https://microg.org/ lub https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 nie jest serwerem matriksa, czy chcesz zamiast niego użyć $server2?';
  }

  @override
  String get shareYourInviteLink => 'Udostępnij swój link zaproszenia';

  @override
  String get scanQrCode => 'Skanuj kod QR';

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
  String get none => 'Brak';

  @override
  String get noPasswordRecoveryDescription =>
      'Nie dodałeś jeszcze sposobu aby odzyskać swoje hasło.';

  @override
  String get noPermission => 'Brak uprawnień';

  @override
  String get noRoomsFound => 'Nie znaleziono pokoi…';

  @override
  String get notifications => 'Powiadomienia';

  @override
  String get notificationsEnabledForThisAccount =>
      'Powiadomienia są włączone dla tego konta';

  @override
  String numUsersTyping(Object count) {
    return '$count użytkowników pisze…';
  }

  @override
  String get obtainingLocation => 'Uzyskiwanie lokalizacji…';

  @override
  String get offensive => 'Agresywne';

  @override
  String get offline => 'Offline';

  @override
  String get ok => 'Ok';

  @override
  String get online => 'Online';

  @override
  String get onlineKeyBackupEnabled =>
      'Kopia zapasowa kluczy online jest włączona';

  @override
  String get oopsPushError =>
      'Ups! Wystąpił błąd podczas ustawiania powiadomień push.';

  @override
  String get oopsSomethingWentWrong => 'Ups! Coś poszło nie tak…';

  @override
  String get openAppToReadMessages => 'Otwórz aplikację by odczytać wiadomości';

  @override
  String get openCamera => 'Otwórz aparat';

  @override
  String get openVideoCamera => 'Nagraj film';

  @override
  String get oneClientLoggedOut => 'Jedno z twoich urządzeń zostało wylogowane';

  @override
  String get addAccount => 'Dodaj konto';

  @override
  String get editBundlesForAccount => 'Edytuj paczki dla tego konta';

  @override
  String get addToBundle => 'Dodaj do pakietu';

  @override
  String get removeFromBundle => 'Usuń z tej paczki';

  @override
  String get bundleName => 'Nazwa pakietu';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Włącza obsługę wiele kont na tym urządzeniu';

  @override
  String get openInMaps => 'Otwórz w mapach';

  @override
  String get link => 'Link';

  @override
  String get serverRequiresEmail =>
      'Ten serwer wymaga potwierdzenia twojego adresu email w celu rejestracji.';

  @override
  String get optionalGroupName => '(Opcjonalnie) Nazwa grupy';

  @override
  String get or => 'Lub';

  @override
  String get participant => 'Uczestnik';

  @override
  String get passphraseOrKey => 'fraza dostępu lub klucz odzyskiwania';

  @override
  String get password => 'Hasło';

  @override
  String get passwordForgotten => 'Zapomniano hasła';

  @override
  String get passwordHasBeenChanged => 'Hasło zostało zmienione';

  @override
  String get passwordRecovery => 'Odzyskiwanie hasła';

  @override
  String get pickImage => 'Wybierz obraz';

  @override
  String get pin => 'Przypnij';

  @override
  String play(Object fileName) {
    return 'Otwórz $fileName';
  }

  @override
  String get pleaseChoose => 'Proszę wybierz';

  @override
  String get pleaseChooseAPasscode => 'Wybierz kod dostępu';

  @override
  String get pleaseChooseAUsername => 'Wybierz nick';

  @override
  String get pleaseClickOnLink =>
      'Proszę kliknij w odnośnik wysłany na email aby kontynuować.';

  @override
  String get pleaseEnter4Digits =>
      'Proszę podaj 4 cyfry. By wyłączyć blokadę pozostaw puste.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Wprowadź identyfikator Matrix.';

  @override
  String get pleaseEnterRecoveryKey => 'Wprowadź swój klucz odzyskiwania:';

  @override
  String get pleaseEnterYourPassword => 'Wprowadź swoje hasło';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Podaj swój PIN';

  @override
  String get pleaseEnterYourUsername => 'Wpisz swój nick';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Wykonaj instrukcje na stronie internetowej i naciśnij dalej.';

  @override
  String get privacy => 'Prywatność';

  @override
  String get publicRooms => 'Publiczne pokoje';

  @override
  String get pushRules => 'Zasady push';

  @override
  String get reason => 'Powód';

  @override
  String get recording => 'Nagranie';

  @override
  String redactedAnEvent(Object username) {
    return '$username stworzył/-a wydarzenie';
  }

  @override
  String get redactMessage => 'Przekaż wiadomość';

  @override
  String get reject => 'Odrzuć';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username odrzucił/-a zaproszenie';
  }

  @override
  String get rejoin => 'Dołącz ponownie';

  @override
  String get remove => 'Usuń';

  @override
  String get removeAllOtherDevices => 'Usuń wszystkie inne urządzenia';

  @override
  String removedBy(Object username) {
    return 'Usunięta przez $username';
  }

  @override
  String get removeDevice => 'Usuń urządzenie';

  @override
  String get unbanFromChat => 'Odbanuj z czatu';

  @override
  String get removeYourAvatar => 'Usuń swój avatar';

  @override
  String get renderRichContent =>
      'Pokazuj w wiadomościach pogrubienia i podkreślenia';

  @override
  String get replaceRoomWithNewerVersion => 'Zamień pokój na nową wersję';

  @override
  String get reply => 'Odpowiedz';

  @override
  String get reportMessage => 'Zgłoś wiadomość';

  @override
  String get requestPermission => 'Prośba o pozwolenie';

  @override
  String get roomHasBeenUpgraded => 'Pokój zostać zaktualizowany';

  @override
  String get roomVersion => 'Wersja pokoju';

  @override
  String get saveFile => 'Zapisz plik';

  @override
  String get search => 'Szukaj';

  @override
  String get security => 'Bezpieczeństwo';

  @override
  String get recoveryKey => 'Klucz odzyskiwania';

  @override
  String get recoveryKeyLost => 'Utracono klucz odzyskiwania?';

  @override
  String seenByUser(Object username) {
    return 'Zobaczone przez $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Zobaczone przez $username i $count innych';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Zobaczone przez $username oraz $username2';
  }

  @override
  String get send => 'Wyślij';

  @override
  String get sendAMessage => 'Wyślij wiadomość';

  @override
  String get sendAsText => 'Wyślij jako tekst';

  @override
  String get sendAudio => 'Wyślij dźwięk';

  @override
  String get sendFile => 'Wyślij plik';

  @override
  String get sendImage => 'Wyślij obraz';

  @override
  String get sendMessages => 'Wyślij wiadomości';

  @override
  String get sendOriginal => 'Wyślij oryginał';

  @override
  String get sendSticker => 'Wyślij naklejkę';

  @override
  String get sendVideo => 'Wyślij film';

  @override
  String sentAFile(Object username) {
    return '📁 $username wysłał/-a plik';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username wysłał/-a plik audio';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username wysłał/-a zdjęcie';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username wysłał/-a naklejkę';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username wysłał/-a film';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName wysłał/-a informacje o połączeniu';
  }

  @override
  String get separateChatTypes => 'Oddzielenie czatów bezpośrednich i grup';

  @override
  String get setAsCanonicalAlias => 'Ustaw jako główny alias';

  @override
  String get setCustomEmotes => 'Ustaw niestandardowe emotki';

  @override
  String get setGroupDescription => 'Ustaw opis grupy';

  @override
  String get setInvitationLink => 'Ustaw link zaproszeniowy';

  @override
  String get setPermissionsLevel => 'Ustaw poziom uprawnień';

  @override
  String get setStatus => 'Ustaw status';

  @override
  String get settings => 'Ustawienia';

  @override
  String get share => 'Udostępnij';

  @override
  String sharedTheLocation(Object username) {
    return '$username udostępnił/-a swoją lokalizacje';
  }

  @override
  String get shareLocation => 'Udostępnij lokalizację';

  @override
  String get showDirectChatsInSpaces =>
      'Pokaż powiązane czaty bezpośrednie w przestrzeniach';

  @override
  String get showPassword => 'Pokaż hasło';

  @override
  String get signUp => 'Zarejestruj się';

  @override
  String get singlesignon => 'Pojedyncze logowanie';

  @override
  String get skip => 'Pomiń';

  @override
  String get sourceCode => 'Kod żródłowy';

  @override
  String get spaceIsPublic => 'Ustaw jako publiczną';

  @override
  String get spaceName => 'Nazwa przestrzeni';

  @override
  String startedACall(Object senderName) {
    return '$senderName rozpoczął rozmowę';
  }

  @override
  String get startFirstChat => 'Rozpocznij swój pierwszy czat';

  @override
  String get status => 'Status';

  @override
  String get statusExampleMessage => 'Jak się masz dziś?';

  @override
  String get submit => 'Odeślij';

  @override
  String get synchronizingPleaseWait => 'Synchronizacja… Proszę czekać.';

  @override
  String get systemTheme => 'System';

  @override
  String get theyDontMatch => 'Nie pasują';

  @override
  String get theyMatch => 'Pasują';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Przełącz ulubione';

  @override
  String get toggleMuted => 'Przełącz wyciszone';

  @override
  String get toggleUnread => 'Oznacz przeczytane/nieprzeczytane';

  @override
  String get tooManyRequestsWarning =>
      'Zbyt wiele zapytań. Proszę spróbuj ponownie później.';

  @override
  String get transferFromAnotherDevice => 'Przenieś z innego urządzenia';

  @override
  String get tryToSendAgain => 'Spróbuj wysłać ponownie';

  @override
  String get unavailable => 'Niedostępne';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username odbanował/-a $targetName';
  }

  @override
  String get unblockDevice => 'Odblokuj urządzenie';

  @override
  String get unknownDevice => 'Nieznane urządzenie';

  @override
  String get unknownEncryptionAlgorithm => 'Nieznany algorytm szyfrowania';

  @override
  String get unmuteChat => 'Wyłącz wyciszenie';

  @override
  String get unpin => 'Odepnij';

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
    return '$username oraz $count innych pisze…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username oraz $username2 piszą…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username pisze…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username opuścił/-a czat';
  }

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username wysłał/-a wydarzenie $type';
  }

  @override
  String get unverified => 'Niezweryfikowane';

  @override
  String get verified => 'Zweryfikowane';

  @override
  String get verify => 'zweryfikuj';

  @override
  String get verifyStart => 'Rozpocznij weryfikację';

  @override
  String get verifySuccess => 'Pomyślnie zweryfikowano!';

  @override
  String get verifyTitle => 'Weryfikowanie innego konta';

  @override
  String get videoCall => 'Rozmowa wideo';

  @override
  String get visibilityOfTheChatHistory => 'Widoczność historii czatu';

  @override
  String get visibleForAllParticipants =>
      'Widoczny dla wszystkich użytkowników';

  @override
  String get visibleForEveryone => 'Widoczny dla każdego';

  @override
  String get voiceMessage => 'Wiadomość głosowa';

  @override
  String get waitingPartnerAcceptRequest =>
      'Oczekiwanie na zaakceptowanie prośby przez drugą osobę…';

  @override
  String get waitingPartnerEmoji =>
      'Oczekiwanie na zaakceptowanie emoji przez drugą osobę…';

  @override
  String get waitingPartnerNumbers =>
      'Oczekiwanie na zaakceptowanie numerów przez drugą osobę…';

  @override
  String get wallpaper => 'Tapeta';

  @override
  String get warning => 'Uwaga!';

  @override
  String get weSentYouAnEmail => 'Wysłaliśmy Ci maila';

  @override
  String get whoCanPerformWhichAction => 'Kto może wykonywać jakie czynności';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Kto może dołączyć do tej grupy';

  @override
  String get whyDoYouWantToReportThis => 'Dlaczego chcesz to zgłosić?';

  @override
  String get wipeChatBackup =>
      'Wymazać kopię zapasową czatu, aby utworzyć nowy klucz odzyskiwania?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Dzięki tym adresom możesz odzyskać swoje hasło.';

  @override
  String get writeAMessage => 'Napisz wiadomość…';

  @override
  String get yes => 'Tak';

  @override
  String get you => 'Ty';

  @override
  String get youAreInvitedToThisChat =>
      'Dostałeś/-aś zaproszenie do tego czatu';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Nie uczestniczysz już w tym czacie';

  @override
  String get youCannotInviteYourself => 'Nie możesz zaprosić siebie';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Zostałeś/-aś zbanowany/-a z tego czatu';

  @override
  String get yourPublicKey => 'Twój klucz publiczny';

  @override
  String get messageInfo => 'Informacje o wiadomości';

  @override
  String get time => 'Czas';

  @override
  String get messageType => 'Rodzaj wiadomości';

  @override
  String get sender => 'Nadawca';

  @override
  String get openGallery => 'Otwórz galerię';

  @override
  String get removeFromSpace => 'Usuń z przestrzeni';

  @override
  String get addToSpaceDescription =>
      'Wybierz przestrzeń, do której ten czat ma być dodany.';

  @override
  String get start => 'Start';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Aby odblokować wcześniejsze wiadomości, wprowadź swój klucz odzyskiwania, który został wygenerowany w poprzedniej sesji. Twój klucz odzyskiwania NIE jest Twoim hasłem.';

  @override
  String get addToStory => 'Dodaj do relacji';

  @override
  String get publish => 'Opublikuj';

  @override
  String get whoCanSeeMyStories => 'Kto może widzieć moje relacje?';

  @override
  String get unsubscribeStories => 'Odsubskrybuj relacje';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Ten użytkownik jeszcze nic nie zamieścił na swojej relacji';

  @override
  String get yourStory => 'Twoja relacja';

  @override
  String get replyHasBeenSent => 'Wysłano odpowiedź';

  @override
  String videoWithSize(Object size) {
    return 'Film ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Relacja z $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Pamiętaj, że w Twojej relacji ludzie mogą się widzieć i kontaktować ze sobą.';

  @override
  String get whatIsGoingOn => 'Co u ciebie słychać?';

  @override
  String get addDescription => 'Dodaj opis';

  @override
  String get storyPrivacyWarning =>
      'Pamiętaj, że w Twojej relacji ludzie mogą się widzieć i kontaktować ze sobą. Twoje relacje będą widoczne przez 24 godziny, ale nie ma gwarancji, że zostaną usunięte ze wszystkich urządzeń i serwerów.';

  @override
  String get iUnderstand => 'Rozumiem';

  @override
  String get openChat => 'Otwórz czat';

  @override
  String get markAsRead => 'Oznacz jako przeczytane';

  @override
  String get reportUser => 'Zgłoś użytkownika';

  @override
  String get dismiss => 'Odrzuć';

  @override
  String get matrixWidgets => 'Widżety Matrix';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender zareagował/-a z $reaction';
  }

  @override
  String get pinMessage => 'Przypnij do pokoju';

  @override
  String get confirmEventUnpin =>
      'Czy na pewno chcesz trwale odpiąć wydarzenie?';

  @override
  String get emojis => 'Emoji';

  @override
  String get placeCall => 'Zadzwoń';

  @override
  String get voiceCall => 'Połączenie głosowe';

  @override
  String get unsupportedAndroidVersion =>
      'Nieobsługiwana wersja systemu Android';

  @override
  String get unsupportedAndroidVersionLong =>
      'Ta funkcja wymaga nowszej wersji systemu Android. Sprawdź aktualizacje lub wsparcie Lineage OS.';

  @override
  String get videoCallsBetaWarning =>
      'Należy pamiętać, że połączenia wideo są obecnie w fazie beta. Mogą nie działać zgodnie z oczekiwaniami lub nie działać w ogóle na wszystkich platformach.';

  @override
  String get experimentalVideoCalls => 'Eksperymentalne połączenia wideo';

  @override
  String get emailOrUsername => 'Adres e-mail lub nazwa użytkownika';

  @override
  String get indexedDbErrorTitle => 'Problemy związane z trybem prywatnym';

  @override
  String get indexedDbErrorLong =>
      'Przechowywanie wiadomości niestety nie jest domyślnie włączone w trybie prywatnym.\nOdwiedź\n - about:config\n - ustaw dom.indexedDB.privateBrowsing.enabled na true\nW przeciwnym razie nie jest możliwe uruchomienie FluffyChat.';

  @override
  String switchToAccount(Object number) {
    return 'Przełącz na konto $number';
  }

  @override
  String get nextAccount => 'Następne konto';

  @override
  String get previousAccount => 'Poprzednie konto';

  @override
  String get editWidgets => 'Edytuj widżety';

  @override
  String get addWidget => 'Dodaj widżet';

  @override
  String get widgetVideo => 'Film';

  @override
  String get widgetEtherpad => 'Notatka';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Własny';

  @override
  String get widgetName => 'Nazwa';

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
  String get widgetUrlError => 'Niepoprawny URL.';

  @override
  String get widgetNameError => 'Podaj nazwę wyświetlaną.';

  @override
  String get errorAddingWidget => 'Błąd podczas dodawania widżetu.';

  @override
  String get youRejectedTheInvitation => 'Odrzucono zaproszenie';

  @override
  String get youJoinedTheChat => 'Dołączono do czatu';

  @override
  String get youAcceptedTheInvitation => '👍 Zaakceptowałeś/-aś zaproszenie';

  @override
  String youBannedUser(Object user) {
    return 'Zbanowałeś/-aś $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Wycofano zaproszenie dla $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 Zostałeś/-aś zaproszony/-a przez $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 Zaprosiłeś/-aś $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 Wyrzuciłeś/-aś $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 Wyrzuciłeś/-aś i zbanowałeś/-aś $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Odbanowałeś/-aś $user';
  }

  @override
  String get noEmailWarning =>
      'Wprowadź prawidłowy adres e-mail. W przeciwnym razie resetowanie hasła nie będzie możliwe. Jeśli nie chcesz, dotknij ponownie przycisku, aby kontynuować.';

  @override
  String get stories => 'Relacje';

  @override
  String get users => 'Użytkownicy';

  @override
  String get unlockOldMessages => 'Odblokuj stare wiadomości';

  @override
  String get storeInSecureStorageDescription =>
      'Przechowaj klucz odzyskiwania w bezpiecznym magazynie tego urządzenia.';

  @override
  String get saveKeyManuallyDescription =>
      'Zapisz ten klucz ręcznie, uruchamiając systemowe okno dialogowe udostępniania lub schowek.';

  @override
  String get storeInAndroidKeystore => 'Przechowaj w Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Przechowaj w pęku kluczy Apple';

  @override
  String get storeSecurlyOnThisDevice =>
      'Przechowaj bezpiecznie na tym urządzeniu';

  @override
  String countFiles(Object count) {
    return '$count plików';
  }

  @override
  String get user => 'Użytkownik';

  @override
  String get custom => 'Własne';

  @override
  String get foregroundServiceRunning =>
      'To powiadomienie pojawia się, gdy usługa w tle jest uruchomiona.';

  @override
  String get screenSharingTitle => 'udostępnianie ekranu';

  @override
  String get screenSharingDetail => 'Udostępniasz swój ekran w FluffyChat';

  @override
  String get callingPermissions => 'Uprawnienia połączeń';

  @override
  String get callingAccount => 'Konto połączeń';

  @override
  String get callingAccountDetails =>
      'Pozwala FluffyChat używać natywnej aplikacji do wykonywania połączeń w Androidzie.';

  @override
  String get appearOnTop => 'Wyświetlaj nad innymi';

  @override
  String get appearOnTopDetails =>
      'Umożliwia wyświetlanie aplikacji nad innymi (nie jest to konieczne, jeśli FluffyChat jest już ustawiony jako konto do dzwonienia)';

  @override
  String get otherCallingPermissions =>
      'Mikrofon, kamera i inne uprawnienia FluffyChat';

  @override
  String get whyIsThisMessageEncrypted =>
      'Dlaczego nie można odczytać tej wiadomości?';

  @override
  String get noKeyForThisMessage =>
      'Może się to zdarzyć, jeśli wiadomość została wysłana przed zalogowaniem się na to konto na tym urządzeniu.\n\nMożliwe jest również, że nadawca zablokował Twoje urządzenie lub coś poszło nie tak z połączeniem internetowym.\n\nJesteś w stanie odczytać wiadomość na innej sesji? W takim razie możesz przenieść z niej wiadomość! Wejdź w Ustawienia > Urządzenia i upewnij się, że Twoje urządzenia zweryfikowały się wzajemnie. Gdy następnym razem otworzysz pokój i obie sesje będą włączone, klucze zostaną przekazane automatycznie.\n\nNie chcesz stracić kluczy podczas wylogowania lub przełączania urządzeń? Upewnij się, że w ustawieniach masz włączoną kopię zapasową czatu.';

  @override
  String get newGroup => 'Nowa grupa';

  @override
  String get newSpace => 'Nowa przestrzeń';

  @override
  String get enterSpace => 'Wejdź do przestrzeni';

  @override
  String get enterRoom => 'Wejdź do pokoju';

  @override
  String get allSpaces => 'Wszystkie przestrzenie';

  @override
  String numChats(Object number) {
    return '$number czatów';
  }

  @override
  String get hideUnimportantStateEvents => 'Ukryj nieistotne wydarzenia stanu';

  @override
  String get doNotShowAgain => 'Nie pokazuj ponownie';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Pusty czat (wcześniej $oldDisplayName)';
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
      'Przestrzenie pozwalają na konsolidację czatów i budowanie prywatnych lub publicznych społeczności.';

  @override
  String get encryptThisChat => 'Zaszyfruj ten czat';

  @override
  String get endToEndEncryption => 'Szyfrowanie od końca do końca';

  @override
  String get disableEncryptionWarning =>
      'Ze względów bezpieczeństwa nie można wyłączyć szyfrowania w czacie, w którym zostało ono wcześniej włączone.';

  @override
  String get sorryThatsNotPossible => 'Przepraszamy... to nie jest możliwe';

  @override
  String get deviceKeys => 'Klucze urządzenia:';

  @override
  String get letsStart => 'Zacznijmy';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Wprowadź link zaproszenia lub identyfikator Matrix...';

  @override
  String get reopenChat => 'Otwórz ponownie czat';

  @override
  String get noBackupWarning =>
      'Uwaga! Bez włączenia kopii zapasowej czatu, stracisz dostęp do swoich zaszyfrowanych wiadomości. Zaleca się włączenie kopii zapasowej czatu przed wylogowaniem.';

  @override
  String get noOtherDevicesFound => 'Nie znaleziono innych urządzeń';

  @override
  String get fileIsTooBigForServer =>
      'Serwer zgłasza, że plik jest zbyt duży, aby go wysłać.';

  @override
  String fileHasBeenSavedAt(Object path) {
    return 'Plik został zapisany w ścieżce $path';
  }

  @override
  String get jumpToLastReadMessage =>
      'Przejdź do ostatnio przeczytanej wiadomości';

  @override
  String get readUpToHere => 'Czytaj do tego miejsca';

  @override
  String get jump => 'Przejdź';

  @override
  String get openLinkInBrowser => 'Otwórz link w przeglądarce';

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
