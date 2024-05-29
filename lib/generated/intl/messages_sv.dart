// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sv locale. All the
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
  String get localeName => 'sv';

  static String m0(username) => "👍 ${username} accepterade inbjudan";

  static String m1(username) => "🔐 ${username} aktiverade ändpunktskryptering";

  static String m2(senderName) => "${senderName} besvarade samtalet";

  static String m3(username) =>
      "Acceptera denna verifikationsförfrågan från ${username}?";

  static String m4(username, targetName) => "${username} bannlös ${targetName}";

  static String m5(uri) => "Kan inte öppna URL ${uri}";

  static String m6(username) => "${username} ändrade sin chatt-avatar";

  static String m7(username, description) =>
      "${username} ändrade chatt-beskrivningen till: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} ändrade sitt chatt-namn till: \'${chatname}\'";

  static String m9(username) => "${username} ändrade chatt-rättigheterna";

  static String m10(username, displayname) =>
      "${username} ändrade visningsnamnet till: \'${displayname}\'";

  static String m11(username) => "${username} ändrade reglerna för gästaccess";

  static String m12(username, rules) =>
      "${username} ändrade reglerna för gästaccess till: ${rules}";

  static String m13(username) => "${username} ändrade historikens synlighet";

  static String m14(username, rules) =>
      "${username} ändrade historikens synlighet till: ${rules}";

  static String m15(username) => "${username} ändrade anslutningsreglerna";

  static String m16(username, joinRules) =>
      "${username} ändrade anslutningsreglerna till ${joinRules}";

  static String m17(username) => "${username} ändrade sin avatar";

  static String m18(username) => "${username} ändrade rummets alias";

  static String m19(username) => "${username} ändrade inbjudningslänken";

  static String m20(command) => "${command} är inte ett kommando.";

  static String m21(error) => "Kunde ej avkoda meddelande: ${error}";

  static String m22(count) => "${count} filer";

  static String m23(count) => "${count} deltagare";

  static String m24(username) => "💬 ${username} skapade chatten";

  static String m25(senderName) => "${senderName} omfamnar dig";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}-${month}-${day}";

  static String m28(month, day) => "${day}-${month}";

  static String m29(senderName) => "${senderName} avslutade samtalet";

  static String m30(error) => "Fel vid erhållande av plats: ${error}";

  static String m31(path) => "Filen har sparats i ${path}";

  static String m32(senderName) => "${senderName} skickar dig googly ögon";

  static String m33(displayname) => "Gruppen med ${displayname}";

  static String m34(username, targetName) =>
      "${username} har tagit tillbaka inbjudan för ${targetName}";

  static String m35(senderName) => "${senderName} kramar dig";

  static String m36(groupName) => "Bjud in kontakt till ${groupName}";

  static String m37(username, link) =>
      "${username} bjöd in dig till FluffyChat. \n1. Installera FluffyChat: https://fluffychat.im \n2. Registrera dig eller logga in \n3. Öppna inbjudningslänk: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} bjöd in ${targetName}";

  static String m39(username) => "👋 ${username} anslöt till chatten";

  static String m40(username, targetName) =>
      "👞 ${username} sparkade ut ${targetName}";

  static String m41(username, targetName) =>
      "🙅 ${username} sparkade och bannade ${targetName}";

  static String m42(localizedTimeShort) =>
      "Senast aktiv: ${localizedTimeShort}";

  static String m43(count) => "Ladda ${count} mer deltagare";

  static String m44(homeserver) => "Logga in till ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} är inte en matrix server, använd ${server2} istället?";

  static String m46(number) => "${number} chattar";

  static String m47(count) => "${count} användare skriver…";

  static String m48(fileName) => "Spela ${fileName}";

  static String m49(min) => "Vänligen ange minst ${min} tecken.";

  static String m50(sender, reaction) => "${sender} reagerade med ${reaction}";

  static String m51(username) => "${username} redigerade en händelse";

  static String m52(username) => "${username} avböjde inbjudan";

  static String m53(username) => "Bortagen av ${username}";

  static String m54(username) => "Sedd av ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Sedd av ${username} och ${count} andra')}";

  static String m56(username, username2) =>
      "Sedd av ${username} och ${username2}";

  static String m57(username) => "📁 ${username} skickade en fil";

  static String m58(username) => "🖼️ ${username} skickade en bild";

  static String m59(username) => "😊 ${username} skickade ett klistermärke";

  static String m60(username) => "🎥 ${username} skickade en video";

  static String m61(username) => "🎤 ${username} skickade ett ljudklipp";

  static String m62(senderName) => "${senderName} skickade samtalsinformation";

  static String m63(username) => "${username} delade sin position";

  static String m64(senderName) => "${senderName} startade ett samtal";

  static String m65(date, body) => "Berättelse från ${date}: \n${body}";

  static String m66(mxid) => "Detta bör vara ${mxid}";

  static String m67(number) => "Byt till konto ${number}";

  static String m68(username, targetName) =>
      "${username} avbannade ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: 'en oläst chatt', other: '${unreadCount} olästa chattar')}";

  static String m70(username, count) =>
      "${username} och ${count} andra skriver…";

  static String m71(username, username2) =>
      "${username} och ${username2} skriver…";

  static String m72(username) => "${username} skriver…";

  static String m73(username) => "🚪 ${username} lämnade chatten";

  static String m74(username, type) =>
      "${username} skickade en ${type} händelse";

  static String m75(size) => "Video (${size})";

  static String m76(oldDisplayName) => "Tom chatt (var ${oldDisplayName})";

  static String m77(user) => "Du förbjöd ${user}";

  static String m78(user) => "Du har återkallat inbjudan till ${user}";

  static String m79(user) => "📩 Du har blivit inbjuden av ${user}";

  static String m80(user) => "📩 Du bjöd in ${user}";

  static String m81(user) => "👞 Du sparkade ut ${user}";

  static String m82(user) => "🙅 Du sparkade ut och förbjöd ${user}";

  static String m83(user) => "Du återkallade förbudet för ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Om"),
        "accept": MessageLookupByLibrary.simpleMessage("Acceptera"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Konto"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Lägg till konto"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Lägg till beskrivning"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Lägg till e-post"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Lägg till en gruppbeskrivning"),
        "addToBundle": MessageLookupByLibrary.simpleMessage("Utöka paket"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Lägg till i utrymme"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Välj ett utrymme som chatten skall läggas till i."),
        "addToStory":
            MessageLookupByLibrary.simpleMessage("Addera till berättelse"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Lägg till widget"),
        "admin": MessageLookupByLibrary.simpleMessage("Admin"),
        "alias": MessageLookupByLibrary.simpleMessage("alias"),
        "all": MessageLookupByLibrary.simpleMessage("Alla"),
        "allChats": MessageLookupByLibrary.simpleMessage("Alla chattar"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Alla utrymmen"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Vem som helst kan gå med"),
        "appLock": MessageLookupByLibrary.simpleMessage("App-lås"),
        "appearOnTop": MessageLookupByLibrary.simpleMessage("Visa ovanpå"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Tillåt att appen visas ovanpå (behövs inte om du redan har FluffyChat konfigurerat som ett samtalskonto)"),
        "archive": MessageLookupByLibrary.simpleMessage("Arkiv"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("Får gästanvändare gå med"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Är du säker?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Är du säker på att du vill logga ut?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "För att kunna signera den andra personen, vänligen ange din lösenfras eller återställningsnyckel för säker lagring."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Automatisk spela upp animerade klistermärken och emoji"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Bannlys från chatt"),
        "banned": MessageLookupByLibrary.simpleMessage("Bannlyst"),
        "bannedUser": m4,
        "blockDevice": MessageLookupByLibrary.simpleMessage("Blockera Enhet"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blockerad"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Bot meddelanden"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Storlek på bubbla"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Paketnamn"),
        "callingAccount": MessageLookupByLibrary.simpleMessage("Samtalskonto"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Tillåt FluffyChat att använda Androids ring-app."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Samtalsbehörighet"),
        "cancel": MessageLookupByLibrary.simpleMessage("Avbryt"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Ändra enhetsnamn"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Ändra lösenord"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Ändra hemserver"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Ändra namn på gruppen"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Ändra din stil"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Ändra bakgrund"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Ändra din avatar"),
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
            "Krypteringen har blivit korrupt"),
        "chat": MessageLookupByLibrary.simpleMessage("Chatt"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("Chatt backup"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Din chatt backup är skyddad av en säkerhetsnyckel. Se till att du inte förlorar den."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Chatt-detaljer"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "Chatt har lagts till i detta utrymme"),
        "chats": MessageLookupByLibrary.simpleMessage("Chatter"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Välj ett starkt lösenord"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Välj ett användarnamn"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Rensa arkiv"),
        "close": MessageLookupByLibrary.simpleMessage("Stäng"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Bannlys användaren från detta rum"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Rensa cache"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Skapa en tom grupp-chatt\nAnvänd --no-encryption för att inaktivera kryptering"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Skicka en omfamning"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Kasta bort sessionen"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Starta en direkt-chatt\nAnvänd --no-encryption för att inaktivera kryptering"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Skicka några googly ögon"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("Skicka HTML-formatted text"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Skicka en kram"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Bjud in användaren till detta rum"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Gå med i rum"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Ta bort användare från detta rum"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Lämna detta rum"),
        "commandHint_markasdm": MessageLookupByLibrary.simpleMessage(
            "Märk som rum för direktmeddelanden"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Märk som grupp"),
        "commandHint_me":
            MessageLookupByLibrary.simpleMessage("Beskriv dig själv"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Sätt din bild för detta rum (by mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Sätt ditt användarnamn för rummet"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Sätt användarens kraft nivå ( standard: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Skicka oformaterad text"),
        "commandHint_react":
            MessageLookupByLibrary.simpleMessage("Skicka svar som reaktion"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("Skicka text"),
        "commandHint_unban":
            MessageLookupByLibrary.simpleMessage("Tillåt användare i rummet"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Felaktigt kommando"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Vänligen jämför uttryckssymbolerna"),
        "compareNumbersMatch":
            MessageLookupByLibrary.simpleMessage("Vänligen jämför siffrorna"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Konfigurera chatt"),
        "confirm": MessageLookupByLibrary.simpleMessage("Bekräfta"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Är du säker på att händelsen inte längre skall vara fastnålad?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Bekräfta ditt Matrix-ID för att radera ditt konto."),
        "connect": MessageLookupByLibrary.simpleMessage("Anslut"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Kontakten har blivit inbjuden till gruppen"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Innehåller visningsnamn"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Innehåller användarnamn"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "Innehållet har rapporterats till server-admins"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Kopierat till urklipp"),
        "copy": MessageLookupByLibrary.simpleMessage("Kopiera"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Kopiera till urklipp"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Skapa"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Skapa ny grupp"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Nytt utrymme"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("För närvarande aktiv"),
        "custom": MessageLookupByLibrary.simpleMessage("Anpassad"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Mörkt"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Detta kommer att avaktivera ditt konto. Det här går inte att ångra! Är du säker?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Standard behörighetsnivå"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Exportera sessionen och rensa enheten"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR-användare: Exportera session"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "TOR-användare rekommenderas att exportera sessionen innan fönstret stängs."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Denna åtgärd kan inte ångras. Försäkra dig om att backupen är i säkert förvar."),
        "delete": MessageLookupByLibrary.simpleMessage("Radera"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Ta bort konto"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Ta bort meddelande"),
        "deny": MessageLookupByLibrary.simpleMessage("Neka"),
        "device": MessageLookupByLibrary.simpleMessage("Enhet"),
        "deviceId": MessageLookupByLibrary.simpleMessage("Enhets-ID"),
        "deviceKeys": MessageLookupByLibrary.simpleMessage("Enhetsnycklar:"),
        "devices": MessageLookupByLibrary.simpleMessage("Enheter"),
        "directChats": MessageLookupByLibrary.simpleMessage("Direkt Chatt"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Av säkerhetsskäl kan du inte stänga av kryptering i en chatt där det tidigare aktiverats."),
        "dismiss": MessageLookupByLibrary.simpleMessage("Avfärda"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Visningsnamn har ändrats"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Visa inte igen"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Ladda ner fil"),
        "edit": MessageLookupByLibrary.simpleMessage("Ändra"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("redigera blockerade servrar"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Lägg till paket för detta konto"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Ändra chatt-rättigheter"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Ändra visningsnamn"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Redigera rum alias"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("redigera rumsavatar"),
        "editWidgets":
            MessageLookupByLibrary.simpleMessage("Redigera widgetar"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage(
            "Användarnamn eller e-postadress"),
        "emojis": MessageLookupByLibrary.simpleMessage("Uttryckssymboler"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Dekalen existerar redan!"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("Ogiltig dekal-kod!"),
        "emotePacks":
            MessageLookupByLibrary.simpleMessage("Dekalpaket för rummet"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Emote inställningar"),
        "emoteShortcode": MessageLookupByLibrary.simpleMessage("Dekal kod"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Du måste välja en dekal-kod och en bild!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Tom chatt"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Aktivera dekal-paket globalt"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Aktivera kryptering"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Du kommer inte ha fortsatt möjlighet till att inaktivera krypteringen. Är du säker?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Aktivera multi-konton på denna enhet"),
        "encryptThisChat":
            MessageLookupByLibrary.simpleMessage("Kryptera denna chatt"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Krypterad"),
        "encryption": MessageLookupByLibrary.simpleMessage("Kryptering"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Kryptering är ej aktiverad"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("Totalsträckskryptering"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Ange ett gruppnamn"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Ange utrymmets namn"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Ange en e-postaddress"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "Ange länk för inbjudan eller Matrix-ID..."),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Gå till rummet"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Gå till utrymme"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Ange din hemserver"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Ett fel uppstod när widgeten skulle läggas till."),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Allt är klart!"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("Experimentella videosamtal"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extremt stötande"),
        "fileHasBeenSavedAt": m31,
        "fileIsTooBigForServer": MessageLookupByLibrary.simpleMessage(
            "Servern informerar om att filen är för stor för att skickas."),
        "fileName": MessageLookupByLibrary.simpleMessage("Filnamn"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Teckensnitt storlek"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "Denna notifikation visas när förgrundstjänsten körs."),
        "forward": MessageLookupByLibrary.simpleMessage("Framåt"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("Från att gå med"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Från inbjudan"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Gå till det nya rummet"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Grupp"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Gruppbeskrivning"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Gruppbeskrivningen ändrad"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Gruppen är publik"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Grupper"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Gäster är förbjudna"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Gäster kan ansluta"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Hjälp"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Göm redigerade händelser"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Göm oviktiga tillståndshändelser"),
        "hideUnknownEvents":
            MessageLookupByLibrary.simpleMessage("Göm okända händelser"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Hemserver"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Hur stötande är detta innehåll?"),
        "hugContent": m35,
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Återställ från säkerhetskopia"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR-användare: Importera session från tidigare export"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Exporterade du sessionen när du senast använde TOR? Importera den enkelt och fortsätt chatta."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Jag har klickat på länken"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Jag förstår"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identitet"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorera"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Du kan ignorera användare som stör dig. Du kommer inte att ha möjlighet att få några meddelanden eller rums-inbjudningar från användare på din personliga ignoreringslista."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignorera användarnamn"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Ignorera användare"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Felaktig lösenordsfras eller åsterställningsnyckel"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "Meddelandelagring är tyvärr inte aktiverat i privat läge som standard.\nGå till\n - about:config\n - sätt dom.indexedDB.privateBrowsing.enabled till true\nAnnars går det inte att använda FluffyChat."),
        "indexedDbErrorTitle":
            MessageLookupByLibrary.simpleMessage("Problem med privat läge"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Oförargligt"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Bjud in kontakt"),
        "inviteContactToGroup": m36,
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Inbjudning till mig"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Inbjuden"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Endast inbjudna användare"),
        "isTyping": MessageLookupByLibrary.simpleMessage("skriver…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Anslut till rum"),
        "joinedTheChat": m39,
        "jumpToLastReadMessage": MessageLookupByLibrary.simpleMessage(
            "Hoppa till det senast lästa meddelandet"),
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Sparka från chatt"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Sågs för längesedan"),
        "leave": MessageLookupByLibrary.simpleMessage("Lämna"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Lämnade chatten"),
        "letsStart": MessageLookupByLibrary.simpleMessage("Lås oss börja"),
        "license": MessageLookupByLibrary.simpleMessage("Licens"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Ljust"),
        "link": MessageLookupByLibrary.simpleMessage("Länk"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Ladda mer…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Laddar... Var god vänta."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Platstjänster är inaktiverade. Var god aktivera dom för att kunna dela din plats."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Plats åtkomst nekad. Var god godkän detta för att kunna dela din plats."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Logga in"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Logga in med ett klick"),
        "logout": MessageLookupByLibrary.simpleMessage("Logga ut"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Se till att identifieraren är giltig"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Markera som läst"),
        "matrixWidgets":
            MessageLookupByLibrary.simpleMessage("Matrix widgetar"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Medlemsändringar"),
        "mention": MessageLookupByLibrary.simpleMessage("Nämn"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Meddelandeinformation"),
        "messageType": MessageLookupByLibrary.simpleMessage("Meddelandetyp"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Meddelandet kommer tas bort för alla deltagare"),
        "messages": MessageLookupByLibrary.simpleMessage("Meddelanden"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderator"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Tysta chatt"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Var medveten om att du behöver Pantalaimon för att använda ändpunktskryptering tillsvidare."),
        "newChat": MessageLookupByLibrary.simpleMessage("Ny chatt"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Ny grupp"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 Nya meddelanden i FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Nytt utrymme"),
        "newSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Utrymmen möjliggör konsolidering av chattar och att bygga privata eller offentliga gemenskaper."),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Ny verifikationsbegäran!"),
        "next": MessageLookupByLibrary.simpleMessage("Nästa"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Nästa konto"),
        "no": MessageLookupByLibrary.simpleMessage("Nej"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "Varning! Om du inte aktiverar säkerhetskopiering av chattar så tappar du åtkomst till krypterade meddelanden. Det är rekommenderat att du aktiverar säkerhetskopiering innan du loggar ut."),
        "noConnectionToTheServer": MessageLookupByLibrary.simpleMessage(
            "Ingen anslutning till servern"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Utan en giltig e-postadress kommer du inte kunna återställa ditt lösenord. Om du inte vill ange en e-postadress, tryck på knappen igen för att fortsätta."),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Hittade inga dekaler. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Du kan endast aktivera kryptering när rummet inte längre är publikt tillgängligt."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "De ser ut som att du inte har google-tjänster på din telefon. Det är ett bra beslut för din integritet! För att få push notifikationer i FluffyChat rekommenderar vi att använda https://microg.org/ eller https://unifiedpush.org/ ."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "Detta kan hända om meddelandet skickades innan du loggade in på ditt konto i den här enheten.\n\nDet kan också vara så att avsändaren har blockerat din enhet eller att något gick fel med internetanslutningen.\n\nKan du läsa meddelandet i en annan session? I sådana fall kan du överföra meddelandet från den sessionen! Gå till Inställningar > Enhet och säkerställ att dina enheter har verifierat varandra. När du öppnar rummet nästa gång och båda sessionerna är i förgrunden, så kommer nycklarna att överföras automatiskt.\n\nVill du inte förlora nycklarna vid utloggning eller när du byter enhet? Säkerställ att du har aktiverat säkerhetskopiering för chatten i inställningarna."),
        "noMatrixServer": m45,
        "noOtherDevicesFound":
            MessageLookupByLibrary.simpleMessage("Inga andra enheter hittades"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Du har inte lagt till något sätt för att återställa ditt lösenord än."),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Ingen behörighet"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Hittade inga rum…"),
        "none": MessageLookupByLibrary.simpleMessage("Ingen"),
        "notifications": MessageLookupByLibrary.simpleMessage("Aviseringar"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notifikationer är påslaget för detta konto"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Erhåller plats…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Stötande"),
        "offline": MessageLookupByLibrary.simpleMessage("Offline"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "En av dina klienter har loggats ut"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Online Nyckel-backup är aktiverad"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Oj! Tyvärr uppstod ett fel vid upprättande av push notiser."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Hoppsan, något gick fel…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Öppna app för att lästa meddelanden"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Öppna kamera"),
        "openChat": MessageLookupByLibrary.simpleMessage("Öppna Chatt"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Öppna galleri"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Öppna i karta"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("Aktivera kamera för video"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Optional) Gruppnamn"),
        "or": MessageLookupByLibrary.simpleMessage("Eller"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Mikrofon, kamera och andra behörigheter för FluffyChat"),
        "participant": MessageLookupByLibrary.simpleMessage("Deltagare"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "lösenord eller återställningsnyckel"),
        "password": MessageLookupByLibrary.simpleMessage("Lösenord"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Glömt lösenord"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Lösenordet har ändrats"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Återställ lösenord"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "Lösenorden stämmer inte överens!"),
        "people": MessageLookupByLibrary.simpleMessage("Människor"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Välj en bild"),
        "pin": MessageLookupByLibrary.simpleMessage("Nåla fast"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("Fäst i rum"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Ring"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Var god välj"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Ange ett lösenord"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("Välj ett användarnamn"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Klicka på länken i e-postmeddelandet för att sedan fortsätta."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Ange 4 siffror eller lämna tom för att inaktivera app-lås."),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("Ange ditt Matrix ID."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Ange din återställningsnyckel:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Ange din återställningsnyckel från en tidigare session för att låsa upp äldre meddelanden. Din återställningsnyckel är INTE ditt lösenord."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Vänligen ange en giltig e-postadress."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Ange ditt lösenord"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Ange din pin-kod"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("Ange ditt användarnamn"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Följ instruktionerna på hemsidan och tryck på nästa."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Föregående konto"),
        "privacy": MessageLookupByLibrary.simpleMessage("Integritet"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Publika Rum"),
        "publish": MessageLookupByLibrary.simpleMessage("Publicera"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Push regler"),
        "reactedWith": m50,
        "readUpToHere":
            MessageLookupByLibrary.simpleMessage("Läs upp till hit"),
        "reason": MessageLookupByLibrary.simpleMessage("Anledning"),
        "recording": MessageLookupByLibrary.simpleMessage("Spelar in"),
        "recoveryKey":
            MessageLookupByLibrary.simpleMessage("Återställningsnyckel"),
        "recoveryKeyLost": MessageLookupByLibrary.simpleMessage(
            "Borttappad återställningsnyckel?"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Redigera meddelande"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Registrera"),
        "reject": MessageLookupByLibrary.simpleMessage("Avböj"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Återanslut"),
        "remove": MessageLookupByLibrary.simpleMessage("Ta bort"),
        "removeAllOtherDevices":
            MessageLookupByLibrary.simpleMessage("Ta bort alla andra enheter"),
        "removeDevice": MessageLookupByLibrary.simpleMessage("Ta bort enhet"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Ta bort från paket"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Ta bort från utrymme"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Ta bort din avatar"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Återge innehåll med rikt meddelande"),
        "reopenChat": MessageLookupByLibrary.simpleMessage("Återöppna chatt"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Upprepa lösenord"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Ersätt rum med nyare version"),
        "reply": MessageLookupByLibrary.simpleMessage("Svara"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Svar har skickats"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Rapportera meddelande"),
        "reportUser":
            MessageLookupByLibrary.simpleMessage("Rapportera användare"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Begär behörighet"),
        "roomHasBeenUpgraded": MessageLookupByLibrary.simpleMessage(
            "Rummet har blivit uppgraderat"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Rum version"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Spara fil"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Spara nyckeln manuellt genom att aktivera dela-funktionen eller urklippshanteraren på enheten."),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Skanna QR-kod"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Du delar din skärm i FluffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("skärmdelning"),
        "search": MessageLookupByLibrary.simpleMessage("Sök"),
        "security": MessageLookupByLibrary.simpleMessage("Säkerhet"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Skicka"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Skicka ett meddelande"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Skicka som text"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Skicka ljud"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Skicka fil"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Skicka bild"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Skickade meddelanden"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("Skicka med Enter"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("Skicka orginal"),
        "sendSticker":
            MessageLookupByLibrary.simpleMessage("Skicka klistermärke"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Skicka video"),
        "sender": MessageLookupByLibrary.simpleMessage("Avsändare"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Separata direktchattar och grupper"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Servern behöver validera din e-postadress för registrering."),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("Sätt som primärt alias"),
        "setCustomEmotes":
            MessageLookupByLibrary.simpleMessage("Ställ in anpassade dekaler"),
        "setGroupDescription":
            MessageLookupByLibrary.simpleMessage("Ställ in gruppbeskrivning"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Ställ in inbjudningslänk"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("Ställ in behörighetsnivå"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Ställ in status"),
        "settings": MessageLookupByLibrary.simpleMessage("Inställningar"),
        "share": MessageLookupByLibrary.simpleMessage("Dela"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("Dela plats"),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("Dela din inbjudan"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Visa relaterade direktchattar i utrymmen"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Visa lösenord"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registrera"),
        "singlesignon": MessageLookupByLibrary.simpleMessage("Single Sign On"),
        "skip": MessageLookupByLibrary.simpleMessage("Hoppa över"),
        "sorryThatsNotPossible":
            MessageLookupByLibrary.simpleMessage("Det där är inte möjligt"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Källkod"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Utrymme är publikt"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Utrymmes namn"),
        "start": MessageLookupByLibrary.simpleMessage("Starta"),
        "startFirstChat":
            MessageLookupByLibrary.simpleMessage("Starta din första chatt"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Hur mår du i dag?"),
        "storeInAndroidKeystore": MessageLookupByLibrary.simpleMessage(
            "Lagra i Androids nyckellagring (KeyStore)"),
        "storeInAppleKeyChain": MessageLookupByLibrary.simpleMessage(
            "Lagra i Apples nyckelkedja (KeyChain)"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Lagra återställningsnyckeln på säker plats på denna enhet."),
        "storeSecurlyOnThisDevice":
            MessageLookupByLibrary.simpleMessage("Lagra säkert på denna enhet"),
        "stories": MessageLookupByLibrary.simpleMessage("Berättelser"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Notera att användare kan se och kontakta varandra i din berättelse. Din berättelse är synlig i 24 timmar, men det finns ingen garanti för att berättelser raderas från alla enheter och servrar."),
        "submit": MessageLookupByLibrary.simpleMessage("Skicka in"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Synkroniserar… Var god vänta."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("System"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Dom Matchar Inte"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Dom Matchar"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Den här användaren har inte lagt till något till deras berättelse än"),
        "time": MessageLookupByLibrary.simpleMessage("Tid"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite": MessageLookupByLibrary.simpleMessage("Växla favorit"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage("Växla tystad"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Markera läst/oläst"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "För många förfrågningar. Vänligen försök senare!"),
        "transferFromAnotherDevice":
            MessageLookupByLibrary.simpleMessage("Överför till annan enhet"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Försök att skicka igen"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Upptagen"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Ta bort chatt-blockering"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Avblockera enhet"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("Okänd enhet"),
        "unknownEncryptionAlgorithm":
            MessageLookupByLibrary.simpleMessage("Okänd krypteringsalgoritm"),
        "unlockOldMessages":
            MessageLookupByLibrary.simpleMessage("Lås upp äldre meddelanden"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Slå på ljudet för chatten"),
        "unpin": MessageLookupByLibrary.simpleMessage("Avnåla"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Avprenumerera berättelser"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Inget stöd för denna version av Android"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Denna funktion kräver en senare version av Android."),
        "unverified": MessageLookupByLibrary.simpleMessage("Ej verifierad"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "FluffyChat-uppdatering tillgänglig"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Påbörja uppdatering i bakgrunden"),
        "user": MessageLookupByLibrary.simpleMessage("Användare"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Användarnamn"),
        "users": MessageLookupByLibrary.simpleMessage("Användare"),
        "verified": MessageLookupByLibrary.simpleMessage("Verifierad"),
        "verify": MessageLookupByLibrary.simpleMessage("Verifiera"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Starta verifiering"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Du har lyckats verifiera!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Verifiera andra konton"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Videosamtal"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Videosamtal är för närvarande under testning. De kanske inte fungerar som det är tänkt eller på alla plattformar."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory":
            MessageLookupByLibrary.simpleMessage("Chatt-historikens synlighet"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("Synlig för alla deltagare"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Synlig för alla"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Röstsamtal"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Röstmeddelande"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Väntar på att deltagaren accepterar begäran…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Väntar på att deltagaren accepterar emojien…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Väntar på att deltagaren accepterar nummer…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Bakgrund"),
        "warning": MessageLookupByLibrary.simpleMessage("Varning!"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "Vi skickade dig ett e-postmeddelande"),
        "whatIsGoingOn": MessageLookupByLibrary.simpleMessage("Vad händer?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Vem kan utföra vilken åtgärd"),
        "whoCanSeeMyStories": MessageLookupByLibrary.simpleMessage(
            "Vem kan se mina berättelser?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Notera att användare kan se och kontakta varandra i din berättelse."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Vilka som är tilllåtna att ansluta till denna grupp"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Varför vill du rapportera detta?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "Varför kan inte detta meddelande läsas?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Anpassad"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("Anteckning"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi-möte"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Namn"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage(
            "Vänligen ange ett visningsnamn."),
        "widgetUrlError": MessageLookupByLibrary.simpleMessage(
            "Detta är inte en giltig URL."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Radera din chatt-backup för att skapa en ny återställningsnyckel?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Med dessa addresser kan du återställa ditt lösenord."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Skriv ett meddelande…"),
        "yes": MessageLookupByLibrary.simpleMessage("Ja"),
        "you": MessageLookupByLibrary.simpleMessage("Du"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("👍 Du accepterade inbjudan"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Du är inbjuden till denna chatt"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Du deltar inte längre i denna chatt"),
        "youBannedUser": m77,
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "Du kan inte bjuda in dig själv"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Du har blivit bannad från denna chatt"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("Du gick med i chatten"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Du avvisade inbjudan"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Din chatt-backup har konfigurerats."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Din publika nyckel"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Din berättelse")
      };
}
