// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(username) => "${username} đã đồng ý lời mời";

  static String m1(username) =>
      "${username} đã kích hoạt mã hóa đầu cuối 2 chiều";

  static String m2(senderName) => "${senderName} đã trả lời cuộc gọi";

  static String m3(username) =>
      "Bạn có đồng ý yêu cầu chứng thực từ ${username} không?";

  static String m4(username, targetName) => "${username} đã cấm ${targetName}";

  static String m6(username) => "${username} đã thay đổi ảnh phòng chat";

  static String m7(username, description) =>
      "${username} đã thay đổi mô tả phòng chat thành: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} đã thay đổi tên phòng chat thành: \'${chatname}\'";

  static String m9(username) =>
      "${username} đã thay đổi quyền trong phòng chat";

  static String m11(username) =>
      "${username} đã thay đổi quy tắc truy cập đối với khách";

  static String m12(username, rules) =>
      "${username} đã thay đổi quy tắc truy cập đối với khách thành: ${rules}";

  static String m17(username) =>
      "${username} đã thay đổi ảnh đại diện của mình";

  static String m18(username) => "${username} đã đổi địa chỉ phòng chat";

  static String m19(username) => "${username} đã thay đổi đường dẫn mời";

  static String m21(error) => "Không thể giải mã tin nhắn: ${error}";

  static String m23(count) => "${count} thành viên";

  static String m24(username) => "${username} đã tạo cuộc trò chuyện";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}/${month}/${year}";

  static String m28(month, day) => "${day}/${month}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Giới thiệu"),
        "accept": MessageLookupByLibrary.simpleMessage("Đồng ý"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "activatedEndToEndEncryption": m1,
        "addEmail": MessageLookupByLibrary.simpleMessage("Thêm email"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Thêm mô tả cho nhóm"),
        "admin": MessageLookupByLibrary.simpleMessage("Quản trị viên"),
        "alias": MessageLookupByLibrary.simpleMessage("bí danh"),
        "answeredTheCall": m2,
        "anyoneCanJoin": MessageLookupByLibrary.simpleMessage(
            "Mọi người đều có thể gia nhập"),
        "archive": MessageLookupByLibrary.simpleMessage("Lưu trữ"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Khách vãng lai có được tham gia không"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Bạn chắc chứ?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc bạn muốn đăng xuất không?"),
        "askVerificationRequest": m3,
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Cấm khỏi cuộc trò chuyện"),
        "banned": MessageLookupByLibrary.simpleMessage("Đã bị cấm"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("Thiết bị bị chặn"),
        "blocked": MessageLookupByLibrary.simpleMessage("Đã chặn"),
        "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Thay đổi tên thiết bị"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Thay đổi mật khẩu"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Thay đổi máy chủ nhà"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Thay đổi tên nhóm"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Thay hình nền"),
        "changedTheChatAvatar": m6,
        "changedTheChatDescriptionTo": m7,
        "changedTheChatNameTo": m8,
        "changedTheChatPermissions": m9,
        "changedTheGuestAccessRules": m11,
        "changedTheGuestAccessRulesTo": m12,
        "changedTheProfileAvatar": m17,
        "changedTheRoomAliases": m18,
        "changedTheRoomInvitationLink": m19,
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Sao lưu cuộc trò chuyện"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Bản sao lưu cuộc trò chuyện của bạn được bảo mật bằng một khoá bảo mật. Bạn đừng làm mất nó."),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Chi tiết cuộc trò chuyện"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Chọn một mật khẩu mạnh"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Chọn tên người dùng"),
        "close": MessageLookupByLibrary.simpleMessage("Đóng"),
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "So sánh và đảm bảo các biểu tượng cảm xúc sau đây giống với các biểu tượng trên máy còn lại"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "So sánh và đảm bảo các số sau đây giống trên máy còn lại"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "connect": MessageLookupByLibrary.simpleMessage("Kết nối"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Liên hệ đã được mời vào nhóm"),
        "copy": MessageLookupByLibrary.simpleMessage("Sao chép"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Tạo"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Tạo một nhóm mới"),
        "createdTheChat": m24,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Đang hoạt động"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Việc này sẽ vô hiệu hoá tài khoản của bạn. Điều này không thể đảo ngược được! Bạn chắc là vẫn muốn tiếp tục chứ?"),
        "delete": MessageLookupByLibrary.simpleMessage("Xoá"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Xoá tài khoản"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("Xoá tin nhắn"),
        "deny": MessageLookupByLibrary.simpleMessage("Từ chối"),
        "device": MessageLookupByLibrary.simpleMessage("Thiết bị"),
        "deviceId":
            MessageLookupByLibrary.simpleMessage("Mã xác định thiết bị"),
        "devices": MessageLookupByLibrary.simpleMessage("Các thiết bị"),
        "displaynameHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Tên hiển thị đã được thay đổi"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Tải ảnh xuống"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Sửa tên hiển thị"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Cài đặt biểu tượng cảm xúc"),
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Mọi thứ đã sẵn sàng!"),
        "next": MessageLookupByLibrary.simpleMessage("Tiếp"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Bạn chỉ có thể kích hoạt mã hoá khi phòng này không mở"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Vui lòng làm theo hướng dẫn trên trang web và bấm tiếp"),
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Hiển thị mật khẩu"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("Chuyển từ thiết bị khác"),
        "verified": MessageLookupByLibrary.simpleMessage("Đã xác thực")
      };
}
