// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(username) => "👍 ${username}님이 초대를 수락함";

  static String m1(username) => "🔐 ${username}님이 종단간 암호화를 활성화함";

  static String m2(senderName) => "${senderName} 가 전화에 응답했습니다";

  static String m3(username) => "${username}의 인증 요청을 수락할까요?";

  static String m4(username, targetName) => "${username}이 ${targetName} 밴함";

  static String m5(uri) => "URI ${uri}를 열 수 없습니다";

  static String m6(username) => "${username}이 채팅 아바타 바꿈";

  static String m7(username, description) =>
      "${username}이 채팅 설명을 \'${description}\' 으로 변경함";

  static String m8(username, chatname) =>
      "${username}이 채팅 이름을 \'${chatname}\' 으로 바꿈";

  static String m9(username) => "${username}이 채팅 권한을 바꿈";

  static String m10(username, displayname) =>
      "${username}이 닉네임을 \'${displayname}\' 으로 바꿈";

  static String m11(username) => "${username}이 게스트 접근 규칙을 변경함";

  static String m12(username, rules) =>
      "${username}이 게스트 접근 규칙을 ${rules} 로 변경함";

  static String m13(username) => "${username}이 대화 기록 설정을 변경함";

  static String m14(username, rules) => "${username}이 대화 기록 설정을 ${rules} 로 바꿈";

  static String m15(username) => "${username}이 참가 규칙을 바꿈";

  static String m16(username, joinRules) =>
      "${username}이 참가 규칙을 ${joinRules} 로 바꿈";

  static String m17(username) => "${username}이 자신의 아바타를 바꿈";

  static String m18(username) => "${username}이 방 별명을 바꿈";

  static String m19(username) => "${username}이 초대 링크 바꿈";

  static String m20(command) => "${command} 는 명령어가 아닙니다.";

  static String m21(error) => "메시지 복호화할 수 없음: ${error}";

  static String m23(count) => "${count} 참여자";

  static String m24(username) => "💬 ${username}님이 채팅을 생성함";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}-${month}-${day}";

  static String m28(month, day) => "${month}-${day}";

  static String m29(senderName) => "${senderName} 이 통화를 종료했습니다";

  static String m30(error) => "위치 얻는 중 오류: ${error}";

  static String m32(senderName) => "${senderName} 님이 왕눈이 눈알을 보냈습니다";

  static String m33(displayname) => "${displayname} 과의 그룹";

  static String m34(username, targetName) =>
      "${username}이 ${targetName}에 대한 초대를 철회함";

  static String m36(groupName) => "연락처 ${groupName} 에 초대";

  static String m37(username, link) =>
      "${username}이 당신을 FluffyChat에 초대했습니다.\n1. FluffyChat 설치: https://fluffychat.im\n2. 가입하거나 로그인\n3. 초대 링크 열기: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username}님이 ${targetName}님을 초대함";

  static String m39(username) => "👋 ${username}님이 채팅에 참가함";

  static String m40(username, targetName) =>
      "👞 ${username}님이 ${targetName}님을 추방함";

  static String m41(username, targetName) =>
      "🙅 ${username}님이 ${targetName}님을 추방하고 차단함";

  static String m42(localizedTimeShort) => "마지막 활동: ${localizedTimeShort}";

  static String m43(count) => "${count}명의 참가자 더 표시";

  static String m44(homeserver) => "${homeserver} 에 로그인";

  static String m45(server1, server2) =>
      "${server1}은 matrix 서버가 아닙니다, ${server2}를 대신 사용할까요?";

  static String m47(count) => "${count}명이 입력 중…";

  static String m48(fileName) => "${fileName} 재생";

  static String m49(min) => "최소 ${min}자를 선택하세요.";

  static String m50(sender, reaction) => "${sender}가 ${reaction}로 반응함";

  static String m51(username) => "${username}이 이벤트를 지움";

  static String m52(username) => "${username}이 초대를 거절함";

  static String m53(username) => "${username}에 의해 지워짐";

  static String m54(username) => "${username}이 읽음";

  static String m55(username, count) =>
      "${Intl.plural(count, other: '${username}과 이외 ${count}명이 읽음')}";

  static String m56(username, username2) => "${username}, ${username2}가 읽음";

  static String m57(username) => "${username}이 파일 보냄";

  static String m58(username) => "${username}이 사진 보냄";

  static String m59(username) => "${username}이 스티커 보냄";

  static String m60(username) => "${username}이 영상 보냄";

  static String m61(username) => "${username}이 오디오 보냄";

  static String m62(senderName) => "${senderName} 이 통화 정보 보냄";

  static String m63(username) => "${username}이 위치 공유함";

  static String m64(senderName) => "${senderName} 가 통화 시작함";

  static String m65(date, body) => "${date}의 스토리:\n${body}";

  static String m68(username, targetName) => "${username}이 ${targetName} 밴 해제함";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '읽지 않은 채팅 1', other: '${unreadCount} 개')}";

  static String m70(username, count) => "${username}과 ${count}명이 입력 중…";

  static String m71(username, username2) => "${username}과 ${username2}가 입력 중…";

  static String m72(username) => "${username}이 입력 중…";

  static String m73(username) => "${username}이 채팅을 나감";

  static String m74(username, type) => "${username}이 ${type} 이벤트 보냄";

  static String m75(size) => "영상 (${size})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("소개"),
        "accept": MessageLookupByLibrary.simpleMessage("수락"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("계정"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("계정 추가"),
        "addDescription": MessageLookupByLibrary.simpleMessage("설명 추가"),
        "addEmail": MessageLookupByLibrary.simpleMessage("이메일 추가"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage("그룹 소개 추가"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("번들에 추가"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("스페이스에 추가"),
        "addToSpaceDescription":
            MessageLookupByLibrary.simpleMessage("이 채팅을 추가할 스페이스를 선택하세요."),
        "addToStory": MessageLookupByLibrary.simpleMessage("스토리에 추가"),
        "admin": MessageLookupByLibrary.simpleMessage("관리자"),
        "alias": MessageLookupByLibrary.simpleMessage("별명"),
        "all": MessageLookupByLibrary.simpleMessage("모두"),
        "allChats": MessageLookupByLibrary.simpleMessage("모든 채팅"),
        "answeredTheCall": m2,
        "anyoneCanJoin": MessageLookupByLibrary.simpleMessage("누구나 들어올 수 있음"),
        "appLock": MessageLookupByLibrary.simpleMessage("앱 잠금"),
        "archive": MessageLookupByLibrary.simpleMessage("저장"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("게스트 유저가 참가 여부"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("확실한가요?"),
        "areYouSureYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("로그아웃하고 싶은 것이 확실한가요?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "다른 사람을 서명하기 위해서, 저장 비밀번호나 복구 키를 입력해주세요."),
        "askVerificationRequest": m3,
        "autoplayImages":
            MessageLookupByLibrary.simpleMessage("자동으로 움직이는 스티커와 이모트 재생"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("채팅에서 밴"),
        "banned": MessageLookupByLibrary.simpleMessage("밴됨"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("기기 차단"),
        "blocked": MessageLookupByLibrary.simpleMessage("차단됨"),
        "botMessages": MessageLookupByLibrary.simpleMessage("봇 메시지"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("버블 크기"),
        "bundleName": MessageLookupByLibrary.simpleMessage("번들 이름"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage("기기 이름 바꾸기"),
        "changePassword": MessageLookupByLibrary.simpleMessage("비밀번호 바꾸기"),
        "changeTheHomeserver": MessageLookupByLibrary.simpleMessage("홈서버 바꾸기"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("그룹의 이름 바꾸기"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("스타일 바꾸기"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage("배경 바꾸기"),
        "changeYourAvatar": MessageLookupByLibrary.simpleMessage("아바타 바꾸기"),
        "changedTheChatAvatar": m6,
        "changedTheChatDescriptionTo": m7,
        "changedTheChatNameTo": m8,
        "changedTheChatPermissions": m9,
        "changedTheDisplaynameTo": m10,
        "changedTheGuestAccessRules": m11,
        "changedTheGuestAccessRulesTo": m12,
        "changedTheHistoryVisibility": m13,
        "changedTheHistoryVisibilityTo": m14,
        "changedTheJoinRules": m15,
        "changedTheJoinRulesTo": m16,
        "changedTheProfileAvatar": m17,
        "changedTheRoomAliases": m18,
        "changedTheRoomInvitationLink": m19,
        "channelCorruptedDecryptError":
            MessageLookupByLibrary.simpleMessage("암호화가 손상되었습니다"),
        "chat": MessageLookupByLibrary.simpleMessage("채팅"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("채팅 백업"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "당신의 오래된 메시지는 보안 키로 보호됩니다. 이 키를 잃어버리지 마세요."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("채팅 정보"),
        "chatHasBeenAddedToThisSpace":
            MessageLookupByLibrary.simpleMessage("이 스페이스에 채팅이 추가되었습니다"),
        "chats": MessageLookupByLibrary.simpleMessage("채팅"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("안전한 비밀번호를 설정하세요"),
        "chooseAUsername": MessageLookupByLibrary.simpleMessage("닉네임 고르기"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("저장 지우기"),
        "close": MessageLookupByLibrary.simpleMessage("닫기"),
        "commandHint_ban":
            MessageLookupByLibrary.simpleMessage("이 룸에서 주어진 유저 밴하기"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("캐시 지우기"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "빈 그룹 채팅을 생성\t\n--no-encryption을 사용해 암호화를 비활성화"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("세션 삭제"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "다이렉트 채팅 시작\t\n--no-encryption을 사용해 암호화 비활성화"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("왕눈이 눈알 보내기"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("HTML 형식의 문자 보내기"),
        "commandHint_invite":
            MessageLookupByLibrary.simpleMessage("주어진 유저 이 룸에 초대하기"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage("주어진 방 들어가기"),
        "commandHint_kick":
            MessageLookupByLibrary.simpleMessage("주어진 유저 방에서 삭제하기"),
        "commandHint_leave": MessageLookupByLibrary.simpleMessage("이 룸 나가기"),
        "commandHint_markasgroup": MessageLookupByLibrary.simpleMessage(""),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("자신을 소개하세요"),
        "commandHint_myroomavatar":
            MessageLookupByLibrary.simpleMessage("이 방의 사진 설정하기 (by mxc-uri)"),
        "commandHint_myroomnick":
            MessageLookupByLibrary.simpleMessage("이 방의 표시 이름 설정하기"),
        "commandHint_op":
            MessageLookupByLibrary.simpleMessage("주어진 유저의 권한 레벨 설정 (기본:50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("형식이 지정되지 않은 문자 보내기"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("답장 반응으로 보내기"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("문자 보내기"),
        "commandHint_unban":
            MessageLookupByLibrary.simpleMessage("주어진 유저 이 룸에서 밴 해제하기"),
        "commandInvalid": MessageLookupByLibrary.simpleMessage("잘못된 명령어"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "다른 기기에서도 아래의 이모지가 일치하는지 비교하세요:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "다른 기기에서도 아래의 숫자가 일치하는지 비교하세요:"),
        "configureChat": MessageLookupByLibrary.simpleMessage("채팅 설정"),
        "confirm": MessageLookupByLibrary.simpleMessage("확인"),
        "confirmEventUnpin":
            MessageLookupByLibrary.simpleMessage("이벤트를 영구적으로 고정 해제할 것이 확실한가요?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "계정을 삭제하려면 Matrix ID를 확인해 주세요."),
        "connect": MessageLookupByLibrary.simpleMessage("연결"),
        "contactHasBeenInvitedToTheGroup":
            MessageLookupByLibrary.simpleMessage("연락처가 그룹에 초대되었습니다"),
        "containsDisplayName": MessageLookupByLibrary.simpleMessage("표시 이름 포함"),
        "containsUserName": MessageLookupByLibrary.simpleMessage("유저 이름 포함"),
        "contentHasBeenReported":
            MessageLookupByLibrary.simpleMessage("콘텐츠가 서버 운영자에게 신고되었습니다"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage("클립보드에 복사됨"),
        "copy": MessageLookupByLibrary.simpleMessage("복사"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage("클립보드에 복사"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("생성"),
        "createNewGroup": MessageLookupByLibrary.simpleMessage("새로운 그룹"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("새로운 스페이스"),
        "createdTheChat": m24,
        "currentlyActive": MessageLookupByLibrary.simpleMessage("현재 활동 중"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("다크"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "이것은 당신의 계정을 비활성화할 것입니다. 이것은 되돌릴 수 없습니다! 확실한가요?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("기본 권한 레벨"),
        "dehydrate": MessageLookupByLibrary.simpleMessage("세션을 내보내고 기기 초기화 하기"),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "이 동작은 되돌릴 수 없습니다. 백업 파일을 꼭 안전하게 보관하세요."),
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("계정 삭제"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("메시지 삭제"),
        "deny": MessageLookupByLibrary.simpleMessage("거부"),
        "device": MessageLookupByLibrary.simpleMessage("기기"),
        "deviceId": MessageLookupByLibrary.simpleMessage("기기 ID"),
        "devices": MessageLookupByLibrary.simpleMessage("기기"),
        "directChats": MessageLookupByLibrary.simpleMessage("다이렉트 채팅"),
        "dismiss": MessageLookupByLibrary.simpleMessage("닫기"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("표시 이름이 변경되었습니다"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("파일 다운로드"),
        "edit": MessageLookupByLibrary.simpleMessage("수정"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage("차단된 서버 수정"),
        "editBundlesForAccount":
            MessageLookupByLibrary.simpleMessage("이 계정의 번들 수정"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage("채팅 권한 수정"),
        "editDisplayname": MessageLookupByLibrary.simpleMessage("표시 이름 수정"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage("방 별명 수정"),
        "editRoomAvatar": MessageLookupByLibrary.simpleMessage("방 아바타 수정"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage("이메일이나 유저 이름"),
        "emojis": MessageLookupByLibrary.simpleMessage("이모지"),
        "emoteExists": MessageLookupByLibrary.simpleMessage("이모트가 이미 존재합니다!"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("올바르지 않은 이모트 단축키!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage("방을 위한 이모트 팩"),
        "emoteSettings": MessageLookupByLibrary.simpleMessage("이모트 설정"),
        "emoteShortcode": MessageLookupByLibrary.simpleMessage("이모트 단축키"),
        "emoteWarnNeedToPick":
            MessageLookupByLibrary.simpleMessage("이모트 단축키와 이미지를 골라야 합니다!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("빈 채팅"),
        "enableEmotesGlobally":
            MessageLookupByLibrary.simpleMessage("이모트 팩 항상 사용하기"),
        "enableEncryption": MessageLookupByLibrary.simpleMessage("암호화 켜기"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "당신은 다시 암호화를 비활성화할 수 없습니다. 확실한가요?"),
        "enableMultiAccounts":
            MessageLookupByLibrary.simpleMessage("(베타) 이 기기에서 다중 계정 활성화"),
        "encrypted": MessageLookupByLibrary.simpleMessage("암호화됨"),
        "encryption": MessageLookupByLibrary.simpleMessage("암호화"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("암호화가 비활성화됨"),
        "endedTheCall": m29,
        "enterAGroupName": MessageLookupByLibrary.simpleMessage("그룹 이름 입력"),
        "enterASpacepName": MessageLookupByLibrary.simpleMessage("스페이스 이름 입력"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("이메일 주소 입력"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("당신의 홈서버를 입력하세요"),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("모든 것이 준비됐어요!"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("실험적인 영상 통화"),
        "extremeOffensive": MessageLookupByLibrary.simpleMessage("매우 공격적임"),
        "fileName": MessageLookupByLibrary.simpleMessage("파일 이름"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("폰트 크기"),
        "forward": MessageLookupByLibrary.simpleMessage("전달"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("들어온 후부터"),
        "fromTheInvitation": MessageLookupByLibrary.simpleMessage("초대받은 후부터"),
        "goToTheNewRoom": MessageLookupByLibrary.simpleMessage("새로운 방 가기"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("그룹"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("그룹 설명"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("그룹 설명 바뀜"),
        "groupIsPublic": MessageLookupByLibrary.simpleMessage("그룸 공개됨"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("그룹"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("게스트는 금지되어 있습니다"),
        "guestsCanJoin": MessageLookupByLibrary.simpleMessage("게스트가 들어올 수 있음"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("도움"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("지워진 이벤트 숨기기"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("알 수 없는 이벤트 숨기기"),
        "homeserver": MessageLookupByLibrary.simpleMessage("홈서버"),
        "howOffensiveIsThisContent":
            MessageLookupByLibrary.simpleMessage("이 콘텐츠가 얼마나 모욕적인가요?"),
        "iHaveClickedOnLink": MessageLookupByLibrary.simpleMessage("링크를 클릭했어요"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("동의합니다"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("신원"),
        "ignore": MessageLookupByLibrary.simpleMessage("무시"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "당신을 방해하는 사용자들을 무시할 수 있습니다. 당신의 개인 무시 리스트에 있는 사용자들에게서 메시지나 방 초대를 수신할 수 없습니다."),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage("유저 이름 무시"),
        "ignoredUsers": MessageLookupByLibrary.simpleMessage("무시된 사용자"),
        "incorrectPassphraseOrKey":
            MessageLookupByLibrary.simpleMessage("올바르지 않은 복구 키나 비밀번호"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("모욕적이지 않음"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("연락처 초대"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("나를 위해 초대"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("초대됨"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage("초대한 사용자만"),
        "isTyping": MessageLookupByLibrary.simpleMessage("가 입력 중…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("방 들어가기"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("채팅에서 추방"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo": MessageLookupByLibrary.simpleMessage("오래 전 접속"),
        "leave": MessageLookupByLibrary.simpleMessage("나가기"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("채팅을 나갔습니다"),
        "license": MessageLookupByLibrary.simpleMessage("라이선스"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("라이트"),
        "link": MessageLookupByLibrary.simpleMessage("링크"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("더 불러오기…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("로딩 중... 기다려 주세요."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "위치 서비스가 비활성화되었습니다. 위치를 공유하려면 활성화시켜주세요."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "위치 권한이 거부되었습니다. 위치를 공유하기 위해서 허용해주세요."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("로그인"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("클릭 한 번으로 로그인"),
        "logout": MessageLookupByLibrary.simpleMessage("로그아웃"),
        "makeSureTheIdentifierIsValid":
            MessageLookupByLibrary.simpleMessage("식별자가 유효한지 확인하세요"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("읽음으로 표시하기"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Matrix 위젯"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("참가자 변경"),
        "mention": MessageLookupByLibrary.simpleMessage("멘션"),
        "messageInfo": MessageLookupByLibrary.simpleMessage("메시지 정보"),
        "messageType": MessageLookupByLibrary.simpleMessage("메시지 유형"),
        "messageWillBeRemovedWarning":
            MessageLookupByLibrary.simpleMessage("모든 참여자에게서 메시지가 지워집니다"),
        "messages": MessageLookupByLibrary.simpleMessage("메시지"),
        "moderator": MessageLookupByLibrary.simpleMessage("관리자"),
        "muteChat": MessageLookupByLibrary.simpleMessage("채팅 음소거"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "지금 종단간 암호화를 사용하기 위해서는 Pantalaimon이 필요하다는 것을 알아주세요."),
        "newChat": MessageLookupByLibrary.simpleMessage("새로운 채팅"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("FluffyChat에서 새로운 메시지"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("새로운 확인 요청!"),
        "next": MessageLookupByLibrary.simpleMessage("다음"),
        "no": MessageLookupByLibrary.simpleMessage("아니요"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("서버에 연결 없음"),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("이모트 발견되지 않음. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "당신은 방이 공개적으로 접근 가능하지 않을 때만 암호화를 켤 수 있습니다."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "이 휴대폰에 Google 서비스가 없는 것 같습니다. 프라이버시를 위해 좋은 결정이죠! FluffyChat에서 푸시 알림을 받으려면 https://microg.org/ 이나 https://unifiedpush.org/ 을 사용하는 것을 권장합니다."),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "당신은 비밀번호를 복구할 방법을 추가하지 않았습니다."),
        "noPermission": MessageLookupByLibrary.simpleMessage("권한 없음"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("아무 방도 발견되지 않았어요…"),
        "none": MessageLookupByLibrary.simpleMessage("없음"),
        "notifications": MessageLookupByLibrary.simpleMessage("알림"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage("이 계정에서 알림이 활성화되었습니다"),
        "numUsersTyping": m47,
        "obtainingLocation": MessageLookupByLibrary.simpleMessage("위치 얻는 중…"),
        "offensive": MessageLookupByLibrary.simpleMessage("모욕적임"),
        "offline": MessageLookupByLibrary.simpleMessage("오프라인"),
        "ok": MessageLookupByLibrary.simpleMessage("확인"),
        "oneClientLoggedOut":
            MessageLookupByLibrary.simpleMessage("당신의 클라이언트 중 하나가 로그아웃 됨"),
        "online": MessageLookupByLibrary.simpleMessage("온라인"),
        "onlineKeyBackupEnabled":
            MessageLookupByLibrary.simpleMessage("온라인 키 백업이 활성화됨"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "앗! 안타깝게도, 푸시 알림을 설정하는 중 오류가 발생했습니다."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("앗, 무언가가 잘못되었습니다…"),
        "openAppToReadMessages":
            MessageLookupByLibrary.simpleMessage("앱을 열어서 메시지를 읽으세요"),
        "openCamera": MessageLookupByLibrary.simpleMessage("카메라 열기"),
        "openChat": MessageLookupByLibrary.simpleMessage("채팅 열기"),
        "openGallery": MessageLookupByLibrary.simpleMessage("갤러리 열기"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("지도에서 열기"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage("영상용 카메라 열기"),
        "optionalGroupName": MessageLookupByLibrary.simpleMessage("(선택) 그룹 이름"),
        "or": MessageLookupByLibrary.simpleMessage("이나"),
        "participant": MessageLookupByLibrary.simpleMessage("참여자"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage("비밀번호나 복구 키"),
        "password": MessageLookupByLibrary.simpleMessage("비밀번호"),
        "passwordForgotten": MessageLookupByLibrary.simpleMessage("비밀번호 까먹음"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("비밀번호가 변경됨"),
        "passwordRecovery": MessageLookupByLibrary.simpleMessage("비밀번호 복구"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("비밀번호가 일치하지 않습니다!"),
        "people": MessageLookupByLibrary.simpleMessage("사람들"),
        "pickImage": MessageLookupByLibrary.simpleMessage("이미지 고르기"),
        "pin": MessageLookupByLibrary.simpleMessage("고정"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("방에 고정"),
        "placeCall": MessageLookupByLibrary.simpleMessage("전화 걸기"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("선택해주세요"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("비밀번호를 골라주세요"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("유저 이름을 골라주세요"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink":
            MessageLookupByLibrary.simpleMessage("이메일의 링크를 클릭하고 진행해주세요."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "4자리 숫자를 입력하거나 앱 잠금을 사용하지 않도록 하려면 비워두세요."),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("Matrix ID를 입력해주세요."),
        "pleaseEnterValidEmail":
            MessageLookupByLibrary.simpleMessage("유효한 이메일 주소를 입력해주세요."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("비밀번호를 입력해주세요"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("PIN을 입력해주세요"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("유저 이름을 입력해주세요"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "웹사이트의 가이드를 따르고 다음 버튼을 눌러주세요."),
        "privacy": MessageLookupByLibrary.simpleMessage("프라이버시"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("공개 방"),
        "publish": MessageLookupByLibrary.simpleMessage("공개"),
        "pushRules": MessageLookupByLibrary.simpleMessage("푸시 규칙"),
        "reactedWith": m50,
        "reason": MessageLookupByLibrary.simpleMessage("이유"),
        "recording": MessageLookupByLibrary.simpleMessage("녹음"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("메시지 지우기"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("가입"),
        "reject": MessageLookupByLibrary.simpleMessage("거절"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("다시 가입"),
        "remove": MessageLookupByLibrary.simpleMessage("지우기"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("모든 다른 기기에서 지우기"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("기기 삭제"),
        "removeFromBundle": MessageLookupByLibrary.simpleMessage("이 번들에서 삭제"),
        "removeFromSpace": MessageLookupByLibrary.simpleMessage("스페이스에서 삭제"),
        "removeYourAvatar": MessageLookupByLibrary.simpleMessage("아바타 지우기"),
        "removedBy": m53,
        "renderRichContent":
            MessageLookupByLibrary.simpleMessage("풍부한 메시지 콘텐츠 렌더링"),
        "repeatPassword": MessageLookupByLibrary.simpleMessage("비밀번호 다시 입력"),
        "replaceRoomWithNewerVersion":
            MessageLookupByLibrary.simpleMessage("방 새로운 버전으로 대체하기"),
        "reply": MessageLookupByLibrary.simpleMessage("답장"),
        "replyHasBeenSent": MessageLookupByLibrary.simpleMessage("답장을 보냈습니다"),
        "reportMessage": MessageLookupByLibrary.simpleMessage("메시지 신고"),
        "reportUser": MessageLookupByLibrary.simpleMessage("사용자 신고"),
        "requestPermission": MessageLookupByLibrary.simpleMessage("권한 요청"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("방이 업그레이드되었습니다"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("방 버전"),
        "saveFile": MessageLookupByLibrary.simpleMessage("파일 저장"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("QR 코드 스캔"),
        "search": MessageLookupByLibrary.simpleMessage("검색"),
        "security": MessageLookupByLibrary.simpleMessage("보안"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("보내기"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("메시지 보내기"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("텍스트로 보내기"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("오디오 보내기"),
        "sendFile": MessageLookupByLibrary.simpleMessage("파일 보내기"),
        "sendImage": MessageLookupByLibrary.simpleMessage("이미지 보내기"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("메시지 보내기"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("엔터로 보내기"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("원본 보내기"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("스티커 보내기"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("영상 보내기"),
        "sender": MessageLookupByLibrary.simpleMessage("발신자"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "이 서버는 가입을 위해 당신의 이메일을 확인해야 합니다."),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("주 별명으로 설정"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage("맞춤 이모트 설정"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage("그룹 설명 설정"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage("초대 링크 설정"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage("권한 레벨 설정"),
        "setStatus": MessageLookupByLibrary.simpleMessage("상태 설정"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "share": MessageLookupByLibrary.simpleMessage("공유"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("위치 보내기"),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("당신의 초대 링크 공유"),
        "sharedTheLocation": m63,
        "showPassword": MessageLookupByLibrary.simpleMessage("비밀번호 보이기"),
        "signUp": MessageLookupByLibrary.simpleMessage("가입"),
        "singlesignon": MessageLookupByLibrary.simpleMessage("단일 계정 로그인(SSO)"),
        "skip": MessageLookupByLibrary.simpleMessage("스킵"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("소스 코드"),
        "spaceIsPublic": MessageLookupByLibrary.simpleMessage("스페이스가 공개됨"),
        "spaceName": MessageLookupByLibrary.simpleMessage("스페이스 이름"),
        "start": MessageLookupByLibrary.simpleMessage("시작"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("상태"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("오늘은 어떤 기분인가요?"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "사람들이 서로를 보고 연락할 수 있다는 점에 유의해주세요. 스토리는 24시간 동안 보이지만 모든 기기와 서버에서 삭제된다는 보장은 없습니다."),
        "submit": MessageLookupByLibrary.simpleMessage("제출"),
        "synchronizingPleaseWait":
            MessageLookupByLibrary.simpleMessage("동기화 중... 기다려주세요."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("시스템"),
        "theyDontMatch": MessageLookupByLibrary.simpleMessage("일치하지 않습니다"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("일치합니다"),
        "thisUserHasNotPostedAnythingYet":
            MessageLookupByLibrary.simpleMessage("이 유저는 스토리에 아무것도 올리지 않았습니다"),
        "time": MessageLookupByLibrary.simpleMessage("시간"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite": MessageLookupByLibrary.simpleMessage("즐겨찾기 토글"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage("음소거 토글"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage("메시지 안/읽음 으로 표시"),
        "tooManyRequestsWarning":
            MessageLookupByLibrary.simpleMessage("너무 많은 요청. 잠시 후에 다시 시도해주세요!"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("다른 기기에서 가져오기"),
        "tryToSendAgain": MessageLookupByLibrary.simpleMessage("다시 보내도록 시도"),
        "unavailable": MessageLookupByLibrary.simpleMessage("사용할 수 없음"),
        "unbanFromChat": MessageLookupByLibrary.simpleMessage("채팅에서 밴 해제"),
        "unbannedUser": m68,
        "unblockDevice": MessageLookupByLibrary.simpleMessage("기기 차단 해제"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("알 수 없는 기기"),
        "unknownEncryptionAlgorithm":
            MessageLookupByLibrary.simpleMessage("알 수 없는 암호화 알고리즘"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage("음소거 해제"),
        "unpin": MessageLookupByLibrary.simpleMessage("고정 해제"),
        "unreadChats": m69,
        "unsubscribeStories": MessageLookupByLibrary.simpleMessage("스토리 구독 해제"),
        "unsupportedAndroidVersion":
            MessageLookupByLibrary.simpleMessage("지원되지 않는 안드로이드 버전"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "이 기능은 새로운 안드로이드 버전을 요구합니다. Lineage OS 지원이나 업데이트를 확인해주세요."),
        "unverified": MessageLookupByLibrary.simpleMessage("확인되지 않음"),
        "updateAvailable":
            MessageLookupByLibrary.simpleMessage("FluffyChat 업데이트 이용가능"),
        "updateNow": MessageLookupByLibrary.simpleMessage("백그라운드에서 업데이트 시작"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("유저 이름"),
        "verified": MessageLookupByLibrary.simpleMessage("확인됨"),
        "verify": MessageLookupByLibrary.simpleMessage("확인"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("확인 시작"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage("성공적으로 확인했어요!"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage("다른 계정 확인 중"),
        "videoCall": MessageLookupByLibrary.simpleMessage("영상 통화"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "영상 통화는 베타임을 확인해주세요. 의도한 대로 작동하지 않거나 모든 플랫폼에서 작동하지 않을 수 있습니다."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("대화 기록 설정"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("모든 참가자에게 보임"),
        "visibleForEveryone": MessageLookupByLibrary.simpleMessage("모두에게 보임"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("음성 통화"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("음성 메시지"),
        "waitingPartnerAcceptRequest":
            MessageLookupByLibrary.simpleMessage("상대가 요청을 수락하길 기다리는 중…"),
        "waitingPartnerEmoji":
            MessageLookupByLibrary.simpleMessage("상대가 이모지를 수락하길 기다리는 중…"),
        "waitingPartnerNumbers":
            MessageLookupByLibrary.simpleMessage("상대가 숫자를 수락하길 기다리는 중…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("배경"),
        "warning": MessageLookupByLibrary.simpleMessage("경고!"),
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("우리가 당신에게 이메일을 보냈습니다"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("무슨 일이 일어나고 있나요?"),
        "whoCanPerformWhichAction":
            MessageLookupByLibrary.simpleMessage("누가 어떤 행동을 할 수 있는지"),
        "whoCanSeeMyStories":
            MessageLookupByLibrary.simpleMessage("누가 내 스토리를 볼 수 있나요?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "스토리에서 사람들이 서로를 보고 연락할 수 있다는 점에 유의하십시오."),
        "whoIsAllowedToJoinThisGroup":
            MessageLookupByLibrary.simpleMessage("누가 이 그룹에 들어오도록 허용할지"),
        "whyDoYouWantToReportThis":
            MessageLookupByLibrary.simpleMessage("왜 이것을 신고하려고 하나요?"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "새로운 보안 키를 생성하기 위해 채팅 백업을 초기화할까요?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage("이 주소로 당신의 비밀번호를 복구할 수 있습니다."),
        "writeAMessage": MessageLookupByLibrary.simpleMessage("메시지 작성…"),
        "yes": MessageLookupByLibrary.simpleMessage("확인"),
        "you": MessageLookupByLibrary.simpleMessage("당신"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("당신은 이 채팅에 초대되었습니다"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage("당신은 더 이상 이 채팅에 참여하지 않습니다"),
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("자신을 초대할 수 없습니다"),
        "youHaveBeenBannedFromThisChat":
            MessageLookupByLibrary.simpleMessage("당신은 이 채팅에서 밴되었습니다"),
        "yourChatBackupHasBeenSetUp":
            MessageLookupByLibrary.simpleMessage("당신의 채팅 백업이 설정되었습니다."),
        "yourPublicKey": MessageLookupByLibrary.simpleMessage("당신의 공개 키"),
        "yourStory": MessageLookupByLibrary.simpleMessage("내 스토리")
      };
}
