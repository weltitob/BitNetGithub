// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(username) => "👍 ${username} 已接受邀请";

  static String m1(username) => "🔐 ${username} 激活了端到端加密";

  static String m2(senderName) => "已开始与 ${senderName} 通话";

  static String m3(username) => "是否接受来自 ${username} 的验证申请？";

  static String m4(username, targetName) => "${username} 封禁了 ${targetName}";

  static String m5(uri) => "无法打开URI ${uri}";

  static String m6(username) => "${username} 更改了会话头像";

  static String m7(username, description) =>
      "${username} 将聊天描述更改为：\'${description}\'";

  static String m8(username, chatname) =>
      "${username} 将聊天名称更改为：\'${chatname}\'";

  static String m9(username) => "${username} 更改了会话权限";

  static String m10(username, displayname) =>
      "${username} 将展示名称更改为：\'${displayname}\'";

  static String m11(username) => "${username} 更改了游客访问规则";

  static String m12(username, rules) => "${username} 更改了游客访问规则为：${rules}";

  static String m13(username) => "${username} 更改了历史记录观察状态";

  static String m14(username, rules) => "${username} 更改了历史记录观察状态到：${rules}";

  static String m15(username) => "${username} 更改了加入的规则";

  static String m16(username, joinRules) =>
      "${username} 更改了加入的规则为：${joinRules}";

  static String m17(username) => "${username} 更改了头像";

  static String m18(username) => "${username} 更改了聊天室别名";

  static String m19(username) => "${username} 更改了邀请链接";

  static String m20(command) => "${command} 不是指令。";

  static String m21(error) => "不能解密消息:${error}";

  static String m22(count) => "${count} 个文件";

  static String m23(count) => "${count} 名参与者";

  static String m24(username) => "💬 ${username} 创建了聊天";

  static String m25(senderName) => "${senderName} 拥抱了你";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}-${month}-${day}";

  static String m28(month, day) => "${month}-${day}";

  static String m29(senderName) => "${senderName} 结束了通话";

  static String m30(error) => "取得地址错误: ${error}";

  static String m32(senderName) => "${senderName} 给你发送了“大眼”表情";

  static String m33(displayname) => "名称为${displayname}的群组";

  static String m34(username, targetName) =>
      "${username} 撤回了对 ${targetName} 的邀请";

  static String m35(senderName) => "${senderName} 搂抱了你";

  static String m36(groupName) => "邀请联系人到 ${groupName}";

  static String m37(username, link) =>
      "${username} 邀请您使用 FluffyChat。 \n1. 安装 FluffyChat：https://fluffychat.im \n2. 注册或登录 \n3. 打开该邀请链接：${link}";

  static String m38(username, targetName) => "📩 ${username} 邀请了 ${targetName}";

  static String m39(username) => "👋 ${username} 加入了聊天";

  static String m40(username, targetName) => "👞 ${username} 踢了 ${targetName}";

  static String m41(username, targetName) =>
      "🙅 ${username} 踢出 ${targetName} 并将其封禁";

  static String m42(localizedTimeShort) => "上次活跃: ${localizedTimeShort}";

  static String m43(count) => "加载 ${count} 个更多的参与者";

  static String m44(homeserver) => "登录 ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} 不是一个Matrix服务器,试试${server2}?";

  static String m46(number) => "${number} 个聊天";

  static String m47(count) => "${count} 人正在输入…";

  static String m48(fileName) => "播放 ${fileName}";

  static String m49(min) => "请至少输入 ${min} 个字符。";

  static String m50(sender, reaction) => "${sender} 通过 ${reaction} 进行了回应";

  static String m51(username) => "${username} 编辑了一个事件";

  static String m52(username) => "${username} 拒绝了邀请";

  static String m53(username) => "被${username}移除";

  static String m54(username) => "被 ${username} 看见";

  static String m55(username, count) =>
      "${Intl.plural(count, other: '被 ${username} 和 ${count} 个其他人看见')}";

  static String m56(username, username2) => "被 ${username} 和 ${username2} 看见";

  static String m57(username) => "📁${username} 发送了文件";

  static String m58(username) => "🖼️ ${username} 发送了图片";

  static String m59(username) => "😊 ${username} 发送了贴纸";

  static String m60(username) => "🎥 ${username} 发送了视频";

  static String m61(username) => "🎤${username} 发送了音频";

  static String m62(senderName) => "${senderName} 发送了通话信息";

  static String m63(username) => "${username} 分享了位置";

  static String m64(senderName) => "${senderName} 开始了通话";

  static String m65(date, body) => "自 ${date} 起的 Story: \n${body}";

  static String m66(mxid) => "应为 ${mxid}";

  static String m67(number) => "切换到账户 ${number}";

  static String m68(username, targetName) => "${username} 解封了 ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 unread chat', other: '${unreadCount} 个未读聊天')}";

  static String m70(username, count) => "${username} 和其他 ${count} 人正在输入…";

  static String m71(username, username2) => "${username} 和 ${username2} 正在输入…";

  static String m72(username) => "${username} 正在输入…";

  static String m73(username) => "🚪${username} 离开了聊天";

  static String m74(username, type) => "${username} 发送了一个 ${type} 事件";

  static String m75(size) => "视频 (${size})";

  static String m76(oldDisplayName) => "空聊天（曾是 ${oldDisplayName}）";

  static String m77(user) => "你封禁了 ${user}";

  static String m78(user) => "你撤回了对 ${user} 的邀请";

  static String m79(user) => "📩 你受到 ${user} 的邀请";

  static String m80(user) => "📩 你邀请了 ${user}";

  static String m81(user) => "👞你踢掉了 ${user}";

  static String m82(user) => "🙅你踢掉并封禁了 ${user}";

  static String m83(user) => "你解除了对 ${user} 的封禁";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "accept": MessageLookupByLibrary.simpleMessage("接受"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("账户"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("添加账户"),
        "addDescription": MessageLookupByLibrary.simpleMessage("添加描述"),
        "addEmail": MessageLookupByLibrary.simpleMessage("添加电子邮件"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage("添加一条群组介绍"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("添加到集合中"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("加入空间"),
        "addToSpaceDescription":
            MessageLookupByLibrary.simpleMessage("选择一个空间以添加此聊天。"),
        "addToStory": MessageLookupByLibrary.simpleMessage("添加到 Story"),
        "addWidget": MessageLookupByLibrary.simpleMessage("添加小部件"),
        "admin": MessageLookupByLibrary.simpleMessage("管理员"),
        "alias": MessageLookupByLibrary.simpleMessage("别名"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "allChats": MessageLookupByLibrary.simpleMessage("所有会话"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("所有空间"),
        "answeredTheCall": m2,
        "anyoneCanJoin": MessageLookupByLibrary.simpleMessage("任何人都可以加入"),
        "appLock": MessageLookupByLibrary.simpleMessage("应用锁"),
        "appearOnTop": MessageLookupByLibrary.simpleMessage("显示在其他应用上方"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "允许应用显示在顶部（如果你已经将 Fluffychat 设置为呼叫账户，则不需要授予此权限）"),
        "archive": MessageLookupByLibrary.simpleMessage("存档"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("是否允许游客加入"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("您确定吗？"),
        "areYouSureYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("您确定要注销吗？"),
        "askSSSSSign":
            MessageLookupByLibrary.simpleMessage("请输入您的安全存储的密码短语或恢复密钥，以向对方签名。"),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage("自动播放动态贴纸和表情"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("从对话中封禁"),
        "banned": MessageLookupByLibrary.simpleMessage("已被封禁"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("屏蔽设备"),
        "blocked": MessageLookupByLibrary.simpleMessage("已屏蔽"),
        "botMessages": MessageLookupByLibrary.simpleMessage("机器人消息"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("气泡大小"),
        "bundleName": MessageLookupByLibrary.simpleMessage("集合名称"),
        "callingAccount": MessageLookupByLibrary.simpleMessage("呼叫账户"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "允许 FluffyChat 使用本机 android 拨号器应用。"),
        "callingPermissions": MessageLookupByLibrary.simpleMessage("呼叫权限"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage("更改设备名称"),
        "changePassword": MessageLookupByLibrary.simpleMessage("更改密码"),
        "changeTheHomeserver": MessageLookupByLibrary.simpleMessage("更改主服务器"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("更改了群组名称"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("改变风格"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage("更改壁纸"),
        "changeYourAvatar": MessageLookupByLibrary.simpleMessage("更改您的头像"),
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
            MessageLookupByLibrary.simpleMessage("加密已被破坏"),
        "chat": MessageLookupByLibrary.simpleMessage("会话"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("聊天记录备份"),
        "chatBackupDescription":
            MessageLookupByLibrary.simpleMessage("您的旧信息受恢复密钥保护。请确保您不会丢失它。"),
        "chatDetails": MessageLookupByLibrary.simpleMessage("会话详情"),
        "chatHasBeenAddedToThisSpace":
            MessageLookupByLibrary.simpleMessage("会话已添加到此空间"),
        "chats": MessageLookupByLibrary.simpleMessage("聊天"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("输入一个强密码"),
        "chooseAUsername": MessageLookupByLibrary.simpleMessage("输入一个昵称"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("清除存档"),
        "close": MessageLookupByLibrary.simpleMessage("关闭"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage("在此聊天室封禁该用户"),
        "commandHint_clearcache": MessageLookupByLibrary.simpleMessage("清除缓存"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "创建空的群聊\n使用 --no-encryption 选项来禁用加密"),
        "commandHint_cuddle": MessageLookupByLibrary.simpleMessage("发送“拥抱”"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("丢弃会话"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "启动一对一聊天\n使用 --no-encryption 选项来禁用加密"),
        "commandHint_googly": MessageLookupByLibrary.simpleMessage("发送 一些“大眼”"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("发送 HTML 格式化文本"),
        "commandHint_hug": MessageLookupByLibrary.simpleMessage("发送“搂抱”"),
        "commandHint_invite":
            MessageLookupByLibrary.simpleMessage("邀请该用户加入此聊天室"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage("加入该聊天室"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage("将该用户移出此聊天室"),
        "commandHint_leave": MessageLookupByLibrary.simpleMessage("退出该聊天室"),
        "commandHint_markasdm":
            MessageLookupByLibrary.simpleMessage("标记为私信聊天室"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("标记为群组"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("介绍自己"),
        "commandHint_myroomavatar":
            MessageLookupByLibrary.simpleMessage("设置您的聊天室头像（通过 mxc-uri）"),
        "commandHint_myroomnick":
            MessageLookupByLibrary.simpleMessage("设置您的聊天室昵称"),
        "commandHint_op":
            MessageLookupByLibrary.simpleMessage("设置该用户的权限等级（默认：50）"),
        "commandHint_plain": MessageLookupByLibrary.simpleMessage("发送纯文本"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage("将回复作为响应发送"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("发送文本"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage("在此聊天室解封该用户"),
        "commandInvalid": MessageLookupByLibrary.simpleMessage("指令无效"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage("请比较表情符号"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage("请比较以下数字"),
        "configureChat": MessageLookupByLibrary.simpleMessage("配置聊天"),
        "confirm": MessageLookupByLibrary.simpleMessage("确认"),
        "confirmEventUnpin":
            MessageLookupByLibrary.simpleMessage("你确定要永久性取消置顶这一活动吗？"),
        "confirmMatrixId":
            MessageLookupByLibrary.simpleMessage("要删除账户，请确认你的 Matrix ID。"),
        "connect": MessageLookupByLibrary.simpleMessage("连接"),
        "contactHasBeenInvitedToTheGroup":
            MessageLookupByLibrary.simpleMessage("联系人已被邀请至群组"),
        "containsDisplayName": MessageLookupByLibrary.simpleMessage("包含显示名称"),
        "containsUserName": MessageLookupByLibrary.simpleMessage("包含用户名"),
        "contentHasBeenReported":
            MessageLookupByLibrary.simpleMessage("此内容已被报告至服务器管理员处"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage("已复制到剪贴板"),
        "copy": MessageLookupByLibrary.simpleMessage("复制"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage("复制到剪贴板"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("创建"),
        "createNewGroup": MessageLookupByLibrary.simpleMessage("创建新群组"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("创建新空间"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive": MessageLookupByLibrary.simpleMessage("目前活跃"),
        "custom": MessageLookupByLibrary.simpleMessage("自定义"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("深色"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning":
            MessageLookupByLibrary.simpleMessage("这将停用您的用户账户。这不能被撤销，您确定吗？"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("默认权限级别"),
        "dehydrate": MessageLookupByLibrary.simpleMessage("导出会话并擦除设备"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage("TOR 用户：导出会话"),
        "dehydrateTorLong":
            MessageLookupByLibrary.simpleMessage("建议 TOR 用户在关闭窗口之前导出会话。"),
        "dehydrateWarning":
            MessageLookupByLibrary.simpleMessage("此操作无法撤消。 确保你安全地存储备份文件。"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("删除账户"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("删除消息"),
        "deny": MessageLookupByLibrary.simpleMessage("否认"),
        "device": MessageLookupByLibrary.simpleMessage("设备"),
        "deviceId": MessageLookupByLibrary.simpleMessage("设备 ID"),
        "deviceKeys": MessageLookupByLibrary.simpleMessage("设备密钥："),
        "devices": MessageLookupByLibrary.simpleMessage("设备"),
        "directChats": MessageLookupByLibrary.simpleMessage("一对一聊天"),
        "disableEncryptionWarning":
            MessageLookupByLibrary.simpleMessage("出于安全考虑 ，您不能在之前已启用的对话中禁用加密。"),
        "discover": MessageLookupByLibrary.simpleMessage("探索"),
        "dismiss": MessageLookupByLibrary.simpleMessage("驳回"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("显示名称已被改变"),
        "doNotShowAgain": MessageLookupByLibrary.simpleMessage("不再显示"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("下载文件"),
        "edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage("编辑被阻止的服务器"),
        "editBundlesForAccount":
            MessageLookupByLibrary.simpleMessage("编辑该账户的集合"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage("编辑聊天权限"),
        "editDisplayname": MessageLookupByLibrary.simpleMessage("编辑显示名称"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage("编辑聊天室别名"),
        "editRoomAvatar": MessageLookupByLibrary.simpleMessage("编辑聊天室头像"),
        "editWidgets": MessageLookupByLibrary.simpleMessage("编辑小部件"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage("电子邮箱或用户名"),
        "emojis": MessageLookupByLibrary.simpleMessage("颜文字"),
        "emoteExists": MessageLookupByLibrary.simpleMessage("表情已存在！"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage("无效的表情快捷码！"),
        "emotePacks": MessageLookupByLibrary.simpleMessage("聊天室的表情包"),
        "emoteSettings": MessageLookupByLibrary.simpleMessage("表情设置"),
        "emoteShortcode": MessageLookupByLibrary.simpleMessage("表情快捷码"),
        "emoteWarnNeedToPick":
            MessageLookupByLibrary.simpleMessage("您需要选择一个表情快捷码和一张图片！"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("空聊天"),
        "enableEmotesGlobally":
            MessageLookupByLibrary.simpleMessage("在全局启用表情包"),
        "enableEncryption": MessageLookupByLibrary.simpleMessage("启用加密"),
        "enableEncryptionWarning":
            MessageLookupByLibrary.simpleMessage("您之后将无法停用加密，确定吗？"),
        "enableMultiAccounts":
            MessageLookupByLibrary.simpleMessage("（测试功能）在本设备上添加多个账户"),
        "encryptThisChat": MessageLookupByLibrary.simpleMessage("加密这个对话"),
        "encrypted": MessageLookupByLibrary.simpleMessage("加密的"),
        "encryption": MessageLookupByLibrary.simpleMessage("加密"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage("加密未启用"),
        "endToEndEncryption": MessageLookupByLibrary.simpleMessage("端对端加密"),
        "endedTheCall": m29,
        "enterAGroupName": MessageLookupByLibrary.simpleMessage("输入群组名称"),
        "enterASpacepName": MessageLookupByLibrary.simpleMessage("输入空间名称"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("输入一个电子邮件地址"),
        "enterRoom": MessageLookupByLibrary.simpleMessage("进入聊天室"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("进入空间"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("输入您的主服务器地址"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage("添加小部件出错。"),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("一切就绪！"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("实验性的视频通话"),
        "extremeOffensive": MessageLookupByLibrary.simpleMessage("令人极度反感"),
        "fileName": MessageLookupByLibrary.simpleMessage("文件名"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("字体大小"),
        "foregroundServiceRunning":
            MessageLookupByLibrary.simpleMessage("此通知在前台服务运行时出现。"),
        "forward": MessageLookupByLibrary.simpleMessage("转发"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("自加入起"),
        "fromTheInvitation": MessageLookupByLibrary.simpleMessage("自邀请起"),
        "goToTheNewRoom": MessageLookupByLibrary.simpleMessage("前往新的聊天室"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("群组"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("群组描述"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("群组描述已被更改"),
        "groupIsPublic": MessageLookupByLibrary.simpleMessage("群组是公开的"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("群组"),
        "guestsAreForbidden": MessageLookupByLibrary.simpleMessage("游客被禁止"),
        "guestsCanJoin": MessageLookupByLibrary.simpleMessage("游客可以加入"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("帮助"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage("隐藏编辑事件"),
        "hideUnimportantStateEvents":
            MessageLookupByLibrary.simpleMessage("隐藏不重要的状态事件"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage("隐藏未知事件"),
        "homeserver": MessageLookupByLibrary.simpleMessage("服务器"),
        "howOffensiveIsThisContent":
            MessageLookupByLibrary.simpleMessage("这些内容有多令人反感？"),
        "hugContent": m35,
        "hydrate": MessageLookupByLibrary.simpleMessage("从备份文件恢复"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage("TOR 用户：导入会话导出"),
        "hydrateTorLong":
            MessageLookupByLibrary.simpleMessage("你上次是否导出 TOR 会话？ 快速导入它并继续聊天。"),
        "iHaveClickedOnLink": MessageLookupByLibrary.simpleMessage("我已经点击了链接"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("我了解"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("身份"),
        "ignore": MessageLookupByLibrary.simpleMessage("忽略"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "您可以忽略打扰您的用户。您将不会收到来自忽略列表中用户的任何消息或聊天室邀请。"),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage("忽略用户名"),
        "ignoredUsers": MessageLookupByLibrary.simpleMessage("已忽略的用户"),
        "incorrectPassphraseOrKey":
            MessageLookupByLibrary.simpleMessage("不正确的密码短语或恢复密钥"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "遗憾的是，默认情况下未在私有模式下启用消息存储。\n请访问\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\n否则，无法运行 FluffyChat。"),
        "indexedDbErrorTitle": MessageLookupByLibrary.simpleMessage("私人模式问题"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("不令人反感"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("邀请联系人"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("来自我的邀请"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("已邀请"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage("仅被邀请用户"),
        "isTyping": MessageLookupByLibrary.simpleMessage("正在输入…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("加入聊天室"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("从聊天室踢出"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo": MessageLookupByLibrary.simpleMessage("很长时间未上线"),
        "leave": MessageLookupByLibrary.simpleMessage("离开"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("离开了聊天"),
        "license": MessageLookupByLibrary.simpleMessage("许可证"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("浅色"),
        "link": MessageLookupByLibrary.simpleMessage("链接"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("加载更多…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage("加载中…请等待。"),
        "locationDisabledNotice":
            MessageLookupByLibrary.simpleMessage("位置服务已禁用.请启用此服务以分享你的位置."),
        "locationPermissionDeniedNotice":
            MessageLookupByLibrary.simpleMessage("位置权限被拒绝.请授予此权限以分享你的位置."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("登录"),
        "loginWithOneClick": MessageLookupByLibrary.simpleMessage("一键登录"),
        "logout": MessageLookupByLibrary.simpleMessage("注销"),
        "makeSureTheIdentifierIsValid":
            MessageLookupByLibrary.simpleMessage("确保识别码正确"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("标为已读"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Matrix 小部件"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("成员变更"),
        "mention": MessageLookupByLibrary.simpleMessage("提到"),
        "messageInfo": MessageLookupByLibrary.simpleMessage("消息信息"),
        "messageType": MessageLookupByLibrary.simpleMessage("消息类型"),
        "messageWillBeRemovedWarning":
            MessageLookupByLibrary.simpleMessage("消息将对所有参与者移除"),
        "messages": MessageLookupByLibrary.simpleMessage("消息"),
        "moderator": MessageLookupByLibrary.simpleMessage("监管者"),
        "muteChat": MessageLookupByLibrary.simpleMessage("将该聊天静音"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "请注意当前您需要Pantalaimon以使用端到端加密功能。"),
        "newChat": MessageLookupByLibrary.simpleMessage("新的聊天"),
        "newGroup": MessageLookupByLibrary.simpleMessage("新群组"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("💬 FluffyChat 新消息"),
        "newSpace": MessageLookupByLibrary.simpleMessage("新空间"),
        "newSpaceDescription":
            MessageLookupByLibrary.simpleMessage("空间让您可以整合聊天并建立私人或公共讨论区。"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("新的验证请求！"),
        "next": MessageLookupByLibrary.simpleMessage("下一步"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("下个账户"),
        "no": MessageLookupByLibrary.simpleMessage("不"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("未与服务器建立连接"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "请输入有效电子邮件地址。否则你将无法重置密码。如果你不想输入邮件地址，再次轻点按钮以继续。"),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage("未找到表情。😕"),
        "noEncryptionForPublicRooms":
            MessageLookupByLibrary.simpleMessage("您只能在聊天室不可被公众访问时才能启用加密。"),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "看起来您手机上没有谷歌服务框架。这对保护您的隐私而言是个好决定！要接收 FluffyChat 的推送通知，推荐您使用 https://microg.org/ 或 https://unifiedpush.org/。"),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "如果消息是在你在此设备上登录账户前发送的，就可能发生这种情况。\n\n也有可能是发送者屏蔽了你的设备或网络连接出了问题。\n\n你能在另一个会话中读取消息吗？如果是的话，你可以从它那里传递信息！点击设置 > 设备，并确保你的设备已经相互验证。当你下次打开聊天室，且两个会话都在前台，密钥就会自动传输。\n\n你不想在注销或切换设备时丢失密钥？请确保在设置中启用了聊天备份。"),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription":
            MessageLookupByLibrary.simpleMessage("您尚未添加恢复密码的方法。"),
        "noPermission": MessageLookupByLibrary.simpleMessage("没有权限"),
        "noRoomsFound": MessageLookupByLibrary.simpleMessage("未找到聊天室…"),
        "none": MessageLookupByLibrary.simpleMessage("无"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage("已为此账户启用通知"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation": MessageLookupByLibrary.simpleMessage("获取位置中…"),
        "offensive": MessageLookupByLibrary.simpleMessage("令人反感"),
        "offline": MessageLookupByLibrary.simpleMessage("离线"),
        "ok": MessageLookupByLibrary.simpleMessage("好"),
        "oneClientLoggedOut":
            MessageLookupByLibrary.simpleMessage("您的一个客户端已登出"),
        "online": MessageLookupByLibrary.simpleMessage("在线"),
        "onlineKeyBackupEnabled":
            MessageLookupByLibrary.simpleMessage("在线密钥备份已启用"),
        "oopsPushError":
            MessageLookupByLibrary.simpleMessage("哎呀！十分不幸，配置推送通知时发生了错误。"),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("哎呀，出了点差错…"),
        "openAppToReadMessages":
            MessageLookupByLibrary.simpleMessage("打开应用以查看消息"),
        "openCamera": MessageLookupByLibrary.simpleMessage("打开相机"),
        "openChat": MessageLookupByLibrary.simpleMessage("打开聊天"),
        "openGallery": MessageLookupByLibrary.simpleMessage("打开图库"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("在地图中打开"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage("打开相机拍摄视频"),
        "optionalGroupName": MessageLookupByLibrary.simpleMessage("(可选) 群组名称"),
        "or": MessageLookupByLibrary.simpleMessage("或"),
        "otherCallingPermissions":
            MessageLookupByLibrary.simpleMessage("麦克风、摄像头和其他 FluffyChat 权限"),
        "participant": MessageLookupByLibrary.simpleMessage("参与者"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage("密码短语或恢复密钥"),
        "password": MessageLookupByLibrary.simpleMessage("密码"),
        "passwordForgotten": MessageLookupByLibrary.simpleMessage("忘记密码"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("密码已被更改"),
        "passwordRecovery": MessageLookupByLibrary.simpleMessage("密码恢复"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage("密码不匹配！"),
        "people": MessageLookupByLibrary.simpleMessage("联系人"),
        "pickImage": MessageLookupByLibrary.simpleMessage("选择图像"),
        "pin": MessageLookupByLibrary.simpleMessage("固定"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("置顶到聊天室"),
        "placeCall": MessageLookupByLibrary.simpleMessage("打电话"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("请选择"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("请选择一个密码"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage("请选择用户名"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink":
            MessageLookupByLibrary.simpleMessage("请点击电子邮件中的链接，然后继续。"),
        "pleaseEnter4Digits":
            MessageLookupByLibrary.simpleMessage("请输入 4 位数字或留空以停用应用锁。"),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("请输入 Matrix ID。"),
        "pleaseEnterRecoveryKey":
            MessageLookupByLibrary.simpleMessage("请输入你的恢复密钥："),
        "pleaseEnterRecoveryKeyDescription":
            MessageLookupByLibrary.simpleMessage(
                "要解锁您的旧邮件，请输入你在之前会话中生成的恢复密钥。 你的恢复密钥不是你的密码。"),
        "pleaseEnterValidEmail":
            MessageLookupByLibrary.simpleMessage("请输入一个有效的电子邮件地址。"),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("请输入您的密码"),
        "pleaseEnterYourPin": MessageLookupByLibrary.simpleMessage("请输入您的 PIN"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("请输入您的用户名"),
        "pleaseFollowInstructionsOnWeb":
            MessageLookupByLibrary.simpleMessage("请按照网站上的提示，点击下一步。"),
        "previousAccount": MessageLookupByLibrary.simpleMessage("上个账户"),
        "privacy": MessageLookupByLibrary.simpleMessage("隐私"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("公开聊天室"),
        "publish": MessageLookupByLibrary.simpleMessage("发布"),
        "pushRules": MessageLookupByLibrary.simpleMessage("推送规则"),
        "reactedWith": m50,
        "reason": MessageLookupByLibrary.simpleMessage("原因"),
        "recording": MessageLookupByLibrary.simpleMessage("录制"),
        "recoveryKey": MessageLookupByLibrary.simpleMessage("恢复密钥"),
        "recoveryKeyLost": MessageLookupByLibrary.simpleMessage("丢失了恢复密钥？"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("重新编辑信息"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("注册"),
        "reject": MessageLookupByLibrary.simpleMessage("拒绝"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("重新加入"),
        "remove": MessageLookupByLibrary.simpleMessage("移除"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("移除其他全部设备"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("移除设备"),
        "removeFromBundle": MessageLookupByLibrary.simpleMessage("从此集合中移除"),
        "removeFromSpace": MessageLookupByLibrary.simpleMessage("从空间删除"),
        "removeYourAvatar": MessageLookupByLibrary.simpleMessage("移除您的头像"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage("渲染富文本内容"),
        "repeatPassword": MessageLookupByLibrary.simpleMessage("再次输入密码"),
        "replaceRoomWithNewerVersion":
            MessageLookupByLibrary.simpleMessage("用较新的版本替换聊天室"),
        "reply": MessageLookupByLibrary.simpleMessage("回复"),
        "replyHasBeenSent": MessageLookupByLibrary.simpleMessage("已发送回复"),
        "report": MessageLookupByLibrary.simpleMessage("举报"),
        "reportMessage": MessageLookupByLibrary.simpleMessage("举报信息"),
        "reportUser": MessageLookupByLibrary.simpleMessage("举报用户"),
        "requestPermission": MessageLookupByLibrary.simpleMessage("请求权限"),
        "roomHasBeenUpgraded": MessageLookupByLibrary.simpleMessage("聊天室已升级"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("聊天室版本"),
        "saveFile": MessageLookupByLibrary.simpleMessage("保存文件"),
        "saveKeyManuallyDescription":
            MessageLookupByLibrary.simpleMessage("通过触发系统共享对话框或剪贴板手动保存此密钥。"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("扫描二维码"),
        "screenSharingDetail":
            MessageLookupByLibrary.simpleMessage("你正在 FluffyChat 共享屏幕"),
        "screenSharingTitle": MessageLookupByLibrary.simpleMessage("屏幕共享"),
        "search": MessageLookupByLibrary.simpleMessage("搜索"),
        "security": MessageLookupByLibrary.simpleMessage("安全"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("发送"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("发送一条消息"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("以文本发送"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("发送音频"),
        "sendFile": MessageLookupByLibrary.simpleMessage("发送文件"),
        "sendImage": MessageLookupByLibrary.simpleMessage("发送图像"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("发送消息"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("按 Enter 键发送"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("发送原图"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("发送贴纸"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("发送视频"),
        "sender": MessageLookupByLibrary.simpleMessage("发送者"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage("分开私聊和群组"),
        "serverRequiresEmail":
            MessageLookupByLibrary.simpleMessage("此服务器需要验证您的电子邮件地址以进行注册。"),
        "setAsCanonicalAlias": MessageLookupByLibrary.simpleMessage("设为主要别名"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage("设置自定义表情"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage("设置群组描述"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage("设置邀请链接"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage("设置权限级别"),
        "setStatus": MessageLookupByLibrary.simpleMessage("设置状态"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "share": MessageLookupByLibrary.simpleMessage("分享"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("分享位置"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage("分享您的邀请链接"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces":
            MessageLookupByLibrary.simpleMessage("在空间中显示相关私聊"),
        "showPassword": MessageLookupByLibrary.simpleMessage("显示密码"),
        "signUp": MessageLookupByLibrary.simpleMessage("注册"),
        "singlesignon": MessageLookupByLibrary.simpleMessage("单点登录"),
        "skip": MessageLookupByLibrary.simpleMessage("跳过"),
        "sorryThatsNotPossible":
            MessageLookupByLibrary.simpleMessage("非常抱歉……这是做不到的"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("源代码"),
        "spaceIsPublic": MessageLookupByLibrary.simpleMessage("空间是公开的"),
        "spaceName": MessageLookupByLibrary.simpleMessage("空间名称"),
        "start": MessageLookupByLibrary.simpleMessage("开始"),
        "startFirstChat": MessageLookupByLibrary.simpleMessage("发起你的第一个聊天"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("状态"),
        "statusExampleMessage": MessageLookupByLibrary.simpleMessage("您今天怎么样？"),
        "storeInAndroidKeystore":
            MessageLookupByLibrary.simpleMessage("存储在 Android KeyStore 中"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("存储在 Apple KeyChain 中"),
        "storeInSecureStorageDescription":
            MessageLookupByLibrary.simpleMessage("将恢复密钥存储在此设备的安全存储中。"),
        "storeSecurlyOnThisDevice":
            MessageLookupByLibrary.simpleMessage("安全地存储在此设备上"),
        "stories": MessageLookupByLibrary.simpleMessage("故事"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "请注意，人们可以在你的 Story 中看到和联系彼此。您的故事在 24 小时内可见，但不能保证它们将从所有设备和服务器上删除。"),
        "submit": MessageLookupByLibrary.simpleMessage("提交"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait":
            MessageLookupByLibrary.simpleMessage("同步中…请等待。"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("系统"),
        "theyDontMatch": MessageLookupByLibrary.simpleMessage("它们不匹配"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("它们匹配"),
        "thisUserHasNotPostedAnythingYet":
            MessageLookupByLibrary.simpleMessage("该用户尚未在 Story 发布任何内容"),
        "time": MessageLookupByLibrary.simpleMessage("时间"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite": MessageLookupByLibrary.simpleMessage("切换收藏"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage("切换静音"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage("标记已读/未读"),
        "tooManyRequestsWarning":
            MessageLookupByLibrary.simpleMessage("请求太多。请稍后再试！"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("从其他设备传输"),
        "tryToSendAgain": MessageLookupByLibrary.simpleMessage("尝试重新发送"),
        "unavailable": MessageLookupByLibrary.simpleMessage("不可用"),
        "unbanFromChat": MessageLookupByLibrary.simpleMessage("解禁聊天"),
        "unbannedUser": m68,
        "unblockDevice": MessageLookupByLibrary.simpleMessage("解锁设备"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("未知设备"),
        "unknownEncryptionAlgorithm":
            MessageLookupByLibrary.simpleMessage("未知加密算法"),
        "unlockOldMessages": MessageLookupByLibrary.simpleMessage("解锁旧信息"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage("解除聊天的静音"),
        "unpin": MessageLookupByLibrary.simpleMessage("取消固定"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("取消 Story 订阅"),
        "unsupportedAndroidVersion":
            MessageLookupByLibrary.simpleMessage("不受支持的 Android 版本"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "这个功能需要较新版本的 Android 系统。请检查更新或 Lineage OS 支持。"),
        "unverified": MessageLookupByLibrary.simpleMessage("未认证"),
        "updateAvailable":
            MessageLookupByLibrary.simpleMessage("FluffyChat 更新可用"),
        "updateNow": MessageLookupByLibrary.simpleMessage("在后台开始更新"),
        "user": MessageLookupByLibrary.simpleMessage("用户"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("用户名"),
        "users": MessageLookupByLibrary.simpleMessage("用户"),
        "verified": MessageLookupByLibrary.simpleMessage("已验证"),
        "verify": MessageLookupByLibrary.simpleMessage("验证"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("开始验证"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage("您已成功验证！"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage("验证其他账户"),
        "videoCall": MessageLookupByLibrary.simpleMessage("视频通话"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "请注意，视频通话目前处于测试阶段。它们可能不能像预期的那样工作，或者在所有平台上都不能工作。"),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("聊天记录的可见性"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("对所有参与者可见"),
        "visibleForEveryone": MessageLookupByLibrary.simpleMessage("对所有人可见"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("语音通话"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("语音消息"),
        "waitingPartnerAcceptRequest":
            MessageLookupByLibrary.simpleMessage("等待对方接受请求…"),
        "waitingPartnerEmoji":
            MessageLookupByLibrary.simpleMessage("等待对方接受 emoji…"),
        "waitingPartnerNumbers":
            MessageLookupByLibrary.simpleMessage("等待对方接受数字…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("壁纸"),
        "warning": MessageLookupByLibrary.simpleMessage("警告！"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("我们向您发送了一封电子邮件"),
        "whatIsGoingOn": MessageLookupByLibrary.simpleMessage("发生什么事了？"),
        "whoCanPerformWhichAction":
            MessageLookupByLibrary.simpleMessage("谁可以执行哪些操作"),
        "whoCanSeeMyStories":
            MessageLookupByLibrary.simpleMessage("谁能看到我的 Story？"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "请注意，人们可以在你的 Story 中看到彼此并相互联系。"),
        "whoIsAllowedToJoinThisGroup":
            MessageLookupByLibrary.simpleMessage("谁被允许加入本群组"),
        "whyDoYouWantToReportThis":
            MessageLookupByLibrary.simpleMessage("您举报的理由是什么？"),
        "whyIsThisMessageEncrypted":
            MessageLookupByLibrary.simpleMessage("为什么此消息不可读？"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("自定义"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("文本笔记"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("名称"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage("请提供显示名称。"),
        "widgetUrlError": MessageLookupByLibrary.simpleMessage("这不是有效的 URL。"),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("视频"),
        "wipeChatBackup":
            MessageLookupByLibrary.simpleMessage("确定要清除您的聊天记录备份以创建新的恢复密钥吗？"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage("通过这些地址，您可以恢复密码。"),
        "writeAMessage": MessageLookupByLibrary.simpleMessage("写一条消息…"),
        "yes": MessageLookupByLibrary.simpleMessage("是"),
        "you": MessageLookupByLibrary.simpleMessage("您"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("👍 你接受了邀请"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("您被邀请到该聊天"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage("您已不再参与此聊天"),
        "youBannedUser": m77,
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("您不能邀请您自己"),
        "youHaveBeenBannedFromThisChat":
            MessageLookupByLibrary.simpleMessage("您已被该聊天封禁"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat": MessageLookupByLibrary.simpleMessage("你加入了聊天"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("你拒绝了邀请"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp":
            MessageLookupByLibrary.simpleMessage("您的聊天记录备份已设置。"),
        "yourPublicKey": MessageLookupByLibrary.simpleMessage("您的公钥"),
        "yourStory": MessageLookupByLibrary.simpleMessage("你的 Story")
      };
}
