// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sr locale. All the
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
  String get localeName => 'sr';

  static String m0(username) => "${username} прихвата позивницу";

  static String m1(username) => "${username} укључи шифровање с краја на крај";

  static String m2(senderName) => "${senderName} одговори на позив";

  static String m3(username) =>
      "Прихватате ли захтев за верификацију од корисника ${username}?";

  static String m4(username, targetName) =>
      "${username} забрани корисника ${targetName}";

  static String m6(username) => "${username} промени аватар ћаскања";

  static String m7(username, description) =>
      "${username} промени опис ћаскања у: „${description}“";

  static String m8(username, chatname) =>
      "${username} промени назив ћаскања у: „${chatname}“";

  static String m9(username) => "${username} измени дозволе ћаскања";

  static String m10(username, displayname) =>
      "${username} промени приказно име на: „${displayname}“";

  static String m11(username) =>
      "${username} измени правила за приступ гостију";

  static String m12(username, rules) =>
      "${username} измени правила за приступ гостију на: ${rules}";

  static String m13(username) => "${username} измени видљивост историје";

  static String m14(username, rules) =>
      "${username} измени видљивост историје на: ${rules}";

  static String m15(username) => "${username} измени правила приступања";

  static String m16(username, joinRules) =>
      "${username} измени правила приступања на: ${joinRules}";

  static String m17(username) => "${username} измени свој аватар";

  static String m18(username) => "${username} измени алијас собе";

  static String m19(username) => "${username} измени везу позивнице";

  static String m21(error) => "Не могу да дешифрујем поруку: ${error}";

  static String m23(count) => "учесника: ${count}";

  static String m24(username) => "${username} направи ћаскање";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day} ${month} ${year}";

  static String m28(month, day) => "${day} ${month}";

  static String m29(senderName) => "${senderName} заврши позив";

  static String m33(displayname) => "Група са корисником ${displayname}";

  static String m34(username, targetName) =>
      "${username} поништи позивницу за корисника ${targetName}";

  static String m36(groupName) => "Позови особу у групу ${groupName}";

  static String m37(username, link) =>
      "${username} вас позива у FluffyChat. \n1. Инсталирајте FluffyChat: https://fluffychat.im \n2. Региструјте се или пријавите \n3. Отворите везу позивнице: ${link}";

  static String m38(username, targetName) =>
      "${username} позва корисника ${targetName}";

  static String m39(username) => "${username} се придружи ћаскању";

  static String m40(username, targetName) =>
      "${username} избаци корисника ${targetName}";

  static String m41(username, targetName) =>
      "${username} избаци и забрани корисника ${targetName}";

  static String m42(localizedTimeShort) =>
      "Последња активност: ${localizedTimeShort}";

  static String m43(count) => "Учитај још ${count} учесника";

  static String m44(homeserver) => "Пријава на ${homeserver}";

  static String m47(count) => "${count} корисника куца…";

  static String m48(fileName) => "Пусти ${fileName}";

  static String m51(username) => "${username} редигова догађај";

  static String m52(username) => "${username} одби позивницу";

  static String m53(username) => "Уклонио корисник ${username}";

  static String m54(username) => "${username} прегледа";

  static String m55(username, count) => "Видео ${username} и још ${count} људи";

  static String m56(username, username2) =>
      "Прегледали ${username} и ${username2}";

  static String m57(username) => "${username} посла фајл";

  static String m58(username) => "${username} посла слику";

  static String m59(username) => "${username} посла налепницу";

  static String m60(username) => "${username} посла видео";

  static String m61(username) => "${username} посла аудио";

  static String m62(senderName) => "${senderName} посла податке о позиву";

  static String m63(username) => "${username} подели локацију";

  static String m64(senderName) => "${senderName} започе позив";

  static String m68(username, targetName) =>
      "${username} одблокира корисника ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, other: 'непрочитаних ћаскања: ${unreadCount}')}";

  static String m70(username, count) =>
      "${username} и ${count} корисника куцају…";

  static String m71(username, username2) =>
      "${username} и ${username2} куцају…";

  static String m72(username) => "${username} куца…";

  static String m73(username) => "${username} напусти ћаскање";

  static String m74(username, type) => "${username} посла ${type} догађај";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("О програму"),
        "accept": MessageLookupByLibrary.simpleMessage("Прихвати"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Налог"),
        "activatedEndToEndEncryption": m1,
        "addEmail": MessageLookupByLibrary.simpleMessage("Додај е-адресу"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Додај опис групе"),
        "admin": MessageLookupByLibrary.simpleMessage("Админ"),
        "alias": MessageLookupByLibrary.simpleMessage("алијас"),
        "all": MessageLookupByLibrary.simpleMessage("Сви"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("свако може да се придружи"),
        "appLock":
            MessageLookupByLibrary.simpleMessage("Закључавање апликације"),
        "archive": MessageLookupByLibrary.simpleMessage("Архива"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Да ли је гостима дозвољен приступ"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Сигурни сте?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Заиста желите да се одјавите?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Да бисте могли да пријавите другу особу, унесите своју безбедносну фразу или кључ опоравка."),
        "askVerificationRequest": m3,
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Забрани у ћаскању"),
        "banned": MessageLookupByLibrary.simpleMessage("Забрањен"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("Блокирај уређај"),
        "blocked": MessageLookupByLibrary.simpleMessage("Блокиран"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Поруке Бота"),
        "cancel": MessageLookupByLibrary.simpleMessage("Откажи"),
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Промени назив уређаја"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Измени лозинку"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Промени домаћи сервер"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Измени назив групе"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Измените изглед"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage("Измени тапет"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Измените свој аватар"),
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
            MessageLookupByLibrary.simpleMessage("Шифровање је покварено"),
        "chat": MessageLookupByLibrary.simpleMessage("Ћаскање"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("Копија ћаскања"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Ваша резервна копија ћаскања је обезбеђена кључем. Немојте да га изгубите."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Детаљи ћаскања"),
        "chats": MessageLookupByLibrary.simpleMessage("Ћаскања"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Изаберите јаку лозинку"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Изаберите корисничко име"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Очисти архиву"),
        "close": MessageLookupByLibrary.simpleMessage("Затвори"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Блокирај задатог корисника за ову собу"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("Шаљи ХТМЛ обликован текст"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Позови задатог корисника у собу"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Придружи се наведеној соби"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Уклони задатог корисника из собе"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Напусти ову собу"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Опишите себе"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Поставља ваш надимак за ову собу"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Подеси ниво задатог корисника (подразумевано: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Шаљи неформатиран текст"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("Шаљи одговор као реакцију"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Пошаљи текст"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Скини забрану задатом кориснику за ову собу"),
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Упоредите и проверите да су емоџији идентични као на другом уређају:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Упоредите и проверите да су следећи бројеви идентични као на другом уређају:"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Подешавање ћаскања"),
        "confirm": MessageLookupByLibrary.simpleMessage("Потврди"),
        "connect": MessageLookupByLibrary.simpleMessage("Повежи се"),
        "contactHasBeenInvitedToTheGroup":
            MessageLookupByLibrary.simpleMessage("Особа је позвана у групу"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Садржи приказно име"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Садржи корисничко име"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "Садржај је пријављен администраторима сервера"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Копирано у клипборд"),
        "copy": MessageLookupByLibrary.simpleMessage("Копирај"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Копирај у клипборд"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Направи"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Направи нову групу"),
        "createdTheChat": m24,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Тренутно активно"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("тамни"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Ово ће деактивирати ваш кориснички налог. Не може се повратити! Сигурни сте?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Подразумевани ниво приступа"),
        "delete": MessageLookupByLibrary.simpleMessage("Обриши"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Обриши налог"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("Брисање поруке"),
        "deny": MessageLookupByLibrary.simpleMessage("Одбиј"),
        "device": MessageLookupByLibrary.simpleMessage("Уређај"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ИД уређаја"),
        "devices": MessageLookupByLibrary.simpleMessage("Уређаји"),
        "directChats": MessageLookupByLibrary.simpleMessage("Директна ћаскања"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Име за приказ је измењено"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Преузми фајл"),
        "edit": MessageLookupByLibrary.simpleMessage("Уреди"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("Уреди блокиране сервере"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Уредите дозволе ћаскања"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Уреди име за приказ"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Уреди алијасе собе"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Уређује аватар собе"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Емоти већ постоји!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Неисправна скраћеница за емоти!"),
        "emotePacks":
            MessageLookupByLibrary.simpleMessage("Пакети емотија за собу"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Поставке емотија"),
        "emoteShortcode": MessageLookupByLibrary.simpleMessage("скраћеница"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Морате да изаберете скраћеницу и слику за емоти!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("празно ћаскање"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Глобално укључи пакет емотија"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Укључује шифровање"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Шифровање више нећете моћи да искључите. Сигурни сте?"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Шифровано"),
        "encryption": MessageLookupByLibrary.simpleMessage("Шифровање"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Шифровање није укључено"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("унесите назив групе"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Унесите адресу е-поште"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Унесите свој домаћи сервер"),
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Све је спремно!"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Екстремно увредљив"),
        "fileName": MessageLookupByLibrary.simpleMessage("Назив фајла"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Величина фонта"),
        "forward": MessageLookupByLibrary.simpleMessage("Напред"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("од приступања"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("од позивања"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Иди у нову собу"),
        "group": MessageLookupByLibrary.simpleMessage("Група"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("Опис групе"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Опис групе измењен"),
        "groupIsPublic": MessageLookupByLibrary.simpleMessage("Група је јавна"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Групе"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("гости су забрањени"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("гости могу приступити"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Помоћ"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Сакриј редиговане догађаје"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("Сакриј непознате догађаје"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Колико је увредљив овај садржај?"),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Кликнуо сам на везу"),
        "id": MessageLookupByLibrary.simpleMessage("ИД"),
        "identity": MessageLookupByLibrary.simpleMessage("Идентитет"),
        "ignore": MessageLookupByLibrary.simpleMessage("Игнориши"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Можете игнорисати кориснике који вас нервирају. Нећете примати никакве поруке нити позивнице од корисника са ваше листе за игнорисање."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Игнориши корисника"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Игнорисани корисници"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Неисправна фраза или кључ опоравка"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Није увредљив"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("Позивање особа"),
        "inviteContactToGroup": m36,
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Позивнице за мене"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Позван"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("само позвани корисници"),
        "isTyping": MessageLookupByLibrary.simpleMessage("куца…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Придружи се соби"),
        "joinedTheChat": m39,
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Избаци из ћаскања"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("одавно није на мрежи"),
        "leave": MessageLookupByLibrary.simpleMessage("Напусти"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Напусти ћаскање"),
        "license": MessageLookupByLibrary.simpleMessage("Лиценца"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("светли"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Учитај још…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Учитавам… Сачекајте."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Пријава"),
        "logout": MessageLookupByLibrary.simpleMessage("Одјава"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Проверите да је идентификатор исправан"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("Измене чланова"),
        "mention": MessageLookupByLibrary.simpleMessage("Спомени"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Поруке ће бити уклоњене за све учеснике"),
        "messages": MessageLookupByLibrary.simpleMessage("Поруке"),
        "moderator": MessageLookupByLibrary.simpleMessage("Модератор"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Ућуткај ћаскање"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "За сада, потребан је Пантелејмон (Pantalaimon) да бисте користили шифровање с краја на крај."),
        "newChat": MessageLookupByLibrary.simpleMessage("Ново ћаскање"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("Нова порука — FluffyChat"),
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "Нови захтев за верификацију!"),
        "next": MessageLookupByLibrary.simpleMessage("Следеће"),
        "no": MessageLookupByLibrary.simpleMessage("Не"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Нема везе са сервером"),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Нема емотија. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Шифровање се може активирати након што соба престане да буде јавно доступна."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Чини се да немате Гугл услуге на телефону. То је добра одлука за вашу приватност! Да би се протурале нотификације у FluffyChat, препоручујемо коришћење https://microg.org/ или https://unifiedpush.org/"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Још нисте одредили начин за опоравак лозинке."),
        "noPermission": MessageLookupByLibrary.simpleMessage("Нема дозвола"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Нисам нашао собе…"),
        "none": MessageLookupByLibrary.simpleMessage("Ништа"),
        "notifications": MessageLookupByLibrary.simpleMessage("Обавештења"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Обавештења укључена за овај налог"),
        "numUsersTyping": m47,
        "offensive": MessageLookupByLibrary.simpleMessage("Увредљив"),
        "offline": MessageLookupByLibrary.simpleMessage("Ван везе"),
        "ok": MessageLookupByLibrary.simpleMessage("у реду"),
        "online": MessageLookupByLibrary.simpleMessage("На вези"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Резерва кључева на мрежи је укључена"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Нажалост, дошло је до грешке при подешавању дотурања обавештења."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Нешто је пошло наопако…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Отворите апликацију да прочитате поруке"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Отвори камеру"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(опционо) назив групе"),
        "or": MessageLookupByLibrary.simpleMessage("или"),
        "participant": MessageLookupByLibrary.simpleMessage("Учесник"),
        "passphraseOrKey":
            MessageLookupByLibrary.simpleMessage("фраза или кључ опоравка"),
        "password": MessageLookupByLibrary.simpleMessage("Лозинка"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Заборављена лозинка"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Лозинка је промењена"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Опоравак лозинке"),
        "people": MessageLookupByLibrary.simpleMessage("Људи"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Избор слике"),
        "pin": MessageLookupByLibrary.simpleMessage("Закачи"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Изаберите"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Изаберите код за пролаз"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("Изаберите корисничко име"),
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Кликните на везу у примљеној е-пошти па наставите."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Унесите 4 цифре или оставите празно да не закључавате апликацију."),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("Унесите ИД са Матрикса."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Унесите своју лозинку"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Унесите свој пин"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Унесите своје корисничко име"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Испратите упутства на веб сајту и тапните на „Следеће“."),
        "privacy": MessageLookupByLibrary.simpleMessage("Приватност"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Јавне собе"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Правила протурања"),
        "reason": MessageLookupByLibrary.simpleMessage("Разлог"),
        "recording": MessageLookupByLibrary.simpleMessage("Снимам"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("Редигуј поруку"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Регистрација"),
        "reject": MessageLookupByLibrary.simpleMessage("Одбиј"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Поново се придружи"),
        "remove": MessageLookupByLibrary.simpleMessage("Уклони"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("Уклони све остале уређаје"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("Уклони уређај"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Уклоните свој аватар"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Приказуј обогаћен садржај поруке"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Замени собу новијом верзијом"),
        "reply": MessageLookupByLibrary.simpleMessage("Одговори"),
        "reportMessage": MessageLookupByLibrary.simpleMessage("Пријави поруку"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Затражи дозволу"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Соба је надограђена"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Верзија собе"),
        "search": MessageLookupByLibrary.simpleMessage("Претражи"),
        "security": MessageLookupByLibrary.simpleMessage("Безбедност"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Пошаљи"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("Пошаљи поруку"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Пошаљи аудио"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Пошаљи фајл"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Пошаљи слику"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("Слање порука"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("Пошаљи оригинал"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Пошаљи видео"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("Постави као главни алијас"),
        "setCustomEmotes":
            MessageLookupByLibrary.simpleMessage("постави посебне емотије"),
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("Постави опис групе"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Поставља везу позивнице"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("Одреди ниво дозволе"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Постави статус"),
        "settings": MessageLookupByLibrary.simpleMessage("Поставке"),
        "share": MessageLookupByLibrary.simpleMessage("Подели"),
        "sharedTheLocation": m63,
        "showPassword": MessageLookupByLibrary.simpleMessage("Прикажи лозинку"),
        "signUp": MessageLookupByLibrary.simpleMessage("Регистрација"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Јединствена пријава"),
        "skip": MessageLookupByLibrary.simpleMessage("Прескочи"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Изворни код"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Стање"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Како сте данас?"),
        "submit": MessageLookupByLibrary.simpleMessage("Пошаљи"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("системски"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Не поклапају се"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Поклапају се"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Мењај омиљеност"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage("Мењај ућутканост"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Означи не/прочитано"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Превише упита. Покушајте касније!"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("Пренос са другог уређаја"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Покушај слање поново"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Недоступно"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Уклони изгнанство"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Одблокирај уређај"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Непознат уређај"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Непознат алгоритам шифровања"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage("Врати обавештења"),
        "unpin": MessageLookupByLibrary.simpleMessage("Откачи"),
        "unreadChats": m69,
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Корисничко име"),
        "verified": MessageLookupByLibrary.simpleMessage("Оверен"),
        "verify": MessageLookupByLibrary.simpleMessage("Верификуј"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Покрени верификацију"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Успешно сте верификовали!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Верификујем други налог"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Видео позив"),
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("Одреди видљивост историје"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("видљиво свим учесницима"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("видљиво свима"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Гласовна порука"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Чекам да саговорник прихвати захтев…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Чекам да саговорник прихвати емоџије…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Чекам да саговорник прихвати бројеве…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Тапета"),
        "warning": MessageLookupByLibrary.simpleMessage("Упозорење!"),
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("Послали смо вам е-пошту"),
        "whoCanPerformWhichAction":
            MessageLookupByLibrary.simpleMessage("ко може шта да ради"),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Ко може да се придружи групи"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Зашто желите ово да пријавите?"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Да обришем резервну копију како би направио нови сигурносни кључ?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Са овим адресама можете опоравити своју лозинку."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("напишите поруку…"),
        "yes": MessageLookupByLibrary.simpleMessage("Да"),
        "you": MessageLookupByLibrary.simpleMessage("Ви"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("Позвани сте у ово ћаскање"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Више не учествујете у овом ћаскању"),
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("Не можете позвати себе"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Забрањено вам је ово ћаскање"),
        "yourPublicKey": MessageLookupByLibrary.simpleMessage("Ваш јавни кључ")
      };
}
