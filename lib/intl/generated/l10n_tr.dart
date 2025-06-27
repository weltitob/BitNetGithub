// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'Kaydol';

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
  String get passwordsDoNotMatch => 'Parolalar eşleşmiyor!';

  @override
  String get pleaseEnterValidEmail =>
      'Lütfen geçerli bir e-posta adresi girin.';

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
  String get people => 'İnsanlar';

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
  String get groups => 'Gruplar';

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
  String get repeatPassword => 'Parolayı tekrarlayın';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Lütfen en az $min karakter seçin.';
  }

  @override
  String get about => 'Hakkında';

  @override
  String get updateAvailable => 'FluffyChat güncellemesi var';

  @override
  String get updateNow => 'Güncellemeyi arka planda başlat';

  @override
  String get accept => 'Kabul et';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username katılma davetini kabul etti';
  }

  @override
  String get account => 'Hesap';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username uçtan uca şifrelemeyi etkinleştirdi';
  }

  @override
  String get addEmail => 'E-posta ekle';

  @override
  String get confirmMatrixId =>
      'Hesabınızı silmek için lütfen Matrix kimliğinizi doğrulayın.';

  @override
  String supposedMxid(Object mxid) {
    return 'Bu $mxid olmalıdır';
  }

  @override
  String get addGroupDescription => 'Grup açıklaması ekle';

  @override
  String get addToSpace => 'Alana ekle';

  @override
  String get admin => 'Yönetici';

  @override
  String get alias => 'takma ad';

  @override
  String get all => 'Tümü';

  @override
  String get allChats => 'Tüm sohbetler';

  @override
  String get commandHint_googly => 'Şaşkın gözler gönder';

  @override
  String get commandHint_cuddle => 'Kucaklama gönder';

  @override
  String get commandHint_hug => 'Sarılma gönder';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName size şaşkın gözler gönderiyor';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName sizi kucaklıyor';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName size sarılıyor';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '$senderName aramayı yanıtladı';
  }

  @override
  String get anyoneCanJoin => 'Herkes katılabilir';

  @override
  String get appLock => 'Uygulama kilidi';

  @override
  String get archive => 'Arşiv';

  @override
  String get areGuestsAllowedToJoin =>
      'Misafir kullanıcıların katılmasına izin veriliyor mu';

  @override
  String get areYouSure => 'Emin misiniz?';

  @override
  String get areYouSureYouWantToLogout =>
      'Oturumu açmak istediğinizden emin misiniz?';

  @override
  String get askSSSSSign =>
      'Diğer kişiyi imzalayabilmek için lütfen güvenli depolama parolanızı veya kurtarma anahtarınızı girin.';

  @override
  String askVerificationRequest(Object username) {
    return '$username kişisinden gelen bu doğrulama isteği kabul edilsin mi?';
  }

  @override
  String get autoplayImages =>
      'Canlandırmalı çıkartmaları ve ifadeleri otomatik olarak oynat';

  @override
  String get sendOnEnter => 'Enter tuşu ile gönder';

  @override
  String get banFromChat => 'Sohbetten engelle';

  @override
  String get banned => 'Engellendi';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username, $targetName kişisini engelledi';
  }

  @override
  String get blockDevice => 'Aygıtı Engelle';

  @override
  String get blocked => 'Engellendi';

  @override
  String get botMessages => 'Bot mesajları';

  @override
  String get bubbleSize => 'Baloncuk boyutu';

  @override
  String get cancel => 'İptal';

  @override
  String cantOpenUri(Object uri) {
    return '$uri URI\'si açılamıyor';
  }

  @override
  String get changeDeviceName => 'Aygıt adını değiştir';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username sohbet avatarını değiştirdi';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username sohbet açıklamasını değiştirdi: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username sohbet adını değiştirdi: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username sohbet izinlerini değiştirdi';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username görünen adını \'$displayname\' olarak değiştirdi';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username misafir erişim kurallarını değiştirdi';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username misafir erişim kurallarını değiştirdi: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username geçmiş görünürlüğünü değiştirdi';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username geçmiş görünürlüğünü değiştirdi: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username katılım kurallarını değiştirdi';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username katılım kurallarını değiştirdi: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username avatarını değiştirdi';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username oda takma adlarını değiştirdi';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username davet bağlantısını değiştirdi';
  }

  @override
  String get changePassword => 'Parolayı değiştir';

  @override
  String get changeTheHomeserver => 'Ana sunucuyu değiştir';

  @override
  String get changeTheme => 'Tarzınızı değiştirin';

  @override
  String get changeTheNameOfTheGroup => 'Grubun adını değiştir';

  @override
  String get changeWallpaper => 'Duvar kağıdını değiştir';

  @override
  String get changeYourAvatar => 'Avatarınızı değiştirin';

  @override
  String get channelCorruptedDecryptError => 'Şifreleme bozuldu';

  @override
  String get chat => 'Sohbet';

  @override
  String get yourChatBackupHasBeenSetUp => 'Sohbet yedeklemeniz ayarlandı.';

  @override
  String get chatBackup => 'Sohbet yedekleme';

  @override
  String get chatBackupDescription =>
      'Eski mesajlarınız bir kurtarma anahtarı ile güvence altına alındı. Lütfen kaybetmediğinizden emin olun.';

  @override
  String get chatDetails => 'Sohbet ayrıntıları';

  @override
  String get chatHasBeenAddedToThisSpace => 'Sohbet bu alana eklendi';

  @override
  String get chats => 'Sohbetler';

  @override
  String get chooseAStrongPassword => 'Güçlü bir parola seçin';

  @override
  String get chooseAUsername => 'Bir kullanıcı adı seçin';

  @override
  String get clearArchive => 'Arşivi temizle';

  @override
  String get close => 'Kapat';

  @override
  String get commandHint_markasdm => 'Doğrudan mesaj odası olarak işaretle';

  @override
  String get commandHint_markasgroup => 'Grup olarak işaretle';

  @override
  String get commandHint_ban => 'Verilen kullanıcıyı bu odadan yasaklayın';

  @override
  String get commandHint_clearcache => 'Önbelleği temizleyin';

  @override
  String get commandHint_create =>
      'Boş bir grup sohbeti oluşturun\nŞifrelemeyi devre dışı bırakmak için --no-encryption kullanın';

  @override
  String get commandHint_discardsession => 'Oturumu silin';

  @override
  String get commandHint_dm =>
      'Doğrudan sohbet başlatın\nŞifrelemeyi devre dışı bırakmak için --no-encryption kullanın';

  @override
  String get commandHint_html => 'HTML biçimli metin gönderin';

  @override
  String get commandHint_invite => 'Verilen kullanıcıyı bu odaya davet edin';

  @override
  String get commandHint_join => 'Verilen odaya katılın';

  @override
  String get commandHint_kick => 'Verilen kullanıcıyı bu odadan kaldırın';

  @override
  String get commandHint_leave => 'Bu odadan ayrılın';

  @override
  String get commandHint_me => 'Kendinizi tanımlayın';

  @override
  String get commandHint_myroomavatar =>
      'Bu oda için resminizi ayarlayın (mxc-uri ile)';

  @override
  String get commandHint_myroomnick => 'Bu oda için görünen adınızı ayarlayın';

  @override
  String get commandHint_op =>
      'Verilen kullanıcının güç seviyesini ayarlayın (öntanımlı: 50)';

  @override
  String get commandHint_plain => 'Biçimlendirilmemiş metin gönderin';

  @override
  String get commandHint_react => 'Tepki olarak yanıt gönderin';

  @override
  String get commandHint_send => 'Metin gönderin';

  @override
  String get commandHint_unban =>
      'Verilen kullanıcının bu odadaki yasağını kaldırın';

  @override
  String get commandInvalid => 'Komut geçersiz';

  @override
  String commandMissing(Object command) {
    return '$command bir komut değil.';
  }

  @override
  String get compareEmojiMatch => 'Lütfen emojileri karşılaştırın';

  @override
  String get compareNumbersMatch => 'Lütfen sayıları karşılaştırın';

  @override
  String get configureChat => 'Sohbeti yapılandır';

  @override
  String get confirm => 'Onayla';

  @override
  String get connect => 'Bağlan';

  @override
  String get contactHasBeenInvitedToTheGroup => 'Kişi gruba davet edildi';

  @override
  String get containsDisplayName => 'Görünen ad içerir';

  @override
  String get containsUserName => 'Kullanıcı adı içerir';

  @override
  String get contentHasBeenReported =>
      'İçerik, sunucu yöneticilerine bildirildi';

  @override
  String get copiedToClipboard => 'Panoya kopyalandı';

  @override
  String get copy => 'Kopyala';

  @override
  String get copyToClipboard => 'Panoya kopyala';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Mesajın şifresi çözülemedi: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count katılımcı';
  }

  @override
  String get create => 'Oluştur';

  @override
  String createdTheChat(Object username) {
    return '💬 $username sohbeti oluşturdu';
  }

  @override
  String get createNewGroup => 'Yeni grup oluştur';

  @override
  String get createNewSpace => 'Yeni alan';

  @override
  String get currentlyActive => 'Şu anda etkin';

  @override
  String get darkTheme => 'Koyu';

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
    return '$day/$month/$year';
  }

  @override
  String get deactivateAccountWarning =>
      'Bu, kullanıcı hesabınızı devre dışı bırakacak. Bu geri alınamaz! Emin misiniz?';

  @override
  String get defaultPermissionLevel => 'Öntanımlı izin seviyesi';

  @override
  String get delete => 'Sil';

  @override
  String get deleteAccount => 'Hesabı sil';

  @override
  String get deleteMessage => 'Mesajı sil';

  @override
  String get deny => 'Reddet';

  @override
  String get device => 'Aygıt';

  @override
  String get deviceId => 'Aygıt kimliği';

  @override
  String get devices => 'Aygıtlar';

  @override
  String get directChats => 'Doğrudan Sohbetler';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Görünen ad değiştirildi';

  @override
  String get downloadFile => 'Dosyayı indir';

  @override
  String get edit => 'Düzenle';

  @override
  String get editBlockedServers => 'Engellenen sunucuları düzenle';

  @override
  String get editChatPermissions => 'Sohbet izinlerini düzenle';

  @override
  String get editDisplayname => 'Görünen adı düzenle';

  @override
  String get editRoomAliases => 'Oda takma adlarını düzenle';

  @override
  String get editRoomAvatar => 'Oda avatarını düzenle';

  @override
  String get emoteExists => 'İfade zaten var!';

  @override
  String get emoteInvalid => 'Geçersiz ifade kısa kodu!';

  @override
  String get emotePacks => 'Oda için ifade paketleri';

  @override
  String get emoteSettings => 'İfade Ayarları';

  @override
  String get emoteShortcode => 'İfade kısa kodu';

  @override
  String get emoteWarnNeedToPick =>
      'Bir ifade kısa kodu ve bir resim seçmeniz gerekiyor!';

  @override
  String get emptyChat => 'Boş sohbet';

  @override
  String get enableEmotesGlobally =>
      'İfade paketini küresel olarak etkinleştir';

  @override
  String get enableEncryption => 'Şifrelemeyi etkinleştir';

  @override
  String get enableEncryptionWarning =>
      'Artık şifrelemeyi devre dışı bırakamayacaksınız. Emin misiniz?';

  @override
  String get encrypted => 'Şifreli';

  @override
  String get encryption => 'Şifreleme';

  @override
  String get encryptionNotEnabled => 'Şifreleme etkinleştirilmedi';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName aramayı sonlandırdı';
  }

  @override
  String get enterAGroupName => 'Bir grup adı girin';

  @override
  String get enterAnEmailAddress => 'Bir e-posta adresi girin';

  @override
  String get enterASpacepName => 'Bir alan adı girin';

  @override
  String get homeserver => 'Ana sunucu';

  @override
  String get enterYourHomeserver => 'Ana sunucunuzu girin';

  @override
  String errorObtainingLocation(Object error) {
    return 'Konum alınırken hata oluştu: $error';
  }

  @override
  String get everythingReady => 'Herşey hazır!';

  @override
  String get extremeOffensive => 'Aşırı rahatsız edici';

  @override
  String get fileName => 'Dosya adı';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Yazı tipi boyutu';

  @override
  String get forward => 'İlet';

  @override
  String get fromJoining => 'Katılmadan';

  @override
  String get fromTheInvitation => 'Davetten';

  @override
  String get goToTheNewRoom => 'Yeni odaya git';

  @override
  String get group => 'Grup';

  @override
  String get groupDescription => 'Grup açıklaması';

  @override
  String get groupDescriptionHasBeenChanged => 'Grup açıklaması değiştirildi';

  @override
  String get groupIsPublic => 'Grup herkese açık';

  @override
  String groupWith(Object displayname) {
    return '$displayname ile grup';
  }

  @override
  String get guestsAreForbidden => 'Misafirlere izin verilmiyor';

  @override
  String get guestsCanJoin => 'Misafirler katılabilir';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username, $targetName için daveti geri çekti';
  }

  @override
  String get help => 'Yardım';

  @override
  String get hideRedactedEvents => 'Düzenlenmiş etkinlikleri gizle';

  @override
  String get hideUnknownEvents => 'Bilinmeyen etkinlikleri gizle';

  @override
  String get howOffensiveIsThisContent => 'Bu içerik ne kadar rahatsız edici?';

  @override
  String get id => 'Kimlik';

  @override
  String get identity => 'Kimlik';

  @override
  String get ignore => 'Yok say';

  @override
  String get ignoredUsers => 'Yok sayılan kullanıcılar';

  @override
  String get ignoreListDescription =>
      'Sizi rahatsız eden kullanıcıları yok sayabilirsiniz. Kişisel yok sayma listenizdeki kullanıcılardan herhangi bir mesaj veya oda daveti alamayacaksınız.';

  @override
  String get ignoreUsername => 'Kullanıcıyı yok say';

  @override
  String get iHaveClickedOnLink => 'Bağlantıya tıkladım';

  @override
  String get incorrectPassphraseOrKey => 'Yanlış parola veya kurtarma anahtarı';

  @override
  String get inoffensive => 'Rahatsız edici değil';

  @override
  String get inviteContact => 'Kişi davet et';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Kişiyi $groupName grubuna davet et';
  }

  @override
  String get invited => 'Davet edildi';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username, $targetName kişisini davet etti';
  }

  @override
  String get invitedUsersOnly => 'Sadece davet edilen kullanıcılar';

  @override
  String get inviteForMe => 'Benim için davet et';

  @override
  String inviteText(Object username, Object link) {
    return '$username sizi FluffyChat\'e davet etti. \n1. FluffyChat kurun: https://fluffychat.im \n2. Kaydolun veya giriş yapın \n3. Davet bağlantısını açın: $link';
  }

  @override
  String get isTyping => 'yazıyor…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username sohbete katıldı';
  }

  @override
  String get joinRoom => 'Odaya katıl';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username, $targetName kişisini attı';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username, $targetName kişisini attı ve engelledi';
  }

  @override
  String get kickFromChat => 'Sohbetten at';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Son görülen: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Uzun zaman önce görüldü';

  @override
  String get leave => 'Ayrıl';

  @override
  String get leftTheChat => 'Sohbetten ayrıldı';

  @override
  String get license => 'Lisans';

  @override
  String get lightTheme => 'Açık';

  @override
  String loadCountMoreParticipants(Object count) {
    return '$count katılımcı daha yükle';
  }

  @override
  String get dehydrate => 'Oturumu dışa aktar ve aygıtı sil';

  @override
  String get dehydrateWarning =>
      'Bu eylem geri alınamaz. Yedekleme dosyasını güvenli bir şekilde sakladığınızdan emin olun.';

  @override
  String get dehydrateTor => 'TOR Kullanıcıları: Oturumu dışa aktar';

  @override
  String get dehydrateTorLong =>
      'TOR kullanıcıları için, pencereyi kapatmadan önce oturumu dışa aktarmaları tavsiye edilir.';

  @override
  String get hydrateTor =>
      'TOR Kullanıcıları: Dışa aktarılan oturumu içe aktar';

  @override
  String get hydrateTorLong =>
      'TOR\'da en son oturumunuzu dışa aktardınız mı? Hızlıca içe aktarın ve sohbete devam edin.';

  @override
  String get hydrate => 'Yedekleme dosyasından geri yükle';

  @override
  String get loadingPleaseWait => 'Yükleniyor… Lütfen bekleyin.';

  @override
  String get loadMore => 'Daha fazla yükle…';

  @override
  String get locationDisabledNotice =>
      'Konum hizmetleri devre dışı. Lütfen konumunuzu paylaşabilmek için etkinleştirin.';

  @override
  String get locationPermissionDeniedNotice =>
      'Konum izni reddedildi. Lütfen konumunuzu paylaşabilmek için izin verin.';

  @override
  String get login => 'Oturum aç';

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
    return '$homeserver üzerinde oturum aç';
  }

  @override
  String get loginWithOneClick => 'Tek tıklamayla oturum aç';

  @override
  String get logout => 'Oturumu kapat';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Tanımlayıcının geçerli olduğundan emin olun';

  @override
  String get memberChanges => 'Üye değişiklikleri';

  @override
  String get mention => 'Bahset';

  @override
  String get messages => 'Mesajlar';

  @override
  String get messageWillBeRemovedWarning =>
      'Mesaj tüm katılımcılar için kaldırılacak';

  @override
  String get moderator => 'Moderatör';

  @override
  String get muteChat => 'Sohbeti sessize al';

  @override
  String get needPantalaimonWarning =>
      'Uçtan uca şifreleme kullanmak için şimdilik Pantalaimon\'a ihtiyacınız olduğunu lütfen unutmayın.';

  @override
  String get newChat => 'Yeni sohbet';

  @override
  String get newMessageInFluffyChat => '💬 FluffyChat\'te yeni mesaj';

  @override
  String get newVerificationRequest => 'Yeni doğrulama isteği!';

  @override
  String get next => 'İleri';

  @override
  String get no => 'Hayır';

  @override
  String get noConnectionToTheServer => 'Sunucuyla bağlantı yok';

  @override
  String get noEmotesFound => 'İfade bulunamadı. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Şifrelemeyi yalnızca oda artık herkese açık olmadığında etkinleştirebilirsiniz.';

  @override
  String get noGoogleServicesWarning =>
      'Görünüşe göre telefonunuzda Google hizmetleri yok. Bu, gizliliğiniz için iyi bir karar! FluffyChat\'te anlık bildirimler almak için https://microg.org/ veya https://unifiedpush.org/ kullanmanızı tavsiye ediyoruz.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 matrix sunucusu değil, onun yerine $server2 kullanılsın mı?';
  }

  @override
  String get shareYourInviteLink => 'Davet bağlantınızı paylaşın';

  @override
  String get scanQrCode => 'QR kodunu tarayın';

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
  String get none => 'Yok';

  @override
  String get noPasswordRecoveryDescription =>
      'Henüz parolanızı kurtarmak için bir yol eklemediniz.';

  @override
  String get noPermission => 'İzin yok';

  @override
  String get noRoomsFound => 'Oda bulunamadı…';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get notificationsEnabledForThisAccount =>
      'Bu hesap için bildirimler etkinleştirildi';

  @override
  String numUsersTyping(Object count) {
    return '$count kullanıcı yazıyor…';
  }

  @override
  String get obtainingLocation => 'Konum alınıyor…';

  @override
  String get offensive => 'Rahatsız edici';

  @override
  String get offline => 'Çevrim dışı';

  @override
  String get ok => 'Tamam';

  @override
  String get online => 'Çevrim içi';

  @override
  String get onlineKeyBackupEnabled =>
      'Çevrim içi anahtar yedekleme etkinleştirildi';

  @override
  String get oopsPushError =>
      'Tüh! Maalesef anlık bildirimlerini ayarlarken bir hata oluştu.';

  @override
  String get oopsSomethingWentWrong => 'Tüh, bir şeyler yanlış gitti…';

  @override
  String get openAppToReadMessages => 'Mesajları okumak için uygulamayı aç';

  @override
  String get openCamera => 'Kamerayı aç';

  @override
  String get openVideoCamera => 'Bir video için kamerayı aç';

  @override
  String get oneClientLoggedOut =>
      'İstemcilerinizden birinin oturumu kapatıldı';

  @override
  String get addAccount => 'Hesap ekle';

  @override
  String get editBundlesForAccount => 'Bu hesap için paketleri düzenle';

  @override
  String get addToBundle => 'Pakete ekle';

  @override
  String get removeFromBundle => 'Bu paketten kaldır';

  @override
  String get bundleName => 'Paket adı';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Bu aygıtta çoklu hesapları etkinleştir';

  @override
  String get openInMaps => 'Haritalarda aç';

  @override
  String get link => 'Bağlantı';

  @override
  String get serverRequiresEmail =>
      'Bu sunucunun kayıt için e-posta adresinizi doğrulaması gerekiyor.';

  @override
  String get optionalGroupName => '(İsteğe bağlı) Grup adı';

  @override
  String get or => 'Veya';

  @override
  String get participant => 'Katılımcı';

  @override
  String get passphraseOrKey => 'parola veya kurtarma anahtarı';

  @override
  String get password => 'Parola';

  @override
  String get passwordForgotten => 'Parola unutuldu';

  @override
  String get passwordHasBeenChanged => 'Parola değiştirildi';

  @override
  String get passwordRecovery => 'Parola kurtarma';

  @override
  String get pickImage => 'Bir resim seç';

  @override
  String get pin => 'Sabitle';

  @override
  String play(Object fileName) {
    return '$fileName dosyasını oynat';
  }

  @override
  String get pleaseChoose => 'Lütfen seçin';

  @override
  String get pleaseChooseAPasscode => 'Lütfen bir geçiş kodu seçin';

  @override
  String get pleaseChooseAUsername => 'Lütfen bir kullanıcı adı seçin';

  @override
  String get pleaseClickOnLink =>
      'Lütfen e-postadaki bağlantıya tıklayın ve devam edin.';

  @override
  String get pleaseEnter4Digits =>
      'Lütfen 4 basamak girin veya uygulama kilidini devre dışı bırakmak için boş bırakın.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Lütfen bir Matrix kimliği girin.';

  @override
  String get pleaseEnterRecoveryKey => 'Lütfen kurtarma anahtarınızı girin:';

  @override
  String get pleaseEnterYourPassword => 'Lütfen parolanızı girin';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Lütfen PIN kodunuzu girin';

  @override
  String get pleaseEnterYourUsername => 'Lütfen kullanıcı adınızı girin';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Lütfen web sitesindeki talimatları izleyin ve \"İleri\" düğmesine dokunun.';

  @override
  String get privacy => 'Gizlilik';

  @override
  String get publicRooms => 'Herkese Açık Odalar';

  @override
  String get pushRules => 'Gönderme kuralları';

  @override
  String get reason => 'Neden';

  @override
  String get recording => 'Kaydediliyor';

  @override
  String redactedAnEvent(Object username) {
    return '$username bir etkinliği düzenledi';
  }

  @override
  String get redactMessage => 'Mesajı düzenle';

  @override
  String get reject => 'Reddet';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username daveti reddetti';
  }

  @override
  String get rejoin => 'Yeniden katıl';

  @override
  String get remove => 'Kaldır';

  @override
  String get removeAllOtherDevices => 'Diğer tüm aygıtları kaldır';

  @override
  String removedBy(Object username) {
    return '$username tarafından kaldırıldı';
  }

  @override
  String get removeDevice => 'Aygıtı kaldır';

  @override
  String get unbanFromChat => 'Sohbet engelini kaldır';

  @override
  String get removeYourAvatar => 'Avatarınızı kaldırın';

  @override
  String get renderRichContent => 'Zengin mesaj içeriğini görüntüle';

  @override
  String get replaceRoomWithNewerVersion => 'Odayı yeni sürümle değiştir';

  @override
  String get reply => 'Yanıtla';

  @override
  String get reportMessage => 'Mesajı bildir';

  @override
  String get requestPermission => 'İzin iste';

  @override
  String get roomHasBeenUpgraded => 'Oda yükseltildi';

  @override
  String get roomVersion => 'Oda sürümü';

  @override
  String get saveFile => 'Dosyayı kaydet';

  @override
  String get search => 'Ara';

  @override
  String get security => 'Güvenlik';

  @override
  String get recoveryKey => 'Kurtarma anahtarı';

  @override
  String get recoveryKeyLost => 'Kurtarma anahtarı kayıp mı?';

  @override
  String seenByUser(Object username) {
    return '$username tarafından görüldü';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return '$username ve $count kişi tarafından görüldü';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return '$username ve $username2 tarafından görüldü';
  }

  @override
  String get send => 'Gönder';

  @override
  String get sendAMessage => 'Bir mesaj gönder';

  @override
  String get sendAsText => 'Metin olarak gönder';

  @override
  String get sendAudio => 'Ses gönder';

  @override
  String get sendFile => 'Dosya gönder';

  @override
  String get sendImage => 'Resim gönder';

  @override
  String get sendMessages => 'Mesaj gönder';

  @override
  String get sendOriginal => 'Orijinali gönder';

  @override
  String get sendSticker => 'Çıkartma gönder';

  @override
  String get sendVideo => 'Video gönder';

  @override
  String sentAFile(Object username) {
    return '📁 $username bir dosya gönderdi';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username bir ses gönderdi';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username bir resim gönderdi';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username bir çıkartma gönderdi';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username bir video gönderdi';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName arama bilgilerini gönderdi';
  }

  @override
  String get separateChatTypes => 'Doğrudan Sohbetleri ve Grupları Ayır';

  @override
  String get setAsCanonicalAlias => 'Ana takma ad olarak ayarla';

  @override
  String get setCustomEmotes => 'Özel ifadeler ayarla';

  @override
  String get setGroupDescription => 'Grup açıklaması ayarla';

  @override
  String get setInvitationLink => 'Davet bağlantısı ayarla';

  @override
  String get setPermissionsLevel => 'İzin seviyesini ayarla';

  @override
  String get setStatus => 'Durumu ayarla';

  @override
  String get settings => 'Ayarlar';

  @override
  String get share => 'Paylaş';

  @override
  String sharedTheLocation(Object username) {
    return '$username konumunu paylaştı';
  }

  @override
  String get shareLocation => 'Konumu paylaş';

  @override
  String get showDirectChatsInSpaces =>
      'Alanlarda ilgili Doğrudan Sohbetleri göster';

  @override
  String get showPassword => 'Parolayı göster';

  @override
  String get signUp => 'Hesap oluştur';

  @override
  String get singlesignon => 'Tek oturum açma';

  @override
  String get skip => 'Atla';

  @override
  String get sourceCode => 'Kaynak kodları';

  @override
  String get spaceIsPublic => 'Alan herkese açık';

  @override
  String get spaceName => 'Alan adı';

  @override
  String startedACall(Object senderName) {
    return '$senderName bir arama başlattı';
  }

  @override
  String get startFirstChat => 'İlk sohbetinizi başlatın';

  @override
  String get status => 'Durum';

  @override
  String get statusExampleMessage => 'Bugün nasılsınız?';

  @override
  String get submit => 'Gönder';

  @override
  String get synchronizingPleaseWait => 'Eşzamanlanıyor… Lütfen bekleyin.';

  @override
  String get systemTheme => 'Sistem';

  @override
  String get theyDontMatch => 'Eşleşmediler';

  @override
  String get theyMatch => 'Eşleştiler';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Sık Kullanılanlara Ekle/Çıkar';

  @override
  String get toggleMuted => 'Sessize Al/Sessizden Çıkar';

  @override
  String get toggleUnread => 'Okundu/Okunmadı Olarak İşaretle';

  @override
  String get tooManyRequestsWarning =>
      'Çok fazla istek. Lütfen daha sonra tekrar deneyin!';

  @override
  String get transferFromAnotherDevice => 'Başka bir aygıttan aktar';

  @override
  String get tryToSendAgain => 'Tekrar göndermeyi deneyin';

  @override
  String get unavailable => 'Yok';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username, $targetName kişisinin engelini kaldırdı';
  }

  @override
  String get unblockDevice => 'Aygıtın Engellemesini Kaldır';

  @override
  String get unknownDevice => 'Bilinmeyen aygıt';

  @override
  String get unknownEncryptionAlgorithm => 'Bilinmeyen şifreleme algoritması';

  @override
  String get unmuteChat => 'Sohbeti sessizden çıkar';

  @override
  String get unpin => 'Sabitlemeyi kaldır';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount okunmamış sohbet',
      one: '1 okunmamış sohbet',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username ve $count diğer kişi yazıyor…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username ve $username2 yazıyor…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username yazıyor…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username sohbetten ayrıldı';
  }

  @override
  String get username => 'Kullanıcı adı';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username bir $type etkinliği gönderdi';
  }

  @override
  String get unverified => 'Doğrulanmadı';

  @override
  String get verified => 'Doğrulandı';

  @override
  String get verify => 'Doğrula';

  @override
  String get verifyStart => 'Doğrulamayı Başlat';

  @override
  String get verifySuccess => 'Başarıyla doğrulandı!';

  @override
  String get verifyTitle => 'Diğer hesap doğrulanıyor';

  @override
  String get videoCall => 'Görüntülü arama';

  @override
  String get visibilityOfTheChatHistory => 'Sohbet geçmişi görünürlüğü';

  @override
  String get visibleForAllParticipants => 'Tüm katılımcılar için görünür';

  @override
  String get visibleForEveryone => 'Herkes için görünür';

  @override
  String get voiceMessage => 'Sesli mesaj';

  @override
  String get waitingPartnerAcceptRequest =>
      'Ortağın isteği kabul etmesi bekleniyor…';

  @override
  String get waitingPartnerEmoji => 'Ortağın emojiyi kabul etmesi bekleniyor…';

  @override
  String get waitingPartnerNumbers =>
      'Ortağın numaraları kabul etmesi bekleniyor…';

  @override
  String get wallpaper => 'Duvar kağıdı';

  @override
  String get warning => 'Uyarı!';

  @override
  String get weSentYouAnEmail => 'Size bir e-posta gönderdik';

  @override
  String get whoCanPerformWhichAction => 'Kim hangi eylemi gerçekleştirebilir';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Bu gruba kimler katılabilir';

  @override
  String get whyDoYouWantToReportThis => 'Bunu neden bildirmek istiyorsunuz?';

  @override
  String get wipeChatBackup =>
      'Yeni bir kurtarma anahtarı oluşturmak için sohbet yedeğiniz silinsin mi?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Bu adresler ile parolanızı kurtarabilirsiniz.';

  @override
  String get writeAMessage => 'Bir mesaj yaz…';

  @override
  String get yes => 'Evet';

  @override
  String get you => 'Sen';

  @override
  String get youAreInvitedToThisChat => 'Sohbete davet edildiniz';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Artık bu sohbette katılımcı değilsiniz';

  @override
  String get youCannotInviteYourself => 'Kendinizi davet edemezsiniz';

  @override
  String get youHaveBeenBannedFromThisChat => 'Bu sohbetten engellendiniz';

  @override
  String get yourPublicKey => 'Ortak anahtarınız';

  @override
  String get messageInfo => 'Mesaj bilgileri';

  @override
  String get time => 'Zaman';

  @override
  String get messageType => 'Mesaj Türü';

  @override
  String get sender => 'Gönderen';

  @override
  String get openGallery => 'Galeriyi aç';

  @override
  String get removeFromSpace => 'Alandan kaldır';

  @override
  String get addToSpaceDescription => 'Bu sohbeti eklemek için bir alan seçin.';

  @override
  String get start => 'Başla';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Eski mesajlarınızın kilidini açmak için lütfen önceki bir oturumda oluşturulan kurtarma anahtarınızı girin. Kurtarma anahtarınız parolanız DEĞİLDİR.';

  @override
  String get addToStory => 'Hikayeye ekle';

  @override
  String get publish => 'Yayınla';

  @override
  String get whoCanSeeMyStories => 'Hikayelerimi kimler görebilir?';

  @override
  String get unsubscribeStories => 'Hikayelerin aboneliğini iptal et';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Bu kullanıcı henüz hikayesinde hiçbir şey yayınlamadı';

  @override
  String get yourStory => 'Senin hikayen';

  @override
  String get replyHasBeenSent => 'Yanıt gönderildi';

  @override
  String videoWithSize(Object size) {
    return 'Video ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return '$date tarihinden hikaye: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'İnsanların hikayenizde birbirlerini görebileceğini ve iletişim kurabileceğini lütfen unutmayın.';

  @override
  String get whatIsGoingOn => 'Ne oluyor?';

  @override
  String get addDescription => 'Açıklama ekle';

  @override
  String get storyPrivacyWarning =>
      'İnsanların hikayenizde birbirlerini görebileceğini ve iletişim kurabileceğini lütfen unutmayın. Hikayeleriniz 24 saat boyunca görünür olacaktır ancak tüm aygıtlardan ve sunuculardan silineceklerinin garantisi yoktur.';

  @override
  String get iUnderstand => 'Anladım';

  @override
  String get openChat => 'Sohbeti Aç';

  @override
  String get markAsRead => 'Okundu olarak işaretle';

  @override
  String get reportUser => 'Kullanıcıyı bildir';

  @override
  String get dismiss => 'Kapat';

  @override
  String get matrixWidgets => 'Matrix Widget\'ları';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender, $reaction ile tepki verdi';
  }

  @override
  String get pinMessage => 'Odaya sabitle';

  @override
  String get confirmEventUnpin =>
      'Etkinliğin sabitlemesini kalıcı olarak kaldırmak istediğinizden emin misiniz?';

  @override
  String get emojis => 'Emojiler';

  @override
  String get placeCall => 'Arama yap';

  @override
  String get voiceCall => 'Sesli arama';

  @override
  String get unsupportedAndroidVersion => 'Desteklenmeyen Android sürümü';

  @override
  String get unsupportedAndroidVersionLong =>
      'Bu özellik daha yeni bir Android sürümü gerektiriyor. Lütfen güncellemelere veya LineageOS desteğine bakın.';

  @override
  String get videoCallsBetaWarning =>
      'Görüntülü aramaların şu anda beta aşamasında olduğunu lütfen unutmayın. Tüm platformlarda beklendiği gibi veya hiç çalışmayabilirler.';

  @override
  String get experimentalVideoCalls => 'Deneysel görüntülü aramalar';

  @override
  String get emailOrUsername => 'E-posta veya kullanıcı adı';

  @override
  String get indexedDbErrorTitle => 'Gizli mod sorunları';

  @override
  String get indexedDbErrorLong =>
      'Mesaj saklama özelliği ne yazık ki öntanımlı olarak gizli modda etkin değildir.\nLütfen\n - about:config sayfasına gidin ve\n - dom.indexedDB.privateBrowsing.enabled seçeneğini true olarak ayarlayın\nAksi takdirde FluffyChat çalıştırılamaz.';

  @override
  String switchToAccount(Object number) {
    return '$number. hesaba geç';
  }

  @override
  String get nextAccount => 'Sonraki hesap';

  @override
  String get previousAccount => 'Önceki hesap';

  @override
  String get editWidgets => 'Widget\'ları düzenle';

  @override
  String get addWidget => 'Widget ekle';

  @override
  String get widgetVideo => 'Video';

  @override
  String get widgetEtherpad => 'Metin notu';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Özel';

  @override
  String get widgetName => 'Ad';

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
  String get widgetUrlError => 'Bu geçerli bir URL değil.';

  @override
  String get widgetNameError => 'Lütfen görünecek bir ad girin.';

  @override
  String get errorAddingWidget => 'Widget eklenirken hata oluştu.';

  @override
  String get youRejectedTheInvitation => 'Daveti reddettiniz';

  @override
  String get youJoinedTheChat => 'Sohbete katıldınız';

  @override
  String get youAcceptedTheInvitation => '👍 Daveti kabul ettiniz';

  @override
  String youBannedUser(Object user) {
    return '$user kullanıcısını yasakladınız';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return '$user için daveti geri çektiniz';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 $user tarafından davet edildiniz';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 $user kullanıcısını davet ettiniz';
  }

  @override
  String youKicked(Object user) {
    return '👞 $user kullanıcısını attınız';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 $user kullanıcısını attınız ve yasakladınız';
  }

  @override
  String youUnbannedUser(Object user) {
    return '$user kullanıcısının yasağını kaldırdınız';
  }

  @override
  String get noEmailWarning =>
      'Lütfen geçerli bir e-posta adresi girin. Aksi takdirde parolanızı sıfırlayamazsınız. İstemiyorsanız, devam etmek için düğmeye tekrar dokunun.';

  @override
  String get stories => 'Hikayeler';

  @override
  String get users => 'Kullanıcılar';

  @override
  String get unlockOldMessages => 'Eski mesajların kilidini aç';

  @override
  String get storeInSecureStorageDescription =>
      'Kurtarma anahtarını bu aygıtın güvenli deposunda saklayın.';

  @override
  String get saveKeyManuallyDescription =>
      'Sistem paylaşımı iletişim kutusunu veya panoyu tetikleyerek bu anahtarı elle kaydedin.';

  @override
  String get storeInAndroidKeystore => 'Android KeyStore\'da sakla';

  @override
  String get storeInAppleKeyChain => 'Apple KeyChain\'de sakla';

  @override
  String get storeSecurlyOnThisDevice => 'Bu aygıtta güvenli bir şekilde sakla';

  @override
  String countFiles(Object count) {
    return '$count dosya';
  }

  @override
  String get user => 'Kullanıcı';

  @override
  String get custom => 'Özel';

  @override
  String get foregroundServiceRunning =>
      'Bu bildirim, ön plan hizmeti çalışırken görünür.';

  @override
  String get screenSharingTitle => 'ekran paylaşımı';

  @override
  String get screenSharingDetail => 'Ekranınızı FuffyChat\'te paylaşıyorsunuz';

  @override
  String get callingPermissions => 'Arama izinleri';

  @override
  String get callingAccount => 'Arama hesabı';

  @override
  String get callingAccountDetails =>
      'FluffyChat\'in yerel android telefon uygulamasını kullanmasına izin verir.';

  @override
  String get appearOnTop => 'Üstte görün';

  @override
  String get appearOnTopDetails =>
      'Uygulamanın üstte görünmesine izin verir (Fluffychat\'ı zaten bir arama hesabı olarak ayarladıysanız gerekli değildir)';

  @override
  String get otherCallingPermissions =>
      'Mikrofon, kamera ve diğer FluffyChat izinleri';

  @override
  String get whyIsThisMessageEncrypted => 'Bu mesaj neden okunamıyor?';

  @override
  String get noKeyForThisMessage =>
      'Bu durum, mesaj siz bu aygıtta hesabınızda oturum açmadan önce gönderildiyse meydana gelebilir.\n\nGönderenin aygıtınızı engellemiş olması veya internet bağlantısında bir sorun olması da mümkündür.\n\nMesajı başka bir oturumda okuyabiliyor musunuz? O zaman mesajı oradan aktarabilirsiniz! Ayarlar > Aygıtlar bölümüne gidin ve aygıtlarınızın birbirini doğruladığından emin olun. Odayı bir sonraki sefer açtığınızda ve her iki oturum da ön planda olduğunda, anahtarlar otomatik olarak iletilecektir.\n\nOturumu kapatırken veya aygıt değiştirirken anahtarları kaybetmek istemiyor musunuz? Ayarlarda sohbet yedeklemesini etkinleştirdiğinizden emin olun.';

  @override
  String get newGroup => 'Yeni grup';

  @override
  String get newSpace => 'Yeni alan';

  @override
  String get enterSpace => 'Alana gir';

  @override
  String get enterRoom => 'Odaya gir';

  @override
  String get allSpaces => 'Tüm alanlar';

  @override
  String numChats(Object number) {
    return '$number sohbet';
  }

  @override
  String get hideUnimportantStateEvents => 'Önemsiz durum etkinliklerini gizle';

  @override
  String get doNotShowAgain => 'Tekrar gösterme';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Boş sohbet ($oldDisplayName idi)';
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
      'Alanlar, sohbetlerinizi birleştirmenize ve özel veya genel topluluklar oluşturmanıza olanak tanır.';

  @override
  String get encryptThisChat => 'Bu sohbeti şifrele';

  @override
  String get endToEndEncryption => 'Uçtan uca şifreleme';

  @override
  String get disableEncryptionWarning =>
      'Güvenlik nedeniyle, daha önce etkinleştirildiği bir sohbette şifrelemeyi devre dışı bırakamazsınız.';

  @override
  String get sorryThatsNotPossible => 'Üzgünüm... bu mümkün değil';

  @override
  String get deviceKeys => 'Aygıt anahtarları:';

  @override
  String get letsStart => 'Başlayalım';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Davet bağlantısını veya Matris kimliğini girin...';

  @override
  String get reopenChat => 'Sohbeti yeniden aç';

  @override
  String get noBackupWarning =>
      'Uyarı! Sohbet yedeklemesini etkinleştirmezseniz, şifrelenen mesajlarınıza erişiminizi kaybedersiniz. Oturumu kapatmadan önce sohbet yedeklemesini etkinleştirmeniz önemle tavsiye edilir.';

  @override
  String get noOtherDevicesFound => 'Başka aygıt bulunamadı';

  @override
  String get fileIsTooBigForServer =>
      'Sunucu, dosyanın gönderilemeyecek kadar büyük olduğunu bildiriyor.';

  @override
  String fileHasBeenSavedAt(Object path) {
    return 'Dosya $path konumuna kaydedildi';
  }

  @override
  String get jumpToLastReadMessage => 'Son okunan mesaja atla';

  @override
  String get readUpToHere => 'Buraya kadar oku';

  @override
  String get jump => 'Atla';

  @override
  String get openLinkInBrowser => 'Bağlantıyı tarayıcıda aç';

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
