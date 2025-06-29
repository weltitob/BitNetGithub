// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => '登録';

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
  String get passwordsDoNotMatch => 'パスワードが一致しません!';

  @override
  String get pleaseEnterValidEmail => '正しいメールアドレスを入力してください。';

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
  String get people => '人々';

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
  String get groups => 'グループ';

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
  String get repeatPassword => 'パスワードを繰り返そ';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return '少なくとも$min文字を選択してください。';
  }

  @override
  String get about => 'このアプリについて';

  @override
  String get updateAvailable => 'FluffyChatのアップデートが利用可能';

  @override
  String get updateNow => 'バックグラウンドでアップデートを開始';

  @override
  String get accept => '承諾する';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍$usernameが招待を承諾しました';
  }

  @override
  String get account => 'アカウント';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐$usernameがエンドツーエンド暗号化を有効にしました';
  }

  @override
  String get addEmail => 'Eメールを追加';

  @override
  String get confirmMatrixId => 'アカウントを削除するには、Matrix IDを確認してください。';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'グループの説明を追加する';

  @override
  String get addToSpace => 'スペースに追加';

  @override
  String get admin => '管理者';

  @override
  String get alias => 'エイリアス';

  @override
  String get all => 'すべて';

  @override
  String get allChats => 'すべて会話';

  @override
  String get commandHint_googly => 'ぎょろ目を送る';

  @override
  String get commandHint_cuddle => 'Send a cuddle';

  @override
  String get commandHint_hug => 'ハグを送る';

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
    return '$senderNameは通話に出ました';
  }

  @override
  String get anyoneCanJoin => '誰でも参加できる';

  @override
  String get appLock => 'アプリのロック';

  @override
  String get archive => 'アーカイブ';

  @override
  String get areGuestsAllowedToJoin => 'ゲストユーザーの参加を許可する';

  @override
  String get areYouSure => 'これでよろしいですか？';

  @override
  String get areYouSureYouWantToLogout => 'ログアウトしてよろしいですか？';

  @override
  String get askSSSSSign => '他の人を署名するためにはパスフレーズやリカバリーキーを入力してください。';

  @override
  String askVerificationRequest(Object username) {
    return '$usernameの検証リクエストを承認しますか？';
  }

  @override
  String get autoplayImages => 'GIFを自動的に再生する';

  @override
  String get sendOnEnter => 'Enterで送信';

  @override
  String get banFromChat => 'チャットからBANする';

  @override
  String get banned => 'BANされています';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$usernameが$targetNameをBANしました';
  }

  @override
  String get blockDevice => 'デバイスをブロックする';

  @override
  String get blocked => 'ブロックしました';

  @override
  String get botMessages => 'ボットメッセージ';

  @override
  String get bubbleSize => 'ふきだしの大きさ';

  @override
  String get cancel => 'キャンセル';

  @override
  String cantOpenUri(Object uri) {
    return 'URIが開けません $uri';
  }

  @override
  String get changeDeviceName => 'デバイス名を変更';

  @override
  String changedTheChatAvatar(Object username) {
    return '$usernameがチャットアバターを変更しました';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$usernameがチャットの説明を「$description」に変更しました';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$usernameがチャットの名前を「$chatname」に変更しました';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$usernameがチャットの権限を変更しました';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$usernameが表示名を「$displayname」に変更しました';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$usernameがゲストのアクセスルールを変更しました';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$usernameがゲストのアクセスルールを$rulesに変更しました';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$usernameが履歴の表示設定を変更しました';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$usernameが履歴の表示設定を$rulesに変更しました';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$usernameが参加ルールを変更しました';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$usernameが参加ルールを$joinRulesに変更しました';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$usernameがアバターを変更しました';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$usernameが部屋のエイリアスを変更しました';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$usernameが招待リンクを変更しました';
  }

  @override
  String get changePassword => 'パスワードを変更';

  @override
  String get changeTheHomeserver => 'ホームサーバーの変更';

  @override
  String get changeTheme => 'スタイルを変更する';

  @override
  String get changeTheNameOfTheGroup => 'グループの名前を変更する';

  @override
  String get changeWallpaper => '壁紙を変更する';

  @override
  String get changeYourAvatar => 'アバタるを変化しする';

  @override
  String get channelCorruptedDecryptError => '暗号が破損しています';

  @override
  String get chat => 'チャット';

  @override
  String get yourChatBackupHasBeenSetUp => 'チャットバックアップを設定ました。';

  @override
  String get chatBackup => 'チャットのバックアップ';

  @override
  String get chatBackupDescription => '古いメッセージはリカバリーキーで保護されます。紛失しないようにご注意ください。';

  @override
  String get chatDetails => 'チャットの詳細';

  @override
  String get chatHasBeenAddedToThisSpace => 'このスペースにチャットが追加されました';

  @override
  String get chats => 'チャット';

  @override
  String get chooseAStrongPassword => '強いパスワードを選択してください';

  @override
  String get chooseAUsername => 'ユーザー名を選択してください';

  @override
  String get clearArchive => 'アーカイブを消去';

  @override
  String get close => '閉じる';

  @override
  String get commandHint_markasdm => 'ダイレクトメッセージの部屋としてマークする';

  @override
  String get commandHint_markasgroup => 'グループとしてマーク';

  @override
  String get commandHint_ban => 'このユーザーを禁止する';

  @override
  String get commandHint_clearcache => 'キャッシュをクリアする';

  @override
  String get commandHint_create =>
      '空のグループチャットを作成\n暗号化を無効にするには、--no-encryption を使用';

  @override
  String get commandHint_discardsession => 'セッションを破棄';

  @override
  String get commandHint_dm =>
      'ダイレクトチャットを開始する\n暗号化を無効にするには、--no-encryptionを使用してください';

  @override
  String get commandHint_html => 'HTML形式のテキストを送信';

  @override
  String get commandHint_invite => '指定したユーザーをこの部屋に招待';

  @override
  String get commandHint_join => '指定した部屋に参加';

  @override
  String get commandHint_kick => 'Remove the given user from this room';

  @override
  String get commandHint_leave => 'この部屋を退出';

  @override
  String get commandHint_me => 'Describe yourself';

  @override
  String get commandHint_myroomavatar => 'この部屋の写真を設定する (mxc-uriで)';

  @override
  String get commandHint_myroomnick => 'この部屋の表示名を設定する';

  @override
  String get commandHint_op =>
      'Set the given user\'s power level (default: 50)';

  @override
  String get commandHint_plain => '書式設定されていないテキストを送信する';

  @override
  String get commandHint_react => 'リアクションとして返信を送信する';

  @override
  String get commandHint_send => 'テキストを送信';

  @override
  String get commandHint_unban => 'Unban the given user from this room';

  @override
  String get commandInvalid => 'コマンドが無効';

  @override
  String commandMissing(Object command) {
    return '$command はコマンドではありません。';
  }

  @override
  String get compareEmojiMatch => '表示されている絵文字が他のデバイスで表示されているものと一致するか確認してください:';

  @override
  String get compareNumbersMatch => '表示されている数字が他のデバイスで表示されているものと一致するか確認してください:';

  @override
  String get configureChat => 'チャットの設定';

  @override
  String get confirm => '確認';

  @override
  String get connect => '接続';

  @override
  String get contactHasBeenInvitedToTheGroup => '連絡先に登録された人が招待されました';

  @override
  String get containsDisplayName => '表示名を含んでいます';

  @override
  String get containsUserName => 'ユーザー名を含んでいます';

  @override
  String get contentHasBeenReported => 'サーバー管理者に通報されました';

  @override
  String get copiedToClipboard => 'クリップボードにコピーされました';

  @override
  String get copy => 'コピー';

  @override
  String get copyToClipboard => 'クリップボードにコピー';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'メッセージを解読できませんでした: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count名の参加者';
  }

  @override
  String get create => '作成';

  @override
  String createdTheChat(Object username) {
    return '💬 $usernameがチャットを作成しました';
  }

  @override
  String get createNewGroup => 'グループを作成する';

  @override
  String get createNewSpace => '新しいスペース';

  @override
  String get currentlyActive => '現在アクティブです';

  @override
  String get darkTheme => 'ダーク';

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
    return '$year/$month/$day';
  }

  @override
  String get deactivateAccountWarning =>
      'あなたのアカウントを無効化します。この操作は元に戻せません！よろしいですか？';

  @override
  String get defaultPermissionLevel => 'デフォルトの権限レベル';

  @override
  String get delete => '削除';

  @override
  String get deleteAccount => 'アカウントの削除';

  @override
  String get deleteMessage => 'メッセージの削除';

  @override
  String get deny => '拒否';

  @override
  String get device => 'デバイス';

  @override
  String get deviceId => 'デバイスID';

  @override
  String get devices => 'デバイス';

  @override
  String get directChats => 'ダイレクトチャット';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => '表示名が変更されました';

  @override
  String get downloadFile => 'ファイルのダウンロード';

  @override
  String get edit => '編集';

  @override
  String get editBlockedServers => 'ブロックしたサーバーを編集';

  @override
  String get editChatPermissions => 'チャット権限の変更';

  @override
  String get editDisplayname => '表示名を編集';

  @override
  String get editRoomAliases => 'ルームエイリアスを編集';

  @override
  String get editRoomAvatar => '部屋のアバターを編集する';

  @override
  String get emoteExists => 'Emoteはすでに存在します！';

  @override
  String get emoteInvalid => '不正なEmoteショートコード！';

  @override
  String get emotePacks => '部屋のEmoteパック';

  @override
  String get emoteSettings => 'Emote設定';

  @override
  String get emoteShortcode => 'Emoteショートコード';

  @override
  String get emoteWarnNeedToPick => 'Emoteショートコードと画像を選択してください！';

  @override
  String get emptyChat => '空のチャット';

  @override
  String get enableEmotesGlobally => 'emoteをグローバルに有効にする';

  @override
  String get enableEncryption => '暗号化を有効にする';

  @override
  String get enableEncryptionWarning => '一度暗号化を有効にするともとに戻せません。よろしいですか？';

  @override
  String get encrypted => '暗号化';

  @override
  String get encryption => '暗号化';

  @override
  String get encryptionNotEnabled => '暗号化されていません';

  @override
  String endedTheCall(Object senderName) {
    return '$senderNameは通話を切断しました';
  }

  @override
  String get enterAGroupName => 'グループ名を入力してください';

  @override
  String get enterAnEmailAddress => 'メールアドレスを入力してください';

  @override
  String get enterASpacepName => 'スペース名を入力してください';

  @override
  String get homeserver => 'ホームサーバー';

  @override
  String get enterYourHomeserver => 'ホームサーバーを入力してください';

  @override
  String errorObtainingLocation(Object error) {
    return '位置情報の取得中にエラーが発生しました: $error';
  }

  @override
  String get everythingReady => 'すべての準備は完了しました！';

  @override
  String get extremeOffensive => 'とても攻撃的';

  @override
  String get fileName => 'ファイル名';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'フォントサイズ';

  @override
  String get forward => '進む';

  @override
  String get fromJoining => '参加時点から閲覧可能';

  @override
  String get fromTheInvitation => '招待時点から閲覧可能';

  @override
  String get goToTheNewRoom => '新規ルームへ';

  @override
  String get group => 'グループ';

  @override
  String get groupDescription => 'グループの説明';

  @override
  String get groupDescriptionHasBeenChanged => 'グループの説明が変更されました';

  @override
  String get groupIsPublic => 'グループは公開されています';

  @override
  String groupWith(Object displayname) {
    return '$displaynameとグループを作成する';
  }

  @override
  String get guestsAreForbidden => 'ゲストは許可されていません';

  @override
  String get guestsCanJoin => 'ゲストが許可されています';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$targetNameの招待を$usernameが取り下げました';
  }

  @override
  String get help => 'ヘルプ';

  @override
  String get hideRedactedEvents => '編集済みイベントを非表示にする';

  @override
  String get hideUnknownEvents => '不明なイベントを非表示にする';

  @override
  String get howOffensiveIsThisContent => 'どのくらい攻撃的でしたか？';

  @override
  String get id => 'ID';

  @override
  String get identity => 'アイデンティティ';

  @override
  String get ignore => '無視する';

  @override
  String get ignoredUsers => '無視されたユーザー';

  @override
  String get ignoreListDescription =>
      'ユーザーは無視することができます。無視したユーザーからのメッセージやルームの招待は受け取れません。';

  @override
  String get ignoreUsername => 'ユーザー名を無視する';

  @override
  String get iHaveClickedOnLink => 'リンクをクリックしました';

  @override
  String get incorrectPassphraseOrKey => 'パスフレーズかリカバリーキーが間違っています';

  @override
  String get inoffensive => '非攻撃的';

  @override
  String get inviteContact => '連絡先から招待する';

  @override
  String inviteContactToGroup(Object groupName) {
    return '連絡先から$groupNameに招待する';
  }

  @override
  String get invited => '招待されました';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username が $targetName を招待しました';
  }

  @override
  String get invitedUsersOnly => '招待されたユーザーのみ';

  @override
  String get inviteForMe => '自分への招待';

  @override
  String inviteText(Object username, Object link) {
    return '$usernameがFluffyChatにあなたを招待しました. \n1. FluffyChatをインストールしてください: https://fluffychat.im \n2. 新しくアカウントを作成するかサインインしてください\n3. 招待リンクを開いてください: $link';
  }

  @override
  String get isTyping => 'が入力しています…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username がチャットに参加しました';
  }

  @override
  String get joinRoom => '部屋に参加';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username は $targetName をキックしました';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username が $targetName をキックしブロックしました';
  }

  @override
  String get kickFromChat => 'チャットからキックする';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return '最終アクティブ: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'ずいぶん前';

  @override
  String get leave => '退室する';

  @override
  String get leftTheChat => '退室しました';

  @override
  String get license => 'ライセンス';

  @override
  String get lightTheme => 'ライト';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'あと$count名参加者を読み込む';
  }

  @override
  String get dehydrate => 'セッションのエクスポートとデバイスの消去';

  @override
  String get dehydrateWarning => 'この操作は元に戻せません。バックアップファイルを安全に保存してください。';

  @override
  String get dehydrateTor => 'TOR ユーザー: セッションをエクスポート';

  @override
  String get dehydrateTorLong =>
      'TOR ユーザーの場合、ウィンドウを閉じる前にセッションをエクスポートすることをお勧めします。';

  @override
  String get hydrateTor => 'TOR ユーザー: セッションのエクスポートをインポート';

  @override
  String get hydrateTorLong =>
      '前回、TOR でセッションをエクスポートしましたか？すぐにインポートしてチャットを続けましょう。';

  @override
  String get hydrate => 'バックアップファイルから復元';

  @override
  String get loadingPleaseWait => '読み込み中…お待ちください。';

  @override
  String get loadMore => '更に読み込む…';

  @override
  String get locationDisabledNotice =>
      '位置情報サービスが無効になっています。位置情報を共有できるようにするには、位置情報サービスを有効にしてください。';

  @override
  String get locationPermissionDeniedNotice =>
      '位置情報の権限が拒否されました。位置情報を共有できるように許可してください。';

  @override
  String get login => 'ログイン';

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
    return '$homeserverにログインする';
  }

  @override
  String get loginWithOneClick => 'ワンクリックでサインイン';

  @override
  String get logout => 'ログアウト';

  @override
  String get makeSureTheIdentifierIsValid => '識別子が正しいか確認してください';

  @override
  String get memberChanges => 'メンバーの変更';

  @override
  String get mention => 'メンション';

  @override
  String get messages => 'メッセージ';

  @override
  String get messageWillBeRemovedWarning => 'メッセージはすべての参加者から消去されます';

  @override
  String get moderator => 'モデレータ';

  @override
  String get muteChat => 'チャットのミュート';

  @override
  String get needPantalaimonWarning =>
      '現時点では、エンドツーエンドの暗号化を使用するにはPantalaimonが必要であることに注意してください。';

  @override
  String get newChat => '新規チャット';

  @override
  String get newMessageInFluffyChat => '💬 FluffyChatに新しいメッセージがあります';

  @override
  String get newVerificationRequest => '認証リクエスト！';

  @override
  String get next => '次へ';

  @override
  String get no => 'いいえ';

  @override
  String get noConnectionToTheServer => 'サーバーに接続できません';

  @override
  String get noEmotesFound => 'Emoteは見つかりませんでした😕';

  @override
  String get noEncryptionForPublicRooms => 'ルームを非公開にした後暗号化を有効にできます。';

  @override
  String get noGoogleServicesWarning =>
      'あなたのスマホにはGoogleサービスがないようですね。プライバシーを保護するための良い選択です！プッシュ通知を受け取るには https://microg.org/ または https://unifiedpush.org/ を使うことをお勧めします。';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 はMatrixのサーバーではありません。代わりに $server2 を使用しますか?';
  }

  @override
  String get shareYourInviteLink => '招待リンクを共有する';

  @override
  String get scanQrCode => 'QRコードをスキャン';

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
  String get none => 'なし';

  @override
  String get noPasswordRecoveryDescription => 'パスワードを回復する方法をまだ追加していません。';

  @override
  String get noPermission => '権限がありません';

  @override
  String get noRoomsFound => '部屋は見つかりませんでした…';

  @override
  String get notifications => '通知';

  @override
  String get notificationsEnabledForThisAccount => 'このアカウントでは通知が有効です';

  @override
  String numUsersTyping(Object count) {
    return '$count人が入力中…';
  }

  @override
  String get obtainingLocation => '位置情報を取得しています…';

  @override
  String get offensive => '攻撃的';

  @override
  String get offline => 'オフライン';

  @override
  String get ok => 'OK';

  @override
  String get online => 'オンライン';

  @override
  String get onlineKeyBackupEnabled => 'オンライン鍵バックアップは使用されています';

  @override
  String get oopsPushError => 'おっと！残念ながら、プッシュ通知の設定中にエラーが発生しました。';

  @override
  String get oopsSomethingWentWrong => 'おっと、何かがうまくいきませんでした…';

  @override
  String get openAppToReadMessages => 'アプリを開いてメッセージを確認してください';

  @override
  String get openCamera => 'カメラを開く';

  @override
  String get openVideoCamera => 'ビデオ用にカメラを開く';

  @override
  String get oneClientLoggedOut => 'クライアントの 1つがログアウトしました';

  @override
  String get addAccount => 'アカウントを追加';

  @override
  String get editBundlesForAccount => 'このアカウントのバンドルを編集';

  @override
  String get addToBundle => 'バンドルに追加';

  @override
  String get removeFromBundle => 'このバンドルから削除';

  @override
  String get bundleName => 'バンドル名';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts => '(ベータ版) このデバイスで複数のアカウントを有効にする';

  @override
  String get openInMaps => 'Open in maps';

  @override
  String get link => 'リンク';

  @override
  String get serverRequiresEmail => 'このサーバーは、登録のためにメールアドレスを検証する必要があります。';

  @override
  String get optionalGroupName => '(任意)グループ名';

  @override
  String get or => 'または';

  @override
  String get participant => '参加者';

  @override
  String get passphraseOrKey => 'パスフレーズかリカバリーキー';

  @override
  String get password => 'パスワード';

  @override
  String get passwordForgotten => 'パスワードを忘れた';

  @override
  String get passwordHasBeenChanged => 'パスワードが変更されました';

  @override
  String get passwordRecovery => 'パスワードリカバリー';

  @override
  String get pickImage => '画像を選択してください';

  @override
  String get pin => 'ピン';

  @override
  String play(Object fileName) {
    return '$fileNameを再生する';
  }

  @override
  String get pleaseChoose => '選択してください';

  @override
  String get pleaseChooseAPasscode => 'パスコードを選んでください';

  @override
  String get pleaseChooseAUsername => 'ユーザー名を選択してください';

  @override
  String get pleaseClickOnLink => 'メールのリンクから進めてください。';

  @override
  String get pleaseEnter4Digits => 'アプリのロック用に4桁の数字を入力してください。空欄の場合は無効になります。';

  @override
  String get pleaseEnterAMatrixIdentifier => 'マトリックスIDを入力してください。';

  @override
  String get pleaseEnterRecoveryKey => 'リカバリーキーを入力してください。';

  @override
  String get pleaseEnterYourPassword => 'パスワードを入力してください';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'PINを入力してください';

  @override
  String get pleaseEnterYourUsername => 'ユーザー名を入力してください';

  @override
  String get pleaseFollowInstructionsOnWeb => 'ウェブサイトにあるやり方を見てから次をタップしてください。';

  @override
  String get privacy => 'プライバシー';

  @override
  String get publicRooms => '公開された部屋';

  @override
  String get pushRules => 'ルールを追加する';

  @override
  String get reason => '理由';

  @override
  String get recording => '録音中';

  @override
  String redactedAnEvent(Object username) {
    return '$usernameがイベントを編集しました';
  }

  @override
  String get redactMessage => 'メッセージを書く';

  @override
  String get reject => '拒否';

  @override
  String rejectedTheInvitation(Object username) {
    return '$usernameは招待を拒否しました';
  }

  @override
  String get rejoin => '再参加';

  @override
  String get remove => '消去';

  @override
  String get removeAllOtherDevices => '他のデバイスをすべて削除';

  @override
  String removedBy(Object username) {
    return '$usernameによって削除されました';
  }

  @override
  String get removeDevice => 'デバイスの削除';

  @override
  String get unbanFromChat => 'チャットからのブロックを解除する';

  @override
  String get removeYourAvatar => 'アバターを削除する';

  @override
  String get renderRichContent => 'リッチメッセージをレンダリングする';

  @override
  String get replaceRoomWithNewerVersion => '部屋を新しいバージョンに変更する';

  @override
  String get reply => '返信';

  @override
  String get reportMessage => 'メッセージを通報';

  @override
  String get requestPermission => '権限を要求する';

  @override
  String get roomHasBeenUpgraded => '部屋はアップグレードされました';

  @override
  String get roomVersion => 'ルームバージョン';

  @override
  String get saveFile => 'ファイルを保存';

  @override
  String get search => '検索';

  @override
  String get security => 'セキュリティ';

  @override
  String get recoveryKey => 'リカバリーキー';

  @override
  String get recoveryKeyLost => 'リカバリーキーを紛失した場合';

  @override
  String seenByUser(Object username) {
    return '$usernameが既読';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return '$usernameと他$count人が閲覧しました';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return '$usernameと$username2が既読';
  }

  @override
  String get send => '送信';

  @override
  String get sendAMessage => 'メッセージを送信';

  @override
  String get sendAsText => 'テキストとして送信';

  @override
  String get sendAudio => '音声の送信';

  @override
  String get sendFile => 'ファイルを送信';

  @override
  String get sendImage => '画像の送信';

  @override
  String get sendMessages => 'メッセージを送る';

  @override
  String get sendOriginal => 'オリジナルの送信';

  @override
  String get sendSticker => 'ステッカーを送る';

  @override
  String get sendVideo => '動画を送信';

  @override
  String sentAFile(Object username) {
    return '📁 $usernameはファイルを送信しました';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $usernameは音声を送信しました';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $usernameは画像を送信しました';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $usernameはステッカーを送信しました';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $usernameは動画を送信しました';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderNameは通話情報を送信しました';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'メインエイリアスに設定';

  @override
  String get setCustomEmotes => 'カスタムエモートの設定';

  @override
  String get setGroupDescription => 'グループの説明を設定する';

  @override
  String get setInvitationLink => '招待リンクを設定する';

  @override
  String get setPermissionsLevel => '権限レベルをセット';

  @override
  String get setStatus => 'ステータスの設定';

  @override
  String get settings => '設定';

  @override
  String get share => '共有';

  @override
  String sharedTheLocation(Object username) {
    return '$usernameは現在地を共有しました';
  }

  @override
  String get shareLocation => '位置情報の共有';

  @override
  String get showDirectChatsInSpaces => '関連するダイレクトチャットをスペースに表示する';

  @override
  String get showPassword => 'パスワードを表示';

  @override
  String get signUp => 'サインアップ';

  @override
  String get singlesignon => 'シングルサインオン';

  @override
  String get skip => 'スキップ';

  @override
  String get sourceCode => 'ソースコード';

  @override
  String get spaceIsPublic => 'スペースは公開されています';

  @override
  String get spaceName => 'スペース名';

  @override
  String startedACall(Object senderName) {
    return '$senderNameは通話を開始しました';
  }

  @override
  String get startFirstChat => '最初のチャットを開始する';

  @override
  String get status => 'ステータス';

  @override
  String get statusExampleMessage => 'お元気ですか？';

  @override
  String get submit => '送信';

  @override
  String get synchronizingPleaseWait => '同期中...お待ちください。';

  @override
  String get systemTheme => 'システム';

  @override
  String get theyDontMatch => '違います';

  @override
  String get theyMatch => '一致しています';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'お気に入り切り替え';

  @override
  String get toggleMuted => 'ミュート切り替え';

  @override
  String get toggleUnread => '既読/未読にマーク';

  @override
  String get tooManyRequestsWarning => 'リクエストが多すぎます。また後で試してみてください！';

  @override
  String get transferFromAnotherDevice => '違うデバイスから移行する';

  @override
  String get tryToSendAgain => '送信し直してみる';

  @override
  String get unavailable => '不在';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$usernameが$targetNameのBANを解除しました';
  }

  @override
  String get unblockDevice => 'デバイスをブロック解除する';

  @override
  String get unknownDevice => '未知デバイス';

  @override
  String get unknownEncryptionAlgorithm => '未知の暗号化アルゴリズム';

  @override
  String get unmuteChat => 'チャットをミュート解除する';

  @override
  String get unpin => 'ピンを外す';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount件の未読メッセージ',
      one: '1件の未読メッセージ',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$usernameと他$count名が入力しています…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$usernameと$username2が入力しています…';
  }

  @override
  String userIsTyping(Object username) {
    return '$usernameが入力しています…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $usernameはチャットから退室しました';
  }

  @override
  String get username => 'ユーザー名';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$usernameは$typeイベントを送信しました';
  }

  @override
  String get unverified => '未検証';

  @override
  String get verified => '検証済み';

  @override
  String get verify => '確認';

  @override
  String get verifyStart => '確認を始める';

  @override
  String get verifySuccess => '確認が完了しました！';

  @override
  String get verifyTitle => '他のアカウントを確認中';

  @override
  String get videoCall => '音声通話';

  @override
  String get visibilityOfTheChatHistory => 'チャット履歴の表示';

  @override
  String get visibleForAllParticipants => 'すべての参加者が閲覧可能';

  @override
  String get visibleForEveryone => 'すべての人が閲覧可能';

  @override
  String get voiceMessage => 'ボイスメッセージ';

  @override
  String get waitingPartnerAcceptRequest => 'パートナーのリクエスト承諾待ちです...';

  @override
  String get waitingPartnerEmoji => 'パートナーの絵文字承諾待ちです...';

  @override
  String get waitingPartnerNumbers => 'パートナーの数字承諾待ちです…';

  @override
  String get wallpaper => '壁紙';

  @override
  String get warning => '警告！';

  @override
  String get weSentYouAnEmail => 'あなたにメールを送信しました';

  @override
  String get whoCanPerformWhichAction => '誰がどの操作を実行できるか';

  @override
  String get whoIsAllowedToJoinThisGroup => '誰がこのチャットに入れますか';

  @override
  String get whyDoYouWantToReportThis => 'これを通報する理由';

  @override
  String get wipeChatBackup => 'チャットのバックアップを消去して、新しいリカバリーキーを作りますか？';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'これらのアドレスを使用すると、パスワードを回復することができます。';

  @override
  String get writeAMessage => 'メッセージを入力してください…';

  @override
  String get yes => 'はい';

  @override
  String get you => 'あなた';

  @override
  String get youAreInvitedToThisChat => 'チャットに招待されています';

  @override
  String get youAreNoLongerParticipatingInThisChat => 'あなたはもうこのチャットの参加者ではありません';

  @override
  String get youCannotInviteYourself => '自分自身を招待することはできません';

  @override
  String get youHaveBeenBannedFromThisChat => 'チャットからBANされてしまいました';

  @override
  String get yourPublicKey => 'あなたの公開鍵';

  @override
  String get messageInfo => 'メッセージの情報';

  @override
  String get time => '時間';

  @override
  String get messageType => 'メッセージの種類';

  @override
  String get sender => '送信者';

  @override
  String get openGallery => 'ギャラリーを開く';

  @override
  String get removeFromSpace => 'スペースから削除';

  @override
  String get addToSpaceDescription => 'このチャットを追加するスペースを選択してください。';

  @override
  String get start => '開始';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      '古いメッセージを解除するには、以前のセッションで生成されたリカバリーキーを入力してください。リカバリーキーはパスワードではありません。';

  @override
  String get addToStory => 'ストーリーに追加';

  @override
  String get publish => '公開';

  @override
  String get whoCanSeeMyStories => 'Who can see my stories?';

  @override
  String get unsubscribeStories => 'ストーリーの購読を解除する';

  @override
  String get thisUserHasNotPostedAnythingYet => 'このユーザーはまだストーリーに何も投稿していません';

  @override
  String get yourStory => 'あなたのストーリー';

  @override
  String get replyHasBeenSent => '返信が送信されました';

  @override
  String videoWithSize(Object size) {
    return 'ビデオ ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return '$dateからのストーリー:\n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'あなたのストーリーでは、人々がお互いを見て連絡を取ることができることに注意してください。';

  @override
  String get whatIsGoingOn => 'What is going on?';

  @override
  String get addDescription => '説明を追加';

  @override
  String get storyPrivacyWarning =>
      'あなたのストーリーでは、人々がお互いを見て連絡を取ることができることに注意してください。ストーリーは24時間表示されますが、すべてのデバイスとサーバーから削除されるという保証はありません。';

  @override
  String get iUnderstand => 'わかりました';

  @override
  String get openChat => 'チャットを開く';

  @override
  String get markAsRead => '既読にする';

  @override
  String get reportUser => 'ユーザーを報告';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get matrixWidgets => 'Matrixのウィジェット';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender が $reaction で反応しました';
  }

  @override
  String get pinMessage => '部屋にピン留めする';

  @override
  String get confirmEventUnpin => 'イベントの固定を完全に解除してもよろしいですか？';

  @override
  String get emojis => '絵文字';

  @override
  String get placeCall => '電話をかける';

  @override
  String get voiceCall => '音声通話';

  @override
  String get unsupportedAndroidVersion => 'サポートされていないAndroidのバージョン';

  @override
  String get unsupportedAndroidVersionLong =>
      'この機能を利用するには、より新しいAndroidのバージョンが必要です。アップデートまたはLineage OSのサポートをご確認ください。';

  @override
  String get videoCallsBetaWarning =>
      'ビデオ通話は、現在ベータ版であることにご注意ください。すべてのプラットフォームで期待通りに動作しない、あるいはまったく動作しない可能性があります。';

  @override
  String get experimentalVideoCalls => '実験的なビデオ通話';

  @override
  String get emailOrUsername => 'メールアドレスまたはユーザー名';

  @override
  String get indexedDbErrorTitle => 'プライベートモードに関する問題';

  @override
  String get indexedDbErrorLong =>
      'The message storage is unfortunately not enabled in private mode by default.\nPlease visit\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\nOtherwise, it is not possible to run FluffyChat.';

  @override
  String switchToAccount(Object number) {
    return 'アカウント $number に切り替える';
  }

  @override
  String get nextAccount => '次のアカウント';

  @override
  String get previousAccount => '前のアカウント';

  @override
  String get editWidgets => 'ウィジェットを編集';

  @override
  String get addWidget => 'ウィジェットを追加';

  @override
  String get widgetVideo => '動画';

  @override
  String get widgetEtherpad => 'Text note';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'カスタム';

  @override
  String get widgetName => '名称';

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
  String get widgetUrlError => '有効なURLではありません。';

  @override
  String get widgetNameError => '表示名を入力してください。';

  @override
  String get errorAddingWidget => 'ウィジェットの追加中にエラーが発生しました。';

  @override
  String get youRejectedTheInvitation => '招待を拒否しました';

  @override
  String get youJoinedTheChat => 'チャットに参加しました';

  @override
  String get youAcceptedTheInvitation => '👍 招待を承諾しました';

  @override
  String youBannedUser(Object user) {
    return '$user を禁止しました';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return '$user への招待を取り下げました';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 $user から招待されました';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 $user を招待しました';
  }

  @override
  String youKicked(Object user) {
    return '👞 $user をキックしました';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 $user をキックしてブロックしました';
  }

  @override
  String youUnbannedUser(Object user) {
    return '$user の禁止を解除しました';
  }

  @override
  String get noEmailWarning =>
      '有効なメールアドレスを入力してください。入力しないと、パスワードをリセットすることができなくなります。不要な場合は、もう一度ボタンをタップして続けてください。';

  @override
  String get stories => 'ストーリー';

  @override
  String get users => 'ユーザー';

  @override
  String get unlockOldMessages => '古いメッセージのロックを解除する';

  @override
  String get storeInSecureStorageDescription => 'このデバイスの安全なストレージにリカバリーキーを保存。';

  @override
  String get saveKeyManuallyDescription =>
      'Save this key manually by triggering the system share dialog or clipboard.';

  @override
  String get storeInAndroidKeystore => 'Android KeyStoreに保存する';

  @override
  String get storeInAppleKeyChain => 'Apple KeyChainに保存';

  @override
  String get storeSecurlyOnThisDevice => 'このデバイスに安全に保管する';

  @override
  String countFiles(Object count) {
    return '$count個のファイル';
  }

  @override
  String get user => 'ユーザー';

  @override
  String get custom => 'カスタム';

  @override
  String get foregroundServiceRunning => 'この通知は、フォアグラウンド サービスの実行中に表示されます。';

  @override
  String get screenSharingTitle => '画面共有';

  @override
  String get screenSharingDetail => 'FuffyChatで画面を共有しています';

  @override
  String get callingPermissions => '通話の権限';

  @override
  String get callingAccount => '通話アカウント';

  @override
  String get callingAccountDetails =>
      'Allows FluffyChat to use the native android dialer app.';

  @override
  String get appearOnTop => 'Appear on top';

  @override
  String get appearOnTopDetails =>
      'アプリをトップに表示できるようにする（すでに通話アカウントとしてFluffychatを設定している場合は必要ありません）';

  @override
  String get otherCallingPermissions => 'マイク、カメラ、その他FluffyChatの権限';

  @override
  String get whyIsThisMessageEncrypted => 'このメッセージが読めない理由';

  @override
  String get noKeyForThisMessage =>
      'This can happen if the message was sent before you have signed in to your account at this device.\n\nIt is also possible that the sender has blocked your device or something went wrong with the internet connection.\n\nAre you able to read the message on another session? Then you can transfer the message from it! Go to Settings > Devices and make sure that your devices have verified each other. When you open the room the next time and both sessions are in the foreground, the keys will be transmitted automatically.\n\nDo you not want to lose the keys when logging out or switching devices? Make sure that you have enabled the chat backup in the settings.';

  @override
  String get newGroup => '新しいグループ';

  @override
  String get newSpace => '新しいスペース';

  @override
  String get enterSpace => 'スペースに入る';

  @override
  String get enterRoom => '部屋に入る';

  @override
  String get allSpaces => 'すべてのスペース';

  @override
  String numChats(Object number) {
    return '$number チャット';
  }

  @override
  String get hideUnimportantStateEvents => '重要でない状態イベントを非表示にする';

  @override
  String get doNotShowAgain => '今後表示しない';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return '空のチャット (以前は $oldDisplayName)';
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
  String get encryptThisChat => 'このチャットを暗号化する';

  @override
  String get endToEndEncryption => 'エンドツーエンド暗号化';

  @override
  String get disableEncryptionWarning =>
      'セキュリティ上の理由から、以前は暗号化が有効だったチャットで暗号化を無効にすることはできません。';

  @override
  String get sorryThatsNotPossible => '申し訳ありません...それは不可能です';

  @override
  String get deviceKeys => 'デバイスキー:';

  @override
  String get letsStart => '始めましょう';

  @override
  String get enterInviteLinkOrMatrixId => '招待リンクまたはMatrixのIDを入力してください...';

  @override
  String get reopenChat => 'チャットを再開する';

  @override
  String get noBackupWarning =>
      '警告！チャットのバックアップを有効にしないと、暗号化されたメッセージにアクセスできなくなります。ログアウトする前に、まずチャットのバックアップを有効にすることを強くお勧めします。';

  @override
  String get noOtherDevicesFound => '他のデバイスが見つかりません';

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
