// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => '注册';

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
  String get passwordsDoNotMatch => '密码不匹配！';

  @override
  String get pleaseEnterValidEmail => '请输入一个有效的电子邮件地址。';

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
  String get people => '联系人';

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
  String get groups => '群组';

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
  String get repeatPassword => '再次输入密码';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return '请至少输入 $min 个字符。';
  }

  @override
  String get about => '关于';

  @override
  String get updateAvailable => 'FluffyChat 更新可用';

  @override
  String get updateNow => '在后台开始更新';

  @override
  String get accept => '接受';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username 已接受邀请';
  }

  @override
  String get account => '账户';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username 激活了端到端加密';
  }

  @override
  String get addEmail => '添加电子邮件';

  @override
  String get confirmMatrixId => '要删除账户，请确认你的 Matrix ID。';

  @override
  String supposedMxid(Object mxid) {
    return '应为 $mxid';
  }

  @override
  String get addGroupDescription => '添加一条群组介绍';

  @override
  String get addToSpace => '加入空间';

  @override
  String get admin => '管理员';

  @override
  String get alias => '别名';

  @override
  String get all => '全部';

  @override
  String get allChats => '所有会话';

  @override
  String get commandHint_googly => '发送 一些“大眼”';

  @override
  String get commandHint_cuddle => '发送“拥抱”';

  @override
  String get commandHint_hug => '发送“搂抱”';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName 给你发送了“大眼”表情';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName 拥抱了你';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName 搂抱了你';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '已开始与 $senderName 通话';
  }

  @override
  String get anyoneCanJoin => '任何人都可以加入';

  @override
  String get appLock => '应用锁';

  @override
  String get archive => '存档';

  @override
  String get areGuestsAllowedToJoin => '是否允许游客加入';

  @override
  String get areYouSure => '您确定吗？';

  @override
  String get areYouSureYouWantToLogout => '您确定要注销吗？';

  @override
  String get askSSSSSign => '请输入您的安全存储的密码短语或恢复密钥，以向对方签名。';

  @override
  String askVerificationRequest(Object username) {
    return '是否接受来自 $username 的验证申请？';
  }

  @override
  String get autoplayImages => '自动播放动态贴纸和表情';

  @override
  String get sendOnEnter => '按 Enter 键发送';

  @override
  String get banFromChat => '从对话中封禁';

  @override
  String get banned => '已被封禁';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username 封禁了 $targetName';
  }

  @override
  String get blockDevice => '屏蔽设备';

  @override
  String get blocked => '已屏蔽';

  @override
  String get botMessages => '机器人消息';

  @override
  String get bubbleSize => '气泡大小';

  @override
  String get cancel => '取消';

  @override
  String cantOpenUri(Object uri) {
    return '无法打开URI $uri';
  }

  @override
  String get changeDeviceName => '更改设备名称';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username 更改了会话头像';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username 将聊天描述更改为：\'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username 将聊天名称更改为：\'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username 更改了会话权限';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username 将展示名称更改为：\'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username 更改了游客访问规则';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username 更改了游客访问规则为：$rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username 更改了历史记录观察状态';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username 更改了历史记录观察状态到：$rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username 更改了加入的规则';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username 更改了加入的规则为：$joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username 更改了头像';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username 更改了聊天室别名';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username 更改了邀请链接';
  }

  @override
  String get changePassword => '更改密码';

  @override
  String get changeTheHomeserver => '更改主服务器';

  @override
  String get changeTheme => '改变风格';

  @override
  String get changeTheNameOfTheGroup => '更改了群组名称';

  @override
  String get changeWallpaper => '更改壁纸';

  @override
  String get changeYourAvatar => '更改您的头像';

  @override
  String get channelCorruptedDecryptError => '加密已被破坏';

  @override
  String get chat => '会话';

  @override
  String get yourChatBackupHasBeenSetUp => '您的聊天记录备份已设置。';

  @override
  String get chatBackup => '聊天记录备份';

  @override
  String get chatBackupDescription => '您的旧信息受恢复密钥保护。请确保您不会丢失它。';

  @override
  String get chatDetails => '会话详情';

  @override
  String get chatHasBeenAddedToThisSpace => '会话已添加到此空间';

  @override
  String get chats => '聊天';

  @override
  String get chooseAStrongPassword => '输入一个强密码';

  @override
  String get chooseAUsername => '输入一个昵称';

  @override
  String get clearArchive => '清除存档';

  @override
  String get close => '关闭';

  @override
  String get commandHint_markasdm => '标记为私信聊天室';

  @override
  String get commandHint_markasgroup => '标记为群组';

  @override
  String get commandHint_ban => '在此聊天室封禁该用户';

  @override
  String get commandHint_clearcache => '清除缓存';

  @override
  String get commandHint_create => '创建空的群聊\n使用 --no-encryption 选项来禁用加密';

  @override
  String get commandHint_discardsession => '丢弃会话';

  @override
  String get commandHint_dm => '启动一对一聊天\n使用 --no-encryption 选项来禁用加密';

  @override
  String get commandHint_html => '发送 HTML 格式化文本';

  @override
  String get commandHint_invite => '邀请该用户加入此聊天室';

  @override
  String get commandHint_join => '加入该聊天室';

  @override
  String get commandHint_kick => '将该用户移出此聊天室';

  @override
  String get commandHint_leave => '退出该聊天室';

  @override
  String get commandHint_me => '介绍自己';

  @override
  String get commandHint_myroomavatar => '设置您的聊天室头像（通过 mxc-uri）';

  @override
  String get commandHint_myroomnick => '设置您的聊天室昵称';

  @override
  String get commandHint_op => '设置该用户的权限等级（默认：50）';

  @override
  String get commandHint_plain => '发送纯文本';

  @override
  String get commandHint_react => '将回复作为响应发送';

  @override
  String get commandHint_send => '发送文本';

  @override
  String get commandHint_unban => '在此聊天室解封该用户';

  @override
  String get commandInvalid => '指令无效';

  @override
  String commandMissing(Object command) {
    return '$command 不是指令。';
  }

  @override
  String get compareEmojiMatch => '请比较表情符号';

  @override
  String get compareNumbersMatch => '请比较以下数字';

  @override
  String get configureChat => '配置聊天';

  @override
  String get confirm => '确认';

  @override
  String get connect => '连接';

  @override
  String get contactHasBeenInvitedToTheGroup => '联系人已被邀请至群组';

  @override
  String get containsDisplayName => '包含显示名称';

  @override
  String get containsUserName => '包含用户名';

  @override
  String get contentHasBeenReported => '此内容已被报告至服务器管理员处';

  @override
  String get copiedToClipboard => '已复制到剪贴板';

  @override
  String get copy => '复制';

  @override
  String get copyToClipboard => '复制到剪贴板';

  @override
  String couldNotDecryptMessage(Object error) {
    return '不能解密消息:$error';
  }

  @override
  String countParticipants(Object count) {
    return '$count 名参与者';
  }

  @override
  String get create => '创建';

  @override
  String createdTheChat(Object username) {
    return '💬 $username 创建了聊天';
  }

  @override
  String get createNewGroup => '创建新群组';

  @override
  String get createNewSpace => '创建新空间';

  @override
  String get currentlyActive => '目前活跃';

  @override
  String get darkTheme => '深色';

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
  String get deactivateAccountWarning => '这将停用您的用户账户。这不能被撤销，您确定吗？';

  @override
  String get defaultPermissionLevel => '默认权限级别';

  @override
  String get delete => '删除';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get deleteMessage => '删除消息';

  @override
  String get deny => '否认';

  @override
  String get device => '设备';

  @override
  String get deviceId => '设备 ID';

  @override
  String get devices => '设备';

  @override
  String get directChats => '一对一聊天';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => '探索';

  @override
  String get displaynameHasBeenChanged => '显示名称已被改变';

  @override
  String get downloadFile => '下载文件';

  @override
  String get edit => '编辑';

  @override
  String get editBlockedServers => '编辑被阻止的服务器';

  @override
  String get editChatPermissions => '编辑聊天权限';

  @override
  String get editDisplayname => '编辑显示名称';

  @override
  String get editRoomAliases => '编辑聊天室别名';

  @override
  String get editRoomAvatar => '编辑聊天室头像';

  @override
  String get emoteExists => '表情已存在！';

  @override
  String get emoteInvalid => '无效的表情快捷码！';

  @override
  String get emotePacks => '聊天室的表情包';

  @override
  String get emoteSettings => '表情设置';

  @override
  String get emoteShortcode => '表情快捷码';

  @override
  String get emoteWarnNeedToPick => '您需要选择一个表情快捷码和一张图片！';

  @override
  String get emptyChat => '空聊天';

  @override
  String get enableEmotesGlobally => '在全局启用表情包';

  @override
  String get enableEncryption => '启用加密';

  @override
  String get enableEncryptionWarning => '您之后将无法停用加密，确定吗？';

  @override
  String get encrypted => '加密的';

  @override
  String get encryption => '加密';

  @override
  String get encryptionNotEnabled => '加密未启用';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName 结束了通话';
  }

  @override
  String get enterAGroupName => '输入群组名称';

  @override
  String get enterAnEmailAddress => '输入一个电子邮件地址';

  @override
  String get enterASpacepName => '输入空间名称';

  @override
  String get homeserver => '服务器';

  @override
  String get enterYourHomeserver => '输入您的主服务器地址';

  @override
  String errorObtainingLocation(Object error) {
    return '取得地址错误: $error';
  }

  @override
  String get everythingReady => '一切就绪！';

  @override
  String get extremeOffensive => '令人极度反感';

  @override
  String get fileName => '文件名';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => '字体大小';

  @override
  String get forward => '转发';

  @override
  String get fromJoining => '自加入起';

  @override
  String get fromTheInvitation => '自邀请起';

  @override
  String get goToTheNewRoom => '前往新的聊天室';

  @override
  String get group => '群组';

  @override
  String get groupDescription => '群组描述';

  @override
  String get groupDescriptionHasBeenChanged => '群组描述已被更改';

  @override
  String get groupIsPublic => '群组是公开的';

  @override
  String groupWith(Object displayname) {
    return '名称为$displayname的群组';
  }

  @override
  String get guestsAreForbidden => '游客被禁止';

  @override
  String get guestsCanJoin => '游客可以加入';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username 撤回了对 $targetName 的邀请';
  }

  @override
  String get help => '帮助';

  @override
  String get hideRedactedEvents => '隐藏编辑事件';

  @override
  String get hideUnknownEvents => '隐藏未知事件';

  @override
  String get howOffensiveIsThisContent => '这些内容有多令人反感？';

  @override
  String get id => 'ID';

  @override
  String get identity => '身份';

  @override
  String get ignore => '忽略';

  @override
  String get ignoredUsers => '已忽略的用户';

  @override
  String get ignoreListDescription => '您可以忽略打扰您的用户。您将不会收到来自忽略列表中用户的任何消息或聊天室邀请。';

  @override
  String get ignoreUsername => '忽略用户名';

  @override
  String get iHaveClickedOnLink => '我已经点击了链接';

  @override
  String get incorrectPassphraseOrKey => '不正确的密码短语或恢复密钥';

  @override
  String get inoffensive => '不令人反感';

  @override
  String get inviteContact => '邀请联系人';

  @override
  String inviteContactToGroup(Object groupName) {
    return '邀请联系人到 $groupName';
  }

  @override
  String get invited => '已邀请';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username 邀请了 $targetName';
  }

  @override
  String get invitedUsersOnly => '仅被邀请用户';

  @override
  String get inviteForMe => '来自我的邀请';

  @override
  String inviteText(Object username, Object link) {
    return '$username 邀请您使用 FluffyChat。 \n1. 安装 FluffyChat：https://fluffychat.im \n2. 注册或登录 \n3. 打开该邀请链接：$link';
  }

  @override
  String get isTyping => '正在输入…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username 加入了聊天';
  }

  @override
  String get joinRoom => '加入聊天室';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username 踢了 $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username 踢出 $targetName 并将其封禁';
  }

  @override
  String get kickFromChat => '从聊天室踢出';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return '上次活跃: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => '很长时间未上线';

  @override
  String get leave => '离开';

  @override
  String get leftTheChat => '离开了聊天';

  @override
  String get license => '许可证';

  @override
  String get lightTheme => '浅色';

  @override
  String loadCountMoreParticipants(Object count) {
    return '加载 $count 个更多的参与者';
  }

  @override
  String get dehydrate => '导出会话并擦除设备';

  @override
  String get dehydrateWarning => '此操作无法撤消。 确保你安全地存储备份文件。';

  @override
  String get dehydrateTor => 'TOR 用户：导出会话';

  @override
  String get dehydrateTorLong => '建议 TOR 用户在关闭窗口之前导出会话。';

  @override
  String get hydrateTor => 'TOR 用户：导入会话导出';

  @override
  String get hydrateTorLong => '你上次是否导出 TOR 会话？ 快速导入它并继续聊天。';

  @override
  String get hydrate => '从备份文件恢复';

  @override
  String get loadingPleaseWait => '加载中…请等待。';

  @override
  String get loadMore => '加载更多…';

  @override
  String get locationDisabledNotice => '位置服务已禁用.请启用此服务以分享你的位置.';

  @override
  String get locationPermissionDeniedNotice => '位置权限被拒绝.请授予此权限以分享你的位置.';

  @override
  String get login => '登录';

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
    return '登录 $homeserver';
  }

  @override
  String get loginWithOneClick => '一键登录';

  @override
  String get logout => '注销';

  @override
  String get makeSureTheIdentifierIsValid => '确保识别码正确';

  @override
  String get memberChanges => '成员变更';

  @override
  String get mention => '提到';

  @override
  String get messages => '消息';

  @override
  String get messageWillBeRemovedWarning => '消息将对所有参与者移除';

  @override
  String get moderator => '监管者';

  @override
  String get muteChat => '将该聊天静音';

  @override
  String get needPantalaimonWarning => '请注意当前您需要Pantalaimon以使用端到端加密功能。';

  @override
  String get newChat => '新的聊天';

  @override
  String get newMessageInFluffyChat => '💬 FluffyChat 新消息';

  @override
  String get newVerificationRequest => '新的验证请求！';

  @override
  String get next => '下一步';

  @override
  String get no => '不';

  @override
  String get noConnectionToTheServer => '未与服务器建立连接';

  @override
  String get noEmotesFound => '未找到表情。😕';

  @override
  String get noEncryptionForPublicRooms => '您只能在聊天室不可被公众访问时才能启用加密。';

  @override
  String get noGoogleServicesWarning =>
      '看起来您手机上没有谷歌服务框架。这对保护您的隐私而言是个好决定！要接收 FluffyChat 的推送通知，推荐您使用 https://microg.org/ 或 https://unifiedpush.org/。';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 不是一个Matrix服务器,试试$server2?';
  }

  @override
  String get shareYourInviteLink => '分享您的邀请链接';

  @override
  String get scanQrCode => '扫描二维码';

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
  String get none => '无';

  @override
  String get noPasswordRecoveryDescription => '您尚未添加恢复密码的方法。';

  @override
  String get noPermission => '没有权限';

  @override
  String get noRoomsFound => '未找到聊天室…';

  @override
  String get notifications => '通知';

  @override
  String get notificationsEnabledForThisAccount => '已为此账户启用通知';

  @override
  String numUsersTyping(Object count) {
    return '$count 人正在输入…';
  }

  @override
  String get obtainingLocation => '获取位置中…';

  @override
  String get offensive => '令人反感';

  @override
  String get offline => '离线';

  @override
  String get ok => '好';

  @override
  String get online => '在线';

  @override
  String get onlineKeyBackupEnabled => '在线密钥备份已启用';

  @override
  String get oopsPushError => '哎呀！十分不幸，配置推送通知时发生了错误。';

  @override
  String get oopsSomethingWentWrong => '哎呀，出了点差错…';

  @override
  String get openAppToReadMessages => '打开应用以查看消息';

  @override
  String get openCamera => '打开相机';

  @override
  String get openVideoCamera => '打开相机拍摄视频';

  @override
  String get oneClientLoggedOut => '您的一个客户端已登出';

  @override
  String get addAccount => '添加账户';

  @override
  String get editBundlesForAccount => '编辑该账户的集合';

  @override
  String get addToBundle => '添加到集合中';

  @override
  String get removeFromBundle => '从此集合中移除';

  @override
  String get bundleName => '集合名称';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts => '（测试功能）在本设备上添加多个账户';

  @override
  String get openInMaps => '在地图中打开';

  @override
  String get link => '链接';

  @override
  String get serverRequiresEmail => '此服务器需要验证您的电子邮件地址以进行注册。';

  @override
  String get optionalGroupName => '(可选) 群组名称';

  @override
  String get or => '或';

  @override
  String get participant => '参与者';

  @override
  String get passphraseOrKey => '密码短语或恢复密钥';

  @override
  String get password => '密码';

  @override
  String get passwordForgotten => '忘记密码';

  @override
  String get passwordHasBeenChanged => '密码已被更改';

  @override
  String get passwordRecovery => '密码恢复';

  @override
  String get pickImage => '选择图像';

  @override
  String get pin => '固定';

  @override
  String play(Object fileName) {
    return '播放 $fileName';
  }

  @override
  String get pleaseChoose => '请选择';

  @override
  String get pleaseChooseAPasscode => '请选择一个密码';

  @override
  String get pleaseChooseAUsername => '请选择用户名';

  @override
  String get pleaseClickOnLink => '请点击电子邮件中的链接，然后继续。';

  @override
  String get pleaseEnter4Digits => '请输入 4 位数字或留空以停用应用锁。';

  @override
  String get pleaseEnterAMatrixIdentifier => '请输入 Matrix ID。';

  @override
  String get pleaseEnterRecoveryKey => '请输入你的恢复密钥：';

  @override
  String get pleaseEnterYourPassword => '请输入您的密码';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => '请输入您的 PIN';

  @override
  String get pleaseEnterYourUsername => '请输入您的用户名';

  @override
  String get pleaseFollowInstructionsOnWeb => '请按照网站上的提示，点击下一步。';

  @override
  String get privacy => '隐私';

  @override
  String get publicRooms => '公开聊天室';

  @override
  String get pushRules => '推送规则';

  @override
  String get reason => '原因';

  @override
  String get recording => '录制';

  @override
  String redactedAnEvent(Object username) {
    return '$username 编辑了一个事件';
  }

  @override
  String get redactMessage => '重新编辑信息';

  @override
  String get reject => '拒绝';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username 拒绝了邀请';
  }

  @override
  String get rejoin => '重新加入';

  @override
  String get remove => '移除';

  @override
  String get removeAllOtherDevices => '移除其他全部设备';

  @override
  String removedBy(Object username) {
    return '被$username移除';
  }

  @override
  String get removeDevice => '移除设备';

  @override
  String get unbanFromChat => '解禁聊天';

  @override
  String get removeYourAvatar => '移除您的头像';

  @override
  String get renderRichContent => '渲染富文本内容';

  @override
  String get replaceRoomWithNewerVersion => '用较新的版本替换聊天室';

  @override
  String get reply => '回复';

  @override
  String get reportMessage => '举报信息';

  @override
  String get requestPermission => '请求权限';

  @override
  String get roomHasBeenUpgraded => '聊天室已升级';

  @override
  String get roomVersion => '聊天室版本';

  @override
  String get saveFile => '保存文件';

  @override
  String get search => '搜索';

  @override
  String get security => '安全';

  @override
  String get recoveryKey => '恢复密钥';

  @override
  String get recoveryKeyLost => '丢失了恢复密钥？';

  @override
  String seenByUser(Object username) {
    return '被 $username 看见';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return '$username 和其他 $count 人已查看';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return '被 $username 和 $username2 看见';
  }

  @override
  String get send => '发送';

  @override
  String get sendAMessage => '发送一条消息';

  @override
  String get sendAsText => '以文本发送';

  @override
  String get sendAudio => '发送音频';

  @override
  String get sendFile => '发送文件';

  @override
  String get sendImage => '发送图像';

  @override
  String get sendMessages => '发送消息';

  @override
  String get sendOriginal => '发送原图';

  @override
  String get sendSticker => '发送贴纸';

  @override
  String get sendVideo => '发送视频';

  @override
  String sentAFile(Object username) {
    return '📁$username 发送了文件';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤$username 发送了音频';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username 发送了图片';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username 发送了贴纸';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username 发送了视频';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName 发送了通话信息';
  }

  @override
  String get separateChatTypes => '分开私聊和群组';

  @override
  String get setAsCanonicalAlias => '设为主要别名';

  @override
  String get setCustomEmotes => '设置自定义表情';

  @override
  String get setGroupDescription => '设置群组描述';

  @override
  String get setInvitationLink => '设置邀请链接';

  @override
  String get setPermissionsLevel => '设置权限级别';

  @override
  String get setStatus => '设置状态';

  @override
  String get settings => '设置';

  @override
  String get share => '分享';

  @override
  String sharedTheLocation(Object username) {
    return '$username 分享了位置';
  }

  @override
  String get shareLocation => '分享位置';

  @override
  String get showDirectChatsInSpaces => '在空间中显示相关私聊';

  @override
  String get showPassword => '显示密码';

  @override
  String get signUp => '注册';

  @override
  String get singlesignon => '单点登录';

  @override
  String get skip => '跳过';

  @override
  String get sourceCode => '源代码';

  @override
  String get spaceIsPublic => '空间是公开的';

  @override
  String get spaceName => '空间名称';

  @override
  String startedACall(Object senderName) {
    return '$senderName 开始了通话';
  }

  @override
  String get startFirstChat => '发起你的第一个聊天';

  @override
  String get status => '状态';

  @override
  String get statusExampleMessage => '您今天怎么样？';

  @override
  String get submit => '提交';

  @override
  String get synchronizingPleaseWait => '同步中…请等待。';

  @override
  String get systemTheme => '系统';

  @override
  String get theyDontMatch => '它们不匹配';

  @override
  String get theyMatch => '它们匹配';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => '切换收藏';

  @override
  String get toggleMuted => '切换静音';

  @override
  String get toggleUnread => '标记已读/未读';

  @override
  String get tooManyRequestsWarning => '请求太多。请稍后再试！';

  @override
  String get transferFromAnotherDevice => '从其他设备传输';

  @override
  String get tryToSendAgain => '尝试重新发送';

  @override
  String get unavailable => '不可用';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username 解封了 $targetName';
  }

  @override
  String get unblockDevice => '解锁设备';

  @override
  String get unknownDevice => '未知设备';

  @override
  String get unknownEncryptionAlgorithm => '未知加密算法';

  @override
  String get unmuteChat => '解除聊天的静音';

  @override
  String get unpin => '取消固定';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount 个未读聊天',
      one: '1 unread chat',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username 和其他 $count 人正在输入…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username 和 $username2 正在输入…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username 正在输入…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪$username 离开了聊天';
  }

  @override
  String get username => '用户名';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username 发送了一个 $type 事件';
  }

  @override
  String get unverified => '未认证';

  @override
  String get verified => '已验证';

  @override
  String get verify => '验证';

  @override
  String get verifyStart => '开始验证';

  @override
  String get verifySuccess => '您已成功验证！';

  @override
  String get verifyTitle => '验证其他账户';

  @override
  String get videoCall => '视频通话';

  @override
  String get visibilityOfTheChatHistory => '聊天记录的可见性';

  @override
  String get visibleForAllParticipants => '对所有参与者可见';

  @override
  String get visibleForEveryone => '对所有人可见';

  @override
  String get voiceMessage => '语音消息';

  @override
  String get waitingPartnerAcceptRequest => '等待对方接受请求…';

  @override
  String get waitingPartnerEmoji => '等待对方接受 emoji…';

  @override
  String get waitingPartnerNumbers => '等待对方接受数字…';

  @override
  String get wallpaper => '壁纸';

  @override
  String get warning => '警告！';

  @override
  String get weSentYouAnEmail => '我们向您发送了一封电子邮件';

  @override
  String get whoCanPerformWhichAction => '谁可以执行哪些操作';

  @override
  String get whoIsAllowedToJoinThisGroup => '谁被允许加入本群组';

  @override
  String get whyDoYouWantToReportThis => '您举报的理由是什么？';

  @override
  String get wipeChatBackup => '确定要清除您的聊天记录备份以创建新的恢复密钥吗？';

  @override
  String get withTheseAddressesRecoveryDescription => '通过这些地址，您可以恢复密码。';

  @override
  String get writeAMessage => '写一条消息…';

  @override
  String get yes => '是';

  @override
  String get you => '您';

  @override
  String get youAreInvitedToThisChat => '您被邀请到该聊天';

  @override
  String get youAreNoLongerParticipatingInThisChat => '您已不再参与此聊天';

  @override
  String get youCannotInviteYourself => '您不能邀请您自己';

  @override
  String get youHaveBeenBannedFromThisChat => '您已被该聊天封禁';

  @override
  String get yourPublicKey => '您的公钥';

  @override
  String get messageInfo => '消息信息';

  @override
  String get time => '时间';

  @override
  String get messageType => '消息类型';

  @override
  String get sender => '发送者';

  @override
  String get openGallery => '打开图库';

  @override
  String get removeFromSpace => '从空间删除';

  @override
  String get addToSpaceDescription => '选择一个空间以添加此聊天。';

  @override
  String get start => '开始';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      '要解锁您的旧邮件，请输入你在之前会话中生成的恢复密钥。 你的恢复密钥不是你的密码。';

  @override
  String get addToStory => '添加到 Story';

  @override
  String get publish => '发布';

  @override
  String get whoCanSeeMyStories => '谁能看到我的 Story？';

  @override
  String get unsubscribeStories => '取消 Story 订阅';

  @override
  String get thisUserHasNotPostedAnythingYet => '该用户尚未在 Story 发布任何内容';

  @override
  String get yourStory => '你的 Story';

  @override
  String get replyHasBeenSent => '已发送回复';

  @override
  String videoWithSize(Object size) {
    return '视频 ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return '自 $date 起的 Story: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc => '请注意，人们可以在你的 Story 中看到彼此并相互联系。';

  @override
  String get whatIsGoingOn => '发生什么事了？';

  @override
  String get addDescription => '添加描述';

  @override
  String get storyPrivacyWarning =>
      '请注意，人们可以在你的 Story 中看到和联系彼此。您的故事在 24 小时内可见，但不能保证它们将从所有设备和服务器上删除。';

  @override
  String get iUnderstand => '我了解';

  @override
  String get openChat => '打开聊天';

  @override
  String get markAsRead => '标为已读';

  @override
  String get reportUser => '举报用户';

  @override
  String get dismiss => '驳回';

  @override
  String get matrixWidgets => 'Matrix 小部件';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender 通过 $reaction 进行了回应';
  }

  @override
  String get pinMessage => '置顶到聊天室';

  @override
  String get confirmEventUnpin => '你确定要永久性取消置顶这一活动吗？';

  @override
  String get emojis => '颜文字';

  @override
  String get placeCall => '打电话';

  @override
  String get voiceCall => '语音通话';

  @override
  String get unsupportedAndroidVersion => '不受支持的 Android 版本';

  @override
  String get unsupportedAndroidVersionLong =>
      '这个功能需要较新版本的 Android 系统。请检查更新或 Lineage OS 支持。';

  @override
  String get videoCallsBetaWarning =>
      '请注意，视频通话目前处于测试阶段。它们可能不能像预期的那样工作，或者在所有平台上都不能工作。';

  @override
  String get experimentalVideoCalls => '实验性的视频通话';

  @override
  String get emailOrUsername => '电子邮箱或用户名';

  @override
  String get indexedDbErrorTitle => '私人模式问题';

  @override
  String get indexedDbErrorLong =>
      '遗憾的是，默认情况下未在私有模式下启用消息存储。\n请访问\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\n否则，无法运行 FluffyChat。';

  @override
  String switchToAccount(Object number) {
    return '切换到账户 $number';
  }

  @override
  String get nextAccount => '下个账户';

  @override
  String get previousAccount => '上个账户';

  @override
  String get editWidgets => '编辑小部件';

  @override
  String get addWidget => '添加小部件';

  @override
  String get widgetVideo => '视频';

  @override
  String get widgetEtherpad => '文本笔记';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => '自定义';

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
  String get widgetUrlError => '这不是有效的 URL。';

  @override
  String get widgetNameError => '请提供显示名称。';

  @override
  String get errorAddingWidget => '添加小部件出错。';

  @override
  String get youRejectedTheInvitation => '你拒绝了邀请';

  @override
  String get youJoinedTheChat => '你加入了聊天';

  @override
  String get youAcceptedTheInvitation => '👍 你接受了邀请';

  @override
  String youBannedUser(Object user) {
    return '你封禁了 $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return '你撤回了对 $user 的邀请';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 你受到 $user 的邀请';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 你邀请了 $user';
  }

  @override
  String youKicked(Object user) {
    return '👞你踢掉了 $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅你踢掉并封禁了 $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return '你解除了对 $user 的封禁';
  }

  @override
  String get noEmailWarning => '请输入有效电子邮件地址。否则你将无法重置密码。如果你不想输入邮件地址，再次轻点按钮以继续。';

  @override
  String get stories => '故事';

  @override
  String get users => '用户';

  @override
  String get unlockOldMessages => '解锁旧信息';

  @override
  String get storeInSecureStorageDescription => '将恢复密钥存储在此设备的安全存储中。';

  @override
  String get saveKeyManuallyDescription => '通过触发系统共享对话框或剪贴板手动保存此密钥。';

  @override
  String get storeInAndroidKeystore => '存储在 Android KeyStore 中';

  @override
  String get storeInAppleKeyChain => '存储在 Apple KeyChain 中';

  @override
  String get storeSecurlyOnThisDevice => '安全地存储在此设备上';

  @override
  String countFiles(Object count) {
    return '$count 个文件';
  }

  @override
  String get user => '用户';

  @override
  String get custom => '自定义';

  @override
  String get foregroundServiceRunning => '此通知在前台服务运行时出现。';

  @override
  String get screenSharingTitle => '屏幕共享';

  @override
  String get screenSharingDetail => '你正在 FluffyChat 共享屏幕';

  @override
  String get callingPermissions => '呼叫权限';

  @override
  String get callingAccount => '呼叫账户';

  @override
  String get callingAccountDetails => '允许 FluffyChat 使用本机 android 拨号器应用。';

  @override
  String get appearOnTop => '显示在其他应用上方';

  @override
  String get appearOnTopDetails =>
      '允许应用显示在顶部（如果你已经将 Fluffychat 设置为呼叫账户，则不需要授予此权限）';

  @override
  String get otherCallingPermissions => '麦克风、摄像头和其他 FluffyChat 权限';

  @override
  String get whyIsThisMessageEncrypted => '为什么此消息不可读？';

  @override
  String get noKeyForThisMessage =>
      '如果消息是在你在此设备上登录账户前发送的，就可能发生这种情况。\n\n也有可能是发送者屏蔽了你的设备或网络连接出了问题。\n\n你能在另一个会话中读取消息吗？如果是的话，你可以从它那里传递信息！点击设置 > 设备，并确保你的设备已经相互验证。当你下次打开聊天室，且两个会话都在前台，密钥就会自动传输。\n\n你不想在注销或切换设备时丢失密钥？请确保在设置中启用了聊天备份。';

  @override
  String get newGroup => '新群组';

  @override
  String get newSpace => '新空间';

  @override
  String get enterSpace => '进入空间';

  @override
  String get enterRoom => '进入聊天室';

  @override
  String get allSpaces => '所有空间';

  @override
  String numChats(Object number) {
    return '$number 个聊天';
  }

  @override
  String get hideUnimportantStateEvents => '隐藏不重要的状态事件';

  @override
  String get doNotShowAgain => '不再显示';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return '空聊天（曾是 $oldDisplayName）';
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
  String get newSpaceDescription => '空间让您可以整合聊天并建立私人或公共讨论区。';

  @override
  String get encryptThisChat => '加密这个对话';

  @override
  String get endToEndEncryption => '端对端加密';

  @override
  String get disableEncryptionWarning => '出于安全考虑 ，您不能在之前已启用的对话中禁用加密。';

  @override
  String get sorryThatsNotPossible => '非常抱歉……这是做不到的';

  @override
  String get deviceKeys => '设备密钥：';

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
  String get report => '举报';

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

/// The translations for Chinese, using the Han script (`zh_Hant`).
class L10nZhHant extends L10nZh {
  L10nZhHant() : super('zh_Hant');

  @override
  String get passwordsDoNotMatch => '密碼不匹配！';

  @override
  String get pleaseEnterValidEmail => '請輸入一個有效的電子郵件地址。';

  @override
  String get people => '人';

  @override
  String get groups => '群組';

  @override
  String get repeatPassword => '再次輸入密碼';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return '請至少輸入 $min 个字元。';
  }

  @override
  String get about => '關於';

  @override
  String get accept => '接受';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username已接受邀請';
  }

  @override
  String get account => '帳號';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username已啟用點對點加密';
  }

  @override
  String get addEmail => '新增電子郵件';

  @override
  String get addGroupDescription => '新增一個群組描述';

  @override
  String get addToSpace => '加入空間';

  @override
  String get admin => '管理員';

  @override
  String get alias => '別稱';

  @override
  String get all => '全部';

  @override
  String get allChats => '所有會話';

  @override
  String answeredTheCall(Object senderName) {
    return '已開始與$senderName通話';
  }

  @override
  String get anyoneCanJoin => '任何人可以加入';

  @override
  String get appLock => '密碼鎖定';

  @override
  String get archive => '封存';

  @override
  String get areGuestsAllowedToJoin => '是否允許訪客加入';

  @override
  String get areYouSure => '您確定嗎？';

  @override
  String get areYouSureYouWantToLogout => '您確定要登出嗎？';

  @override
  String get askSSSSSign => '請輸入您安全儲存的密碼短語或恢復金鑰，以向對方簽名。';

  @override
  String askVerificationRequest(Object username) {
    return '是否接受來自$username的驗證申請？';
  }

  @override
  String get autoplayImages => '自動播放動態貼圖和表情';

  @override
  String get sendOnEnter => '按 Enter 鍵發送';

  @override
  String get banFromChat => '已從聊天室中封禁';

  @override
  String get banned => '已被封禁';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username封禁了$targetName';
  }

  @override
  String get blockDevice => '封鎖裝置';

  @override
  String get blocked => '已封鎖';

  @override
  String get botMessages => '機器人訊息';

  @override
  String get cancel => '取消';

  @override
  String cantOpenUri(Object uri) {
    return '無法打開URI $uri';
  }

  @override
  String get changeDeviceName => '變更裝置名稱';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username變更了對話頭貼';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username變更了對話介紹為：「$description」';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username變更了暱稱為：「$chatname」';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username變更了對話權限';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username 變更了顯示名稱為：「$displayname」';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username變更了訪客訪問規則';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username變更了訪客訪問規則為：$rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username變更了歷史記錄觀察狀態';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username變更了歷史紀錄觀察狀態到：$rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username變更了加入的規則';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username變更了加入的規則為：$joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username變更了頭貼';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username變更了聊天室名';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username變更了邀請連結';
  }

  @override
  String get changePassword => '變更密碼';

  @override
  String get changeTheHomeserver => '變更主機位址';

  @override
  String get changeTheme => '變更主題';

  @override
  String get changeTheNameOfTheGroup => '變更了群組名稱';

  @override
  String get changeWallpaper => '變更聊天背景';

  @override
  String get changeYourAvatar => '更改您的大頭貼';

  @override
  String get channelCorruptedDecryptError => '加密已被破壞';

  @override
  String get chat => '聊天';

  @override
  String get yourChatBackupHasBeenSetUp => '您的聊天記錄備份已設定。';

  @override
  String get chatBackup => '備份聊天室';

  @override
  String get chatBackupDescription => '您的聊天記錄備份已被安全金鑰鑰加密。請您確保不會弄丟它。';

  @override
  String get chatDetails => '對話詳細';

  @override
  String get chatHasBeenAddedToThisSpace => '聊天室已添加到此空間';

  @override
  String get chats => '聊天室';

  @override
  String get chooseAStrongPassword => '輸入一個較強的密碼';

  @override
  String get chooseAUsername => '輸入您的使用者名稱';

  @override
  String get clearArchive => '清除存檔';

  @override
  String get close => '關閉';

  @override
  String get commandHint_ban => '在此聊天室封禁該使用者';

  @override
  String get commandHint_clearcache => '清除快取';

  @override
  String get commandHint_create => '建立一個空的群聊\n使用 --no-encryption 選項來禁用加密';

  @override
  String get commandHint_discardsession => '丟棄工作階段';

  @override
  String get commandHint_dm => '啟動一對一聊天\n使用 --no-encryption 選項來禁用加密';

  @override
  String get commandHint_invite => '邀請該使用者加入此聊天室';

  @override
  String get commandHint_join => '加入此聊天室';

  @override
  String get commandHint_kick => '將這個使用者移出此聊天室';

  @override
  String get commandHint_leave => '退出此聊天室';

  @override
  String get commandHint_myroomavatar => '設置您的聊天室頭貼（通過 mxc-uri）';

  @override
  String get commandHint_myroomnick => '設定您的聊天室暱稱';

  @override
  String get commandHint_unban => '在此聊天室解封該使用者';

  @override
  String get compareEmojiMatch => '對比並確認這些表情符合其他那些裝置：';

  @override
  String get compareNumbersMatch => '比較以下數字，確保它們和另一個裝置上的相同：';

  @override
  String get configureChat => '設定聊天室';

  @override
  String get confirm => '確認';

  @override
  String get connect => '連接';

  @override
  String get contactHasBeenInvitedToTheGroup => '聯絡人已被邀請至群組';

  @override
  String get containsDisplayName => '包含顯示名稱';

  @override
  String get containsUserName => '包含使用者名稱';

  @override
  String get contentHasBeenReported => '此內容已被回報給伺服器管理員們';

  @override
  String get copiedToClipboard => '已複製到剪貼簿';

  @override
  String get copy => '複製';

  @override
  String get copyToClipboard => '複製到剪貼簿';

  @override
  String couldNotDecryptMessage(Object error) {
    return '不能解密訊息：$error';
  }

  @override
  String countParticipants(Object count) {
    return '$count個參與者';
  }

  @override
  String get create => '建立';

  @override
  String createdTheChat(Object username) {
    return '$username建立了聊天室';
  }

  @override
  String get createNewGroup => '建立新群組';

  @override
  String get currentlyActive => '目前活躍';

  @override
  String get darkTheme => '夜間模式';

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
  String get deactivateAccountWarning => '這將停用您的帳號。這個決定是不能挽回的！您確定嗎？';

  @override
  String get defaultPermissionLevel => '預設權限等級';

  @override
  String get delete => '刪除';

  @override
  String get deleteAccount => '刪除帳號';

  @override
  String get deleteMessage => '刪除訊息';

  @override
  String get deny => '否認';

  @override
  String get device => '裝置';

  @override
  String get deviceId => '裝置ID';

  @override
  String get devices => '裝置';

  @override
  String get directChats => '直接傳訊';

  @override
  String get displaynameHasBeenChanged => '顯示名稱已被變更';

  @override
  String get downloadFile => '下載文件';

  @override
  String get edit => '編輯';

  @override
  String get editBlockedServers => '編輯被封鎖的伺服器';

  @override
  String get editChatPermissions => '編輯聊天室權限';

  @override
  String get editDisplayname => '編輯顯示名稱';

  @override
  String get editRoomAliases => '編輯聊天室名';

  @override
  String get editRoomAvatar => '編輯聊天室頭貼';

  @override
  String get emoteExists => '表情已存在！';

  @override
  String get emoteInvalid => '無效的表情快捷鍵！';

  @override
  String get emotePacks => '聊天室的表情符號';

  @override
  String get emoteSettings => '表情設定';

  @override
  String get emoteShortcode => '表情快捷鍵';

  @override
  String get emoteWarnNeedToPick => '您需要選取一個表情快捷鍵和一張圖片！';

  @override
  String get emptyChat => '空的聊天室';

  @override
  String get enableEmotesGlobally => '在全域啟用表情符號';

  @override
  String get enableEncryption => '啟用加密';

  @override
  String get enableEncryptionWarning => '您將不能再停用加密，確定嗎？';

  @override
  String get encrypted => '加密的';

  @override
  String get encryption => '加密';

  @override
  String get encryptionNotEnabled => '加密未啟用';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName結束了通話';
  }

  @override
  String get enterAGroupName => '輸入群組名稱';

  @override
  String get enterAnEmailAddress => '輸入一個電子郵件位址';

  @override
  String get enterYourHomeserver => '輸入伺服器位址';

  @override
  String get everythingReady => '一切就緒！';

  @override
  String get extremeOffensive => '極端令人反感';

  @override
  String get fileName => '檔案名稱';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => '字體大小';

  @override
  String get forward => '轉發';

  @override
  String get fromJoining => '自加入起';

  @override
  String get fromTheInvitation => '自邀請起';

  @override
  String get goToTheNewRoom => '前往新聊天室';

  @override
  String get group => '群組';

  @override
  String get groupDescription => '群組描述';

  @override
  String get groupDescriptionHasBeenChanged => '群組描述已被變更';

  @override
  String get groupIsPublic => '群組是公開的';

  @override
  String groupWith(Object displayname) {
    return '名稱為$displayname的群組';
  }

  @override
  String get guestsAreForbidden => '訪客已被禁止';

  @override
  String get guestsCanJoin => '訪客可以加入';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username收回了對$targetName的邀請';
  }

  @override
  String get help => '幫助';

  @override
  String get hideRedactedEvents => '隱藏編輯過的事件';

  @override
  String get hideUnknownEvents => '隱藏未知事件';

  @override
  String get howOffensiveIsThisContent => '這個內容有多令人反感？';

  @override
  String get id => 'ID';

  @override
  String get identity => '身份';

  @override
  String get ignore => '無視';

  @override
  String get ignoredUsers => '已無視的使用者';

  @override
  String get ignoreListDescription =>
      '您可以無視打擾您的使用者。您將不會再收到來自無視列表中使用者的任何消息或聊天室邀請。';

  @override
  String get ignoreUsername => '無視使用者名稱';

  @override
  String get iHaveClickedOnLink => '我已經點擊了網址';

  @override
  String get incorrectPassphraseOrKey => '錯誤的密碼短語或恢復金鑰';

  @override
  String get inoffensive => '不令人反感';

  @override
  String get inviteContact => '邀請聯絡人';

  @override
  String inviteContactToGroup(Object groupName) {
    return '邀請聯絡人到$groupName';
  }

  @override
  String get invited => '已邀請';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username邀請了$targetName';
  }

  @override
  String get invitedUsersOnly => '只有被邀請的使用者';

  @override
  String get inviteForMe => '來自我的邀請';

  @override
  String inviteText(Object username, Object link) {
    return '$username邀請您使用FluffyChat\n1. 安裝FluffyChat：https://fluffychat.im\n2. 登入或註冊\n3. 打開該邀請網址：$link';
  }

  @override
  String get isTyping => '正在輸入...…';

  @override
  String joinedTheChat(Object username) {
    return '$username加入了聊天室';
  }

  @override
  String get joinRoom => '加入聊天室';

  @override
  String kicked(Object username, Object targetName) {
    return '$username踢了$targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username踢了$targetName並將其封禁';
  }

  @override
  String get kickFromChat => '從聊天室踢出';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return '最後活動時間：$localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => '很長一段時間沒有上線了';

  @override
  String get leave => '離開';

  @override
  String get leftTheChat => '離開了聊天室';

  @override
  String get license => '授權';

  @override
  String get lightTheme => '日間模式';

  @override
  String loadCountMoreParticipants(Object count) {
    return '載入$count個更多的參與者';
  }

  @override
  String get loadingPleaseWait => '載入中… 請稍候。';

  @override
  String get loadMore => '載入更多…';

  @override
  String get login => '登入';

  @override
  String logInTo(Object homeserver) {
    return '登入$homeserver';
  }

  @override
  String get logout => '登出';

  @override
  String get makeSureTheIdentifierIsValid => '確保識別碼正確';

  @override
  String get memberChanges => '變更成員';

  @override
  String get mention => '提及';

  @override
  String get messages => '訊息';

  @override
  String get messageWillBeRemovedWarning => '將移除所有參與者的訊息';

  @override
  String get moderator => '版主';

  @override
  String get muteChat => '將該聊天室靜音';

  @override
  String get needPantalaimonWarning => '請注意您需要Pantalaimon才能使用點對點加密功能。';

  @override
  String get newChat => '新聊天室';

  @override
  String get newMessageInFluffyChat => '來自 FluffyChat 的新訊息';

  @override
  String get newVerificationRequest => '新的驗證請求！';

  @override
  String get next => '下一個';

  @override
  String get no => '否';

  @override
  String get noConnectionToTheServer => '無法連接到伺服器';

  @override
  String get noEmotesFound => '表情符號不存在。😕';

  @override
  String get noEncryptionForPublicRooms => '您只能在這個聊天室不再被允許公開訪問後，才能啟用加密。';

  @override
  String get noGoogleServicesWarning =>
      '看起來您手機上沒有Google服務框架。這對於保護您的隱私而言是個好決定！但為了收到FluffyChat的推播通知，我們推薦您使用 https://microg.org/ 或 https://unifiedpush.org/。';

  @override
  String get none => '無';

  @override
  String get noPasswordRecoveryDescription => '您尚未新增恢復密碼的方法。';

  @override
  String get noPermission => '沒有權限';

  @override
  String get noRoomsFound => '找不到聊天室…';

  @override
  String get notifications => '通知';

  @override
  String get notificationsEnabledForThisAccount => '已為此帳號啟用通知';

  @override
  String numUsersTyping(Object count) {
    return '$count個人正在輸入…';
  }

  @override
  String get offensive => '令人反感';

  @override
  String get offline => '離線';

  @override
  String get ok => 'OK';

  @override
  String get online => '線上';

  @override
  String get onlineKeyBackupEnabled => '線上金鑰備份已啟用';

  @override
  String get oopsSomethingWentWrong => '哎呀！出了一點差錯…';

  @override
  String get openAppToReadMessages => '打開應用程式以讀取訊息';

  @override
  String get openCamera => '開啟相機';

  @override
  String get optionalGroupName => '（可選）群組名稱';

  @override
  String get participant => '參與者';

  @override
  String get passphraseOrKey => '密碼短語或恢復金鑰';

  @override
  String get password => '密碼';

  @override
  String get passwordForgotten => '忘記密碼';

  @override
  String get passwordHasBeenChanged => '密碼已被變更';

  @override
  String get passwordRecovery => '恢復密碼';

  @override
  String get pickImage => '選擇圖片';

  @override
  String get pin => '釘選';

  @override
  String play(Object fileName) {
    return '播放$fileName';
  }

  @override
  String get pleaseChooseAPasscode => '請選擇一個密碼';

  @override
  String get pleaseChooseAUsername => '請選擇使用者名稱';

  @override
  String get pleaseClickOnLink => '請點擊電子郵件中的網址，然後繼續。';

  @override
  String get pleaseEnter4Digits => '請輸入4位數字，或留空以停用密碼鎖定。';

  @override
  String get pleaseEnterAMatrixIdentifier => '請輸入Matrix ID。';

  @override
  String get pleaseEnterYourPassword => '請輸入您的密碼';

  @override
  String get pleaseEnterYourUsername => '請輸入您的使用者名稱';

  @override
  String get pleaseFollowInstructionsOnWeb => '請按照網站上的說明進行操作，然後點擊下一步。';

  @override
  String get privacy => '隱私';

  @override
  String get publicRooms => '公開的聊天室';

  @override
  String get pushRules => '推播規則';

  @override
  String get reason => '原因';

  @override
  String get recording => '錄音中';

  @override
  String redactedAnEvent(Object username) {
    return '$username編輯了一個事件';
  }

  @override
  String get redactMessage => '重新編輯訊息';

  @override
  String get reject => '拒絕';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username拒絕了邀請';
  }

  @override
  String get rejoin => '重新加入';

  @override
  String get remove => '移除';

  @override
  String get removeAllOtherDevices => '移除所有其他裝置';

  @override
  String removedBy(Object username) {
    return '被$username移除';
  }

  @override
  String get removeDevice => '移除裝置';

  @override
  String get unbanFromChat => '解禁聊天';

  @override
  String get renderRichContent => '繪製圖文訊息內容';

  @override
  String get replaceRoomWithNewerVersion => '用較新的版本取代聊天室';

  @override
  String get reply => '回覆';

  @override
  String get reportMessage => '檢舉訊息';

  @override
  String get requestPermission => '請求權限';

  @override
  String get roomHasBeenUpgraded => '聊天室已更新';

  @override
  String get roomVersion => '聊天室的版本';

  @override
  String get search => '搜尋';

  @override
  String get security => '安全';

  @override
  String seenByUser(Object username) {
    return '$username已讀';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return '$username 和另外 $count 人已查看';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return '$username和$username2已讀';
  }

  @override
  String get send => '傳送';

  @override
  String get sendAMessage => '傳送訊息';

  @override
  String get sendAudio => '傳送音訊';

  @override
  String get sendFile => '傳送文件';

  @override
  String get sendImage => '傳送圖片';

  @override
  String get sendMessages => '傳送訊息';

  @override
  String get sendOriginal => '傳送原始內容';

  @override
  String get sendVideo => '傳送影片';

  @override
  String sentAFile(Object username) {
    return '$username傳送了一個文件';
  }

  @override
  String sentAnAudio(Object username) {
    return '$username傳送了一個音訊';
  }

  @override
  String sentAPicture(Object username) {
    return '$username傳送了一張圖片';
  }

  @override
  String sentASticker(Object username) {
    return '$username 傳送了貼圖';
  }

  @override
  String sentAVideo(Object username) {
    return '$username 傳送了影片';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName 傳送了通話資訊';
  }

  @override
  String get setCustomEmotes => '自訂表情符號';

  @override
  String get setGroupDescription => '設定群組描述';

  @override
  String get setInvitationLink => '設定邀請連結';

  @override
  String get setPermissionsLevel => '設定權限級別';

  @override
  String get setStatus => '設定狀態';

  @override
  String get settings => '設定';

  @override
  String get share => '分享';

  @override
  String sharedTheLocation(Object username) {
    return '$username 分享了位置';
  }

  @override
  String get showPassword => '顯示密碼';

  @override
  String get signUp => '註冊';

  @override
  String get skip => '跳過';

  @override
  String get sourceCode => '原始碼';

  @override
  String startedACall(Object senderName) {
    return '$senderName開始了通話';
  }

  @override
  String get status => '狀態';

  @override
  String get statusExampleMessage => '今天過得如何？';

  @override
  String get submit => '送出';

  @override
  String get systemTheme => '自動';

  @override
  String get theyDontMatch => '它們不相符';

  @override
  String get theyMatch => '它們相符';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => '切換收藏夾';

  @override
  String get toggleMuted => '切換靜音';

  @override
  String get toggleUnread => '標記為已讀/未讀';

  @override
  String get tooManyRequestsWarning => '太多請求了。請稍候再試！';

  @override
  String get transferFromAnotherDevice => '從其他裝置傳輸';

  @override
  String get tryToSendAgain => '再次嘗試傳送';

  @override
  String get unavailable => '無法取得';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username解除封禁了$targetName';
  }

  @override
  String get unblockDevice => '解除鎖定裝置';

  @override
  String get unknownDevice => '未知裝置';

  @override
  String get unknownEncryptionAlgorithm => '未知的加密演算法';

  @override
  String get unmuteChat => '取消靜音聊天室';

  @override
  String get unpin => '取消釘選';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount 個未讀聊天室',
      one: '1 unread chat',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username和其他$count個人正在輸入…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username和$username2正在輸入…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username正在輸入…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '$username離開了聊天室';
  }

  @override
  String get username => '使用者名稱';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username傳送了一個$type事件';
  }

  @override
  String get verified => '已驗證';

  @override
  String get verify => '驗證';

  @override
  String get verifyStart => '開始驗證';

  @override
  String get verifySuccess => '您成功驗證了！';

  @override
  String get verifyTitle => '正在驗證其他帳號';

  @override
  String get videoCall => '視訊通話';

  @override
  String get visibilityOfTheChatHistory => '聊天記錄的可見性';

  @override
  String get visibleForAllParticipants => '對所有參與者可見';

  @override
  String get visibleForEveryone => '對所有人可見';

  @override
  String get voiceMessage => '語音訊息';

  @override
  String get waitingPartnerAcceptRequest => '正在等待夥伴接受請求…';

  @override
  String get waitingPartnerEmoji => '正在等待夥伴接受表情符號…';

  @override
  String get waitingPartnerNumbers => '正在等待夥伴接受數字…';

  @override
  String get wallpaper => '桌布';

  @override
  String get warning => '警告！';

  @override
  String get weSentYouAnEmail => '我們向您傳送了一封電子郵件';

  @override
  String get whoCanPerformWhichAction => '誰可以執行這個動作';

  @override
  String get whoIsAllowedToJoinThisGroup => '誰可以加入這個群組';

  @override
  String get whyDoYouWantToReportThis => '您檢舉的原因是什麼？';

  @override
  String get wipeChatBackup => '要清除您的聊天記錄備份以建立新的安全金鑰嗎？';

  @override
  String get withTheseAddressesRecoveryDescription => '有了這些位址，您就可以恢復密碼。';

  @override
  String get writeAMessage => '輸入訊息…';

  @override
  String get yes => '是';

  @override
  String get you => '您';

  @override
  String get youAreInvitedToThisChat => '有人邀請您加入這個聊天室';

  @override
  String get youAreNoLongerParticipatingInThisChat => '您不再參與這個聊天室了';

  @override
  String get youCannotInviteYourself => '您不能邀請您自己';

  @override
  String get youHaveBeenBannedFromThisChat => '您已經被這個聊天室封禁';

  @override
  String get yourPublicKey => '您的公鑰';
}
