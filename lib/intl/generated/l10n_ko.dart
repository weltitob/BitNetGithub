// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class L10nKo extends L10n {
  L10nKo([String locale = 'ko']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => '가입';

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
  String get passwordsDoNotMatch => '비밀번호가 일치하지 않습니다!';

  @override
  String get pleaseEnterValidEmail => '유효한 이메일 주소를 입력해주세요.';

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
  String get people => '사람들';

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
  String get groups => '그룹';

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
  String get repeatPassword => '비밀번호 다시 입력';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return '최소 $min자를 선택하세요.';
  }

  @override
  String get about => '소개';

  @override
  String get updateAvailable => 'FluffyChat 업데이트 이용가능';

  @override
  String get updateNow => '백그라운드에서 업데이트 시작';

  @override
  String get accept => '수락';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username님이 초대를 수락함';
  }

  @override
  String get account => '계정';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username님이 종단간 암호화를 활성화함';
  }

  @override
  String get addEmail => '이메일 추가';

  @override
  String get confirmMatrixId => '계정을 삭제하려면 Matrix ID를 확인해 주세요.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => '그룹 소개 추가';

  @override
  String get addToSpace => '스페이스에 추가';

  @override
  String get admin => '관리자';

  @override
  String get alias => '별명';

  @override
  String get all => '모두';

  @override
  String get allChats => '모든 채팅';

  @override
  String get commandHint_googly => '왕눈이 눈알 보내기';

  @override
  String get commandHint_cuddle => 'Send a cuddle';

  @override
  String get commandHint_hug => 'Send a hug';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName 님이 왕눈이 눈알을 보냈습니다';
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
    return '$senderName 가 전화에 응답했습니다';
  }

  @override
  String get anyoneCanJoin => '누구나 들어올 수 있음';

  @override
  String get appLock => '앱 잠금';

  @override
  String get archive => '저장';

  @override
  String get areGuestsAllowedToJoin => '게스트 유저가 참가 여부';

  @override
  String get areYouSure => '확실한가요?';

  @override
  String get areYouSureYouWantToLogout => '로그아웃하고 싶은 것이 확실한가요?';

  @override
  String get askSSSSSign => '다른 사람을 서명하기 위해서, 저장 비밀번호나 복구 키를 입력해주세요.';

  @override
  String askVerificationRequest(Object username) {
    return '$username의 인증 요청을 수락할까요?';
  }

  @override
  String get autoplayImages => '자동으로 움직이는 스티커와 이모트 재생';

  @override
  String get sendOnEnter => '엔터로 보내기';

  @override
  String get banFromChat => '채팅에서 밴';

  @override
  String get banned => '밴됨';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username이 $targetName 밴함';
  }

  @override
  String get blockDevice => '기기 차단';

  @override
  String get blocked => '차단됨';

  @override
  String get botMessages => '봇 메시지';

  @override
  String get bubbleSize => '버블 크기';

  @override
  String get cancel => '취소';

  @override
  String cantOpenUri(Object uri) {
    return 'URI $uri를 열 수 없습니다';
  }

  @override
  String get changeDeviceName => '기기 이름 바꾸기';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username이 채팅 아바타 바꿈';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username이 채팅 설명을 \'$description\' 으로 변경함';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username이 채팅 이름을 \'$chatname\' 으로 바꿈';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username이 채팅 권한을 바꿈';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username이 닉네임을 \'$displayname\' 으로 바꿈';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username이 게스트 접근 규칙을 변경함';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username이 게스트 접근 규칙을 $rules 로 변경함';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username이 대화 기록 설정을 변경함';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username이 대화 기록 설정을 $rules 로 바꿈';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username이 참가 규칙을 바꿈';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username이 참가 규칙을 $joinRules 로 바꿈';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username이 자신의 아바타를 바꿈';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username이 방 별명을 바꿈';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username이 초대 링크 바꿈';
  }

  @override
  String get changePassword => '비밀번호 바꾸기';

  @override
  String get changeTheHomeserver => '홈서버 바꾸기';

  @override
  String get changeTheme => '스타일 바꾸기';

  @override
  String get changeTheNameOfTheGroup => '그룹의 이름 바꾸기';

  @override
  String get changeWallpaper => '배경 바꾸기';

  @override
  String get changeYourAvatar => '아바타 바꾸기';

  @override
  String get channelCorruptedDecryptError => '암호화가 손상되었습니다';

  @override
  String get chat => '채팅';

  @override
  String get yourChatBackupHasBeenSetUp => '당신의 채팅 백업이 설정되었습니다.';

  @override
  String get chatBackup => '채팅 백업';

  @override
  String get chatBackupDescription =>
      '당신의 오래된 메시지는 보안 키로 보호됩니다. 이 키를 잃어버리지 마세요.';

  @override
  String get chatDetails => '채팅 정보';

  @override
  String get chatHasBeenAddedToThisSpace => '이 스페이스에 채팅이 추가되었습니다';

  @override
  String get chats => '채팅';

  @override
  String get chooseAStrongPassword => '안전한 비밀번호를 설정하세요';

  @override
  String get chooseAUsername => '닉네임 고르기';

  @override
  String get clearArchive => '저장 지우기';

  @override
  String get close => '닫기';

  @override
  String get commandHint_markasdm => 'Mark as direct message room';

  @override
  String get commandHint_markasgroup => '';

  @override
  String get commandHint_ban => '이 룸에서 주어진 유저 밴하기';

  @override
  String get commandHint_clearcache => '캐시 지우기';

  @override
  String get commandHint_create =>
      '빈 그룹 채팅을 생성\t\n--no-encryption을 사용해 암호화를 비활성화';

  @override
  String get commandHint_discardsession => '세션 삭제';

  @override
  String get commandHint_dm => '다이렉트 채팅 시작\t\n--no-encryption을 사용해 암호화 비활성화';

  @override
  String get commandHint_html => 'HTML 형식의 문자 보내기';

  @override
  String get commandHint_invite => '주어진 유저 이 룸에 초대하기';

  @override
  String get commandHint_join => '주어진 방 들어가기';

  @override
  String get commandHint_kick => '주어진 유저 방에서 삭제하기';

  @override
  String get commandHint_leave => '이 룸 나가기';

  @override
  String get commandHint_me => '자신을 소개하세요';

  @override
  String get commandHint_myroomavatar => '이 방의 사진 설정하기 (by mxc-uri)';

  @override
  String get commandHint_myroomnick => '이 방의 표시 이름 설정하기';

  @override
  String get commandHint_op => '주어진 유저의 권한 레벨 설정 (기본:50)';

  @override
  String get commandHint_plain => '형식이 지정되지 않은 문자 보내기';

  @override
  String get commandHint_react => '답장 반응으로 보내기';

  @override
  String get commandHint_send => '문자 보내기';

  @override
  String get commandHint_unban => '주어진 유저 이 룸에서 밴 해제하기';

  @override
  String get commandInvalid => '잘못된 명령어';

  @override
  String commandMissing(Object command) {
    return '$command 는 명령어가 아닙니다.';
  }

  @override
  String get compareEmojiMatch => '다른 기기에서도 아래의 이모지가 일치하는지 비교하세요:';

  @override
  String get compareNumbersMatch => '다른 기기에서도 아래의 숫자가 일치하는지 비교하세요:';

  @override
  String get configureChat => '채팅 설정';

  @override
  String get confirm => '확인';

  @override
  String get connect => '연결';

  @override
  String get contactHasBeenInvitedToTheGroup => '연락처가 그룹에 초대되었습니다';

  @override
  String get containsDisplayName => '표시 이름 포함';

  @override
  String get containsUserName => '유저 이름 포함';

  @override
  String get contentHasBeenReported => '콘텐츠가 서버 운영자에게 신고되었습니다';

  @override
  String get copiedToClipboard => '클립보드에 복사됨';

  @override
  String get copy => '복사';

  @override
  String get copyToClipboard => '클립보드에 복사';

  @override
  String couldNotDecryptMessage(Object error) {
    return '메시지 복호화할 수 없음: $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count 참여자';
  }

  @override
  String get create => '생성';

  @override
  String createdTheChat(Object username) {
    return '💬 $username님이 채팅을 생성함';
  }

  @override
  String get createNewGroup => '새로운 그룹';

  @override
  String get createNewSpace => '새로운 스페이스';

  @override
  String get currentlyActive => '현재 활동 중';

  @override
  String get darkTheme => '다크';

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
      '이것은 당신의 계정을 비활성화할 것입니다. 이것은 되돌릴 수 없습니다! 확실한가요?';

  @override
  String get defaultPermissionLevel => '기본 권한 레벨';

  @override
  String get delete => '삭제';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteMessage => '메시지 삭제';

  @override
  String get deny => '거부';

  @override
  String get device => '기기';

  @override
  String get deviceId => '기기 ID';

  @override
  String get devices => '기기';

  @override
  String get directChats => '다이렉트 채팅';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => '표시 이름이 변경되었습니다';

  @override
  String get downloadFile => '파일 다운로드';

  @override
  String get edit => '수정';

  @override
  String get editBlockedServers => '차단된 서버 수정';

  @override
  String get editChatPermissions => '채팅 권한 수정';

  @override
  String get editDisplayname => '표시 이름 수정';

  @override
  String get editRoomAliases => '방 별명 수정';

  @override
  String get editRoomAvatar => '방 아바타 수정';

  @override
  String get emoteExists => '이모트가 이미 존재합니다!';

  @override
  String get emoteInvalid => '올바르지 않은 이모트 단축키!';

  @override
  String get emotePacks => '방을 위한 이모트 팩';

  @override
  String get emoteSettings => '이모트 설정';

  @override
  String get emoteShortcode => '이모트 단축키';

  @override
  String get emoteWarnNeedToPick => '이모트 단축키와 이미지를 골라야 합니다!';

  @override
  String get emptyChat => '빈 채팅';

  @override
  String get enableEmotesGlobally => '이모트 팩 항상 사용하기';

  @override
  String get enableEncryption => '암호화 켜기';

  @override
  String get enableEncryptionWarning => '당신은 다시 암호화를 비활성화할 수 없습니다. 확실한가요?';

  @override
  String get encrypted => '암호화됨';

  @override
  String get encryption => '암호화';

  @override
  String get encryptionNotEnabled => '암호화가 비활성화됨';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName 이 통화를 종료했습니다';
  }

  @override
  String get enterAGroupName => '그룹 이름 입력';

  @override
  String get enterAnEmailAddress => '이메일 주소 입력';

  @override
  String get enterASpacepName => '스페이스 이름 입력';

  @override
  String get homeserver => '홈서버';

  @override
  String get enterYourHomeserver => '당신의 홈서버를 입력하세요';

  @override
  String errorObtainingLocation(Object error) {
    return '위치 얻는 중 오류: $error';
  }

  @override
  String get everythingReady => '모든 것이 준비됐어요!';

  @override
  String get extremeOffensive => '매우 공격적임';

  @override
  String get fileName => '파일 이름';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => '폰트 크기';

  @override
  String get forward => '전달';

  @override
  String get fromJoining => '들어온 후부터';

  @override
  String get fromTheInvitation => '초대받은 후부터';

  @override
  String get goToTheNewRoom => '새로운 방 가기';

  @override
  String get group => '그룹';

  @override
  String get groupDescription => '그룹 설명';

  @override
  String get groupDescriptionHasBeenChanged => '그룹 설명 바뀜';

  @override
  String get groupIsPublic => '그룸 공개됨';

  @override
  String groupWith(Object displayname) {
    return '$displayname 과의 그룹';
  }

  @override
  String get guestsAreForbidden => '게스트는 금지되어 있습니다';

  @override
  String get guestsCanJoin => '게스트가 들어올 수 있음';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username이 $targetName에 대한 초대를 철회함';
  }

  @override
  String get help => '도움';

  @override
  String get hideRedactedEvents => '지워진 이벤트 숨기기';

  @override
  String get hideUnknownEvents => '알 수 없는 이벤트 숨기기';

  @override
  String get howOffensiveIsThisContent => '이 콘텐츠가 얼마나 모욕적인가요?';

  @override
  String get id => 'ID';

  @override
  String get identity => '신원';

  @override
  String get ignore => '무시';

  @override
  String get ignoredUsers => '무시된 사용자';

  @override
  String get ignoreListDescription =>
      '당신을 방해하는 사용자들을 무시할 수 있습니다. 당신의 개인 무시 리스트에 있는 사용자들에게서 메시지나 방 초대를 수신할 수 없습니다.';

  @override
  String get ignoreUsername => '유저 이름 무시';

  @override
  String get iHaveClickedOnLink => '링크를 클릭했어요';

  @override
  String get incorrectPassphraseOrKey => '올바르지 않은 복구 키나 비밀번호';

  @override
  String get inoffensive => '모욕적이지 않음';

  @override
  String get inviteContact => '연락처 초대';

  @override
  String inviteContactToGroup(Object groupName) {
    return '연락처 $groupName 에 초대';
  }

  @override
  String get invited => '초대됨';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username님이 $targetName님을 초대함';
  }

  @override
  String get invitedUsersOnly => '초대한 사용자만';

  @override
  String get inviteForMe => '나를 위해 초대';

  @override
  String inviteText(Object username, Object link) {
    return '$username이 당신을 FluffyChat에 초대했습니다.\n1. FluffyChat 설치: https://fluffychat.im\n2. 가입하거나 로그인\n3. 초대 링크 열기: $link';
  }

  @override
  String get isTyping => '가 입력 중…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username님이 채팅에 참가함';
  }

  @override
  String get joinRoom => '방 들어가기';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username님이 $targetName님을 추방함';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username님이 $targetName님을 추방하고 차단함';
  }

  @override
  String get kickFromChat => '채팅에서 추방';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return '마지막 활동: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => '오래 전 접속';

  @override
  String get leave => '나가기';

  @override
  String get leftTheChat => '채팅을 나갔습니다';

  @override
  String get license => '라이선스';

  @override
  String get lightTheme => '라이트';

  @override
  String loadCountMoreParticipants(Object count) {
    return '$count명의 참가자 더 표시';
  }

  @override
  String get dehydrate => '세션을 내보내고 기기 초기화 하기';

  @override
  String get dehydrateWarning => '이 동작은 되돌릴 수 없습니다. 백업 파일을 꼭 안전하게 보관하세요.';

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
  String get loadingPleaseWait => '로딩 중... 기다려 주세요.';

  @override
  String get loadMore => '더 불러오기…';

  @override
  String get locationDisabledNotice => '위치 서비스가 비활성화되었습니다. 위치를 공유하려면 활성화시켜주세요.';

  @override
  String get locationPermissionDeniedNotice =>
      '위치 권한이 거부되었습니다. 위치를 공유하기 위해서 허용해주세요.';

  @override
  String get login => '로그인';

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
    return '$homeserver 에 로그인';
  }

  @override
  String get loginWithOneClick => '클릭 한 번으로 로그인';

  @override
  String get logout => '로그아웃';

  @override
  String get makeSureTheIdentifierIsValid => '식별자가 유효한지 확인하세요';

  @override
  String get memberChanges => '참가자 변경';

  @override
  String get mention => '멘션';

  @override
  String get messages => '메시지';

  @override
  String get messageWillBeRemovedWarning => '모든 참여자에게서 메시지가 지워집니다';

  @override
  String get moderator => '관리자';

  @override
  String get muteChat => '채팅 음소거';

  @override
  String get needPantalaimonWarning =>
      '지금 종단간 암호화를 사용하기 위해서는 Pantalaimon이 필요하다는 것을 알아주세요.';

  @override
  String get newChat => '새로운 채팅';

  @override
  String get newMessageInFluffyChat => 'FluffyChat에서 새로운 메시지';

  @override
  String get newVerificationRequest => '새로운 확인 요청!';

  @override
  String get next => '다음';

  @override
  String get no => '아니요';

  @override
  String get noConnectionToTheServer => '서버에 연결 없음';

  @override
  String get noEmotesFound => '이모트 발견되지 않음. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      '당신은 방이 공개적으로 접근 가능하지 않을 때만 암호화를 켤 수 있습니다.';

  @override
  String get noGoogleServicesWarning =>
      '이 휴대폰에 Google 서비스가 없는 것 같습니다. 프라이버시를 위해 좋은 결정이죠! FluffyChat에서 푸시 알림을 받으려면 https://microg.org/ 이나 https://unifiedpush.org/ 을 사용하는 것을 권장합니다.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1은 matrix 서버가 아닙니다, $server2를 대신 사용할까요?';
  }

  @override
  String get shareYourInviteLink => '당신의 초대 링크 공유';

  @override
  String get scanQrCode => 'QR 코드 스캔';

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
  String get none => '없음';

  @override
  String get noPasswordRecoveryDescription => '당신은 비밀번호를 복구할 방법을 추가하지 않았습니다.';

  @override
  String get noPermission => '권한 없음';

  @override
  String get noRoomsFound => '아무 방도 발견되지 않았어요…';

  @override
  String get notifications => '알림';

  @override
  String get notificationsEnabledForThisAccount => '이 계정에서 알림이 활성화되었습니다';

  @override
  String numUsersTyping(Object count) {
    return '$count명이 입력 중…';
  }

  @override
  String get obtainingLocation => '위치 얻는 중…';

  @override
  String get offensive => '모욕적임';

  @override
  String get offline => '오프라인';

  @override
  String get ok => '확인';

  @override
  String get online => '온라인';

  @override
  String get onlineKeyBackupEnabled => '온라인 키 백업이 활성화됨';

  @override
  String get oopsPushError => '앗! 안타깝게도, 푸시 알림을 설정하는 중 오류가 발생했습니다.';

  @override
  String get oopsSomethingWentWrong => '앗, 무언가가 잘못되었습니다…';

  @override
  String get openAppToReadMessages => '앱을 열어서 메시지를 읽으세요';

  @override
  String get openCamera => '카메라 열기';

  @override
  String get openVideoCamera => '영상용 카메라 열기';

  @override
  String get oneClientLoggedOut => '당신의 클라이언트 중 하나가 로그아웃 됨';

  @override
  String get addAccount => '계정 추가';

  @override
  String get editBundlesForAccount => '이 계정의 번들 수정';

  @override
  String get addToBundle => '번들에 추가';

  @override
  String get removeFromBundle => '이 번들에서 삭제';

  @override
  String get bundleName => '번들 이름';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts => '(베타) 이 기기에서 다중 계정 활성화';

  @override
  String get openInMaps => '지도에서 열기';

  @override
  String get link => '링크';

  @override
  String get serverRequiresEmail => '이 서버는 가입을 위해 당신의 이메일을 확인해야 합니다.';

  @override
  String get optionalGroupName => '(선택) 그룹 이름';

  @override
  String get or => '이나';

  @override
  String get participant => '참여자';

  @override
  String get passphraseOrKey => '비밀번호나 복구 키';

  @override
  String get password => '비밀번호';

  @override
  String get passwordForgotten => '비밀번호 까먹음';

  @override
  String get passwordHasBeenChanged => '비밀번호가 변경됨';

  @override
  String get passwordRecovery => '비밀번호 복구';

  @override
  String get pickImage => '이미지 고르기';

  @override
  String get pin => '고정';

  @override
  String play(Object fileName) {
    return '$fileName 재생';
  }

  @override
  String get pleaseChoose => '선택해주세요';

  @override
  String get pleaseChooseAPasscode => '비밀번호를 골라주세요';

  @override
  String get pleaseChooseAUsername => '유저 이름을 골라주세요';

  @override
  String get pleaseClickOnLink => '이메일의 링크를 클릭하고 진행해주세요.';

  @override
  String get pleaseEnter4Digits => '4자리 숫자를 입력하거나 앱 잠금을 사용하지 않도록 하려면 비워두세요.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Matrix ID를 입력해주세요.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => '비밀번호를 입력해주세요';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'PIN을 입력해주세요';

  @override
  String get pleaseEnterYourUsername => '유저 이름을 입력해주세요';

  @override
  String get pleaseFollowInstructionsOnWeb => '웹사이트의 가이드를 따르고 다음 버튼을 눌러주세요.';

  @override
  String get privacy => '프라이버시';

  @override
  String get publicRooms => '공개 방';

  @override
  String get pushRules => '푸시 규칙';

  @override
  String get reason => '이유';

  @override
  String get recording => '녹음';

  @override
  String redactedAnEvent(Object username) {
    return '$username이 이벤트를 지움';
  }

  @override
  String get redactMessage => '메시지 지우기';

  @override
  String get reject => '거절';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username이 초대를 거절함';
  }

  @override
  String get rejoin => '다시 가입';

  @override
  String get remove => '지우기';

  @override
  String get removeAllOtherDevices => '모든 다른 기기에서 지우기';

  @override
  String removedBy(Object username) {
    return '$username에 의해 지워짐';
  }

  @override
  String get removeDevice => '기기 삭제';

  @override
  String get unbanFromChat => '채팅에서 밴 해제';

  @override
  String get removeYourAvatar => '아바타 지우기';

  @override
  String get renderRichContent => '풍부한 메시지 콘텐츠 렌더링';

  @override
  String get replaceRoomWithNewerVersion => '방 새로운 버전으로 대체하기';

  @override
  String get reply => '답장';

  @override
  String get reportMessage => '메시지 신고';

  @override
  String get requestPermission => '권한 요청';

  @override
  String get roomHasBeenUpgraded => '방이 업그레이드되었습니다';

  @override
  String get roomVersion => '방 버전';

  @override
  String get saveFile => '파일 저장';

  @override
  String get search => '검색';

  @override
  String get security => '보안';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return '$username이 읽음';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return '$username와 $count명의 다른 사람들이 봤습니다';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return '$username, $username2가 읽음';
  }

  @override
  String get send => '보내기';

  @override
  String get sendAMessage => '메시지 보내기';

  @override
  String get sendAsText => '텍스트로 보내기';

  @override
  String get sendAudio => '오디오 보내기';

  @override
  String get sendFile => '파일 보내기';

  @override
  String get sendImage => '이미지 보내기';

  @override
  String get sendMessages => '메시지 보내기';

  @override
  String get sendOriginal => '원본 보내기';

  @override
  String get sendSticker => '스티커 보내기';

  @override
  String get sendVideo => '영상 보내기';

  @override
  String sentAFile(Object username) {
    return '$username이 파일 보냄';
  }

  @override
  String sentAnAudio(Object username) {
    return '$username이 오디오 보냄';
  }

  @override
  String sentAPicture(Object username) {
    return '$username이 사진 보냄';
  }

  @override
  String sentASticker(Object username) {
    return '$username이 스티커 보냄';
  }

  @override
  String sentAVideo(Object username) {
    return '$username이 영상 보냄';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName 이 통화 정보 보냄';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => '주 별명으로 설정';

  @override
  String get setCustomEmotes => '맞춤 이모트 설정';

  @override
  String get setGroupDescription => '그룹 설명 설정';

  @override
  String get setInvitationLink => '초대 링크 설정';

  @override
  String get setPermissionsLevel => '권한 레벨 설정';

  @override
  String get setStatus => '상태 설정';

  @override
  String get settings => '설정';

  @override
  String get share => '공유';

  @override
  String sharedTheLocation(Object username) {
    return '$username이 위치 공유함';
  }

  @override
  String get shareLocation => '위치 보내기';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => '비밀번호 보이기';

  @override
  String get signUp => '가입';

  @override
  String get singlesignon => '단일 계정 로그인(SSO)';

  @override
  String get skip => '스킵';

  @override
  String get sourceCode => '소스 코드';

  @override
  String get spaceIsPublic => '스페이스가 공개됨';

  @override
  String get spaceName => '스페이스 이름';

  @override
  String startedACall(Object senderName) {
    return '$senderName 가 통화 시작함';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => '상태';

  @override
  String get statusExampleMessage => '오늘은 어떤 기분인가요?';

  @override
  String get submit => '제출';

  @override
  String get synchronizingPleaseWait => '동기화 중... 기다려주세요.';

  @override
  String get systemTheme => '시스템';

  @override
  String get theyDontMatch => '일치하지 않습니다';

  @override
  String get theyMatch => '일치합니다';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => '즐겨찾기 토글';

  @override
  String get toggleMuted => '음소거 토글';

  @override
  String get toggleUnread => '메시지 안/읽음 으로 표시';

  @override
  String get tooManyRequestsWarning => '너무 많은 요청. 잠시 후에 다시 시도해주세요!';

  @override
  String get transferFromAnotherDevice => '다른 기기에서 가져오기';

  @override
  String get tryToSendAgain => '다시 보내도록 시도';

  @override
  String get unavailable => '사용할 수 없음';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username이 $targetName 밴 해제함';
  }

  @override
  String get unblockDevice => '기기 차단 해제';

  @override
  String get unknownDevice => '알 수 없는 기기';

  @override
  String get unknownEncryptionAlgorithm => '알 수 없는 암호화 알고리즘';

  @override
  String get unmuteChat => '음소거 해제';

  @override
  String get unpin => '고정 해제';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount 개',
      one: '읽지 않은 채팅 1',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username과 $count명이 입력 중…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username과 $username2가 입력 중…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username이 입력 중…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '$username이 채팅을 나감';
  }

  @override
  String get username => '유저 이름';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username이 $type 이벤트 보냄';
  }

  @override
  String get unverified => '확인되지 않음';

  @override
  String get verified => '확인됨';

  @override
  String get verify => '확인';

  @override
  String get verifyStart => '확인 시작';

  @override
  String get verifySuccess => '성공적으로 확인했어요!';

  @override
  String get verifyTitle => '다른 계정 확인 중';

  @override
  String get videoCall => '영상 통화';

  @override
  String get visibilityOfTheChatHistory => '대화 기록 설정';

  @override
  String get visibleForAllParticipants => '모든 참가자에게 보임';

  @override
  String get visibleForEveryone => '모두에게 보임';

  @override
  String get voiceMessage => '음성 메시지';

  @override
  String get waitingPartnerAcceptRequest => '상대가 요청을 수락하길 기다리는 중…';

  @override
  String get waitingPartnerEmoji => '상대가 이모지를 수락하길 기다리는 중…';

  @override
  String get waitingPartnerNumbers => '상대가 숫자를 수락하길 기다리는 중…';

  @override
  String get wallpaper => '배경';

  @override
  String get warning => '경고!';

  @override
  String get weSentYouAnEmail => '우리가 당신에게 이메일을 보냈습니다';

  @override
  String get whoCanPerformWhichAction => '누가 어떤 행동을 할 수 있는지';

  @override
  String get whoIsAllowedToJoinThisGroup => '누가 이 그룹에 들어오도록 허용할지';

  @override
  String get whyDoYouWantToReportThis => '왜 이것을 신고하려고 하나요?';

  @override
  String get wipeChatBackup => '새로운 보안 키를 생성하기 위해 채팅 백업을 초기화할까요?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      '이 주소로 당신의 비밀번호를 복구할 수 있습니다.';

  @override
  String get writeAMessage => '메시지 작성…';

  @override
  String get yes => '확인';

  @override
  String get you => '당신';

  @override
  String get youAreInvitedToThisChat => '당신은 이 채팅에 초대되었습니다';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      '당신은 더 이상 이 채팅에 참여하지 않습니다';

  @override
  String get youCannotInviteYourself => '자신을 초대할 수 없습니다';

  @override
  String get youHaveBeenBannedFromThisChat => '당신은 이 채팅에서 밴되었습니다';

  @override
  String get yourPublicKey => '당신의 공개 키';

  @override
  String get messageInfo => '메시지 정보';

  @override
  String get time => '시간';

  @override
  String get messageType => '메시지 유형';

  @override
  String get sender => '발신자';

  @override
  String get openGallery => '갤러리 열기';

  @override
  String get removeFromSpace => '스페이스에서 삭제';

  @override
  String get addToSpaceDescription => '이 채팅을 추가할 스페이스를 선택하세요.';

  @override
  String get start => '시작';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'To unlock your old messages, please enter your recovery key that has been generated in a previous session. Your recovery key is NOT your password.';

  @override
  String get addToStory => '스토리에 추가';

  @override
  String get publish => '공개';

  @override
  String get whoCanSeeMyStories => '누가 내 스토리를 볼 수 있나요?';

  @override
  String get unsubscribeStories => '스토리 구독 해제';

  @override
  String get thisUserHasNotPostedAnythingYet => '이 유저는 스토리에 아무것도 올리지 않았습니다';

  @override
  String get yourStory => '내 스토리';

  @override
  String get replyHasBeenSent => '답장을 보냈습니다';

  @override
  String videoWithSize(Object size) {
    return '영상 ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return '$date의 스토리:\n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc => '스토리에서 사람들이 서로를 보고 연락할 수 있다는 점에 유의하십시오.';

  @override
  String get whatIsGoingOn => '무슨 일이 일어나고 있나요?';

  @override
  String get addDescription => '설명 추가';

  @override
  String get storyPrivacyWarning =>
      '사람들이 서로를 보고 연락할 수 있다는 점에 유의해주세요. 스토리는 24시간 동안 보이지만 모든 기기와 서버에서 삭제된다는 보장은 없습니다.';

  @override
  String get iUnderstand => '동의합니다';

  @override
  String get openChat => '채팅 열기';

  @override
  String get markAsRead => '읽음으로 표시하기';

  @override
  String get reportUser => '사용자 신고';

  @override
  String get dismiss => '닫기';

  @override
  String get matrixWidgets => 'Matrix 위젯';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender가 $reaction로 반응함';
  }

  @override
  String get pinMessage => '방에 고정';

  @override
  String get confirmEventUnpin => '이벤트를 영구적으로 고정 해제할 것이 확실한가요?';

  @override
  String get emojis => '이모지';

  @override
  String get placeCall => '전화 걸기';

  @override
  String get voiceCall => '음성 통화';

  @override
  String get unsupportedAndroidVersion => '지원되지 않는 안드로이드 버전';

  @override
  String get unsupportedAndroidVersionLong =>
      '이 기능은 새로운 안드로이드 버전을 요구합니다. Lineage OS 지원이나 업데이트를 확인해주세요.';

  @override
  String get videoCallsBetaWarning =>
      '영상 통화는 베타임을 확인해주세요. 의도한 대로 작동하지 않거나 모든 플랫폼에서 작동하지 않을 수 있습니다.';

  @override
  String get experimentalVideoCalls => '실험적인 영상 통화';

  @override
  String get emailOrUsername => '이메일이나 유저 이름';

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
