// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(username) => "👍${username}が招待を承諾しました";

  static String m1(username) => "🔐${username}がエンドツーエンド暗号化を有効にしました";

  static String m2(senderName) => "${senderName}は通話に出ました";

  static String m3(username) => "${username}の検証リクエストを承認しますか？";

  static String m4(username, targetName) => "${username}が${targetName}をBANしました";

  static String m5(uri) => "URIが開けません ${uri}";

  static String m6(username) => "${username}がチャットアバターを変更しました";

  static String m7(username, description) =>
      "${username}がチャットの説明を「${description}」に変更しました";

  static String m8(username, chatname) =>
      "${username}がチャットの名前を「${chatname}」に変更しました";

  static String m9(username) => "${username}がチャットの権限を変更しました";

  static String m10(username, displayname) =>
      "${username}が表示名を「${displayname}」に変更しました";

  static String m11(username) => "${username}がゲストのアクセスルールを変更しました";

  static String m12(username, rules) =>
      "${username}がゲストのアクセスルールを${rules}に変更しました";

  static String m13(username) => "${username}が履歴の表示設定を変更しました";

  static String m14(username, rules) => "${username}が履歴の表示設定を${rules}に変更しました";

  static String m15(username) => "${username}が参加ルールを変更しました";

  static String m16(username, joinRules) =>
      "${username}が参加ルールを${joinRules}に変更しました";

  static String m17(username) => "${username}がアバターを変更しました";

  static String m18(username) => "${username}が部屋のエイリアスを変更しました";

  static String m19(username) => "${username}が招待リンクを変更しました";

  static String m20(command) => "${command} はコマンドではありません。";

  static String m21(error) => "メッセージを解読できませんでした: ${error}";

  static String m22(count) => "${count}個のファイル";

  static String m23(count) => "${count}名の参加者";

  static String m24(username) => "💬 ${username}がチャットを作成しました";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}/${month}/${day}";

  static String m28(month, day) => "${month}-${day}";

  static String m29(senderName) => "${senderName}は通話を切断しました";

  static String m30(error) => "位置情報の取得中にエラーが発生しました: ${error}";

  static String m33(displayname) => "${displayname}とグループを作成する";

  static String m34(username, targetName) =>
      "${targetName}の招待を${username}が取り下げました";

  static String m36(groupName) => "連絡先から${groupName}に招待する";

  static String m37(username, link) =>
      "${username}がFluffyChatにあなたを招待しました. \n1. FluffyChatをインストールしてください: https://fluffychat.im \n2. 新しくアカウントを作成するかサインインしてください\n3. 招待リンクを開いてください: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} が ${targetName} を招待しました";

  static String m39(username) => "👋 ${username} がチャットに参加しました";

  static String m40(username, targetName) =>
      "👞 ${username} は ${targetName} をキックしました";

  static String m41(username, targetName) =>
      "🙅 ${username} が ${targetName} をキックしブロックしました";

  static String m42(localizedTimeShort) => "最終アクティブ: ${localizedTimeShort}";

  static String m43(count) => "あと${count}名参加者を読み込む";

  static String m44(homeserver) => "${homeserver}にログインする";

  static String m45(server1, server2) =>
      "${server1} はMatrixのサーバーではありません。代わりに ${server2} を使用しますか?";

  static String m46(number) => "${number} チャット";

  static String m47(count) => "${count}人が入力中…";

  static String m48(fileName) => "${fileName}を再生する";

  static String m49(min) => "少なくとも${min}文字を選択してください。";

  static String m50(sender, reaction) => "${sender} が ${reaction} で反応しました";

  static String m51(username) => "${username}がイベントを編集しました";

  static String m52(username) => "${username}は招待を拒否しました";

  static String m53(username) => "${username}によって削除されました";

  static String m54(username) => "${username}が既読";

  static String m55(username, count) => "${username}と他${count}人が閲覧しました";

  static String m56(username, username2) => "${username}と${username2}が既読";

  static String m57(username) => "📁 ${username}はファイルを送信しました";

  static String m58(username) => "🖼️ ${username}は画像を送信しました";

  static String m59(username) => "😊 ${username}はステッカーを送信しました";

  static String m60(username) => "🎥 ${username}は動画を送信しました";

  static String m61(username) => "🎤 ${username}は音声を送信しました";

  static String m62(senderName) => "${senderName}は通話情報を送信しました";

  static String m63(username) => "${username}は現在地を共有しました";

  static String m64(senderName) => "${senderName}は通話を開始しました";

  static String m65(date, body) => "${date}からのストーリー:\n${body}";

  static String m67(number) => "アカウント ${number} に切り替える";

  static String m68(username, targetName) =>
      "${username}が${targetName}のBANを解除しました";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1件の未読メッセージ', other: '${unreadCount}件の未読メッセージ')}";

  static String m70(username, count) => "${username}と他${count}名が入力しています…";

  static String m71(username, username2) => "${username}と${username2}が入力しています…";

  static String m72(username) => "${username}が入力しています…";

  static String m73(username) => "🚪 ${username}はチャットから退室しました";

  static String m74(username, type) => "${username}は${type}イベントを送信しました";

  static String m75(size) => "ビデオ (${size})";

  static String m76(oldDisplayName) => "空のチャット (以前は ${oldDisplayName})";

  static String m77(user) => "${user} を禁止しました";

  static String m78(user) => "${user} への招待を取り下げました";

  static String m79(user) => "📩 ${user} から招待されました";

  static String m80(user) => "📩 ${user} を招待しました";

  static String m81(user) => "👞 ${user} をキックしました";

  static String m82(user) => "🙅 ${user} をキックしてブロックしました";

  static String m83(user) => "${user} の禁止を解除しました";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("このアプリについて"),
        "accept": MessageLookupByLibrary.simpleMessage("承諾する"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("アカウント"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("アカウントを追加"),
        "addDescription": MessageLookupByLibrary.simpleMessage("説明を追加"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Eメールを追加"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("グループの説明を追加する"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("バンドルに追加"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("スペースに追加"),
        "addToSpaceDescription":
            MessageLookupByLibrary.simpleMessage("このチャットを追加するスペースを選択してください。"),
        "addToStory": MessageLookupByLibrary.simpleMessage("ストーリーに追加"),
        "addWidget": MessageLookupByLibrary.simpleMessage("ウィジェットを追加"),
        "admin": MessageLookupByLibrary.simpleMessage("管理者"),
        "alias": MessageLookupByLibrary.simpleMessage("エイリアス"),
        "all": MessageLookupByLibrary.simpleMessage("すべて"),
        "allChats": MessageLookupByLibrary.simpleMessage("すべて会話"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("すべてのスペース"),
        "answeredTheCall": m2,
        "anyoneCanJoin": MessageLookupByLibrary.simpleMessage("誰でも参加できる"),
        "appLock": MessageLookupByLibrary.simpleMessage("アプリのロック"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "アプリをトップに表示できるようにする（すでに通話アカウントとしてFluffychatを設定している場合は必要ありません）"),
        "archive": MessageLookupByLibrary.simpleMessage("アーカイブ"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("ゲストユーザーの参加を許可する"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("これでよろしいですか？"),
        "areYouSureYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("ログアウトしてよろしいですか？"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "他の人を署名するためにはパスフレーズやリカバリーキーを入力してください。"),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage("GIFを自動的に再生する"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("チャットからBANする"),
        "banned": MessageLookupByLibrary.simpleMessage("BANされています"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("デバイスをブロックする"),
        "blocked": MessageLookupByLibrary.simpleMessage("ブロックしました"),
        "botMessages": MessageLookupByLibrary.simpleMessage("ボットメッセージ"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("ふきだしの大きさ"),
        "bundleName": MessageLookupByLibrary.simpleMessage("バンドル名"),
        "callingAccount": MessageLookupByLibrary.simpleMessage("通話アカウント"),
        "callingPermissions": MessageLookupByLibrary.simpleMessage("通話の権限"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage("デバイス名を変更"),
        "changePassword": MessageLookupByLibrary.simpleMessage("パスワードを変更"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("ホームサーバーの変更"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("グループの名前を変更する"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("スタイルを変更する"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage("壁紙を変更する"),
        "changeYourAvatar": MessageLookupByLibrary.simpleMessage("アバタるを変化しする"),
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
            MessageLookupByLibrary.simpleMessage("暗号が破損しています"),
        "chat": MessageLookupByLibrary.simpleMessage("チャット"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("チャットのバックアップ"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "古いメッセージはリカバリーキーで保護されます。紛失しないようにご注意ください。"),
        "chatDetails": MessageLookupByLibrary.simpleMessage("チャットの詳細"),
        "chatHasBeenAddedToThisSpace":
            MessageLookupByLibrary.simpleMessage("このスペースにチャットが追加されました"),
        "chats": MessageLookupByLibrary.simpleMessage("チャット"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("強いパスワードを選択してください"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("ユーザー名を選択してください"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("アーカイブを消去"),
        "close": MessageLookupByLibrary.simpleMessage("閉じる"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage("このユーザーを禁止する"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("キャッシュをクリアする"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "空のグループチャットを作成\n暗号化を無効にするには、--no-encryption を使用"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("セッションを破棄"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "ダイレクトチャットを開始する\n暗号化を無効にするには、--no-encryptionを使用してください"),
        "commandHint_googly": MessageLookupByLibrary.simpleMessage("ぎょろ目を送る"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("HTML形式のテキストを送信"),
        "commandHint_hug": MessageLookupByLibrary.simpleMessage("ハグを送る"),
        "commandHint_invite":
            MessageLookupByLibrary.simpleMessage("指定したユーザーをこの部屋に招待"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage("指定した部屋に参加"),
        "commandHint_leave": MessageLookupByLibrary.simpleMessage("この部屋を退出"),
        "commandHint_markasdm":
            MessageLookupByLibrary.simpleMessage("ダイレクトメッセージの部屋としてマークする"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("グループとしてマーク"),
        "commandHint_myroomavatar":
            MessageLookupByLibrary.simpleMessage("この部屋の写真を設定する (mxc-uriで)"),
        "commandHint_myroomnick":
            MessageLookupByLibrary.simpleMessage("この部屋の表示名を設定する"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("書式設定されていないテキストを送信する"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("リアクションとして返信を送信する"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("テキストを送信"),
        "commandInvalid": MessageLookupByLibrary.simpleMessage("コマンドが無効"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "表示されている絵文字が他のデバイスで表示されているものと一致するか確認してください:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "表示されている数字が他のデバイスで表示されているものと一致するか確認してください:"),
        "configureChat": MessageLookupByLibrary.simpleMessage("チャットの設定"),
        "confirm": MessageLookupByLibrary.simpleMessage("確認"),
        "confirmEventUnpin":
            MessageLookupByLibrary.simpleMessage("イベントの固定を完全に解除してもよろしいですか？"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "アカウントを削除するには、Matrix IDを確認してください。"),
        "connect": MessageLookupByLibrary.simpleMessage("接続"),
        "contactHasBeenInvitedToTheGroup":
            MessageLookupByLibrary.simpleMessage("連絡先に登録された人が招待されました"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("表示名を含んでいます"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("ユーザー名を含んでいます"),
        "contentHasBeenReported":
            MessageLookupByLibrary.simpleMessage("サーバー管理者に通報されました"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("クリップボードにコピーされました"),
        "copy": MessageLookupByLibrary.simpleMessage("コピー"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage("クリップボードにコピー"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("作成"),
        "createNewGroup": MessageLookupByLibrary.simpleMessage("グループを作成する"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("新しいスペース"),
        "createdTheChat": m24,
        "currentlyActive": MessageLookupByLibrary.simpleMessage("現在アクティブです"),
        "custom": MessageLookupByLibrary.simpleMessage("カスタム"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("ダーク"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "あなたのアカウントを無効化します。この操作は元に戻せません！よろしいですか？"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("デフォルトの権限レベル"),
        "dehydrate":
            MessageLookupByLibrary.simpleMessage("セッションのエクスポートとデバイスの消去"),
        "dehydrateTor":
            MessageLookupByLibrary.simpleMessage("TOR ユーザー: セッションをエクスポート"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "TOR ユーザーの場合、ウィンドウを閉じる前にセッションをエクスポートすることをお勧めします。"),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "この操作は元に戻せません。バックアップファイルを安全に保存してください。"),
        "delete": MessageLookupByLibrary.simpleMessage("削除"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("アカウントの削除"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("メッセージの削除"),
        "deny": MessageLookupByLibrary.simpleMessage("拒否"),
        "device": MessageLookupByLibrary.simpleMessage("デバイス"),
        "deviceId": MessageLookupByLibrary.simpleMessage("デバイスID"),
        "deviceKeys": MessageLookupByLibrary.simpleMessage("デバイスキー:"),
        "devices": MessageLookupByLibrary.simpleMessage("デバイス"),
        "directChats": MessageLookupByLibrary.simpleMessage("ダイレクトチャット"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "セキュリティ上の理由から、以前は暗号化が有効だったチャットで暗号化を無効にすることはできません。"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("表示名が変更されました"),
        "doNotShowAgain": MessageLookupByLibrary.simpleMessage("今後表示しない"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("ファイルのダウンロード"),
        "edit": MessageLookupByLibrary.simpleMessage("編集"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("ブロックしたサーバーを編集"),
        "editBundlesForAccount":
            MessageLookupByLibrary.simpleMessage("このアカウントのバンドルを編集"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("チャット権限の変更"),
        "editDisplayname": MessageLookupByLibrary.simpleMessage("表示名を編集"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage("ルームエイリアスを編集"),
        "editRoomAvatar": MessageLookupByLibrary.simpleMessage("部屋のアバターを編集する"),
        "editWidgets": MessageLookupByLibrary.simpleMessage("ウィジェットを編集"),
        "emailOrUsername":
            MessageLookupByLibrary.simpleMessage("メールアドレスまたはユーザー名"),
        "emojis": MessageLookupByLibrary.simpleMessage("絵文字"),
        "emoteExists": MessageLookupByLibrary.simpleMessage("Emoteはすでに存在します！"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("不正なEmoteショートコード！"),
        "emotePacks": MessageLookupByLibrary.simpleMessage("部屋のEmoteパック"),
        "emoteSettings": MessageLookupByLibrary.simpleMessage("Emote設定"),
        "emoteShortcode": MessageLookupByLibrary.simpleMessage("Emoteショートコード"),
        "emoteWarnNeedToPick":
            MessageLookupByLibrary.simpleMessage("Emoteショートコードと画像を選択してください！"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("空のチャット"),
        "enableEmotesGlobally":
            MessageLookupByLibrary.simpleMessage("emoteをグローバルに有効にする"),
        "enableEncryption": MessageLookupByLibrary.simpleMessage("暗号化を有効にする"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "一度暗号化を有効にするともとに戻せません。よろしいですか？"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(ベータ版) このデバイスで複数のアカウントを有効にする"),
        "encryptThisChat": MessageLookupByLibrary.simpleMessage("このチャットを暗号化する"),
        "encrypted": MessageLookupByLibrary.simpleMessage("暗号化"),
        "encryption": MessageLookupByLibrary.simpleMessage("暗号化"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("暗号化されていません"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("エンドツーエンド暗号化"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("グループ名を入力してください"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("スペース名を入力してください"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("メールアドレスを入力してください"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "招待リンクまたはMatrixのIDを入力してください..."),
        "enterRoom": MessageLookupByLibrary.simpleMessage("部屋に入る"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("スペースに入る"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("ホームサーバーを入力してください"),
        "errorAddingWidget":
            MessageLookupByLibrary.simpleMessage("ウィジェットの追加中にエラーが発生しました。"),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("すべての準備は完了しました！"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("実験的なビデオ通話"),
        "extremeOffensive": MessageLookupByLibrary.simpleMessage("とても攻撃的"),
        "fileName": MessageLookupByLibrary.simpleMessage("ファイル名"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("フォントサイズ"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "この通知は、フォアグラウンド サービスの実行中に表示されます。"),
        "forward": MessageLookupByLibrary.simpleMessage("進む"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("参加時点から閲覧可能"),
        "fromTheInvitation": MessageLookupByLibrary.simpleMessage("招待時点から閲覧可能"),
        "goToTheNewRoom": MessageLookupByLibrary.simpleMessage("新規ルームへ"),
        "group": MessageLookupByLibrary.simpleMessage("グループ"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("グループの説明"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("グループの説明が変更されました"),
        "groupIsPublic": MessageLookupByLibrary.simpleMessage("グループは公開されています"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("グループ"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("ゲストは許可されていません"),
        "guestsCanJoin": MessageLookupByLibrary.simpleMessage("ゲストが許可されています"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("ヘルプ"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("編集済みイベントを非表示にする"),
        "hideUnimportantStateEvents":
            MessageLookupByLibrary.simpleMessage("重要でない状態イベントを非表示にする"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("不明なイベントを非表示にする"),
        "homeserver": MessageLookupByLibrary.simpleMessage("ホームサーバー"),
        "howOffensiveIsThisContent":
            MessageLookupByLibrary.simpleMessage("どのくらい攻撃的でしたか？"),
        "hydrate": MessageLookupByLibrary.simpleMessage("バックアップファイルから復元"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR ユーザー: セッションのエクスポートをインポート"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "前回、TOR でセッションをエクスポートしましたか？すぐにインポートしてチャットを続けましょう。"),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("リンクをクリックしました"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("わかりました"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("アイデンティティ"),
        "ignore": MessageLookupByLibrary.simpleMessage("無視する"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "ユーザーは無視することができます。無視したユーザーからのメッセージやルームの招待は受け取れません。"),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage("ユーザー名を無視する"),
        "ignoredUsers": MessageLookupByLibrary.simpleMessage("無視されたユーザー"),
        "incorrectPassphraseOrKey":
            MessageLookupByLibrary.simpleMessage("パスフレーズかリカバリーキーが間違っています"),
        "indexedDbErrorTitle":
            MessageLookupByLibrary.simpleMessage("プライベートモードに関する問題"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("非攻撃的"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("連絡先から招待する"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("自分への招待"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("招待されました"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage("招待されたユーザーのみ"),
        "isTyping": MessageLookupByLibrary.simpleMessage("が入力しています…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("部屋に参加"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("チャットからキックする"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo": MessageLookupByLibrary.simpleMessage("ずいぶん前"),
        "leave": MessageLookupByLibrary.simpleMessage("退室する"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("退室しました"),
        "letsStart": MessageLookupByLibrary.simpleMessage("始めましょう"),
        "license": MessageLookupByLibrary.simpleMessage("ライセンス"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("ライト"),
        "link": MessageLookupByLibrary.simpleMessage("リンク"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("更に読み込む…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("読み込み中…お待ちください。"),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "位置情報サービスが無効になっています。位置情報を共有できるようにするには、位置情報サービスを有効にしてください。"),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "位置情報の権限が拒否されました。位置情報を共有できるように許可してください。"),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("ログイン"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("ワンクリックでサインイン"),
        "logout": MessageLookupByLibrary.simpleMessage("ログアウト"),
        "makeSureTheIdentifierIsValid":
            MessageLookupByLibrary.simpleMessage("識別子が正しいか確認してください"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("既読にする"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Matrixのウィジェット"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("メンバーの変更"),
        "mention": MessageLookupByLibrary.simpleMessage("メンション"),
        "messageInfo": MessageLookupByLibrary.simpleMessage("メッセージの情報"),
        "messageType": MessageLookupByLibrary.simpleMessage("メッセージの種類"),
        "messageWillBeRemovedWarning":
            MessageLookupByLibrary.simpleMessage("メッセージはすべての参加者から消去されます"),
        "messages": MessageLookupByLibrary.simpleMessage("メッセージ"),
        "moderator": MessageLookupByLibrary.simpleMessage("モデレータ"),
        "muteChat": MessageLookupByLibrary.simpleMessage("チャットのミュート"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "現時点では、エンドツーエンドの暗号化を使用するにはPantalaimonが必要であることに注意してください。"),
        "newChat": MessageLookupByLibrary.simpleMessage("新規チャット"),
        "newGroup": MessageLookupByLibrary.simpleMessage("新しいグループ"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("💬 FluffyChatに新しいメッセージがあります"),
        "newSpace": MessageLookupByLibrary.simpleMessage("新しいスペース"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("認証リクエスト！"),
        "next": MessageLookupByLibrary.simpleMessage("次へ"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("次のアカウント"),
        "no": MessageLookupByLibrary.simpleMessage("いいえ"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "警告！チャットのバックアップを有効にしないと、暗号化されたメッセージにアクセスできなくなります。ログアウトする前に、まずチャットのバックアップを有効にすることを強くお勧めします。"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("サーバーに接続できません"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "有効なメールアドレスを入力してください。入力しないと、パスワードをリセットすることができなくなります。不要な場合は、もう一度ボタンをタップして続けてください。"),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Emoteは見つかりませんでした😕"),
        "noEncryptionForPublicRooms":
            MessageLookupByLibrary.simpleMessage("ルームを非公開にした後暗号化を有効にできます。"),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "あなたのスマホにはGoogleサービスがないようですね。プライバシーを保護するための良い選択です！プッシュ通知を受け取るには https://microg.org/ または https://unifiedpush.org/ を使うことをお勧めします。"),
        "noMatrixServer": m45,
        "noOtherDevicesFound":
            MessageLookupByLibrary.simpleMessage("他のデバイスが見つかりません"),
        "noPasswordRecoveryDescription":
            MessageLookupByLibrary.simpleMessage("パスワードを回復する方法をまだ追加していません。"),
        "noPermission": MessageLookupByLibrary.simpleMessage("権限がありません"),
        "noRoomsFound": MessageLookupByLibrary.simpleMessage("部屋は見つかりませんでした…"),
        "none": MessageLookupByLibrary.simpleMessage("なし"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage("このアカウントでは通知が有効です"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("位置情報を取得しています…"),
        "offensive": MessageLookupByLibrary.simpleMessage("攻撃的"),
        "offline": MessageLookupByLibrary.simpleMessage("オフライン"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oneClientLoggedOut":
            MessageLookupByLibrary.simpleMessage("クライアントの 1つがログアウトしました"),
        "online": MessageLookupByLibrary.simpleMessage("オンライン"),
        "onlineKeyBackupEnabled":
            MessageLookupByLibrary.simpleMessage("オンライン鍵バックアップは使用されています"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "おっと！残念ながら、プッシュ通知の設定中にエラーが発生しました。"),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("おっと、何かがうまくいきませんでした…"),
        "openAppToReadMessages":
            MessageLookupByLibrary.simpleMessage("アプリを開いてメッセージを確認してください"),
        "openCamera": MessageLookupByLibrary.simpleMessage("カメラを開く"),
        "openChat": MessageLookupByLibrary.simpleMessage("チャットを開く"),
        "openGallery": MessageLookupByLibrary.simpleMessage("ギャラリーを開く"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage("ビデオ用にカメラを開く"),
        "optionalGroupName": MessageLookupByLibrary.simpleMessage("(任意)グループ名"),
        "or": MessageLookupByLibrary.simpleMessage("または"),
        "otherCallingPermissions":
            MessageLookupByLibrary.simpleMessage("マイク、カメラ、その他FluffyChatの権限"),
        "participant": MessageLookupByLibrary.simpleMessage("参加者"),
        "passphraseOrKey":
            MessageLookupByLibrary.simpleMessage("パスフレーズかリカバリーキー"),
        "password": MessageLookupByLibrary.simpleMessage("パスワード"),
        "passwordForgotten": MessageLookupByLibrary.simpleMessage("パスワードを忘れた"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("パスワードが変更されました"),
        "passwordRecovery": MessageLookupByLibrary.simpleMessage("パスワードリカバリー"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("パスワードが一致しません!"),
        "people": MessageLookupByLibrary.simpleMessage("人々"),
        "pickImage": MessageLookupByLibrary.simpleMessage("画像を選択してください"),
        "pin": MessageLookupByLibrary.simpleMessage("ピン"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("部屋にピン留めする"),
        "placeCall": MessageLookupByLibrary.simpleMessage("電話をかける"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("選択してください"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("パスコードを選んでください"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("ユーザー名を選択してください"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink":
            MessageLookupByLibrary.simpleMessage("メールのリンクから進めてください。"),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "アプリのロック用に4桁の数字を入力してください。空欄の場合は無効になります。"),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("マトリックスIDを入力してください。"),
        "pleaseEnterRecoveryKey":
            MessageLookupByLibrary.simpleMessage("リカバリーキーを入力してください。"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "古いメッセージを解除するには、以前のセッションで生成されたリカバリーキーを入力してください。リカバリーキーはパスワードではありません。"),
        "pleaseEnterValidEmail":
            MessageLookupByLibrary.simpleMessage("正しいメールアドレスを入力してください。"),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("パスワードを入力してください"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("PINを入力してください"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("ユーザー名を入力してください"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "ウェブサイトにあるやり方を見てから次をタップしてください。"),
        "previousAccount": MessageLookupByLibrary.simpleMessage("前のアカウント"),
        "privacy": MessageLookupByLibrary.simpleMessage("プライバシー"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("公開された部屋"),
        "publish": MessageLookupByLibrary.simpleMessage("公開"),
        "pushRules": MessageLookupByLibrary.simpleMessage("ルールを追加する"),
        "reactedWith": m50,
        "reason": MessageLookupByLibrary.simpleMessage("理由"),
        "recording": MessageLookupByLibrary.simpleMessage("録音中"),
        "recoveryKey": MessageLookupByLibrary.simpleMessage("リカバリーキー"),
        "recoveryKeyLost":
            MessageLookupByLibrary.simpleMessage("リカバリーキーを紛失した場合"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("メッセージを書く"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("登録"),
        "reject": MessageLookupByLibrary.simpleMessage("拒否"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("再参加"),
        "remove": MessageLookupByLibrary.simpleMessage("消去"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("他のデバイスをすべて削除"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("デバイスの削除"),
        "removeFromBundle": MessageLookupByLibrary.simpleMessage("このバンドルから削除"),
        "removeFromSpace": MessageLookupByLibrary.simpleMessage("スペースから削除"),
        "removeYourAvatar": MessageLookupByLibrary.simpleMessage("アバターを削除する"),
        "removedBy": m53,
        "renderRichContent":
            MessageLookupByLibrary.simpleMessage("リッチメッセージをレンダリングする"),
        "reopenChat": MessageLookupByLibrary.simpleMessage("チャットを再開する"),
        "repeatPassword": MessageLookupByLibrary.simpleMessage("パスワードを繰り返そ"),
        "replaceRoomWithNewerVersion":
            MessageLookupByLibrary.simpleMessage("部屋を新しいバージョンに変更する"),
        "reply": MessageLookupByLibrary.simpleMessage("返信"),
        "replyHasBeenSent": MessageLookupByLibrary.simpleMessage("返信が送信されました"),
        "reportMessage": MessageLookupByLibrary.simpleMessage("メッセージを通報"),
        "reportUser": MessageLookupByLibrary.simpleMessage("ユーザーを報告"),
        "requestPermission": MessageLookupByLibrary.simpleMessage("権限を要求する"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("部屋はアップグレードされました"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("ルームバージョン"),
        "saveFile": MessageLookupByLibrary.simpleMessage("ファイルを保存"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("QRコードをスキャン"),
        "screenSharingDetail":
            MessageLookupByLibrary.simpleMessage("FuffyChatで画面を共有しています"),
        "screenSharingTitle": MessageLookupByLibrary.simpleMessage("画面共有"),
        "search": MessageLookupByLibrary.simpleMessage("検索"),
        "security": MessageLookupByLibrary.simpleMessage("セキュリティ"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("送信"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("メッセージを送信"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("テキストとして送信"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("音声の送信"),
        "sendFile": MessageLookupByLibrary.simpleMessage("ファイルを送信"),
        "sendImage": MessageLookupByLibrary.simpleMessage("画像の送信"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("メッセージを送る"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("Enterで送信"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("オリジナルの送信"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("ステッカーを送る"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("動画を送信"),
        "sender": MessageLookupByLibrary.simpleMessage("送信者"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "このサーバーは、登録のためにメールアドレスを検証する必要があります。"),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("メインエイリアスに設定"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage("カスタムエモートの設定"),
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("グループの説明を設定する"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage("招待リンクを設定する"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("権限レベルをセット"),
        "setStatus": MessageLookupByLibrary.simpleMessage("ステータスの設定"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "share": MessageLookupByLibrary.simpleMessage("共有"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("位置情報の共有"),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("招待リンクを共有する"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces":
            MessageLookupByLibrary.simpleMessage("関連するダイレクトチャットをスペースに表示する"),
        "showPassword": MessageLookupByLibrary.simpleMessage("パスワードを表示"),
        "signUp": MessageLookupByLibrary.simpleMessage("サインアップ"),
        "singlesignon": MessageLookupByLibrary.simpleMessage("シングルサインオン"),
        "skip": MessageLookupByLibrary.simpleMessage("スキップ"),
        "sorryThatsNotPossible":
            MessageLookupByLibrary.simpleMessage("申し訳ありません...それは不可能です"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("ソースコード"),
        "spaceIsPublic": MessageLookupByLibrary.simpleMessage("スペースは公開されています"),
        "spaceName": MessageLookupByLibrary.simpleMessage("スペース名"),
        "start": MessageLookupByLibrary.simpleMessage("開始"),
        "startFirstChat": MessageLookupByLibrary.simpleMessage("最初のチャットを開始する"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("ステータス"),
        "statusExampleMessage": MessageLookupByLibrary.simpleMessage("お元気ですか？"),
        "storeInAndroidKeystore":
            MessageLookupByLibrary.simpleMessage("Android KeyStoreに保存する"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("Apple KeyChainに保存"),
        "storeInSecureStorageDescription":
            MessageLookupByLibrary.simpleMessage("このデバイスの安全なストレージにリカバリーキーを保存。"),
        "storeSecurlyOnThisDevice":
            MessageLookupByLibrary.simpleMessage("このデバイスに安全に保管する"),
        "stories": MessageLookupByLibrary.simpleMessage("ストーリー"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "あなたのストーリーでは、人々がお互いを見て連絡を取ることができることに注意してください。ストーリーは24時間表示されますが、すべてのデバイスとサーバーから削除されるという保証はありません。"),
        "submit": MessageLookupByLibrary.simpleMessage("送信"),
        "switchToAccount": m67,
        "synchronizingPleaseWait":
            MessageLookupByLibrary.simpleMessage("同期中...お待ちください。"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("システム"),
        "theyDontMatch": MessageLookupByLibrary.simpleMessage("違います"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("一致しています"),
        "thisUserHasNotPostedAnythingYet":
            MessageLookupByLibrary.simpleMessage("このユーザーはまだストーリーに何も投稿していません"),
        "time": MessageLookupByLibrary.simpleMessage("時間"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite": MessageLookupByLibrary.simpleMessage("お気に入り切り替え"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage("ミュート切り替え"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage("既読/未読にマーク"),
        "tooManyRequestsWarning":
            MessageLookupByLibrary.simpleMessage("リクエストが多すぎます。また後で試してみてください！"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("違うデバイスから移行する"),
        "tryToSendAgain": MessageLookupByLibrary.simpleMessage("送信し直してみる"),
        "unavailable": MessageLookupByLibrary.simpleMessage("不在"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("チャットからのブロックを解除する"),
        "unbannedUser": m68,
        "unblockDevice": MessageLookupByLibrary.simpleMessage("デバイスをブロック解除する"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("未知デバイス"),
        "unknownEncryptionAlgorithm":
            MessageLookupByLibrary.simpleMessage("未知の暗号化アルゴリズム"),
        "unlockOldMessages":
            MessageLookupByLibrary.simpleMessage("古いメッセージのロックを解除する"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage("チャットをミュート解除する"),
        "unpin": MessageLookupByLibrary.simpleMessage("ピンを外す"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("ストーリーの購読を解除する"),
        "unsupportedAndroidVersion":
            MessageLookupByLibrary.simpleMessage("サポートされていないAndroidのバージョン"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "この機能を利用するには、より新しいAndroidのバージョンが必要です。アップデートまたはLineage OSのサポートをご確認ください。"),
        "unverified": MessageLookupByLibrary.simpleMessage("未検証"),
        "updateAvailable":
            MessageLookupByLibrary.simpleMessage("FluffyChatのアップデートが利用可能"),
        "updateNow": MessageLookupByLibrary.simpleMessage("バックグラウンドでアップデートを開始"),
        "user": MessageLookupByLibrary.simpleMessage("ユーザー"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("ユーザー名"),
        "users": MessageLookupByLibrary.simpleMessage("ユーザー"),
        "verified": MessageLookupByLibrary.simpleMessage("検証済み"),
        "verify": MessageLookupByLibrary.simpleMessage("確認"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("確認を始める"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage("確認が完了しました！"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage("他のアカウントを確認中"),
        "videoCall": MessageLookupByLibrary.simpleMessage("音声通話"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "ビデオ通話は、現在ベータ版であることにご注意ください。すべてのプラットフォームで期待通りに動作しない、あるいはまったく動作しない可能性があります。"),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("チャット履歴の表示"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("すべての参加者が閲覧可能"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("すべての人が閲覧可能"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("音声通話"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("ボイスメッセージ"),
        "waitingPartnerAcceptRequest":
            MessageLookupByLibrary.simpleMessage("パートナーのリクエスト承諾待ちです..."),
        "waitingPartnerEmoji":
            MessageLookupByLibrary.simpleMessage("パートナーの絵文字承諾待ちです..."),
        "waitingPartnerNumbers":
            MessageLookupByLibrary.simpleMessage("パートナーの数字承諾待ちです…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("壁紙"),
        "warning": MessageLookupByLibrary.simpleMessage("警告！"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("あなたにメールを送信しました"),
        "whoCanPerformWhichAction":
            MessageLookupByLibrary.simpleMessage("誰がどの操作を実行できるか"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "あなたのストーリーでは、人々がお互いを見て連絡を取ることができることに注意してください。"),
        "whoIsAllowedToJoinThisGroup":
            MessageLookupByLibrary.simpleMessage("誰がこのチャットに入れますか"),
        "whyDoYouWantToReportThis":
            MessageLookupByLibrary.simpleMessage("これを通報する理由"),
        "whyIsThisMessageEncrypted":
            MessageLookupByLibrary.simpleMessage("このメッセージが読めない理由"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("カスタム"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("名称"),
        "widgetNameError":
            MessageLookupByLibrary.simpleMessage("表示名を入力してください。"),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("有効なURLではありません。"),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("動画"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "チャットのバックアップを消去して、新しいリカバリーキーを作りますか？"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "これらのアドレスを使用すると、パスワードを回復することができます。"),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("メッセージを入力してください…"),
        "yes": MessageLookupByLibrary.simpleMessage("はい"),
        "you": MessageLookupByLibrary.simpleMessage("あなた"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("👍 招待を承諾しました"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("チャットに招待されています"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage("あなたはもうこのチャットの参加者ではありません"),
        "youBannedUser": m77,
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("自分自身を招待することはできません"),
        "youHaveBeenBannedFromThisChat":
            MessageLookupByLibrary.simpleMessage("チャットからBANされてしまいました"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat": MessageLookupByLibrary.simpleMessage("チャットに参加しました"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("招待を拒否しました"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp":
            MessageLookupByLibrary.simpleMessage("チャットバックアップを設定ました。"),
        "yourPublicKey": MessageLookupByLibrary.simpleMessage("あなたの公開鍵"),
        "yourStory": MessageLookupByLibrary.simpleMessage("あなたのストーリー")
      };
}
