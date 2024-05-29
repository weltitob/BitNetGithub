// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(username) => "${username} принял(а) приглашение войти в чат";

  static String m1(username) =>
      "${username} активировал(а) сквозное шифрование";

  static String m2(senderName) => "${senderName} ответил(а) на звонок";

  static String m3(username) =>
      "Принять этот запрос подтверждения от ${username}?";

  static String m4(username, targetName) =>
      "${username} заблокировал(а) ${targetName}";

  static String m5(uri) => "Не удается открыть URI ${uri}";

  static String m6(username) => "${username} изменил(а) аватар чата";

  static String m7(username, description) =>
      "${username} изменил(а) описание чата на: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} изменил(а) имя чата на: \'${chatname}\'";

  static String m9(username) => "${username} изменил(а) права доступа к чату";

  static String m10(username, displayname) =>
      "${username} изменил(а) отображаемое имя на: \'${displayname}\'";

  static String m11(username) =>
      "${username} изменил(а) правила гостевого доступа";

  static String m12(username, rules) =>
      "${username} изменил(а) правила гостевого доступа на: ${rules}";

  static String m13(username) => "${username} изменил(а) видимость истории";

  static String m14(username, rules) =>
      "${username} изменил(а) видимость истории на: ${rules}";

  static String m15(username) => "${username} изменил(а) правила присоединения";

  static String m16(username, joinRules) =>
      "${username} изменил(а) правила присоединения на: ${joinRules}";

  static String m17(username) => "${username} изменил(а) аватар";

  static String m18(username) => "${username} изменил(а) псевдонимы комнаты";

  static String m19(username) =>
      "${username} изменил(а) ссылку для приглашения";

  static String m20(command) => "${command} не является командой.";

  static String m21(error) => "Не удалось расшифровать сообщение: ${error}";

  static String m22(count) => "${count} файлов";

  static String m23(count) => "${count} участника(ов)";

  static String m24(username) => "${username} создал(а) чат";

  static String m26(date, timeOfDay) => "${timeOfDay}, ${date}";

  static String m27(year, month, day) => "${day}-${month}-${year}";

  static String m28(month, day) => "${day}-${month}";

  static String m29(senderName) => "${senderName} завершил(а) звонок";

  static String m30(error) => "Ошибка получения местоположения: ${error}";

  static String m33(displayname) => "Группа с ${displayname}";

  static String m34(username, targetName) =>
      "${username} отозвал(а) приглашение для ${targetName}";

  static String m36(groupName) => "Пригласить контакт в ${groupName}";

  static String m37(username, link) =>
      "${username} пригласил(а) вас в FluffyChat. \n1. Установите FluffyChat: https://fluffychat.im \n2. Зарегистрируйтесь или войдите \n3. Откройте ссылку приглашения: ${link}";

  static String m38(username, targetName) =>
      "${username} пригласил(а) ${targetName}";

  static String m39(username) => "${username} присоединился(ась) к чату";

  static String m40(username, targetName) =>
      "${username} исключил(а) ${targetName}";

  static String m41(username, targetName) =>
      "${username} исключил(а) и заблокировал(а) ${targetName}";

  static String m42(localizedTimeShort) =>
      "Последнее посещение: ${localizedTimeShort}";

  static String m43(count) => "Загрузить еще ${count} участника(ов)";

  static String m44(homeserver) => "Войти в ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} не является matrix-сервером, использовать ${server2} вместо него?";

  static String m46(number) => "${number} чатов";

  static String m47(count) => "${count} пользователей печатают…";

  static String m48(fileName) => "Проиграть ${fileName}";

  static String m49(min) => "Пожалуйста, выберите не менее ${min} символов.";

  static String m50(sender, reaction) => "${sender} реагирует с ${reaction}";

  static String m51(username) => "${username} отредактировал(а) событие";

  static String m52(username) => "${username} отклонил(а) приглашение";

  static String m53(username) => "Удалено пользователем ${username}";

  static String m54(username) => "Просмотрено пользователем ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Просмотрено пользователями ${username} и ${count} другими')}";

  static String m56(username, username2) =>
      "Просмотрено пользователями ${username} и ${username2}";

  static String m57(username) => "📁 ${username} отправил(а) файл";

  static String m58(username) => "🖼️ ${username} отправил(а) изображение";

  static String m59(username) => "😊 ${username} отправил(а) стикер";

  static String m60(username) => "🎥 ${username} отправил(а) видео";

  static String m61(username) => "🎤 ${username} отправил(а) аудио";

  static String m62(senderName) =>
      "${senderName} отправил(а) информацию о звонке";

  static String m63(username) => "${username} поделился(ась) местоположением";

  static String m64(senderName) => "${senderName} начал(а) звонок";

  static String m65(date, body) => "История за ${date}:\n${body}";

  static String m66(mxid) => "Это должно быть ${mxid}";

  static String m67(number) => "Переключиться на учётную запись ${number}";

  static String m68(username, targetName) =>
      "${username} разблокировал(а) ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, other: '${unreadCount} непрочитанных чата(ов)')}";

  static String m70(username, count) =>
      "${username} и ${count} других участников печатают…";

  static String m71(username, username2) =>
      "${username} и ${username2} печатают…";

  static String m72(username) => "${username} печатает…";

  static String m73(username) => "${username} покинул(а) чат";

  static String m74(username, type) =>
      "${username} отправил(а) событие типа \"${type}\"";

  static String m75(size) => "Видео (${size})";

  static String m77(user) => "Вы заблокировали ${user}";

  static String m78(user) => "Вы отозвали приглашение для ${user}";

  static String m79(user) => "Вы были приглашены ${user}";

  static String m80(user) => "Вы пригласили ${user}";

  static String m81(user) => "Вы исключили ${user}";

  static String m82(user) => "Вы исключили и заблокировали ${user}";

  static String m83(user) => "Вы разблокировали ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("О проекте"),
        "accept": MessageLookupByLibrary.simpleMessage("Принять"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Учётная запись"),
        "activatedEndToEndEncryption": m1,
        "addAccount":
            MessageLookupByLibrary.simpleMessage("Добавить учетную запись"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Добавить описание"),
        "addEmail":
            MessageLookupByLibrary.simpleMessage("Добавить электронную почту"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Добавить описание группы"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("Добавить в пакет"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Добавить в пространство"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Выберите пространство, чтобы добавить к нему этот чат."),
        "addToStory":
            MessageLookupByLibrary.simpleMessage("Добавить в историю"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Добавить виджет"),
        "admin": MessageLookupByLibrary.simpleMessage("Администратор"),
        "alias": MessageLookupByLibrary.simpleMessage("псевдоним"),
        "all": MessageLookupByLibrary.simpleMessage("Все"),
        "allChats": MessageLookupByLibrary.simpleMessage("Все чаты"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Все пространства"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Каждый может присоединиться"),
        "appLock":
            MessageLookupByLibrary.simpleMessage("Блокировка приложения"),
        "appearOnTop":
            MessageLookupByLibrary.simpleMessage("Появляться сверху"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Позволяет приложению отображаться сверху (не требуется, если у вас уже настроен Fluffychat как аккаунт для звонков)"),
        "archive": MessageLookupByLibrary.simpleMessage("Архив"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Разрешено ли гостям присоединяться"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Вы уверены?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Вы действительно хотите выйти?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Для подписи ключа другого пользователя, пожалуйста, введите вашу парольную фразу или ключ восстановления."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Автоматически воспроизводить анимированные стикеры и эмодзи"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Заблокировать в чате"),
        "banned": MessageLookupByLibrary.simpleMessage("Заблокирован(а)"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Заблокировать устройство"),
        "blocked": MessageLookupByLibrary.simpleMessage("Заблокировано"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Сообщения ботов"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Размер пузыря"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Название пакета"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Аккаунт для звонков"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Позволяет FluffyChat использовать родное android приложение для звонков."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Разрешения на звонки"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Изменить имя устройства"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Изменить пароль"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Изменить сервер Matrix"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Изменить название группы"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Тема"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Изменить фон чатов"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Изменить свой аватар"),
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
            MessageLookupByLibrary.simpleMessage("Шифрование было повреждено"),
        "chat": MessageLookupByLibrary.simpleMessage("Чат"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Резервное копирование чата"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Резервная старых сообщений защищена ключом восстановления. Пожалуйста, не потеряйте его."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Детали чата"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "Чат был добавлен в это пространство"),
        "chats": MessageLookupByLibrary.simpleMessage("Чаты"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Выберите надёжный пароль"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Выберите имя пользователя"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Очистить архив"),
        "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Заблокировать данного пользователя в этой комнате"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Очистить кэш"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Создайте пустой групповой чат\nИспользуйте --no-encryption, чтобы отключить шифрование"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Удалить сеанс"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Начните личный чат\nИспользуйте --no-encryption, чтобы отключить шифрование"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Отправить текст формата HTML"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Пригласить данного пользователя в эту комнату"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage(
            "Присоединиться к данной комнате"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Удалить данного пользователя из этой комнаты"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Покинуть эту комнату"),
        "commandHint_markasdm": MessageLookupByLibrary.simpleMessage(
            "Пометить как комнату личных сообщений"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Пометить как группу"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Опишите себя"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Установите свою фотографию для этой комнаты (автор: mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Задайте отображаемое имя для этой комнаты"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Установить уровень прав данного пользователя (по умолчанию: 50)"),
        "commandHint_plain": MessageLookupByLibrary.simpleMessage(
            "Отправить неотформатированный текст"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("Отправить ответ как реакцию"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Отправить текст"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Разблокировать данного пользователя в этой комнате"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Недопустимая команда"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Сравните и убедитесь, что следующие эмодзи соответствуют эмодзи на другом устройстве:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Сравните и убедитесь, что следующие числа соответствуют числам на другом устройстве:"),
        "configureChat": MessageLookupByLibrary.simpleMessage("Настроить чат"),
        "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Вы уверены, что хотите навсегда открепить событие?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, подтвердите Matrix ID, чтобы удалить свою учётную запись."),
        "connect": MessageLookupByLibrary.simpleMessage("Присоединиться"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Контакт был приглашен в группу"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Содержит отображаемое имя"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Содержит имя пользователя"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "О контенте было сообщено администраторам сервера"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Скопировано в буфер обмена"),
        "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Скопировать в буфер обмена"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Создать"),
        "createNewGroup": MessageLookupByLibrary.simpleMessage("Новая группа"),
        "createNewSpace":
            MessageLookupByLibrary.simpleMessage("Новое пространство"),
        "createdTheChat": m24,
        "currentlyActive": MessageLookupByLibrary.simpleMessage(
            "В настоящее время активен(а)"),
        "custom": MessageLookupByLibrary.simpleMessage("Пользовательское"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Тёмная"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Это деактивирует вашу учётную запись пользователя. Данное действие не может быть отменено! Вы уверены?"),
        "defaultPermissionLevel": MessageLookupByLibrary.simpleMessage(
            "Уровень разрешений по умолчанию"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Экспорт сеанса и очистка устройства"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "Пользователи TOR: Экспорт сеанса"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Для пользователей TOR рекомендуется экспортировать сессию перед закрытием окна."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Это действие не может быть отменено. Убедитесь, что вы безопасно сохранили файл резервной копии."),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Удалить сообщение"),
        "deny": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "device": MessageLookupByLibrary.simpleMessage("Устройство"),
        "deviceId":
            MessageLookupByLibrary.simpleMessage("Идентификатор устройства"),
        "devices": MessageLookupByLibrary.simpleMessage("Устройства"),
        "directChats": MessageLookupByLibrary.simpleMessage("Личные чаты"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "displaynameHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Отображаемое имя было изменено"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Скачать файл"),
        "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Редактировать заблокированные серверы"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Изменить пакеты для этой учетной записи"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Изменить разрешения чата"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Отображаемое имя"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage(
            "Редактировать псевдонимы комнаты"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Изменить аватар комнаты"),
        "editWidgets":
            MessageLookupByLibrary.simpleMessage("Редактировать виджеты"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage(
            "Адрес электронной почты или имя пользователя"),
        "emojis": MessageLookupByLibrary.simpleMessage("Эмоджи"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Эмодзи уже существует!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Недопустимый краткий код эмодзи!"),
        "emotePacks":
            MessageLookupByLibrary.simpleMessage("Наборы эмодзи для комнаты"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Настройки эмодзи"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Краткий код для эмодзи"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Вам нужно задать код эмодзи и изображение!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Пустой чат"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Включить набор эмодзи глобально"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Включить шифрование"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Вы больше не сможете отключить шифрование. Вы уверены?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(БЕТА) Включить несколько учетных записей на этом устройстве"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Зашифровано"),
        "encryption": MessageLookupByLibrary.simpleMessage("Шифрование"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Шифрование не включено"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Введите название группы"),
        "enterASpacepName": MessageLookupByLibrary.simpleMessage(
            "Введите название пространства"),
        "enterAnEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Введите адрес электронной почты"),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Войти в комнату"),
        "enterSpace":
            MessageLookupByLibrary.simpleMessage("Войти в пространство"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage(
            "Введите адрес вашего сервера Matrix"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Ошибка при добавлении виджета."),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("Всё готово!"),
        "experimentalVideoCalls": MessageLookupByLibrary.simpleMessage(
            "Экспериментальные видеозвонки"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Крайне оскорбительный"),
        "fileName": MessageLookupByLibrary.simpleMessage("Имя файла"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Размер шрифта"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "Это уведомление появляется, когда запущена основная служба."),
        "forward": MessageLookupByLibrary.simpleMessage("Переслать"),
        "fromJoining":
            MessageLookupByLibrary.simpleMessage("С момента присоединения"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("С момента приглашения"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("В новую комнату"),
        "group": MessageLookupByLibrary.simpleMessage("Группа"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Описание группы"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Описание группы изменено"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Публичная группа"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Группы"),
        "guestsAreForbidden": MessageLookupByLibrary.simpleMessage(
            "Гости не могут присоединиться"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Гости могут присоединиться"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Помощь"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage(
            "Скрыть отредактированные события"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("Скрыть неизвестные события"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Сервер Matrix"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Насколько оскорбительным является этот контент?"),
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Восстановить из файла резервной копии"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "Пользователи TOR: Импорт экспорта сессии"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "В прошлый раз вы экспортировали свою сессию в TOR? Быстро импортируйте его и продолжайте общение."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Я перешёл по ссылке"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Я понимаю"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Идентификация"),
        "ignore": MessageLookupByLibrary.simpleMessage("Игнорировать"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Вы можете игнорировать пользователей, которые вам мешают. Вы не сможете получать сообщения или приглашения в комнату от пользователей из вашего личного списка игнорирования."),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage(
            "Игнорировать имя пользователя"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Игнорируемые пользователи"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Неверный пароль или ключ восстановления"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "К сожалению, по умолчанию хранилище сообщений не включено в приватном режиме.\nПожалуйста, посетите\n  - about:config\n  - установите для dom.indexedDB.privateBrowsing.enabled значение true\nВ противном случае запуск FluffyChat будет невозможен."),
        "indexedDbErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Проблемы с приватным режимом"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Безобидный"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Пригласить контакт"),
        "inviteContactToGroup": m36,
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Приглашение для меня"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Приглашён"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage(
            "Только приглашённым пользователям"),
        "isTyping": MessageLookupByLibrary.simpleMessage("печатает…"),
        "joinRoom":
            MessageLookupByLibrary.simpleMessage("Присоединиться к комнате"),
        "joinedTheChat": m39,
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Исключить из чата"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("был(а) в сети давно"),
        "leave": MessageLookupByLibrary.simpleMessage("Покинуть"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Покинуть чат"),
        "license": MessageLookupByLibrary.simpleMessage("Лицензия"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Светлая"),
        "link": MessageLookupByLibrary.simpleMessage("Ссылка"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Загрузить больше…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Загрузка... Пожалуйста, подождите."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Службы определения местоположения отключены. Включите их, чтобы иметь возможность обмениваться информацией о своем местоположении."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Разрешение на определение местоположения отклонено. Пожалуйста, предоставьте это разрешение, чтобы иметь возможность делиться своим местоположением."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Войти"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Вход одним нажатием"),
        "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Убедитесь, что идентификатор действителен"),
        "markAsRead":
            MessageLookupByLibrary.simpleMessage("Отметить как прочитанное"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Виджеты Matrix"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Изменения участников"),
        "mention": MessageLookupByLibrary.simpleMessage("Упомянуть"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Информация о сообщении"),
        "messageType": MessageLookupByLibrary.simpleMessage("Тип сообщения"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Сообщение будет удалено для всех участников"),
        "messages": MessageLookupByLibrary.simpleMessage("Сообщения"),
        "moderator": MessageLookupByLibrary.simpleMessage("Модератор"),
        "muteChat":
            MessageLookupByLibrary.simpleMessage("Отключить уведомления"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Помните, что вам нужен Pantalaimon для использования сквозного шифрования."),
        "newChat": MessageLookupByLibrary.simpleMessage("Новый чат"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Новая группа"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 Новое сообщение во FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Новое пространство"),
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "Новый запрос на подтверждение!"),
        "next": MessageLookupByLibrary.simpleMessage("Далее"),
        "nextAccount":
            MessageLookupByLibrary.simpleMessage("Следующая учётная запись"),
        "no": MessageLookupByLibrary.simpleMessage("Нет"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Нет соединения с сервером"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите действительный адрес электронной почты. В противном случае вы не сможете сбросить пароль. Если вы не хотите этого делать, нажмите еще раз на кнопку, чтобы продолжить."),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Эмодзи не найдены 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Вы можете активировать шифрование только тогда, когда комната перестает быть общедоступной."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Похоже, у вас нет служб Google на вашем телефоне. Это хорошее решение для вашей конфиденциальности! Для получения push-уведомлений во FluffyChat мы рекомендуем использовать https://microg.org/ или https://unifiedpush.org/."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "Это может произойти, если сообщение было отправлено до того, как вы вошли в свою учетную запись на данном устройстве.\n\nТакже возможно, что отправитель заблокировал ваше устройство или что-то пошло не так с интернет-соединением.\n\nВы можете прочитать сообщение на другой сессии? Тогда вы можете перенести сообщение с неё! Перейдите в Настройки > Устройства и убедитесь, что ваши устройства проверили друг друга. Когда вы откроете комнату в следующий раз и обе сессии будут открыты, ключи будут переданы автоматически.\n\nВы не хотите потерять ключи при выходе из системы или переключении устройств? Убедитесь, что вы включили резервное копирование чата в настройках."),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Вы ещё не добавили способ восстановления пароля."),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Нет прав доступа"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Комнаты не найдены…"),
        "none": MessageLookupByLibrary.simpleMessage("Ничего"),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Уведомления включены для этой учётной записи"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Получение местоположения…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Оскорбительный"),
        "offline": MessageLookupByLibrary.simpleMessage("Не в сети"),
        "ok": MessageLookupByLibrary.simpleMessage("Ок"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Один из ваших клиентов вышел"),
        "online": MessageLookupByLibrary.simpleMessage("В сети"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Резервное копирование ключей на сервере включено"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Ой! К сожалению, при настройке push-уведомлений произошла ошибка."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Упс! Что-то пошло не так…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Откройте приложение для чтения сообщений"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Открыть камеру"),
        "openChat": MessageLookupByLibrary.simpleMessage("Открыть чат"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Открыть галерею"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Открыть на картах"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("Открыть камеру для видео"),
        "optionalGroupName": MessageLookupByLibrary.simpleMessage(
            "(необязательно) Название группы"),
        "or": MessageLookupByLibrary.simpleMessage("Или"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Микрофон, камера и другие разрешения FluffyChat"),
        "participant": MessageLookupByLibrary.simpleMessage("Участник"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "пароль или ключ восстановления"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Забыли пароль"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Пароль был изменён"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Восстановление пароля"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Пароли не совпадают!"),
        "people": MessageLookupByLibrary.simpleMessage("Люди"),
        "pickImage":
            MessageLookupByLibrary.simpleMessage("Выбрать изображение"),
        "pin": MessageLookupByLibrary.simpleMessage("Закрепить"),
        "pinMessage":
            MessageLookupByLibrary.simpleMessage("Прикрепить к комнате"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Совершить звонок"),
        "play": m48,
        "pleaseChoose":
            MessageLookupByLibrary.simpleMessage("Пожалуйста, выберите"),
        "pleaseChooseAPasscode": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, выберите код доступа"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, выберите имя пользователя"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, нажмите на ссылку в электронной почте, для того чтобы продолжить."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Введите 4 цифры или оставьте поле пустым, чтобы отключить блокировку приложения."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите Matrix ID."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Введите ключ восстановления:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Чтобы разблокировать старые сообщения, введите ключ восстановления, сгенерированный в предыдущем сеансе. Ваш ключ восстановления НЕ является вашим паролем."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите действительный адрес электронной почты."),
        "pleaseEnterYourPassword": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите ваш пароль"),
        "pleaseEnterYourPin": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите свой пин-код"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите имя пользователя"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Следуйте инструкциям на веб-сайте и нажмите «Далее»."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Предыдущая учётная запись"),
        "privacy": MessageLookupByLibrary.simpleMessage("Конфиденциальность"),
        "publicRooms":
            MessageLookupByLibrary.simpleMessage("Публичные комнаты"),
        "publish": MessageLookupByLibrary.simpleMessage("Опубликовать"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Правила push"),
        "reactedWith": m50,
        "reason": MessageLookupByLibrary.simpleMessage("Причина"),
        "recording": MessageLookupByLibrary.simpleMessage("Запись"),
        "recoveryKey":
            MessageLookupByLibrary.simpleMessage("Ключ восстановления"),
        "recoveryKeyLost":
            MessageLookupByLibrary.simpleMessage("Ключ восстановления утерян?"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Отредактировать сообщение"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "reject": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Зайти повторно"),
        "remove": MessageLookupByLibrary.simpleMessage("Удалить"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Удалить все другие устройства"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Удалить устройство"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Удалить из этого пакета"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Удалить из пространства"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Удалить свой аватар"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Показывать текст с форматированием"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Повторите пароль"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Заменить комнату более новой версией"),
        "reply": MessageLookupByLibrary.simpleMessage("Ответить"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Ответ отправлен"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Сообщить о сообщении"),
        "reportUser":
            MessageLookupByLibrary.simpleMessage("Сообщить о пользователе"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Запросить разрешение"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Комната обновлена"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Версия комнаты"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Сохранить файл"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Сохраните этот ключ вручную, вызвав диалог общего доступа системы или буфера обмена."),
        "scanQrCode":
            MessageLookupByLibrary.simpleMessage("Сканировать QR-код"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Вы делитесь своим экраном в FuffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("общий доступ к экрану"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "security": MessageLookupByLibrary.simpleMessage("Безопасность"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Отправить сообщение"),
        "sendAsText":
            MessageLookupByLibrary.simpleMessage("Отправить как текст"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Отправить аудио"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Отправить файл"),
        "sendImage":
            MessageLookupByLibrary.simpleMessage("Отправить изображение"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Отправить сообщения"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Отправлять по Enter"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Отправить оригинал"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Отправить стикер"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Отправить видео"),
        "sender": MessageLookupByLibrary.simpleMessage("Отправитель"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Разделять личные чаты и группы"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Этот сервер должен подтвердить ваш адрес электронной почты для регистрации."),
        "setAsCanonicalAlias": MessageLookupByLibrary.simpleMessage(
            "Установить как основной псевдоним"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Установить пользовательские эмодзи"),
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("Задать описание группы"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage(
            "Установить ссылку для приглашения"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage(
            "Установить уровень разрешений"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Задать статус"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "share": MessageLookupByLibrary.simpleMessage("Поделиться"),
        "shareLocation":
            MessageLookupByLibrary.simpleMessage("Поделиться местоположением"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Поделиться ссылкой приглашения"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Показывать связанные Личные чаты в Пространствах"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Показать пароль"),
        "signUp": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Единая точка входа"),
        "skip": MessageLookupByLibrary.simpleMessage("Пропустить"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Исходный код"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Публичное пространство"),
        "spaceName":
            MessageLookupByLibrary.simpleMessage("Название пространства"),
        "start": MessageLookupByLibrary.simpleMessage("Начать"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Статус"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Как у вас сегодня дела?"),
        "storeInAndroidKeystore": MessageLookupByLibrary.simpleMessage(
            "Сохранить в Android KeyStore"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("Сохранить в Apple KeyChain"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Сохраните ключ восстановления в безопасном хранилище этого устройства."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Сохранить на этом устройстве"),
        "stories": MessageLookupByLibrary.simpleMessage("Истории"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Обратите внимание, что люди могут видеть и связываться друг с другом в вашей истории. Ваши истории будут видны в течение 24 часов, но нет гарантии, что они будут удалены со всех устройств и серверов."),
        "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Синхронизация… Пожалуйста, подождите."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Системная"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Они не совпадают"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Они совпадают"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Этот пользователь еще ничего не опубликовал в своей истории"),
        "time": MessageLookupByLibrary.simpleMessage("Время"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Переключить избранное"),
        "toggleMuted":
            MessageLookupByLibrary.simpleMessage("Переключить без звука"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage(
            "Отметить как прочитанное/непрочитанное"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Слишком много запросов. Пожалуйста, повторите попытку позже!"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Перенос с другого устройства"),
        "tryToSendAgain": MessageLookupByLibrary.simpleMessage(
            "Попробуйте отправить ещё раз"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Недоступен"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Разблокировать в чате"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Разблокировать устройство"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Неизвестное устройство"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Неизвестный алгоритм шифрования"),
        "unlockOldMessages": MessageLookupByLibrary.simpleMessage(
            "Разблокировать старые сообщения"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Включить уведомления"),
        "unpin": MessageLookupByLibrary.simpleMessage("Открепить"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Отписаться от историй"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Неподдерживаемая версия Android"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Для этой функции требуется более новая версия Android. Проверьте наличие обновлений или поддержку Lineage OS."),
        "unverified": MessageLookupByLibrary.simpleMessage("Не проверено"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "Доступно обновление для FluffyChat"),
        "updateNow":
            MessageLookupByLibrary.simpleMessage("Обновить в фоновом режиме"),
        "user": MessageLookupByLibrary.simpleMessage("Пользователь"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
        "users": MessageLookupByLibrary.simpleMessage("Пользователи"),
        "verified": MessageLookupByLibrary.simpleMessage("Проверено"),
        "verify": MessageLookupByLibrary.simpleMessage("Проверить"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("Начать проверку"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Вы успешно проверены!"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage(
            "Проверка другой учётной записи"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Видеозвонок"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Обратите внимание, что видеозвонки в настоящее время находятся в бета-версии. Они могут работать не так, как ожидалось, или вообще не работать на всех платформах."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("Видимость истории чата"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("Видима для всех участников"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Видна всем"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Голосовой звонок"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage(
            "Отправить голосовое сообщение"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Жду, когда партнер примет запроc…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Жду, когда партнер примет эмодзи…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "В ожидании партнёра, чтобы принять числа…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Обои"),
        "warning": MessageLookupByLibrary.simpleMessage("Предупреждение!"),
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "Мы отправили вам электронное письмо"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("Что происходит?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Кто и какое действие может выполнять"),
        "whoCanSeeMyStories": MessageLookupByLibrary.simpleMessage(
            "Кто может видеть мои истории?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Обратите внимание, что люди могут видеть и связываться друг с другом в вашей истории."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Кому разрешено вступать в эту группу"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Почему вы хотите сообщить об этом?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "Почему это сообщение нечитаемо?"),
        "widgetCustom":
            MessageLookupByLibrary.simpleMessage("Пользовательский"),
        "widgetEtherpad":
            MessageLookupByLibrary.simpleMessage("Текстовая записка"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Совещание Jitsi"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Имя"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, укажите отображаемое имя."),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("Этот URL не действителен."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Видео"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Удалить резервную копию чата, чтобы создать новый ключ восстановления?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "По этим адресам вы можете восстановить свой пароль."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Напишите сообщение…"),
        "yes": MessageLookupByLibrary.simpleMessage("Да"),
        "you": MessageLookupByLibrary.simpleMessage("Вы"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Вы приняли приглашение"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("Вы приглашены в этот чат"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Вы больше не участвуете в этом чате"),
        "youBannedUser": m77,
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "Вы не можете пригласить себя"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Вы были заблокированы в этом чате"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("Вы присоединились к чату"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Вы отклонили приглашение"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Резервное копирование чата настроено."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Ваш открытый ключ"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Ваша история")
      };
}
