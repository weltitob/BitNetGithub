// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  static String m0(username) => "👍 ${username} погоджується на запрошення";

  static String m1(username) => "🔐 ${username} активує наскрізне шифрування";

  static String m2(senderName) => "${senderName} відповідає на виклик";

  static String m3(username) =>
      "Прийняти цей запит на підтвердження від ${username}?";

  static String m4(username, targetName) => "${username} блокує ${targetName}";

  static String m5(uri) => "Не вдалося відкрити URI ${uri}";

  static String m6(username) => "${username} змінює аватар бесіди";

  static String m7(username, description) =>
      "${username} змінює опис бесіди на: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} змінює назву бесіди на: \'${chatname}\'";

  static String m9(username) => "${username} змінює права доступу бесіди";

  static String m10(username, displayname) =>
      "${username} змінює показуване ім\'я на: \'${displayname}\'";

  static String m11(username) =>
      "${username} змінює правила гостьового доступу";

  static String m12(username, rules) =>
      "${username} змінює правила гостьового доступу на: ${rules}";

  static String m13(username) => "${username} змінює видимість історії";

  static String m14(username, rules) =>
      "${username} змінює видимість історії на: ${rules}";

  static String m15(username) => "${username} змінює правила приєднання";

  static String m16(username, joinRules) =>
      "${username} змінює правила приєднання на: ${joinRules}";

  static String m17(username) => "${username} змінює аватар";

  static String m18(username) => "${username} змінює псевдоніми кімнати";

  static String m19(username) => "${username} змінює посилання для запрошення";

  static String m20(command) => "${command} не є командою.";

  static String m21(error) => "Помилка розшифрування повідомлення: ${error}";

  static String m22(count) => "${count} файлів";

  static String m23(count) => "Учасників: ${count}";

  static String m24(username) => "💬 ${username} створює бесіду";

  static String m25(senderName) => "${senderName} пригортається до вас";

  static String m26(date, timeOfDay) => "${timeOfDay}, ${date}";

  static String m27(year, month, day) => "${day}-${month}-${year}";

  static String m28(month, day) => "${day}-${month}";

  static String m29(senderName) => "${senderName} завершує виклик";

  static String m30(error) =>
      "Помилка під час отримання розташування: ${error}";

  static String m31(path) => "Файл збережено в ${path}";

  static String m32(senderName) => "${senderName} надсилає вам гугл-очі";

  static String m33(displayname) => "Група з ${displayname}";

  static String m34(username, targetName) =>
      "${username} відкликає запрошення для ${targetName}";

  static String m35(senderName) => "${senderName} обіймає вас";

  static String m36(groupName) => "Запросити контакт до ${groupName}";

  static String m37(username, link) =>
      "${username} запрошує вас у FluffyChat. \n1. Установіть FluffyChat: http://fluffychat.im \n2. Зареєструйтесь або увійдіть \n3. Відкрийте запрошувальне посилання: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} запрошує ${targetName}";

  static String m39(username) => "👋 ${username} приєднується до бесіди";

  static String m40(username, targetName) =>
      "👞 ${username} вилучає ${targetName}";

  static String m41(username, targetName) =>
      "🙅 ${username} вилучає та блокує ${targetName}";

  static String m42(localizedTimeShort) =>
      "Остання активність: ${localizedTimeShort}";

  static String m43(count) => "Завантажити ще ${count} учасників";

  static String m44(homeserver) => "Увійти до ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} не є сервером matrix, використовувати ${server2} натомість?";

  static String m46(number) => "${number} бесід";

  static String m47(count) => "${count} користувачів пишуть…";

  static String m48(fileName) => "Відтворити ${fileName}";

  static String m49(min) => "Виберіть принаймні ${min} символів.";

  static String m50(sender, reaction) => "${sender} реагує з ${reaction}";

  static String m51(username) => "${username} змінює подію";

  static String m52(username) => "${username} відхиляє запрошення";

  static String m53(username) => "Вилучено користувачем ${username}";

  static String m54(username) => "Переглянуто ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Переглянули ${username} і ${count} інших')}";

  static String m56(username, username2) =>
      "Переглянули ${username} і ${username2}";

  static String m57(username) => "📁 ${username} надсилає файл";

  static String m58(username) => "🖼️ ${username} надсилає зображення";

  static String m59(username) => "😊 ${username} надсилає наліпку";

  static String m60(username) => "🎥 ${username} надсилає відео";

  static String m61(username) => "🎤 ${username} надсилає аудіо";

  static String m62(senderName) =>
      "${senderName} надсилає відомості про виклик";

  static String m63(username) => "${username} ділиться своїм місцеперебуванням";

  static String m64(senderName) => "${senderName} розпочинає виклик";

  static String m65(date, body) => "Історія за ${date}: \n${body}";

  static String m66(mxid) => "Це має бути ${mxid}";

  static String m67(number) => "Перемкнутися на обліковий запис ${number}";

  static String m68(username, targetName) =>
      "${username} розблоковує ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 непрочитана бесіда', few: '${unreadCount} непрочитані бесіди', many: '${unreadCount} непрочитаних бесід', other: '${unreadCount} непрочитані бесіди')}";

  static String m70(username, count) => "${username} та ${count} інших пишуть…";

  static String m71(username, username2) =>
      "${username} і ${username2} пишуть…";

  static String m72(username) => "${username} пише…";

  static String m73(username) => "🚪 ${username} виходить з бесіди";

  static String m74(username, type) => "${username} надсилає подію ${type}";

  static String m75(size) => "Відео (${size})";

  static String m76(oldDisplayName) =>
      "Порожня бесіда (раніше ${oldDisplayName})";

  static String m77(user) => "Ви заблокували ${user}";

  static String m78(user) => "Ви відкликали запрошення для ${user}";

  static String m79(user) => "📩 Ви були запрошені ${user}";

  static String m80(user) => "📩 Ви запросили ${user}";

  static String m81(user) => "👞 Ви вилучили ${user}";

  static String m82(user) => "🙅 Ви вилучили й заблокували ${user}";

  static String m83(user) => "Ви розблокували ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Про застосунок"),
        "accept": MessageLookupByLibrary.simpleMessage("Прийняти"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Обліковий запис"),
        "activatedEndToEndEncryption": m1,
        "addAccount":
            MessageLookupByLibrary.simpleMessage("Додати обліковий запис"),
        "addDescription": MessageLookupByLibrary.simpleMessage("Додати опис"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Додати е-пошту"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Додати опис групи"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("Додати до вузлів"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("Додати простір"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Виберіть простір, щоб додати до нього цю бесіду."),
        "addToStory": MessageLookupByLibrary.simpleMessage("Додати до історії"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Додати віджет"),
        "admin": MessageLookupByLibrary.simpleMessage("Адміністратор"),
        "alias": MessageLookupByLibrary.simpleMessage("псевдонім"),
        "all": MessageLookupByLibrary.simpleMessage("Усі"),
        "allChats": MessageLookupByLibrary.simpleMessage("Усі бесіди"),
        "allRooms": MessageLookupByLibrary.simpleMessage("Усі групові бесіди"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Усі простори"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Будь-хто може приєднатись"),
        "appLock":
            MessageLookupByLibrary.simpleMessage("Блокування застосунку"),
        "appearOnTop":
            MessageLookupByLibrary.simpleMessage("З\'являтися зверху"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Дозволяє застосунку показуватися зверху (не потрібно, якщо Fluffychat вже налаштований обліковим записом для викликів)"),
        "archive": MessageLookupByLibrary.simpleMessage("Архів"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Чи дозволено гостям приєднуватись"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Ви впевнені?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Ви впевнені, що хочете вийти?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Для підпису ключа іншого користувача введіть свою парольну фразу або ключ відновлення."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Автоматично відтворювати анімовані наліпки та емоджі"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Заблокувати в бесіді"),
        "banned": MessageLookupByLibrary.simpleMessage("Заблоковано"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Заблокувати пристрій"),
        "blocked": MessageLookupByLibrary.simpleMessage("Заблоковано"),
        "botMessages":
            MessageLookupByLibrary.simpleMessage("Повідомлення ботів"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Розмір бульбашки"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Назва вузла"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Обліковий запис для виклику"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Дозволяє FluffyChat використовувати основний застосунок Android для набору номера."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Дозволи на виклик"),
        "cancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Змінити назву пристрою"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Змінити пароль"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Змінити домашній сервер"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Змінити назву групи"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Змінити стиль"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage("Змінити тло"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Змінити аватар"),
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
            MessageLookupByLibrary.simpleMessage("Шифрування було пошкоджено"),
        "chat": MessageLookupByLibrary.simpleMessage("Бесіда"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Резервне копіювання бесіди"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Ваші старі повідомлення захищені ключем відновлення. Переконайтеся, що ви не втратите його."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Подробиці бесіди"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "Бесіду додано до цього простору"),
        "chats": MessageLookupByLibrary.simpleMessage("Бесіди"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Виберіть надійний пароль"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Виберіть ім\'я користувача"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Очистити архів"),
        "close": MessageLookupByLibrary.simpleMessage("Закрити"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Заблокувати цього користувача кімнати"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Очистити кеш"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Створіть порожню групову бесіду\nВикористовуйте --no-encryption, щоб вимкнути шифрування"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Надіслати пригортайку"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Відкинути сеанс"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Початок особистої бесіди\nВикористовуйте --no-encryption, що вимкнути шифрування"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Надіслати кілька гугл-очей"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Надіслати текст у форматі HTML"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Надіслати обійми"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Запросіть цього користувача до цієї кімнати"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Приєднатися до цієї кімнати"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Вилучити цього користувача з цієї кімнати"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Вийти з цієї кімнати"),
        "commandHint_markasdm": MessageLookupByLibrary.simpleMessage(
            "Позначити кімнатою особистого спілкування"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Позначити групою"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Опишіть себе"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Встановіть зображення для цієї кімнати (від mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Укажіть показуване ім\'я для цієї кімнати"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Укажіть рівень повноважень цього користувача (типово: 50)"),
        "commandHint_plain": MessageLookupByLibrary.simpleMessage(
            "Надіслати неформатований текст"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Надіслати відповідь як реакцію"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Надіслати текст"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Розблокувати цього користувача у цій кімнаті"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Неприпустима команда"),
        "commandMissing": m20,
        "compareEmojiMatch":
            MessageLookupByLibrary.simpleMessage("Порівняйте емодзі"),
        "compareNumbersMatch":
            MessageLookupByLibrary.simpleMessage("Порівняйте цифри"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Налаштувати бесіду"),
        "confirm": MessageLookupByLibrary.simpleMessage("Підтвердити"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Ви впевнені, що бажаєте назавжди відкріпите подію?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Підтвердьте свій Matrix ID, щоб видалити свій обліковий запис."),
        "connect": MessageLookupByLibrary.simpleMessage("Під\'єднатись"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Контакт був запрошений в групу"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Містить показуване ім’я"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Містить ім’я користувача"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "Скаргу на вміст надіслано адміністраторам сервера"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Скопійовано в буфер обміну"),
        "copy": MessageLookupByLibrary.simpleMessage("Копіювати"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Копіювати до буфера обміну"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Створити"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Створити нову групу"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Новий простір"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Зараз у мережі"),
        "custom": MessageLookupByLibrary.simpleMessage("Користувацький"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Темний"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Це деактивує ваш обліковий запис. Це неможливо скасувати! Ви впевнені?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Типовий рівень дозволів"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Експортувати сеанс та очистити пристрій"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "Користувачі TOR: експорт сеансу"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Для користувачів TOR рекомендується експортувати сеанс перед закриттям вікна."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Цю дію не можна скасувати. Переконайтеся, що ви безпечно зберігаєте файл резервної копії."),
        "delete": MessageLookupByLibrary.simpleMessage("Видалити"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Видалити обліковий запис"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Видалити повідомлення"),
        "deny": MessageLookupByLibrary.simpleMessage("Відхилити"),
        "device": MessageLookupByLibrary.simpleMessage("Пристрій"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ID пристрою"),
        "deviceKeys": MessageLookupByLibrary.simpleMessage("Ключі пристрою:"),
        "devices": MessageLookupByLibrary.simpleMessage("Пристрої"),
        "directChats": MessageLookupByLibrary.simpleMessage("Особисті бесіди"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "З міркувань безпеки ви не можете вимкнути шифрування в бесіді, ув якій воно було ввімкнене раніше."),
        "discover": MessageLookupByLibrary.simpleMessage("Огляд"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Відхилити"),
        "displaynameHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Показуване ім\'я було змінено"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Не показувати знову"),
        "downloadFile":
            MessageLookupByLibrary.simpleMessage("Завантажити файл"),
        "edit": MessageLookupByLibrary.simpleMessage("Редагувати"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Редагувати заблоковані сервери"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Змінити вузол для цього облікового запису"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Редагувати дозволи бесіди"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Змінити показуване ім\'я"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Змінити псевдоніми кімнати"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Змінити аватар кімнати"),
        "editWidgets":
            MessageLookupByLibrary.simpleMessage("Редагувати віджети"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage(
            "Електронна адреса або ім’я користувача"),
        "emojis": MessageLookupByLibrary.simpleMessage("Емоджі"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Емодзі вже існує!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Неприпустимий короткий код емодзі!"),
        "emotePacks":
            MessageLookupByLibrary.simpleMessage("Набори емоджі для кімнати"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Налаштування емодзі"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Короткий код для емодзі"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Укажіть короткий код емодзі та зображення!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Порожня бесіда"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Увімкнути пакунок емоджі глобально"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Увімкнути шифрування"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Ви більше не зможете вимкнути шифрування. Ви впевнені?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(БЕТА) Увімкнути кілька облікових записів на цьому пристрої"),
        "encryptThisChat":
            MessageLookupByLibrary.simpleMessage("Зашифрувати цю бесіду"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Зашифровано"),
        "encryption": MessageLookupByLibrary.simpleMessage("Шифрування"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Шифрування вимкнено"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("Наскрізне шифрування"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Введіть назву групи"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Введіть назву простору"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Введіть адресу е-пошти"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "Введіть запрошувальне посилання або Matrix ID..."),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Увійти в кімнату"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Увійти в простір"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage(
            "Введіть адресу домашнього сервера"),
        "errorAddingWidget":
            MessageLookupByLibrary.simpleMessage("Помилка додавання віджета."),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("Усе готово!"),
        "experimentalVideoCalls": MessageLookupByLibrary.simpleMessage(
            "Експериментальні відеовиклики"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Украй образливий"),
        "fileHasBeenSavedAt": m31,
        "fileIsTooBigForServer": MessageLookupByLibrary.simpleMessage(
            "Сервер повідомляє, що файл завеликий для надсилання."),
        "fileName": MessageLookupByLibrary.simpleMessage("Назва файлу"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Розмір шрифту"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "Це сповіщення з\'являється під час роботи основної служби."),
        "forward": MessageLookupByLibrary.simpleMessage("Переслати"),
        "fromJoining":
            MessageLookupByLibrary.simpleMessage("З моменту приєднання"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("З моменту запрошення"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Перейти до нової кімнати"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Група"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("Опис групи"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Опис групи було змінено"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Загальнодоступна група"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Групи"),
        "guestsAreForbidden": MessageLookupByLibrary.simpleMessage(
            "Гості не можуть приєднуватись"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Гості можуть приєднуватись"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Довідка"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Сховати змінені події"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Сховати неважливі державні свята"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("Сховати невідомі події"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Домашній сервер"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Наскільки образливий цей вміст?"),
        "hugContent": m35,
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Відновлення з файлу резервної копії"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "Користувачі TOR: імпорт експортованого сеансу"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Минулого разу ви експортували свій сеанс із TOR? Швидко імпортуйте його та продовжуйте спілкування."),
        "iHaveClickedOnLink": MessageLookupByLibrary.simpleMessage(
            "Мною виконано перехід за посиланням"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Я розумію"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Ідентифікація"),
        "ignore": MessageLookupByLibrary.simpleMessage("Нехтувати"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Ви можете нехтувати користувачів, які вас турбують. Ви не зможете отримувати повідомлення або запрошення в кімнату від користувачів у вашому особистому списку нехтування."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Нехтувати ім\'я користувача"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Нехтувані користувачі"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Неправильна парольна фраза або ключ відновлення"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "На жаль, сховище повідомлень не ввімкнуто у приватному режимі типово.\nВідкрийте\n - about:config\n - установіть для dom.indexedDB.privateBrowsing.enabled значення true\nІнакше запустити FluffyChat буде неможливо."),
        "indexedDbErrorTitle":
            MessageLookupByLibrary.simpleMessage("Проблеми приватного режиму"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Необразливий"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Запросити контакт"),
        "inviteContactToGroup": m36,
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Запрошення для мене"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Запрошено"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Лише запрошені користувачі"),
        "isTyping": MessageLookupByLibrary.simpleMessage("пише…"),
        "joinRoom":
            MessageLookupByLibrary.simpleMessage("Приєднатися до кімнати"),
        "joinedTheChat": m39,
        "jump": MessageLookupByLibrary.simpleMessage("Перейти"),
        "jumpToLastReadMessage": MessageLookupByLibrary.simpleMessage(
            "Перейти до останнього прочитаного повідомлення"),
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Вилучити з бесіди"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Давно не було в мережі"),
        "leave": MessageLookupByLibrary.simpleMessage("Вийти"),
        "leftTheChat":
            MessageLookupByLibrary.simpleMessage("Виходить з бесіди"),
        "letsStart": MessageLookupByLibrary.simpleMessage("Розпочнімо"),
        "license": MessageLookupByLibrary.simpleMessage("Ліцензія"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Світлий"),
        "link": MessageLookupByLibrary.simpleMessage("Посилання"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Завантажити ще…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Завантаження… Будь ласка, зачекайте."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Служби визначення місцеположення вимкнені. Увімкніть їх, щоб могти надавати доступ до вашого місцеположення."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Дозвіл на розташування відхилено. Надайте можливість ділитися своїм місцеперебуванням."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Увійти"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Увійти одним натисканням"),
        "logout": MessageLookupByLibrary.simpleMessage("Вийти"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Переконайтеся, що ідентифікатор дійсний"),
        "markAsRead":
            MessageLookupByLibrary.simpleMessage("Позначити прочитаним"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Віджети Matrix"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Зміни учасників"),
        "mention": MessageLookupByLibrary.simpleMessage("Згадати"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Відомості про повідомлення"),
        "messageType": MessageLookupByLibrary.simpleMessage("Тип повідомлення"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Повідомлення буде вилучено для всіх учасників"),
        "messages": MessageLookupByLibrary.simpleMessage("Повідомлення"),
        "moderator": MessageLookupByLibrary.simpleMessage("Модератор"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Вимкнути сповіщення"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Майте на увазі, що на цей час вам потрібен Pantalaimon, щоб використовувати наскрізне шифрування."),
        "newChat": MessageLookupByLibrary.simpleMessage("Нова бесіда"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Нова група"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 Нове повідомлення у FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Новий простір"),
        "newSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Простори дозволяють об\'єднувати ваші бесіди та створювати приватні або загальнодоступні спільноти."),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Новий запит перевірки!"),
        "next": MessageLookupByLibrary.simpleMessage("Далі"),
        "nextAccount":
            MessageLookupByLibrary.simpleMessage("Наступний обліковий запис"),
        "no": MessageLookupByLibrary.simpleMessage("Ні"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "Увага! Якщо ви не ввімкнете резервне копіювання бесіди, ви втратите доступ до своїх зашифрованих повідомлень. Наполегливо радимо ввімкнути резервне копіювання бесіди перед виходом."),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Немає з\'єднання з сервером"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Введіть справжню адресу електронної пошти. В іншому випадку ви не зможете скинути пароль. Якщо ви цього не хочете, торкніться кнопки ще раз, щоб продовжити."),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Емоджі не знайдено. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Активувати шифрування можна лише тоді, коли кімната більше не буде загальнодоступною."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Схоже, на вашому телефоні немає служб Google. Це гарне рішення для вашої приватності! Щоб отримувати push-сповіщення у FluffyChat, ми радимо використовувати https://microg.org/ або https://unifiedpush.org/."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "Це може статися, якщо повідомлення було надіслано до того, як ви ввійшли у свій обліковий запис на цьому пристрої.\n\nТакож можливо, що відправник заблокував ваш пристрій або щось пішло не так з під\'єднанням до інтернету.\n\nЧи можете ви прочитати повідомлення на іншому сеансі? Тоді ви зможете перенести повідомлення з нього! Перейдіть до Налаштування > Пристрої та переконайтеся, що ваші пристрої перевірили один одного. Коли ви відкриєте кімнату наступного разу й обидва сеанси будуть на активні, ключі будуть передані автоматично.\n\nВи ж не хочете втрачати ключі після виходу або зміни пристроїв? Переконайтеся, що ви ввімкнули резервне копіювання бесід у налаштуваннях."),
        "noMatrixServer": m45,
        "noOtherDevicesFound":
            MessageLookupByLibrary.simpleMessage("Інших пристроїв не знайдено"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Ви ще не додали спосіб відновлення пароля."),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Немає прав доступу"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Кімнат не знайдено…"),
        "none": MessageLookupByLibrary.simpleMessage("Нічого"),
        "notifications": MessageLookupByLibrary.simpleMessage("Сповіщення"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Сповіщення ввімкнені для цього облікового запису"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Отримання розташування…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Образливий"),
        "offline": MessageLookupByLibrary.simpleMessage("Офлайн"),
        "ok": MessageLookupByLibrary.simpleMessage("Гаразд"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "На одному з ваших клієнтів виконано вихід із системи"),
        "online": MessageLookupByLibrary.simpleMessage("Онлайн"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Резервне онлайн-копіювання ключів увімкнено"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Дідько! На жаль, сталася помилка під час налаштування push-сповіщень."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Халепа, щось пішло не так…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Відкрийте застосунок читання повідомлень"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Відкрити камеру"),
        "openChat": MessageLookupByLibrary.simpleMessage("Відкрити бесіду"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Відкрити галерею"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Відкрити в картах"),
        "openLinkInBrowser": MessageLookupByLibrary.simpleMessage(
            "Відкрити посилання у браузері"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("Відкрити камеру для відео"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Необов’язково) Назва групи"),
        "or": MessageLookupByLibrary.simpleMessage("Або"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Мікрофон, камера та інші дозволи FluffyChat"),
        "participant": MessageLookupByLibrary.simpleMessage("Учасник"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "парольна фраза або ключ відновлення"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Забули пароль"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Пароль змінено"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Відновлення пароля"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Паролі не збігаються!"),
        "people": MessageLookupByLibrary.simpleMessage("Люди"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Вибрати зображення"),
        "pin": MessageLookupByLibrary.simpleMessage("Закріпити"),
        "pinMessage":
            MessageLookupByLibrary.simpleMessage("Прикріпити в кімнаті"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Здійснити виклик"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Виберіть"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Виберіть код доступу"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("Виберіть ім\'я користувача"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Натисніть на посилання в електронному листі, а потім продовжуйте."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Введіть 4 цифри або залиште порожнім, щоб вимкнути блокування застосунку."),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("Введіть Matrix ID."),
        "pleaseEnterRecoveryKey":
            MessageLookupByLibrary.simpleMessage("Введіть ключ відновлення:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Щоб розблокувати старі повідомлення, введіть ключ відновлення, згенерований у попередньому сеансі. Ваш ключ відновлення це НЕ ваш пароль."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Введіть дійсну адресу е-пошти."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Введіть свій пароль"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Введіть свій PIN-код"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Введіть своє ім\'я користувача"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Виконайте вказівки вебсайту та торкніться далі."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Попередній обліковий запис"),
        "privacy": MessageLookupByLibrary.simpleMessage("Приватність"),
        "publicRooms":
            MessageLookupByLibrary.simpleMessage("Загальнодоступні кімнати"),
        "publish": MessageLookupByLibrary.simpleMessage("Опублікувати"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Правила сповіщень"),
        "reactedWith": m50,
        "readUpToHere": MessageLookupByLibrary.simpleMessage("Читати тут"),
        "reason": MessageLookupByLibrary.simpleMessage("Причина"),
        "recording": MessageLookupByLibrary.simpleMessage("Запис"),
        "recoveryKey": MessageLookupByLibrary.simpleMessage("Ключ відновлення"),
        "recoveryKeyLost":
            MessageLookupByLibrary.simpleMessage("Ключ відновлення втрачено?"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Редагувати повідомлення"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Зареєструватися"),
        "reject": MessageLookupByLibrary.simpleMessage("Відхилити"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Приєднатися знову"),
        "remove": MessageLookupByLibrary.simpleMessage("Вилучити"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("Вилучити всі інші пристрої"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Вилучити пристрій"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Вилучити з цього вузла"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Вилучити з простору"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Вилучити свій аватар"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Показувати форматований вміст повідомлення"),
        "reopenChat": MessageLookupByLibrary.simpleMessage("Відновити бесіду"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Повторити пароль"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Замінити кімнату новішою версією"),
        "reply": MessageLookupByLibrary.simpleMessage("Відповісти"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Відповідь надіслано"),
        "report": MessageLookupByLibrary.simpleMessage("повідомити"),
        "reportErrorDescription": MessageLookupByLibrary.simpleMessage(
            "О, ні. Щось пішло не так. Повторіть спробу пізніше. Якщо хочете, можете повідомити про помилку розробникам."),
        "reportMessage": MessageLookupByLibrary.simpleMessage(
            "Поскаржитися на повідомлення"),
        "reportUser":
            MessageLookupByLibrary.simpleMessage("Поскаржився на користувача"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Запит дозволу"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Кімнату було оновлено"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Версія кімнати"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Зберегти файл"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Збережіть цей ключ вручну, запустивши діалогове вікно спільного доступу до системи або буфер обміну."),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Сканувати QR-код"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Ви ділитеся своїм екраном FuffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("спільний доступ до екрана"),
        "search": MessageLookupByLibrary.simpleMessage("Пошук"),
        "security": MessageLookupByLibrary.simpleMessage("Безпека"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Надіслати"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Надіслати повідомлення"),
        "sendAsText":
            MessageLookupByLibrary.simpleMessage("Надіслати як текст"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Надіслати аудіо"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Надіслати файл"),
        "sendImage":
            MessageLookupByLibrary.simpleMessage("Надіслати зображення"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Надсилати повідомлення"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Надсилати натисканням Enter"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Надіслати оригінал"),
        "sendSticker":
            MessageLookupByLibrary.simpleMessage("Надіслати наліпку"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Надіслати відео"),
        "sender": MessageLookupByLibrary.simpleMessage("Відправник"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Розділіть особисті бесіди та групи"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Цей сервер потребує перевірки вашої адресу е-пошти для реєстрації."),
        "setAsCanonicalAlias": MessageLookupByLibrary.simpleMessage(
            "Установити основним псевдонімом"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Установити користувацькі емоджі"),
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("Додати опис групи"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage(
            "Указати посилання для запрошення"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("Указати рівні дозволів"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Указати статус"),
        "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
        "share": MessageLookupByLibrary.simpleMessage("Поділитися"),
        "shareLocation": MessageLookupByLibrary.simpleMessage(
            "Поділитися місцеперебуванням"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Поділіться своїм посиланням запрошення"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Показувати пов\'язані особисті бесіди у просторах"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Показати пароль"),
        "signUp": MessageLookupByLibrary.simpleMessage("Зареєструватися"),
        "singlesignon": MessageLookupByLibrary.simpleMessage("Єдиний вхід"),
        "skip": MessageLookupByLibrary.simpleMessage("Пропустити"),
        "sorryThatsNotPossible":
            MessageLookupByLibrary.simpleMessage("Вибачте... це неможливо"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Джерельний код"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Простір загальнодоступний"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Назва простору"),
        "start": MessageLookupByLibrary.simpleMessage("Почати"),
        "startFirstChat": MessageLookupByLibrary.simpleMessage(
            "Розпочніть свою першу бесіду"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Статус"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Як справи сьогодні?"),
        "storeInAndroidKeystore":
            MessageLookupByLibrary.simpleMessage("Зберегти в Android KeyStore"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("Зберегти в Apple KeyChain"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Збережіть ключ відновлення в безпечному сховищі цього пристрою."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Зберегти безпечно на цей пристрій"),
        "stories": MessageLookupByLibrary.simpleMessage("Історії"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Зверніть увагу, що люди можуть бачити та зв\'язуватися один з одним у вашій історії. Ваші історії будуть видимі впродовж 24 годин, але немає жодної гарантії, що вони будуть видалені з усіх пристроїв і серверів."),
        "submit": MessageLookupByLibrary.simpleMessage("Надіслати"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Синхронізація… Будь ласка, зачекайте."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Системна"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Вони відрізняються"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Вони збігаються"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Цей користувач ще нічого не опублікував у своїй історії"),
        "time": MessageLookupByLibrary.simpleMessage("Час"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Перемикнути вибране"),
        "toggleMuted":
            MessageLookupByLibrary.simpleMessage("Увімкнути/вимкнути звук"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage(
            "Позначити прочитаним/непрочитаним"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Забагато запитів. Спробуйте пізніше!"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Перенесення з іншого пристрою"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Спробуйте надіслати ще раз"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Недоступний"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Розблокувати у бесіді"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Розблокувати пристрій"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Невідомий пристрій"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Невідомий алгоритм шифрування"),
        "unlockOldMessages": MessageLookupByLibrary.simpleMessage(
            "Розблокувати старі повідомлення"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Увімкнути сповіщення"),
        "unpin": MessageLookupByLibrary.simpleMessage("Відкріпити"),
        "unreadChats": m69,
        "unsubscribeStories": MessageLookupByLibrary.simpleMessage(
            "Скасувати підписку на історії"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Непідтримувана версія Android"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Для цієї функції потрібна новіша версія Android. Перевірте наявність оновлень або підтримку Lineage OS."),
        "unverified": MessageLookupByLibrary.simpleMessage("Неперевірений"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "Доступне оновлення FluffyChat"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Почати оновлення у фоновому режимі"),
        "user": MessageLookupByLibrary.simpleMessage("Користувач"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Ім\'я користувача"),
        "users": MessageLookupByLibrary.simpleMessage("Користувачі"),
        "verified": MessageLookupByLibrary.simpleMessage("Перевірений"),
        "verify": MessageLookupByLibrary.simpleMessage("Перевірити"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("Почати перевірку"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Ви успішно перевірені!"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage(
            "Перевірка іншого облікового запису"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Відеовиклик"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Зауважте, що відеовиклики на ранньому етапі розробки. Вони можуть працювати не так, як очікувалося, або взагалі не працювати на всіх платформах."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("Видимість історії бесіди"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("Видима для всіх учасників"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Видима для всіх"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Голосовий виклик"),
        "voiceMessage":
            MessageLookupByLibrary.simpleMessage("Голосове повідомлення"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Очікування прийняття запиту партнером…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Очікування прийняття емоджі партнером…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Очікування прийняття чисел партнером…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Тло"),
        "warning": MessageLookupByLibrary.simpleMessage("Попередження!"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "Ми надіслали вам електронний лист"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("Що відбувається?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Хто і яку дію може виконувати"),
        "whoCanSeeMyStories": MessageLookupByLibrary.simpleMessage(
            "Хто може бачити мої історії?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Зауважте, що у вашій історії люди можуть бачити та зв’язуватися одне з одним."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Кому дозволено приєднуватися до цієї групи"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Чому ви хочете поскаржитися?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "Чому це повідомлення нечитабельне?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Користувацький"),
        "widgetEtherpad":
            MessageLookupByLibrary.simpleMessage("Текстова примітка"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Назва"),
        "widgetNameError":
            MessageLookupByLibrary.simpleMessage("Укажіть коротку назву."),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("Це недійсна URL-адреса."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Відео"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Стерти резервну копію бесіди, щоб створити новий ключ відновлення?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "За допомогою цих адрес ви можете відновити свій пароль."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Написати повідомлення…"),
        "yes": MessageLookupByLibrary.simpleMessage("Так"),
        "you": MessageLookupByLibrary.simpleMessage("Ви"),
        "youAcceptedTheInvitation": MessageLookupByLibrary.simpleMessage(
            "👍 Ви погодилися на запрошення"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Вас запрошують до цієї бесіди"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Ви більше не берете участь у цій бесіді"),
        "youBannedUser": m77,
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("Ви не можете запросити себе"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Ви були заблоковані у цій бесіді"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("Ви приєдналися до бесіди"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Ви відхилили запрошення"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Резервне копіювання бесіди налаштовано."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Ваш відкритий ключ"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Ваша історія")
      };
}
