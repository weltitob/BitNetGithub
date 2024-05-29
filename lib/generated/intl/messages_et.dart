// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a et locale. All the
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
  String get localeName => 'et';

  static String m0(username) => "👍 ${username} võttis kutse vastu";

  static String m1(username) =>
      "🔐${username} võttis kasutusele läbiva krüptimise";

  static String m2(senderName) => "${senderName} vastas kõnele";

  static String m3(username) =>
      "Kas võtad vastu selle verifitseerimispalve kasutajalt ${username}?";

  static String m4(username, targetName) =>
      "${username} keelas ligipääsu kasutajale ${targetName}";

  static String m5(uri) => "${uri} aadressi avamine ei õnnestu";

  static String m6(username) => "${username} muutis vestluse tunnuspilti";

  static String m7(username, description) =>
      "${username} muutis vestluse uueks kirjelduseks „${description}“";

  static String m8(username, chatname) =>
      "${username} muutis oma uueks kuvatavaks nimeks „${chatname}“";

  static String m9(username) => "${username} muutis vestlusega seotud õigusi";

  static String m10(username, displayname) =>
      "${username} muutis uueks kuvatavaks nimeks: ${displayname}";

  static String m11(username) =>
      "${username} muutis külaliste ligipääsureegleid";

  static String m12(username, rules) =>
      "${username} muutis külaliste ligipääsureegleid järgnevalt: ${rules}";

  static String m13(username) => "${username} muutis sõnumite ajaloo nähtavust";

  static String m14(username, rules) =>
      "${username} muutis sõnumite ajaloo nähtavust järgnevalt: ${rules}";

  static String m15(username) => "${username} muutis liitumise reegleid";

  static String m16(username, joinRules) =>
      "${username} muutis liitumise reegleid järgnevalt: ${joinRules}";

  static String m17(username) => "${username} muutis oma tunnuspilti";

  static String m18(username) => "${username} muutis jututoa aliast";

  static String m19(username) => "${username} muutis kutse linki";

  static String m20(command) => "${command} ei ole käsk.";

  static String m21(error) => "Sõnumi dekrüptimine ei õnnestunud: ${error}";

  static String m22(count) => "${count} faili";

  static String m23(count) => "${count} osalejat";

  static String m24(username) => "💬 ${username} algatas vestluse";

  static String m25(senderName) => "${senderName} kaisutab sind";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}.${month}.${day}";

  static String m28(month, day) => "${day}.${month}";

  static String m29(senderName) => "${senderName} lõpetas kõne";

  static String m30(error) => "Viga asukoha tuvastamisel: ${error}";

  static String m31(path) => "Fail on salvestatud kausta: ${path}";

  static String m32(senderName) => "${senderName} saatis sulle otsivad silmad";

  static String m33(displayname) => "Vestlusrühm ${displayname} kasutajanimega";

  static String m34(username, targetName) =>
      "${username} on võtnud tagasi ${targetName} kutse";

  static String m35(senderName) => "${senderName} kallistab sind";

  static String m36(groupName) =>
      "Kutsu sõpru ja tuttavaid ${groupName} liikmeks";

  static String m37(username, link) =>
      "${username} kutsus sind kasutama Matrix\'i-põhist suhtlusrakendust FluffyChat. \n1. Paigalda FluffyChat: https://fluffychat.im \n2. Liitu kasutajaks või logi sisse olemasoleva Matrix\'i kasutajakontoga\n3. Ava kutse link: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} saatis kutse kasutajale ${targetName}";

  static String m39(username) => "👋 ${username} liitus vestlusega";

  static String m40(username, targetName) =>
      "👞 ${username} müksas kasutaja ${targetName} välja";

  static String m41(username, targetName) =>
      "🙅${username} müksas kasutaja ${targetName} välja ning seadis talle suhtluskeelu";

  static String m42(localizedTimeShort) =>
      "Viimati nähtud: ${localizedTimeShort}";

  static String m43(count) => "Lisa veel ${count} osalejat";

  static String m44(homeserver) => "Logi sisse ${homeserver} serverisse";

  static String m45(server1, server2) =>
      "${server1} pole Matrix\'i server, kas kasutame selle asemel ${server2} serverit?";

  static String m46(number) => "${number} vestlust";

  static String m47(count) => "${count} kasutajat kirjutavad…";

  static String m48(fileName) => "Esita ${fileName}";

  static String m49(min) => "Palun vali pikkuseks vähemalt ${min} tähemärki.";

  static String m50(sender, reaction) => "${sender} reageeris nii ${reaction}";

  static String m51(username) => "${username} muutis sündmust";

  static String m52(username) => "${username} lükkas kutse tagasi";

  static String m53(username) => "${username} eemaldas sündmuse";

  static String m54(username) => "Sõnumit nägi ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Sõnumit nägid ${username} ja veel ${count} kasutajat')}";

  static String m56(username, username2) =>
      "Sõnumit nägid ${username} ja ${username2}";

  static String m57(username) => "📁 ${username} saatis faili";

  static String m58(username) => "🖼️ ${username} saatis pildi";

  static String m59(username) => "😊 ${username} saatis kleepsu";

  static String m60(username) => "🎥 ${username} saatis video";

  static String m61(username) => "🎤 ${username} saatis helifaili";

  static String m62(senderName) => "${senderName} saatis teavet kõne kohta";

  static String m63(username) => "${username} jagas oma asukohta";

  static String m64(senderName) => "${senderName} alustas kõnet";

  static String m65(date, body) => "Lugu ${date}:\n${body}";

  static String m66(mxid) => "See peaks olema ${mxid}";

  static String m67(number) => "Pruugi kasutajakontot # ${number}";

  static String m68(username, targetName) =>
      "${username} eemaldas ligipääsukeelu kasutajalt ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 lugemata vestlus', other: '${unreadCount} lugemata vestlust')}";

  static String m70(username, count) =>
      "${username} ja ${count} muud kirjutavad…";

  static String m71(username, username2) =>
      "${username} ja ${username2} kirjutavad…";

  static String m72(username) => "${username} kirjutab…";

  static String m73(username) => "🚪${username} lahkus vestlusest";

  static String m74(username, type) => "${username} saatis ${type} sündmuse";

  static String m75(size) => "Video (${size})";

  static String m76(oldDisplayName) =>
      "Sõnumiteta vestlus (vana nimega ${oldDisplayName})";

  static String m77(user) => "Sa seadsid suhtluskeelu kasutajale ${user}";

  static String m78(user) => "Sa oled tühistanud kutse kasutajale ${user}";

  static String m79(user) => "📩 ${user} saatis sulle kutse";

  static String m80(user) => "📩 Sa saatsid kutse kasutajale ${user}";

  static String m81(user) => "👞 Sa müksasid kasutaja ${user} välja";

  static String m82(user) =>
      "🙅Sa müksasid kasutaja ${user} välja ning seadsid talle suhtluskeelu";

  static String m83(user) => "Sa eemaldasid suhtluskeelu kasutajalt ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Rakenduse teave"),
        "accept": MessageLookupByLibrary.simpleMessage("Nõustu"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Kasutajakonto"),
        "activatedEndToEndEncryption": m1,
        "addAccount":
            MessageLookupByLibrary.simpleMessage("Lisa kasutajakonto"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Lisa kirjeldus"),
        "addEmail":
            MessageLookupByLibrary.simpleMessage("Lisa e-posti aadress"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Lisa vestlusrühma kirjeldus"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("Lisa köitesse"),
        "addToSpace": MessageLookupByLibrary.simpleMessage("Lisa kogukonda"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Vali kogukond, kuhu soovid seda vestlust lisada."),
        "addToStory": MessageLookupByLibrary.simpleMessage("Lisa jutustusele"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Lisa vidin"),
        "admin": MessageLookupByLibrary.simpleMessage("Peakasutaja"),
        "alias": MessageLookupByLibrary.simpleMessage("alias"),
        "all": MessageLookupByLibrary.simpleMessage("Kõik"),
        "allChats": MessageLookupByLibrary.simpleMessage("Kõik vestlused"),
        "allRooms": MessageLookupByLibrary.simpleMessage("Kõik vestlusrühmad"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Kõik kogukonnad"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Kõik võivad liituda"),
        "appLock": MessageLookupByLibrary.simpleMessage("Rakenduse lukustus"),
        "appearOnTop":
            MessageLookupByLibrary.simpleMessage("Luba pealmise rakendusena"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Sellega lubad rakendust avada kõige pealmisena (pole vajalik, kui Fluffychat on juba seadistatud toimima helistamiskontoga)"),
        "archive": MessageLookupByLibrary.simpleMessage("Arhiiv"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Kas külalised võivad liituda"),
        "areYouSure":
            MessageLookupByLibrary.simpleMessage("Kas sa oled kindel?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Kas sa oled kindel, et soovid välja logida?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Selleks, et teist osapoolt identifitseerivat allkirja anda, palun sisesta oma turvahoidla paroolifraas või taastevõti."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Esita liikuvad kleepse ja emotikone automaatselt"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Keela ligipääs vestlusele"),
        "banned": MessageLookupByLibrary.simpleMessage(
            "Ligipääs vestlusele on keelatud"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("Blokeeri seade"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blokeeritud"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Robotite sõnumid"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Jutumulli suurus"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Köite nimi"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Helistamiskonto"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Võimaldab FluffyChat\'il kasutada Androidi helistamisrakendust."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Helistamise õigused"),
        "cancel": MessageLookupByLibrary.simpleMessage("Katkesta"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Muuda seadme nime"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Muuda salasõna"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Muuda koduserverit"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Muuda vestlusrühma nime"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Muuda oma stiili"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Muuda taustapilti"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Muuda oma tunnuspilti"),
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
        "channelCorruptedDecryptError": MessageLookupByLibrary.simpleMessage(
            "Kasutatud krüptimine on vigane"),
        "chat": MessageLookupByLibrary.simpleMessage("Vestlus"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("Varunda vestlus"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Sinu vestluste varukoopia on krüptitud taastamiseks mõeldud turvavõtmega. Palun vaata, et sa seda ei kaota."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Vestluse teave"),
        "chatHasBeenAddedToThisSpace":
            MessageLookupByLibrary.simpleMessage("Lisasime vestluse kogukonda"),
        "chats": MessageLookupByLibrary.simpleMessage("Vestlused"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Vali korralik salasõna"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Vali kasutajanimi"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Kustuta arhiiv"),
        "close": MessageLookupByLibrary.simpleMessage("Sulge"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Sea sellele kasutajale antud jututoas suhtluskeeld"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Tühjenda vahemälu"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Loo tühi vestlusrühm\nKrüptimise keelamiseks kasuta --no-encryption võtit"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Saada üks kaisutus"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Loobu sessioonist"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Alusta otsevestlust\nKrüptimise keelamiseks kasuta --no-encryption võtit"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Saada ühed otsivad silmad"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("Saada HTML-vormingus tekst"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Saada üks kallistus"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Kutsu see kasutaja antud jututuppa"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Liitu selle jututoaga"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Eemalda antud kasutaja sellest jututoast"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Lahku sellest jututoast"),
        "commandHint_markasdm":
            MessageLookupByLibrary.simpleMessage("Märgi otsevestusluseks"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Märgi vestlusrühmaks"),
        "commandHint_me":
            MessageLookupByLibrary.simpleMessage("Kirjelda ennast"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Määra selles jututoas oma tunnuspilt (mxc-uri vahendusel)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Määra selles jututoas oma kuvatav nimi"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Seadista selle kasutaja õigusi (vaikimisi: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Saada vormindamata tekst"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("Saada vastus reaktsioonina"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("Saada sõnum"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Eemalda sellelt kasutajalt antud jututoas suhtluskeeld"),
        "commandInvalid": MessageLookupByLibrary.simpleMessage("Vigane käsk"),
        "commandMissing": m20,
        "compareEmojiMatch":
            MessageLookupByLibrary.simpleMessage("Palun võrdle emotikone"),
        "compareNumbersMatch":
            MessageLookupByLibrary.simpleMessage("Palun võrdle numbreid"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Seadista vestlust"),
        "confirm": MessageLookupByLibrary.simpleMessage("Kinnita"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Kas sa oled kindel, et tahad klammerdatud sündmuse eemaldada?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Konto kustutamiseks palun kinnitage oma Matrix\'i ID."),
        "connect": MessageLookupByLibrary.simpleMessage("Ühenda"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Sinu kontakt on kutsutud liituma vestlusrühma"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Sisaldab kuvatavat nime"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Sisaldab kasutajanime"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "Saatsime selle sisu kohta teate koduserveri haldajate"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Kopeerisin lõikelauale"),
        "copy": MessageLookupByLibrary.simpleMessage("Kopeeri"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Kopeeri lõikelauale"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Loo"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Loo uus vestlusrühm"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Uus kogukond"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Hetkel aktiivne"),
        "custom": MessageLookupByLibrary.simpleMessage("Kohandatud"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Tume"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Järgnevaga eemaldatakse sinu konto kasutusest. Seda tegevust ei saa tagasi pöörata! Kas sa ikka oled kindel?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Vaikimisi õigused"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Ekspordi sessiooni teave ja kustuta nutiseadmest rakenduse andmed"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR\'i kasutajad: Ekspordi sessioon"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Kui oled TOR\'i võrgu kasutaja, siis enne akna sulgemist palun ekspordi viimase sessiooni andmed."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Seda tegevust ei saa tagasi pöörata. Palun kontrolli, et sa oled varukoopia turvaliselt salvestanud."),
        "delete": MessageLookupByLibrary.simpleMessage("Kustuta"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Kustuta kasutajakonto"),
        "deleteMessage": MessageLookupByLibrary.simpleMessage("Kustuta sõnum"),
        "deny": MessageLookupByLibrary.simpleMessage("Keela"),
        "device": MessageLookupByLibrary.simpleMessage("Seade"),
        "deviceId": MessageLookupByLibrary.simpleMessage("Seadme tunnus"),
        "deviceKeys": MessageLookupByLibrary.simpleMessage("Seadme võtmed:"),
        "devices": MessageLookupByLibrary.simpleMessage("Seadmed"),
        "directChats": MessageLookupByLibrary.simpleMessage("Otsevestlused"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Kui vestluses on krüptimine kasutusele võetud, siis turvalisuse huvides ei saa seda hiljem välja lülitada."),
        "discover": MessageLookupByLibrary.simpleMessage("Otsi ja leia"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Loobu"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Kuvatav nimi on muudetud"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Ära näita uuesti"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Laadi fail alla"),
        "edit": MessageLookupByLibrary.simpleMessage("Muuda"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Muuda blokeeritud serverite loendit"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Muuda selle kasutajakonto köiteid"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Muuda vestluse õigusi"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Muuda kuvatavat nime"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Muuda jututoa aliast"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Muuda jututoa tunnuspilti"),
        "editWidgets": MessageLookupByLibrary.simpleMessage("Muuda vidinaid"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage(
            "E-posti aadress või kasutajanimi"),
        "emojis": MessageLookupByLibrary.simpleMessage("Emotikonid"),
        "emoteExists": MessageLookupByLibrary.simpleMessage(
            "Selline emotsioonitegevus on juba olemas!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Vigane emotsioonitegevuse lühikood!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Emotsioonitegevuste pakid jututoa jaoks"),
        "emoteSettings": MessageLookupByLibrary.simpleMessage(
            "Emotsioonitegevuste seadistused"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Emotsioonitegevuse lühikood"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Sa pead valima emotsioonitegevuse lühikoodi ja pildi!"),
        "emptyChat":
            MessageLookupByLibrary.simpleMessage("Vestlust pole olnud"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Võta emotsioonitegevuste pakid läbivalt kasutusele"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Kasuta krüptimist"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Sa ei saa hiljem enam krüptimist välja lülitada. Kas oled kindel?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(KATSELINE) Pruugi selles seadmes mitut Matrix\'i kasutajakontot"),
        "encryptThisChat":
            MessageLookupByLibrary.simpleMessage("Krüpti see vestlus"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Krüptitud"),
        "encryption": MessageLookupByLibrary.simpleMessage("Krüptimine"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Krüptimine ei ole kasutusel"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("Läbiv krüptimine"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Sisesta vestlusrühma nimi"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Sisesta kogukonna nimi"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Sisesta e-posti aadress"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "Sisesta kutse link või Matrix ID..."),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Ava jututuba"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Sisene kogukonda"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage(
            "Sisesta oma koduserveri aadress"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Vidina lisamisel tekkis viga."),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Kõik on valmis!"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("Katselised videokõned"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Äärmiselt solvav"),
        "fileHasBeenSavedAt": m31,
        "fileIsTooBigForServer": MessageLookupByLibrary.simpleMessage(
            "Serveri seadistuste alusel on see fail saatmiseks liiga suur."),
        "fileName": MessageLookupByLibrary.simpleMessage("Faili nimi"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Fondi suurus"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "See teavitus toimib siis, kui esiplaaniteenus töötab."),
        "forward": MessageLookupByLibrary.simpleMessage("Edasta"),
        "fromJoining":
            MessageLookupByLibrary.simpleMessage("Alates liitumise hetkest"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Kutse saamisest"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Hakka kasutama uut jututuba"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Vestlusrühm"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Vestlusrühma kirjeldus"),
        "groupDescriptionHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Vestlusrühma kirjeldus on muutunud"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Vestlusrühm on avalik"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Vestlusrühmad"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Külalised ei ole lubatud"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Külalised võivad liituda"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Abiteave"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Peida muudetud sündmused"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Peida väheolulised olekuteated"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("Peida tundmatud sündmused"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Koduserver"),
        "howOffensiveIsThisContent":
            MessageLookupByLibrary.simpleMessage("Kui solvav see sisu on?"),
        "hugContent": m35,
        "hydrate":
            MessageLookupByLibrary.simpleMessage("Taasta varundatud failist"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR\'i kasutajatele: impordi viimati eksporditud sessiooni andmed"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Kui viimati TOR\'i võrku kasutasid, siis kas sa eksportisid oma sessiooni andmed? Kui jah, siis impordi nad mugavasti ja jätka suhtlemist."),
        "iHaveClickedOnLink": MessageLookupByLibrary.simpleMessage(
            "Ma olen klõpsinud saadetud linki"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Ma mõistan"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identiteet"),
        "ignore": MessageLookupByLibrary.simpleMessage("Eira"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Sul on võimalik eirata neid kasutajaid, kes sind segavad. Oma isiklikku eiramisloendisse lisatud kasutajad ei saa sulle saata sõnumeid ega kutseid."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Eira kasutajanime"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Eiratud kasutajad"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Vigane paroolifraas või taastevõti"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "Privaatse akna puhul andmete salvestamine vaikimisi pole kasutusel.\nPalun toimi alljärgnevalt:\n- ava about:config\n- määra dom.indexedDB.privateBrowsing.enabled väärtuseks true\nVastasel juhul sa ei saa FluffyChat\'i kasutada."),
        "indexedDbErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Brauseri privaatse akna kasutamisega seotud asjaolud"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Kahjutu"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Kutsu sõpru ja tuttavaid"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Kutse minu jaoks"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Kutsutud"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage(
            "Ainult kutsutud kasutajatele"),
        "isTyping": MessageLookupByLibrary.simpleMessage("kirjutab…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Liitu jututoaga"),
        "joinedTheChat": m39,
        "jump": MessageLookupByLibrary.simpleMessage("Hüppa"),
        "jumpToLastReadMessage": MessageLookupByLibrary.simpleMessage(
            "Liigu viimase loetud sõnumini"),
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Müksa vestlusest välja"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Nähtud ammu aega tagasi"),
        "leave": MessageLookupByLibrary.simpleMessage("Lahku"),
        "leftTheChat":
            MessageLookupByLibrary.simpleMessage("Lahkus vestlusest"),
        "letsStart": MessageLookupByLibrary.simpleMessage("Sõidame!"),
        "license": MessageLookupByLibrary.simpleMessage("Litsents"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Hele"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Laadi veel…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Laadin andmeid… Palun oota."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Asukohateenused on seadmes väljalülitatud. Asukoha jagamiseks palun lülita nad sisse."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Puudub luba asukohateenuste kasutamiseks. Asukoha jagamiseks palun anna rakendusele vastavad õigused."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Logi sisse"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Logi sisse ühe klõpsuga"),
        "logout": MessageLookupByLibrary.simpleMessage("Logi välja"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Kontrolli, et see tunnus oleks õige"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Märgi loetuks"),
        "matrixWidgets":
            MessageLookupByLibrary.simpleMessage("Matrix\'i vidinad"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Muudatused liikmeskonnas"),
        "mention": MessageLookupByLibrary.simpleMessage("Märgi ära"),
        "messageInfo": MessageLookupByLibrary.simpleMessage("Sõnumi teave"),
        "messageType": MessageLookupByLibrary.simpleMessage("Sõnumi tüüp"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Sõnum eemaldatakse kõikidelt kasutajatelt"),
        "messages": MessageLookupByLibrary.simpleMessage("Sõnumid"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderaator"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Summuta vestlus"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Palun arvesta, et sa saad hetkel kasutada läbivat krüptimist vaid siis, kui koduserver kasutab Pantalaimon\'it."),
        "newChat": MessageLookupByLibrary.simpleMessage("Uus vestlus"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Uus jututuba"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 Uus sõnum FluffyChat\'i vahendusel"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Uus kogukond"),
        "newSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Kogukonnad võimaldavad sul koondada erinevaid vestlusi ning korraldada avalikku või privaatset ühistegevust."),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Uus verifitseerimispäring!"),
        "next": MessageLookupByLibrary.simpleMessage("Edasi"),
        "nextAccount":
            MessageLookupByLibrary.simpleMessage("Järgmine kasutajakonto"),
        "no": MessageLookupByLibrary.simpleMessage("Ei"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "Hoiatus! Kui sa ei lülita sisse vestluse varundust, siis sul puudub hiljem ligipääs krüptitud sõnumitele. Me tungivalt soovitame, et palun lülita vestluse varundamine sisse enne väljalogimist."),
        "noConnectionToTheServer": MessageLookupByLibrary.simpleMessage(
            "Puudub ühendus koduserveriga"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Palun sisesta korrektne e-posti aadress. Vastasel juhul ei saa te oma salasõna taastada. Kui te seda ei soovi, siis jätkamiseks klõpsige nuppu uuesti."),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage(
            "Ühtegi emotsioonitegevust ei leidunud. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Sa võid krüptimise kasutusele võtta niipea, kui jututuba pole enam avalik."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Tundub, et sinu nutiseadmes pole Google teenuseid. Sinu privaatsuse mõttes on see kindlasti hea otsus! Kui sa soovid FluffyChat\'is näha tõuketeavitusi, siis soovitame, et selle jaoks kasutad https://microg.org või https://unifiedpush.org liidestust."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "See võib juhtuda, kui sõnum oli saadetud enne, kui siin seadmes oma kontoga sisse logisid.\n\nSamuti võib juhtuda siis, kui saatja on lugemises selles seadmes blokeerinud või on tekkinud tõrkeid veebiühenduses.\n\nAga mõnes teises seadmes saad seda sõnumit lugeda? Siis sa võid sõnumi sealt üle tõsta. Ava Seadistused -> Seadmed ning kontrolli, et kõik sinu seadmed on omavahel verifitseeritud. Kui avad selle vestluse või jututoa ning mõlemad sessioonid on avatud, siis vajalikud krüptovõtmed saadetakse automaatset.\n\nKas sa soovid vältida krüptovõtmete kadumist väljalogimisel ja seadmete vahetusel? Siis palun kontrolli, et seadistuses on krüptovõtmete varundus sisse lülitatud."),
        "noMatrixServer": m45,
        "noOtherDevicesFound":
            MessageLookupByLibrary.simpleMessage("Muid seadmeid ei leidu"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Sa pole veel lisanud võimalust salasõna taastamiseks."),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Õigused puuduvad"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Jututubasid ei leidunud…"),
        "none": MessageLookupByLibrary.simpleMessage("Mitte midagi"),
        "notifications": MessageLookupByLibrary.simpleMessage("Teavitused"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Teavitused on sellel kontol kasutusel"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Tuvastan asukohta…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Solvav"),
        "offline": MessageLookupByLibrary.simpleMessage("Väljas"),
        "ok": MessageLookupByLibrary.simpleMessage("sobib"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Üks sinu klientrakendustest on Matrix\'i võrgust välja loginud"),
        "online": MessageLookupByLibrary.simpleMessage("Saadaval"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Krüptovõtmete veebipõhine varundus on kasutusel"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Hopsti! Kahjuks tekkis tõuketeavituste seadistamisel viga."),
        "oopsSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "Hopsti! Midagi läks nüüd viltu…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Sõnumite lugemiseks ava rakendus"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Ava kaamera"),
        "openChat": MessageLookupByLibrary.simpleMessage("Ava vestlus"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Ava galerii"),
        "openInMaps":
            MessageLookupByLibrary.simpleMessage("Ava kaardirakendusega"),
        "openLinkInBrowser":
            MessageLookupByLibrary.simpleMessage("Ava link veebibrauseris"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage(
            "Video salvestamiseks ava kaamera"),
        "optionalGroupName": MessageLookupByLibrary.simpleMessage(
            "(Kui soovid) Vestlusrühma nimi"),
        "or": MessageLookupByLibrary.simpleMessage("või"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Mikrofoni, kaamera ja muud FluffyChat\'i õigused"),
        "participant": MessageLookupByLibrary.simpleMessage("Osaleja"),
        "passphraseOrKey":
            MessageLookupByLibrary.simpleMessage("paroolifraas või taastevõti"),
        "password": MessageLookupByLibrary.simpleMessage("Salasõna"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Salasõna on ununenud"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Salasõna on muudetud"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Salasõna taastamine"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "Salasõnad ei klapi omavahel!"),
        "people": MessageLookupByLibrary.simpleMessage("Inimesed"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Vali pilt"),
        "pin": MessageLookupByLibrary.simpleMessage("Klammerda"),
        "pinMessage":
            MessageLookupByLibrary.simpleMessage("Klammerda sõnum jututuppa"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Helista"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Palun vali"),
        "pleaseChooseAPasscode": MessageLookupByLibrary.simpleMessage(
            "Palun vali rakenduse PIN-kood"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("Palun vali kasutajanimi"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Jätkamiseks palun klõpsi sulle saadetud e-kirjas leiduvat linki."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Rakenduse luku jaoks sisesta 4 numbrit või kui sa sellist võimalust ei soovi kasutada, siis jäta nad tühjaks."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Palun sisesta Matrix\'i kasutajatunnus."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Palun sisesta oma taastevõti:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Vanade sõnumite lugemiseks palun siseta oma varasemas sessioonis loodud taastevõti. Taastamiseks mõeldud krüptovõti EI OLE sinu salasõna."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Palun sisesta kehtiv e-posti aadress."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Palun sisesta oma salasõna"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Palun sisesta oma PIN-kood"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Palun sisesta oma kasutajanimi"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Palun järgi veebilehel olevaid juhiseid ja klõpsi nuppu Edasi."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Eelmine kasutajakonto"),
        "privacy": MessageLookupByLibrary.simpleMessage("Privaatsus"),
        "publicRooms":
            MessageLookupByLibrary.simpleMessage("Avalikud jututoad"),
        "publish": MessageLookupByLibrary.simpleMessage("Avalda"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Tõukereeglid"),
        "reactedWith": m50,
        "readUpToHere":
            MessageLookupByLibrary.simpleMessage("Siiamaani on loetud"),
        "reason": MessageLookupByLibrary.simpleMessage("Põhjus"),
        "recording": MessageLookupByLibrary.simpleMessage("Salvestan"),
        "recoveryKey": MessageLookupByLibrary.simpleMessage("Taastevõti"),
        "recoveryKeyLost":
            MessageLookupByLibrary.simpleMessage("Kas taasetvõti on kadunud?"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("Muuda sõnumit"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Registreeru"),
        "reject": MessageLookupByLibrary.simpleMessage("Lükka tagasi"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Liitu uuesti"),
        "remove": MessageLookupByLibrary.simpleMessage("Eemalda"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("Eemalda kõik muud seadmed"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("Eemalda seade"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Eemalda sellest köitest"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Eemalda kogukonnast"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Kustuta oma tunnuspilt"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Visualiseeri vormindatud sõnumite sisu"),
        "reopenChat":
            MessageLookupByLibrary.simpleMessage("Alusta vestlust uuesti"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Korda salasõna"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Asenda jututoa senine versioon uuega"),
        "reply": MessageLookupByLibrary.simpleMessage("Vasta"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Vastus on saadetud"),
        "report": MessageLookupByLibrary.simpleMessage("teata"),
        "reportErrorDescription": MessageLookupByLibrary.simpleMessage(
            "Oh appike! Midagi läks valesti. Palun proovi hiljem uuesti. Kui soovid, võid sellest veast arendajatele teatada."),
        "reportMessage": MessageLookupByLibrary.simpleMessage("Teata sõnumist"),
        "reportUser": MessageLookupByLibrary.simpleMessage("Teata kasutajast"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Palu õigusi"),
        "roomHasBeenUpgraded": MessageLookupByLibrary.simpleMessage(
            "Jututoa vesrioon on uuendatud"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Jututoa versioon"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Salvesta fail"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Salvesta see krüptovõti kasutades selle süsteemi jagamisvalikuid või lõikelauda."),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Skaneeri QR-koodi"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Sa jagad oma ekraani FuffyChat\'i vahendusel"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("ekraani jagamine"),
        "search": MessageLookupByLibrary.simpleMessage("Otsi"),
        "security": MessageLookupByLibrary.simpleMessage("Turvalisus"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Saada"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("Saada sõnum"),
        "sendAsText":
            MessageLookupByLibrary.simpleMessage("Saada tekstisõnumina"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Saada helifail"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Saada fail"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Saada pilt"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("Saada sõnumeid"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage(
            "Saada sõnum sisestusklahvi vajutusel"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Saada fail muutmata kujul"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Saada kleeps"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Saada videofail"),
        "sender": MessageLookupByLibrary.simpleMessage("Saatja"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Eraldi vestlused ja jututoad"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "See koduserver eeldab registreerimisel kasutatava e-postiaadressi kinnitamist."),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("Määra põhinimeks"),
        "setCustomEmotes":
            MessageLookupByLibrary.simpleMessage("Kohanda emotsioonitegevusi"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Seadista vestlusrühma kirjeldus"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Tee kutselink"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("Seadista õigusi"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Määra olek"),
        "settings": MessageLookupByLibrary.simpleMessage("Seadistused"),
        "share": MessageLookupByLibrary.simpleMessage("Jaga"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("Jaga asukohta"),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("Jaga oma kutselinki"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Näita kogukonnasga seotud otsevestlusi"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Näita salasõna"),
        "signUp": MessageLookupByLibrary.simpleMessage("Liitu"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Ühekordne sisselogimine"),
        "skip": MessageLookupByLibrary.simpleMessage("Jäta vahele"),
        "sorryThatsNotPossible": MessageLookupByLibrary.simpleMessage(
            "Vabandust... see ei ole võimalik"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Lähtekood"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Kogukond on avalik"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Kogukonna nimi"),
        "start": MessageLookupByLibrary.simpleMessage("Alusta"),
        "startFirstChat":
            MessageLookupByLibrary.simpleMessage("Alusta oma esimest vestlust"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Olek"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Kuidas sul täna läheb?"),
        "storeInAndroidKeystore": MessageLookupByLibrary.simpleMessage(
            "Vali salvestuskohaks Android KeyStore"),
        "storeInAppleKeyChain": MessageLookupByLibrary.simpleMessage(
            "Vali salvestuskohaks Apple KeyChain"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Salvesta taastevõti selle seadme turvahoidlas."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Salvesta turvaliselt selles seadmes"),
        "stories": MessageLookupByLibrary.simpleMessage("Jutustused"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Palun arvesta, et sinu jutustuste lugejad näevad üksteist ning saavad üksteisega suhelda. Lood ise on loetavad vaid 24 tunni jooksul, kuid mitte miski ei taga, et nad kustutatakse kõikidest seadmetest ja serveritest."),
        "submit": MessageLookupByLibrary.simpleMessage("Saada"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Sünkroniseerin andmeid… Palun oota."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Süsteem"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Nad ei klapi omavahel"),
        "theyMatch":
            MessageLookupByLibrary.simpleMessage("Nad klapivad omavahel"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "See kasutaja pole ühtegi jutustust veel avaldanud"),
        "time": MessageLookupByLibrary.simpleMessage("Kellaaeg"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Muuda olekut lemmikuna"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage(
            "Lülita summutamine sisse või välja"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Märgi loetuks / lugemata"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Liiga palju päringuid. Palun proovi hiljem uuesti!"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("Tõsta teisest seadmest"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Proovi uuesti saata"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Eemal"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Eemalda suhtluskeeld"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Eemalda seadmelt blokeering"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("Tundmatu seade"),
        "unknownEncryptionAlgorithm":
            MessageLookupByLibrary.simpleMessage("Tundmatu krüptoalgoritm"),
        "unlockOldMessages": MessageLookupByLibrary.simpleMessage(
            "Muuda vanad sõnumid loetavaks"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage(
            "Lõpeta vestluse vaigistamine"),
        "unpin": MessageLookupByLibrary.simpleMessage("Eemalda klammerdus"),
        "unreadChats": m69,
        "unsubscribeStories": MessageLookupByLibrary.simpleMessage(
            "Loobu jutustuste tellimusest"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "See Androidi versioon ei ole toetatud"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "See funktsionaalsus eeldab uuemat Androidi versiooni. Palun kontrolli, kas sinu nutiseadmele leidub süsteemiuuendusi või saaks seal Lineage OS\'i kasutada."),
        "unverified": MessageLookupByLibrary.simpleMessage("Verifitseerimata"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "On olemas FluffyChat\'i uuendus"),
        "updateNow":
            MessageLookupByLibrary.simpleMessage("Alusta uuendamist taustal"),
        "user": MessageLookupByLibrary.simpleMessage("Kasutaja"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Kasutajanimi"),
        "users": MessageLookupByLibrary.simpleMessage("Kasutajad"),
        "verified": MessageLookupByLibrary.simpleMessage("Verifitseeritud"),
        "verify": MessageLookupByLibrary.simpleMessage("Verifitseeri"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Alusta verifitseerimist"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage(
            "Sinu verifitseerimine õnnestus!"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage(
            "Verifitseerin teist kasutajakontot"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Videokõne"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Palun arvesta, et videokõned on veel beetajärgus. Nad ei pruugi veel toimida kõikidel platvormidel korrektselt."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("Vestluse ajaloo nähtavus"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Nähtav kõikidele osalejatele"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Nähtav kõikidele"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Häälkõne"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Häälsõnum"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Ootan, et teine osapool nõustuks päringuga…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Ootan teise osapoole kinnitust, et tegemist on samade emojidega…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Ootan teise osapoole kinnitust, et tegemist on samade numbritega…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Taustapilt"),
        "warning": MessageLookupByLibrary.simpleMessage("Hoiatus!"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("Me saatsime sulle e-kirja"),
        "whatIsGoingOn": MessageLookupByLibrary.simpleMessage("Mis toimub?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Erinevatele kasutajatele lubatud toimingud"),
        "whoCanSeeMyStories":
            MessageLookupByLibrary.simpleMessage("Kes näeb minu jutustusi?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Palun arvesta, et sinu jutustuste lugejad näevad üksteist ning saavad üksteisega suhelda."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Kes võivad selle vestlusrühmaga liituda"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Miks sa soovid sellest teatada?"),
        "whyIsThisMessageEncrypted":
            MessageLookupByLibrary.simpleMessage("Miks see sõnum pole loetav?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Kohandatud"),
        "widgetEtherpad":
            MessageLookupByLibrary.simpleMessage("Märkmed ja tekstid"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Nimi"),
        "widgetNameError":
            MessageLookupByLibrary.simpleMessage("Palun sisesta kuvatav nimi."),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("See pole korrektne URL."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Kas kustutame sinu vestluste varukoopia ja loome uue taastamiseks mõeldud krüptovõtme?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Nende e-posti aadresside abil saad taastada oma salasõna."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Kirjuta üks sõnum…"),
        "yes": MessageLookupByLibrary.simpleMessage("Jah"),
        "you": MessageLookupByLibrary.simpleMessage("Sina"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("👍 Sa võtsid kutse vastu"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Sa oled kutsutud osalema selles vestluses"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Sa enam ei osale selles vestluses"),
        "youBannedUser": m77,
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "Sa ei saa endale kutset saata"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Sinule on selles vestluses seatud suhtluskeeld"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("Sa liitusid vestlusega"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Sa lükkasid kutse tagasi"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Sinu vestluste varundus on seadistatud."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Sinu avalik võti"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Sinu jutustused")
      };
}
