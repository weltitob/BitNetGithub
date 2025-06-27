// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a cs locale. All the
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
  String get localeName => 'cs';

  static String m0(username) => "👍 ${username} přijal/a pozvání";

  static String m1(username) => "🔐 ${username} aktivoval/a koncové šifrování";

  static String m2(senderName) => "${senderName} odpověděl na hovor";

  static String m3(username) => "Přijmout žádost o ověření od ${username}?";

  static String m4(username, targetName) => "${username} zakázal ${targetName}";

  static String m5(uri) => "Nelze otevřít URI ${uri}";

  static String m6(username) => "${username} změnil avatar chatu";

  static String m7(username, description) =>
      "${username} změnil popis chatu na: „${description}“";

  static String m8(username, chatname) =>
      "${username} změnil jméno chatu na: „${chatname}“";

  static String m9(username) =>
      "${username} změnili nastavení oprávnění v chatu";

  static String m10(username, displayname) =>
      "${username} změnili svoji přezdívku na: ${displayname}";

  static String m11(username) =>
      "${username} změnili přístupová práva pro hosty";

  static String m12(username, rules) =>
      "${username} změnili přístupová práva pro hosty na: ${rules}";

  static String m13(username) =>
      "${username} změnili nastavení viditelnosti historie diskuze";

  static String m14(username, rules) =>
      "${username} změnili nastavení viditelnosti historie diskuze na: ${rules}";

  static String m15(username) =>
      "${username} změnili nastavení pravidel připojení";

  static String m16(username, joinRules) =>
      "${username} změnili nastavení pravidel připojení na: ${joinRules}";

  static String m17(username) => "${username} změnili svůj avatar";

  static String m18(username) =>
      "${username} změnili nastavení aliasů místnosti";

  static String m19(username) =>
      "${username} změnili odkaz k pozvání do místnosti";

  static String m20(command) => "${command} není příkaz.";

  static String m21(error) => "Nebylo možné dešifrovat zprávu: ${error}";

  static String m23(count) => "${count} účastníků";

  static String m24(username) => "💬 ${username} založil/a chat";

  static String m25(senderName) => "${senderName} se s vámi mazlí";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}. ${month}. ${year}";

  static String m28(month, day) => "${day}.${month}";

  static String m29(senderName) => "${senderName} ukončil hovor";

  static String m30(error) => "Chyba při získávání polohy: ${error}";

  static String m32(senderName) =>
      "${senderName} vám posílá kroutící se očička";

  static String m33(displayname) => "Skupina s ${displayname}";

  static String m34(username, targetName) =>
      "${username} stáhl pozvánku pro ${targetName}";

  static String m35(senderName) => "${senderName} vás objímá";

  static String m36(groupName) => "Pozvat kontakt do ${groupName}";

  static String m37(username, link) =>
      "${username} vás pozval na FluffyChat.\n1. Nainstalujte si FluffyChat: https://fluffychat.im\n2. Zaregistrujte se anebo se přihlašte\n3. Otevřete odkaz na pozvánce: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} pozval/a ${targetName}";

  static String m39(username) => "👋 ${username} se připojil/a k chatu";

  static String m40(username, targetName) =>
      "👞 ${username} vyhodil/a ${targetName}";

  static String m41(username, targetName) =>
      "${username} vyhodili a zakázali ${targetName}";

  static String m42(localizedTimeShort) =>
      "Naposledy aktivní: ${localizedTimeShort}";

  static String m43(count) => "Načíst dalších ${count} účastníků";

  static String m44(homeserver) => "Přihlášení k ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} není matrixový server, použít místo toho server ${server2}?";

  static String m47(count) => "${count} uživatelé píší…";

  static String m48(fileName) => "Přehrát ${fileName}";

  static String m49(min) => "Vyberte prosím alespoň ${min} znaků.";

  static String m50(sender, reaction) => "${sender} reagoval s ${reaction}";

  static String m51(username) => "${username} opravili událost";

  static String m52(username) => "${username} odmítli pozvání";

  static String m53(username) => "Odstraněno ${username}";

  static String m54(username) => "Viděno uživatelem ${username}";

  static String m55(username, count) =>
      "Zobrazeno uživatelem ${username} a dalšími ${count}";

  static String m56(username, username2) =>
      "Viděno uživateli ${username} a ${username2}";

  static String m57(username) => "${username} poslali soubor";

  static String m58(username) => "${username} poslali obrázek";

  static String m59(username) => "${username} poslali samolepku";

  static String m60(username) => "${username} poslali video";

  static String m61(username) => "${username} poslali zvukovou nahrávku";

  static String m62(senderName) => "${senderName} odeslal informace o hovoru";

  static String m63(username) => "${username} sdílel jejich polohu";

  static String m64(senderName) => "${senderName} zahájil hovor";

  static String m65(date, body) => "Příběh z ${date}:\n ${body}";

  static String m67(number) => "Přepnout na účet ${number}";

  static String m68(username, targetName) =>
      "${username} zrušili zákaz pro ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 nepřečtený chat', other: '${unreadCount} nepřečtené chaty')}";

  static String m70(username, count) => "${username} a ${count} dalších píší…";

  static String m71(username, username2) => "${username} a ${username2} píší…";

  static String m72(username) => "${username} píše…";

  static String m73(username) => "${username} opustili chat";

  static String m74(username, type) => "${username} poslali událost ${type}";

  static String m75(size) => "Video (${size})";

  static String m77(user) => "Zakázali jste uživatele ${user}";

  static String m78(user) => "Stáhli jste pozvánku pro uživatele ${user}";

  static String m79(user) => "Byli jste pozváni uživatelem ${user}";

  static String m80(user) => "Pozvali jste uživatele ${user}";

  static String m81(user) => "Vykopli jste uživatele ${user}";

  static String m82(user) => "Vykopli jste a zakázali jste uživatele ${user}";

  static String m83(user) => "Zrušili jste zákaz uživateli ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("O aplikaci"),
        "accept": MessageLookupByLibrary.simpleMessage("Přijmout"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Účet"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Přidat účet"),
        "addDescription": MessageLookupByLibrary.simpleMessage("Přidat popis"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Přidat e-mail"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Přidat popis skupiny"),
        "addToBundle":
            MessageLookupByLibrary.simpleMessage("Přidat do balíčku"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Přidat do prostoru"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Vyberte umístění, do kterého chcete tento chat přidat."),
        "addToStory": MessageLookupByLibrary.simpleMessage("Přidat do příběhu"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Přidat widget"),
        "admin": MessageLookupByLibrary.simpleMessage("Správce"),
        "alias": MessageLookupByLibrary.simpleMessage("alias"),
        "all": MessageLookupByLibrary.simpleMessage("Vše"),
        "allChats": MessageLookupByLibrary.simpleMessage("Všechny chaty"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Kdokoliv se může připojit"),
        "appLock": MessageLookupByLibrary.simpleMessage("Zámek aplikace"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivovat"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("Mohou se připojit hosté"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Jste si jistý?"),
        "areYouSureYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("Opravdu se chcete odhlásit?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Pro ověření této osoby zadejte prosím přístupovou frázi k „bezpečnému úložišti“ anebo „klíč pro obnovu“."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Automaticky přehrajte animované nálepky a emoce"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("Zakázat chat"),
        "banned": MessageLookupByLibrary.simpleMessage("Zakázán"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Blokovat zařízení"),
        "blocked": MessageLookupByLibrary.simpleMessage("Zakázán"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Zprávy od bota"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Velikost bubliny"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Název balíčku"),
        "cancel": MessageLookupByLibrary.simpleMessage("Zrušit"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Změnit název zařízení"),
        "changePassword": MessageLookupByLibrary.simpleMessage("Změnit heslo"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Změnit domovský server"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Změnit název skupiny"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Změňte svůj styl"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Změnit pozadí"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Změňte svůj avatar"),
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
            MessageLookupByLibrary.simpleMessage("Šifrování bylo poškozeno"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("Záloha chatu"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Záloha chatu je zabezpečena bezpečnostním klíčem. Ujistěte se, prosím, že klíč neztratíte."),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Bližší údaje o chatu"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "Do tohoto prostoru byl přidán chat"),
        "chats": MessageLookupByLibrary.simpleMessage("Chaty"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Vyberte silné heslo"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Vyberte uživatelské jméno"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Vymazat archiv"),
        "close": MessageLookupByLibrary.simpleMessage("Zavřít"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Zakázat danému uživateli přístup do této místnosti"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Vymazat mezipamět"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Vytvořte prázdný skupinový chat\n K deaktivaci šifrování použijte --no-encryption"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Poslat mazlení"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Zahodit relaci"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Zahajte přímý chat\nK deaktivaci šifrování použijte --no-encryption"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Poslat kroutící se očička"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Odeslat text ve formátu HTML"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Poslat obejmutí"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Pozvěte daného uživatele do této místnosti"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage(
            "Připojte se k dané místnosti"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Odeberte daného uživatele z této místnosti"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Opusťte tuto místnost"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Představ se"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Nastavte si obrázek pro tuto místnost (autor mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Nastavte si váš zobrazovaný název pro tuto místnost"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Nastavit úroveň práv daného uživatele (výchozí: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Odeslat neformátovaný text"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("Odeslat odpověď jako reakci"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Poslat zprávu"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Zrušte zákaz přístupu daného uživatele do této místnosti"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Příkaz je neplatný"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Porovnejte a přesvědčete se, že následující emotikony se shodují na obou zařízeních:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Porovnejte a přesvědčete se, že následující čísla se shodují na obou zařízeních:"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Nastavení chatu"),
        "confirm": MessageLookupByLibrary.simpleMessage("Potvrdit"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Opravdu chcete událost trvale odepnout?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Prosím, potvrďte vaše Matrix ID, abyste mohli smazat váš účet."),
        "connect": MessageLookupByLibrary.simpleMessage("Připojit"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Kontakt byl pozván do skupiny"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Obsahuje zobrazovaný název"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Obsahuje uživatelské jméno"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "Obsah byl nahlášen správcům serveru"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Zkopírováno do schránky"),
        "copy": MessageLookupByLibrary.simpleMessage("Kopírovat"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Zkopírovat do schránky"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Vytvořit"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Založit novou skupinu"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Nový prostor"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Aktuálně aktivní"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Tmavé"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Tímto krokem se deaktivuje váš uživatelský účet. Akci nelze vrátit zpět! Jste si jistí?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Výchozí úroveň oprávnění"),
        "delete": MessageLookupByLibrary.simpleMessage("Smazat"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Smazat účet"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("Smazat zprávu"),
        "deny": MessageLookupByLibrary.simpleMessage("Odmítnout"),
        "device": MessageLookupByLibrary.simpleMessage("Zařízení"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ID zařízení"),
        "devices": MessageLookupByLibrary.simpleMessage("Zařízení"),
        "directChats": MessageLookupByLibrary.simpleMessage("Přímé chatování"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Z bezpečnostních důvodů nemůžete vypnout šifrování v chatu, kde již bylo dříve zapnuto."),
        "dismiss": MessageLookupByLibrary.simpleMessage("Zavrhnout"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Přezdívka byla změněna"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Stáhnout soubor"),
        "edit": MessageLookupByLibrary.simpleMessage("Upravit"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("Upravit zakázané servery"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Upravit balíčky pro tento účet"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Upravit oprávnění chatu"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Změnit přezdívku"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Upravit aliasy místností"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Upravit avatara místnosti"),
        "editWidgets": MessageLookupByLibrary.simpleMessage("Upravit widgety"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage(
            "E-mail nebo uživatelské jméno"),
        "emojis": MessageLookupByLibrary.simpleMessage("Emojis"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Emotikona již existuje!"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("Neplatný kód emotikony!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Balíček emotikonů pro místnost"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Nastavení emotikonů"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Klávesová zkratka emotikonu"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Musíte si vybrat klávesovou zkratku emotikonu a obrázek!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Prázdný chat"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Povolit balíček emotikon všude"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Povolit šifrování"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Šifrování již nebude možné vypnout. Jste si tím jisti?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Na tomto zařízení povolte více účtů"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Šifrováno"),
        "encryption": MessageLookupByLibrary.simpleMessage("Šifrování"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Šifrování není aktivní"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Zadejte název skupiny"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Zadejte název prostoru"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Zadejte e-mailovou adresu"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage(
            "Zadejte svůj domovský server"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Chyba při přidávání widgetu."),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Vše připraveno!"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("Experimentální videohovory"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extrémně urážlivé"),
        "fileName": MessageLookupByLibrary.simpleMessage("Název souboru"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Velikost písma"),
        "forward": MessageLookupByLibrary.simpleMessage("Přeposlat"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("Od vstupu"),
        "fromTheInvitation": MessageLookupByLibrary.simpleMessage("Od pozvání"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Přejít do nové místnost"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Skupina"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Popis skupiny"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Popis skupiny byl změněn"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Skupina je veřejná"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Skupiny"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Hosté jsou zakázáni"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Hosté se mohou připojit"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Pomoc"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Skrýt redigované události"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("Skrýt neznámé události"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Domácí server"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Jak urážlivý je tento obsah?"),
        "hugContent": m35,
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Klikl jsem na odkaz"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Rozumím"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identita"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorovat"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Můžete ignorovat uživatele, kteří vás znepokojují. Nebudete moci přijímat žádné zprávy nebo pozvánky od uživatelů na vašem osobním seznamu ignorovaných."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignorovat uživatelské jméno"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Ignorovaní uživatelé"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Nesprávné přístupové heslo anebo klíč pro obnovu"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Neškodný"),
        "inviteContact": MessageLookupByLibrary.simpleMessage("Pozvat kontakt"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Pozvěte mě"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Pozvaný"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Pouze pozvaní uživatelé"),
        "isTyping": MessageLookupByLibrary.simpleMessage("píše…"),
        "joinRoom":
            MessageLookupByLibrary.simpleMessage("Připojte se k místnosti"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("Vyhodit z chatu"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Viděn velmi dávno"),
        "leave": MessageLookupByLibrary.simpleMessage("Opustit"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Opustil chat"),
        "license": MessageLookupByLibrary.simpleMessage("Licence"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Světlé"),
        "link": MessageLookupByLibrary.simpleMessage("Odkaz"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Načíst další…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Načítání… Prosíme vyčkejte."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Služby určování polohy jsou deaktivovány. Povolte jim, aby mohli sdílet vaši polohu."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Oprávnění k poloze odepřeno. Udělte jim prosím možnost sdílet vaši polohu."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Přihlásit se"),
        "loginWithOneClick": MessageLookupByLibrary.simpleMessage(
            "Přihlaste se jedním kliknutím"),
        "logout": MessageLookupByLibrary.simpleMessage("Odhlásit"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Ujistěte se, že je identifikátor validní"),
        "markAsRead":
            MessageLookupByLibrary.simpleMessage("Označit jako přečtené"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Matrix widgety"),
        "memberChanges": MessageLookupByLibrary.simpleMessage("Změny členů"),
        "mention": MessageLookupByLibrary.simpleMessage("Zmínit se"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Informace o zprávě"),
        "messageType": MessageLookupByLibrary.simpleMessage("Typ zprávy"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Zpráva bude odstraněna pro všechny účastníky"),
        "messages": MessageLookupByLibrary.simpleMessage("Zprávy"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderátor"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Ztlumit chat"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Prosím vezměte na vědomí, že pro použití koncového šifrování je prozatím potřeba použít Pantalaimon."),
        "newChat": MessageLookupByLibrary.simpleMessage("Nový chat"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("Nová zpráva ve FluffyChatu"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Nová žádost o ověření!"),
        "next": MessageLookupByLibrary.simpleMessage("Další"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Další účet"),
        "no": MessageLookupByLibrary.simpleMessage("Ne"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Žádné připojení k serveru"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Prosím zadejte platnou emailovou adresu. V opačném případě nebudete moci obnovit heslo. Pokud nechcete, pokračujte dalším klepnutím na tlačítko."),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage(
            "Nebyly nalezeny žádné emotikony. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Můžete aktivovat šifrování jakmile místnost přestane být veřejně dostupná."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Zdá se, že v telefonu nemáte žádné služby Google. To je dobré rozhodnutí pro vaše soukromí! Chcete-li dostávat push oznámení ve FluffyChat, doporučujeme použít: https://microg.org/ nebo https://unifiedpush.org/."),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Dosud jste nepřidali způsob, jak obnovit své heslo."),
        "noPermission": MessageLookupByLibrary.simpleMessage("Chybí oprávnění"),
        "noRoomsFound": MessageLookupByLibrary.simpleMessage(
            "Nebyly nalezeny žádné místnosti…"),
        "none": MessageLookupByLibrary.simpleMessage("Žádný"),
        "notifications": MessageLookupByLibrary.simpleMessage("Oznámení"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Oznámení povolena pro tento účet"),
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Získávání polohy…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Urážlivé"),
        "offline": MessageLookupByLibrary.simpleMessage("Odpojeni"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Jeden z vašich klientů byl odhlášen"),
        "online": MessageLookupByLibrary.simpleMessage("Připojeni"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Online záloha kíčů je zapnuta"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Jejda! Při nastavování oznámení push došlo bohužel k chybě."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Jejda, něco se pokazilo…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Otevřete aplikaci pro přečtení zpráv"),
        "openCamera":
            MessageLookupByLibrary.simpleMessage("Otevřít fotoaparát"),
        "openChat": MessageLookupByLibrary.simpleMessage("Otevřete chat"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Otevřít galerii"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Otevřít v mapách"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage(
            "Otevřete fotoaparát pro video"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Volitelné) Název skupiny"),
        "or": MessageLookupByLibrary.simpleMessage("Nebo"),
        "participant": MessageLookupByLibrary.simpleMessage("Účastník"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "heslo nebo klíč pro obnovení"),
        "password": MessageLookupByLibrary.simpleMessage("Heslo"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Zapomenuté heslo"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Heslo bylo změněno"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Obnova hesla"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Hesla se neshodují!"),
        "people": MessageLookupByLibrary.simpleMessage("Lidé"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Zvolit obrázek"),
        "pin": MessageLookupByLibrary.simpleMessage("Připnout zprávu"),
        "pinMessage": MessageLookupByLibrary.simpleMessage(
            "Připnout zprávu do místnosti"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Zavolejte"),
        "play": m48,
        "pleaseChoose":
            MessageLookupByLibrary.simpleMessage("Prosím vyberte si"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Vyberte přístupový kód"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Zvolte si prosím uživatelské jméno"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Klikněte na odkaz v e-mailu a pokračujte."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Chcete-li deaktivovat zámek aplikace, zadejte 4 číslice nebo nechte prázdné."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Prosím zadejte identifikátor sítě Matrix."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Prosím zadejte platnou emailovou adresu."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Zadejte prosím své heslo"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Zadejte svůj PIN"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Zadejte prosím své uživatelské jméno"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Postupujte podle pokynů na webu a klepněte na další."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Předchozí účet"),
        "privacy": MessageLookupByLibrary.simpleMessage("Soukromí"),
        "publicRooms":
            MessageLookupByLibrary.simpleMessage("Veřejné místnosti"),
        "publish": MessageLookupByLibrary.simpleMessage("Uveřejnit"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Pravidla push"),
        "reactedWith": m50,
        "reason": MessageLookupByLibrary.simpleMessage("Důvod"),
        "recording": MessageLookupByLibrary.simpleMessage("Nahrávání"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Redigovat zprávu"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Registrovat"),
        "reject": MessageLookupByLibrary.simpleMessage("Zamítnout"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Znovu se připojte"),
        "remove": MessageLookupByLibrary.simpleMessage("Odstranit"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Odstranit všechna další zařízení"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Odstraňit zařízení"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Odstranit z tohoto balíčku"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Odstranit z tohoto místa"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Odstraňte svého avatara"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Zobrazit bohatě vykreslený obsah zpráv"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Zopakujte heslo"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Nahradit místnost novou verzí"),
        "reply": MessageLookupByLibrary.simpleMessage("Odpovědět"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Odpověď byla odeslána"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Nahlásit zprávu"),
        "reportUser":
            MessageLookupByLibrary.simpleMessage("Nahlásit uživatele"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Vyžádat oprávnění"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Místnost byla upgradována"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Verze místnosti"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Uložit soubor"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Naskenujte QR kód"),
        "search": MessageLookupByLibrary.simpleMessage("Hledat"),
        "security": MessageLookupByLibrary.simpleMessage("Bezpečnostní"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Odeslat"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("Odeslat zprávu"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Odeslat jako text"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Odeslat audio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Odeslat soubor"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Odeslat obrázek"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("Odeslat zprávy"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Odeslat při vstupu"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Odeslat originál"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Odeslat nálepku"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Odeslat video"),
        "sender": MessageLookupByLibrary.simpleMessage("Odesílatel"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Odděĺlit přímé chaty, skupiny a prostory"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Tento server potřebuje k registraci ověřit vaši e -mailovou adresu."),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("Nastavit jako hlavní alias"),
        "setCustomEmotes":
            MessageLookupByLibrary.simpleMessage("Nastavit vlastní emotikony"),
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("Nastavit popis skupiny"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Nastavit zvací odkaz"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("Nastavit úroveň oprávnění"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Nastavit stav"),
        "settings": MessageLookupByLibrary.simpleMessage("Nastavení"),
        "share": MessageLookupByLibrary.simpleMessage("Sdílet"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("Sdílet polohu"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Sdílejte váš odkaz na pozvání"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Zobrazit související přímé chaty ve službě Spaces"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Zobrazit heslo"),
        "signUp": MessageLookupByLibrary.simpleMessage("Přihlásit se"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Jedinečné přihlášení"),
        "skip": MessageLookupByLibrary.simpleMessage("Přeskočit"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Zdrojové kódy"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Prostor je veřejný"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Název prostoru"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Stav"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Jak se dneska máš?"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Upozorňujeme, že lidé se ve vašem příběhu mohou navzájem vidět a kontaktovat. Vaše příběhy budou viditelné po dobu 24 hodin, ale není zaručeno, že budou smazány ze všech zařízení a serverů."),
        "submit": MessageLookupByLibrary.simpleMessage("Odeslat"),
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Synchronizace ... Čekejte prosím."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Téma systému"),
        "theyDontMatch": MessageLookupByLibrary.simpleMessage("Neshodují se"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Shodují se"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Tento uživatel zatím nic ve svém příběhu nezveřejnil"),
        "time": MessageLookupByLibrary.simpleMessage("Čas"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Přepnout Oblíbené"),
        "toggleMuted":
            MessageLookupByLibrary.simpleMessage("Přepnout ztlumené"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage(
            "Označit jako přečtené/nepřečtené"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Příliš mnoho požadavků. Prosím zkuste to znovu později!"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("Přenos z jiného zařízení"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Zkuste odeslat znovu"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Nedostupní"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Zrušit zákaz chatu"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Odblokovat zařízení"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Neznámé zařízení"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Neznámý šifrovací algoritmus"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Zrušit ztlumení chatu"),
        "unpin": MessageLookupByLibrary.simpleMessage("Odepnout zprávu"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Odhlásit příběhy"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Nepodporovaná verze Androidu"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Tato funkce vyžaduje novější verzi Android. Zkontrolujte prosím aktualizace nebo podporu Lineage OS."),
        "unverified": MessageLookupByLibrary.simpleMessage("Neověřeno"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "K dispozici aktualizace FluffyChat"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Spustit aktualizaci na pozadí"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Uživatelské jméno"),
        "verified": MessageLookupByLibrary.simpleMessage("Ověřeno"),
        "verify": MessageLookupByLibrary.simpleMessage("Ověřit"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("Zahájit ověření"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Ověření proběhlo úspěšně!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Ověřuji druhý účet"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Video hovor"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Upozorňujeme, že videohovory jsou aktuálně ve verzi beta. Nemusí fungovat podle očekávání nebo fungovat vůbec na všech platformách."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("Viditelnost historie chatu"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Viditelné pro všechny účastnící se"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Viditelné pro všechny"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Hlasový hovor"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Hlasová zpráva"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Čeká se na potvrzení žádosti partnerem…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Čeká se na potvrzení emoji partnerem…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Čekání na partnera až přijme čísla…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Pozadí"),
        "warning": MessageLookupByLibrary.simpleMessage("Varování!"),
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("Zaslali jsme vám e-mail"),
        "whatIsGoingOn": MessageLookupByLibrary.simpleMessage("Co se děje?"),
        "whoCanPerformWhichAction":
            MessageLookupByLibrary.simpleMessage("Kdo může provést jakou akci"),
        "whoCanSeeMyStories": MessageLookupByLibrary.simpleMessage(
            "Kdo může vidět moje příběhy?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Upozorňujeme, že lidé se ve vašem příběhu mohou navzájem vidět a kontaktovat."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Kdo se může připojit do této skupiny"),
        "whyDoYouWantToReportThis":
            MessageLookupByLibrary.simpleMessage("Proč to chcete nahlásit?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Vlastní"),
        "widgetEtherpad":
            MessageLookupByLibrary.simpleMessage("Textová poznámka"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Jméno"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage(
            "Zadejte jméno pro zobrazení."),
        "widgetUrlError": MessageLookupByLibrary.simpleMessage(
            "Toto není platná adresa URL."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Chcete vymazat zálohu chatu a vytvořit nový bezpečnostní klíč?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "S těmito adresami můžete obnovit své heslo."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Napište zprávu…"),
        "yes": MessageLookupByLibrary.simpleMessage("Ano"),
        "you": MessageLookupByLibrary.simpleMessage("Vy"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Přijal jsi pozvání"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("Jste zváni do tohoto chatu"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Tohoto chatu se nadále neúčastníte"),
        "youBannedUser": m77,
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("Nemůžete pozvat sami sebe"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Byl vám zablokován přístup k tomuto chatu"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("Připojili jste se k chatu"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Odmítli jste pozvání"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Vaše záloha chatu byla nastavena."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Váš veřejný klíč"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Váš příběh")
      };
}
