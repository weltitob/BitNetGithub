// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hu locale. All the
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
  String get localeName => 'hu';

  static String m0(username) => "👍 ${username} elfogadta a meghívást";

  static String m1(username) =>
      "🔐 ${username} aktiválta a végpontok közötti titkosítást";

  static String m2(senderName) => "${senderName} megválaszolta a hívást";

  static String m3(username) => "Elfogadod ${username} hitelesítési kérelmét?";

  static String m4(username, targetName) =>
      "${username} kitiltotta: ${targetName}";

  static String m5(uri) => "Nem sikerült az URI megnyitása: ${uri}";

  static String m6(username) =>
      "${username} módosította a csevegési profilképét";

  static String m7(username, description) =>
      "${username} módosította a csevegés leírását erre: „${description}”";

  static String m8(username, chatname) =>
      "${username} módosította a csevegés nevét erre: „${chatname}”";

  static String m9(username) =>
      "${username} módosította a csevegési engedélyeket";

  static String m10(username, displayname) =>
      "${username} módosította a megjenelítési nevét erre: ${displayname}";

  static String m11(username) =>
      "${username} módosította a vendégek hozzáférési szabályait";

  static String m12(username, rules) =>
      "${username} módosította a vendégek hozzáférési szabályait, így: ${rules}";

  static String m13(username) =>
      "${username} módosította az előzmények láthatóságát";

  static String m14(username, rules) =>
      "${username} módosította az előzmények láthatóságát, így: ${rules}";

  static String m15(username) =>
      "${username} módosított a csatlakozási szabályokat";

  static String m16(username, joinRules) =>
      "${username} módosította a csatlakozási szabályokat, így: ${joinRules}";

  static String m17(username) => "${username} módosította a profilképét";

  static String m18(username) => "${username} módosította a szoba címeit";

  static String m19(username) =>
      "${username} módosította a meghívó hivatkozást";

  static String m20(command) => "${command} nem egy parancs.";

  static String m21(error) =>
      "Nem sikerült visszafejteni a titkosított üzenetet: ${error}";

  static String m23(count) => "${count} résztvevő";

  static String m24(username) => "💬  ${username} létrehozta a csevegést";

  static String m25(senderName) => "${senderName} megölelt";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}. ${month}. ${day}.";

  static String m28(month, day) => "${month}. ${day}.";

  static String m29(senderName) => "${senderName} befejezte a hívást";

  static String m30(error) =>
      "Hiba a tartózkodási hely lekérése közben: ${error}";

  static String m32(senderName) => "${senderName} gülüszemeket küld";

  static String m33(displayname) => "Csoport vele: ${displayname}";

  static String m34(username, targetName) =>
      "${username} visszavonta ${targetName} meghívását";

  static String m36(groupName) =>
      "Ismerős meghívása a(z) ${groupName} csoportba";

  static String m37(username, link) =>
      "${username} meghívott a FluffyChat alkalmazásba. \n1. Telepítsd a FluffyChat appot: https://fluffychat.im \n2. Regisztrálj, vagy jelentkezz be. \n3. Nyisd meg a meghívó hivatkozást: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} meghívta ${targetName}-t";

  static String m39(username) => "👋 ${username} csatlakozott a csevegéshez";

  static String m40(username, targetName) =>
      "👞 ${username} kirúgta ${targetName}-t";

  static String m41(username, targetName) =>
      "🙅 ${username} kirúgta és kitiltotta ${targetName}-t";

  static String m42(localizedTimeShort) =>
      "Utoljára aktív: ${localizedTimeShort}";

  static String m43(count) => "További ${count} résztvevő betöltése";

  static String m44(homeserver) =>
      "Bejelentkezés a(z) ${homeserver} Matrix-kiszolgálóra";

  static String m45(server1, server2) =>
      "${server1} nem egy Matrix szerver, használjam a ${server2} szervert inkább?";

  static String m47(count) => "${count} felhasználó gépel…";

  static String m48(fileName) => "${fileName} lejátszása";

  static String m49(min) => "Válasszon legalább ${min} karaktert.";

  static String m51(username) => "${username} visszavont egy eseményt";

  static String m52(username) => "${username} elutasította a meghívást";

  static String m53(username) => "${username} törölte";

  static String m54(username) => "${username} látta";

  static String m55(username, count) =>
      "${Intl.plural(count, other: '${username} és ${count} másik résztvevő látta')}";

  static String m56(username, username2) => "${username} és ${username2} látta";

  static String m57(username) => "📁 ${username} fájlt küldött";

  static String m58(username) => "${username} képet küldött";

  static String m59(username) => "${username} matricát küldött";

  static String m60(username) => "${username} videót küldött";

  static String m61(username) => "${username} hangüzenetet küldött";

  static String m62(senderName) => "${senderName} hívásinformációt küldött";

  static String m63(username) => "${username} megosztotta a pozícióját";

  static String m64(senderName) => "${senderName} hívást indított";

  static String m68(username, targetName) =>
      "${username} feloldotta ${targetName} kitiltását";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, other: '${unreadCount} olvasatlan csevegés')}";

  static String m70(username, count) =>
      "${username} és ${count} másik résztvevő gépel…";

  static String m71(username, username2) =>
      "${username} és ${username2} gépel…";

  static String m72(username) => "${username} gépel…";

  static String m73(username) => "${username} elhagyta a csevegést";

  static String m74(username, type) => "${username} ${type} eseményt küldött";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Névjegy"),
        "accept": MessageLookupByLibrary.simpleMessage("Elfogadás"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Fiók"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Fiók hozzáadása"),
        "addEmail":
            MessageLookupByLibrary.simpleMessage("E-mail-cím hozzáadása"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Csoportleírás hozzáadása"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("Hozzáadás térhez"),
        "admin": MessageLookupByLibrary.simpleMessage("Admin"),
        "alias": MessageLookupByLibrary.simpleMessage("álnév"),
        "all": MessageLookupByLibrary.simpleMessage("Összes"),
        "allChats": MessageLookupByLibrary.simpleMessage("Összes csevegés"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Bárki csatlakozhat"),
        "appLock": MessageLookupByLibrary.simpleMessage("Alkalmazászár"),
        "archive": MessageLookupByLibrary.simpleMessage("Archívum"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("Csatlakozhatnak-e vendégek"),
        "areYouSure":
            MessageLookupByLibrary.simpleMessage("Biztos vagy benne?"),
        "areYouSureYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("Biztos, hogy kijelentkezel?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "A másik fél igazolásához meg kell adni a biztonságos tároló jelmondatát vagy a visszaállítási kulcsot."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Animált matricák és hangulatjelek automatikus lejátszása"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Kitiltás a csevegésből"),
        "banned": MessageLookupByLibrary.simpleMessage("Kitiltva"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Eszköz blokkolása"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blokkolva"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Bot üzenetek"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Buborék méret"),
        "cancel": MessageLookupByLibrary.simpleMessage("Mégse"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Eszköznév módosítása"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Jelszó módosítása"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Matrix-kiszolgáló váltása"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Csoport nevének módosítása"),
        "changeTheme":
            MessageLookupByLibrary.simpleMessage("Stílus módosítása"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Háttér módosítása"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Profilkép módosítása"),
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
            MessageLookupByLibrary.simpleMessage("A titkosítás megsérült"),
        "chat": MessageLookupByLibrary.simpleMessage("Csevegés"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Beszélgetések mentése"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "A régebbi beszélgetéseid egy biztonsági kulccsal vanak védve. Bizonyosodj meg róla, hogy nem fogod elveszíteni."),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Csevegés részletei"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "A beszélgetés hozzá lett adva ehhez a térhez"),
        "chats": MessageLookupByLibrary.simpleMessage("Beszélgetések"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Válassz erős jelszót"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Válassz felhasználónevet"),
        "clearArchive":
            MessageLookupByLibrary.simpleMessage("Archívum törlése"),
        "close": MessageLookupByLibrary.simpleMessage("Bezárás"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Felhasználó kitiltása ebből a szobából"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Gyorsítótár törlése"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Egy üres csoport létrehozása\nA --no-encryption kapcsolóval titkosítatlan szoba hozható létre"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Ölelés küldése"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Munkamenet elvetése"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Közvetlen beszélgetés indítása\nA --no-encryption kapcsolóval titkosítatlan beszélgetés lesz létrehozva"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Gülüszemek küldése"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "HTML formázott üzenet küldése"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Ölelés küldése"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Felhasználó meghívása ebbe a szobába"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage(
            "Csatlakozás a megadott szobához"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "A megadott felhasználó kirúgása a szobából"),
        "commandHint_leave": MessageLookupByLibrary.simpleMessage(
            "Ennek a szobának az elhagyása"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Csoportnak jelölés"),
        "commandHint_me":
            MessageLookupByLibrary.simpleMessage("Mit csinálsz épp"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Az ebben a szobában megjelenített profilképed megváltoztatása (mxc URI-t kell megadni)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Az ebben a szobában megjelenített beceneved megváltoztatása"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Az adott felhasználó hozzáférési szintjét változtatja (alapértelmezett: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Formázatlan szöveg küldése"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("Válasz küldése reakcióként"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Szöveg küldése"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Az adott felhasználó visszaengedése ebbe a szobába"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Érvénytelen parancs"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Hasonlítsd össze az emodzsikat a másik eszközön lévőkkel, és bizonyosodj meg róla, hogy egyeznek:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Hasonlítsd össze a számokat a másik eszközön lévőkkel, és bizonyosodj meg arról, hogy egyeznek:"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Beszélgetés beállítása"),
        "confirm": MessageLookupByLibrary.simpleMessage("Megerősítés"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "A fiók törléséhez adja meg a Matrix ID-t."),
        "connect": MessageLookupByLibrary.simpleMessage("Csatlakozás"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Meghívtad az ismerősödet a csoportba"),
        "containsDisplayName": MessageLookupByLibrary.simpleMessage(
            "Tartalmazza a megjelenített becenevet"),
        "containsUserName": MessageLookupByLibrary.simpleMessage(
            "Tartalmazza a felhasználónevet"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "A tartalom jelentve lett a szerver üzemeltetőinek"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Vágólapra másolva"),
        "copy": MessageLookupByLibrary.simpleMessage("Másolás"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Vágólapra másolás"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Létrehozás"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Új csoport létrehozása"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Új tér"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Jelenleg aktív"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Sötét"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Ez deaktiválja a felhasználói fiókodat. Ez nem vonható vissza! Biztos vagy benne?"),
        "defaultPermissionLevel": MessageLookupByLibrary.simpleMessage(
            "Alapértelmezett hozzáférési szint"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Munkamenet exportálásssa és az eszköz törlése"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "Tor felhasználók: munkamenet dehidratálása"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Tor felhasználóknak ajánlott a munkamenet dehidratálása az ablak bezárása előtt."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Ez nem visszavonható. Bizonyosodj meg róla, hogy biztonságos helyen tárolod a mentett fájlt."),
        "delete": MessageLookupByLibrary.simpleMessage("Törlés"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Fiók törlése"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("Üzenet törlése"),
        "deny": MessageLookupByLibrary.simpleMessage("Elutasítás"),
        "device": MessageLookupByLibrary.simpleMessage("Eszköz"),
        "deviceId": MessageLookupByLibrary.simpleMessage("Eszköz ID"),
        "devices": MessageLookupByLibrary.simpleMessage("Eszközök"),
        "directChats":
            MessageLookupByLibrary.simpleMessage("Közvetlen beszélgetés"),
        "displaynameHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Megjelenítési név megváltozott"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Fájl letöltése"),
        "edit": MessageLookupByLibrary.simpleMessage("Szerkeszt"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Blokkolt szerverek szerkesztése"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage(
            "Beszélgetés engedélyek szerkesztése"),
        "editDisplayname": MessageLookupByLibrary.simpleMessage(
            "Megjelenítési név módosítása"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Szoba címeinek szerkesztése"),
        "editRoomAvatar": MessageLookupByLibrary.simpleMessage(
            "Szoba profilképének szerkesztése"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("A hangulatjel már létezik!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Érvénytelen hangulatjel rövid kód!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Hangulatjel-csomagok a szobához"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Hangulatjel-beállítások"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Rövid kód a hangulatjelhez"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "A hangulatjelhez egy képet és egy rövid kódot kell választani!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Üres csevegés"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Hangulatjel-csomag engedélyezése globálisan"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Titkosítás bekapcsolása"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Többé nem fogod tudni kikapcsolni a titkosítást. Biztos vagy benne?"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Titkosított"),
        "encryption": MessageLookupByLibrary.simpleMessage("Titkosítás"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage(
            "Titkosítás nincs engedélyezve"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Adj meg egy csoportnevet"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Add meg a tér nevét"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Adj meg egy email címet"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage(
            "Add meg a Matrix-kiszolgálód"),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("Minden kész!"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extrém sértő"),
        "fileName": MessageLookupByLibrary.simpleMessage("Fájlnév"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Betűméret"),
        "forward": MessageLookupByLibrary.simpleMessage("Továbbítás"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("Csatlakozás óta"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Meghívás óta"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Új szoba megnyitása"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Csoport"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Csoport leírása"),
        "groupDescriptionHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "A csoport leírása megváltozott"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("A csoport nyilvános"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Csoportok"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Nem lehetnek vendégek"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Csatlakozhatnak vendégek"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Súgó"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage(
            "Visszavont események elrejtése"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Ismeretlen események elrejtése"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Matrix szerver"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Mennyire sértő ez a tartalom?"),
        "hydrate":
            MessageLookupByLibrary.simpleMessage("Visszaállítás fájlból"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "Tor felhasználók: hidratált munkamenet importálása"),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Rákattintottam a linkre"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Azonosító"),
        "ignore":
            MessageLookupByLibrary.simpleMessage("Figyelmen kívül hagyás"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Figyelmen kívül hagyhatja azon felhasználókat, akik zavarják. Nem fog üzeneteket vagy szobameghívókat kapni a személyes listáján szereplő felhasználóktól."),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage(
            "Felhasználó figyelmen kívül hagyása"),
        "ignoredUsers": MessageLookupByLibrary.simpleMessage(
            "Figyelmen kívül hagyott felhasználók"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Hibás jelmondat vagy visszaállítási kulcs"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Nem sértő"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Ismerős meghívása"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Meghívás nekem"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Meghívott"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Csak meghívottak"),
        "isTyping": MessageLookupByLibrary.simpleMessage("gépel…"),
        "joinRoom":
            MessageLookupByLibrary.simpleMessage("Csatlakozás a szobához"),
        "joinedTheChat": m39,
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Kirúgás a csevegésből"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Már régen látta"),
        "leave": MessageLookupByLibrary.simpleMessage("Csevegés elhagyása"),
        "leftTheChat":
            MessageLookupByLibrary.simpleMessage("Elhagyta a csevegést"),
        "license": MessageLookupByLibrary.simpleMessage("Licenc"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Világos"),
        "link": MessageLookupByLibrary.simpleMessage("Hivatkozás"),
        "loadCountMoreParticipants": m43,
        "loadMore":
            MessageLookupByLibrary.simpleMessage("Továbbiak betöltése…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Betöltés… Kérlek, várj."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "A helymeghatározás ki van kapcsolva. Kérlek, kapcsold be, hogy meg tudd osztani a helyzeted."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "A helymeghatározás nincs engedélyezve az alkalmazásnak. Kérlek engedélyezd, hogy meg tudd osztani a helyzeted."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Bejelentkezés"),
        "loginWithOneClick": MessageLookupByLibrary.simpleMessage(
            "Bejelentkezés egy kattintással"),
        "logout": MessageLookupByLibrary.simpleMessage("Kijelentkezés"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Bizonyosodj meg az azonosító helyességéről"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Tagság változások"),
        "mention": MessageLookupByLibrary.simpleMessage("Megemlítés"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Az üzenet minden résztvevő számára törlődni fog"),
        "messages": MessageLookupByLibrary.simpleMessage("Üzenetek"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderátor"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Csevegés némítása"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Jelenleg a Pantalaimon szükséges a végpontok közötti titkosítás használatához."),
        "newChat": MessageLookupByLibrary.simpleMessage("Új beszélgetés"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("💬 Új FluffyChat-üzenet"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Új hitelesítési kérelem!"),
        "next": MessageLookupByLibrary.simpleMessage("Következő"),
        "no": MessageLookupByLibrary.simpleMessage("Nem"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Nem elérhető a szerver"),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Nincsenek hangulatjelek. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Csak akkor kapcsolható be a titkosítás, ha a szoba nem nyilvánosan hozzáférhető."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Úgy tűnik, hogy nincsenek Google szolgáltatások a telefonodon. Ez adatvédelmi szempontból jó döntés! Ahhoz, hogy push értesítéseket fogadhass a FluffyChat alkalmazásban, a microG használatát javasoljuk: https://microg.org/."),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Még nem adtál meg semmilyen módot a jelszavad visszaállítására"),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Nincsenek engedélyek"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Nem találhatók szobák…"),
        "none": MessageLookupByLibrary.simpleMessage("Nincs"),
        "notifications": MessageLookupByLibrary.simpleMessage("Értesítések"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Értesítések bekapcsolása ebben a fiókban"),
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Tartózkodási hely lekérése…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Sértő"),
        "offline": MessageLookupByLibrary.simpleMessage("Offline"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Online kulcsmentés engedélyezve"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Oops! Sajnos hiba történt a push értesítések beállításakor."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Hoppá, valami baj történt…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Alkalmazás megnyitása az üzenetek elolvasásához"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Kamera megnyitása"),
        "openInMaps":
            MessageLookupByLibrary.simpleMessage("Megnyitás térképen"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("Kamera megnyitása videóhoz"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("Csoportnév (nem kötelező)"),
        "or": MessageLookupByLibrary.simpleMessage("Vagy"),
        "participant": MessageLookupByLibrary.simpleMessage("Résztvevő"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Jelmondat vagy visszaállítási kulcs"),
        "password": MessageLookupByLibrary.simpleMessage("Jelszó"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Elfelejtett jelszó"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("A jelszó módosítva"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Jelszó visszaállítás"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("A jelszavak nem egyeznek."),
        "people": MessageLookupByLibrary.simpleMessage("Emberek"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Kép választása"),
        "pin": MessageLookupByLibrary.simpleMessage("Rögzítés"),
        "play": m48,
        "pleaseChoose":
            MessageLookupByLibrary.simpleMessage("Kérjük válasszon"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Válassz egy felhasználónevet"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Írjon be 4 számjegyet, vagy hagyja üresen a zár kikapcsolásához."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Írj be egy Matrix-azonosítót."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Adjon meg egy érvényes e-mail-címet."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Add meg a jelszavad"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Írja be a PIN-kódot"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Add meg a felhasználónevedet"),
        "privacy": MessageLookupByLibrary.simpleMessage("Adatvédelem"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Nyilvános szobák"),
        "reason": MessageLookupByLibrary.simpleMessage("Ok"),
        "recording": MessageLookupByLibrary.simpleMessage("Felvétel"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Üzenet visszavonása"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Regisztrálás"),
        "reject": MessageLookupByLibrary.simpleMessage("Elutasítás"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Újracsatlakozás"),
        "remove": MessageLookupByLibrary.simpleMessage("Eltávolítás"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Minden más eszköz eltávolítása"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Eszköz eltávolítása"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Formázott üzenetek megjelenítése"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Jelszó megismétlése"),
        "reply": MessageLookupByLibrary.simpleMessage("Válasz"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Üzenet jelentése"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Jogosultság igénylése"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("A szoba frissítve lett"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Szobaverzió"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Fájl mentése"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("QR kód beolvasása"),
        "search": MessageLookupByLibrary.simpleMessage("Keresés"),
        "security": MessageLookupByLibrary.simpleMessage("Biztonság"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Küldés"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("Üzenet küldése"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Hangüzenet küldése"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Fájl küldése"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Kép küldése"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Üzenetek küldése"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("Küldés Enterrel"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("Eredeti küldése"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Matrica küldése"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Videó küldése"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("Csoportleírás beállítása"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage(
            "Meghívó hivatkozás beállítása"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Állapot beállítása"),
        "settings": MessageLookupByLibrary.simpleMessage("Beállítások"),
        "share": MessageLookupByLibrary.simpleMessage("Megosztás"),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("Meghívási link küldése"),
        "sharedTheLocation": m63,
        "signUp": MessageLookupByLibrary.simpleMessage("Regisztráció"),
        "skip": MessageLookupByLibrary.simpleMessage("Kihagyás"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Forráskód"),
        "startedACall": m64,
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Hogy vagy?"),
        "submit": MessageLookupByLibrary.simpleMessage("Beküldés"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Rendszer"),
        "theyDontMatch": MessageLookupByLibrary.simpleMessage("Nem egyeznek"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Egyeznek"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Újraküldés megpróbálása"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Nem érhető el"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Kitiltás feloldása"),
        "unbannedUser": m68,
        "unblockDevice": MessageLookupByLibrary.simpleMessage(
            "Eszköz blokkolásának megszüntetése"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Ismeretlen eszköz"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Ismeretlen titkosítási algoritmus"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage(
            "Csevegés némításának megszüntetése"),
        "unpin": MessageLookupByLibrary.simpleMessage("Rögzítés megszüntetése"),
        "unreadChats": m69,
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "FluffyChat-frissítés elérhető"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Frissítés elindítása a háttérben"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Felhasználónév"),
        "verify": MessageLookupByLibrary.simpleMessage("Hitelesítés"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Hitelesítés megkezdése"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Sikeres hitelesítés!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Másik fiók hitelesítése"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Videóhívás"),
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Csevegési előzmény láthatósága"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Minden résztvevő számára látható"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Bárki számára látható"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Hangüzenet"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Várakozás partnerre, amíg elfogadja a kérést…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Várakozás partnerre, hogy elfogadja a hangulatjeleket…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Várakozás a partnerre, hogy elfogadja a számokat…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Háttér"),
        "warning": MessageLookupByLibrary.simpleMessage("Figyelmeztetés!"),
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("Küldtünk neked egy emailt"),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Ki csatlakozhat a csoporthoz"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Ezzekkel a címekkel vissza tudod állítani a jelszavad, ha szükséges"),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Írj egy üzenetet…"),
        "yes": MessageLookupByLibrary.simpleMessage("Igen"),
        "you": MessageLookupByLibrary.simpleMessage("Te"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("Meghívtak ebbe a csevegésbe"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Nem veszel részt ebben a csevegésben"),
        "youCannotInviteYourself":
            MessageLookupByLibrary.simpleMessage("Nem tudod meghívni magadat"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Kitiltottak ebből a csevegésből"),
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "A beszélgetések mentése be lett állítva.")
      };
}
