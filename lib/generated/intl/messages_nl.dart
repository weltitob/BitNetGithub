// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static String m0(username) =>
      "👍 ${username} heeft de uitnodiging geaccepteerd";

  static String m1(username) =>
      "🔐 ${username} heeft eind-tot-eindversleuteling geactiveerd";

  static String m2(senderName) => "${senderName} heeft de oproep beantwoord";

  static String m3(username) =>
      "Accepteer je dit verificatieverzoek van ${username}?";

  static String m4(username, targetName) => "${username} verbant ${targetName}";

  static String m5(uri) => "Kan de URI ${uri} niet openen";

  static String m6(username) => "${username} heeft de chatavatar gewijzigd";

  static String m7(username, description) =>
      "${username} heeft de chatomschrijving gewijzigd in: ${description}";

  static String m8(username, chatname) =>
      "${username} heeft de chatnaam gewijzigd in: ${chatname}";

  static String m9(username) => "${username} heeft de chatrechten gewijzigd";

  static String m10(username, displayname) =>
      "${username}\'s naam is nu ${displayname}";

  static String m11(username) =>
      "${username} heeft de toegangsregels voor gasten gewijzigd";

  static String m12(username, rules) =>
      "${username} heeft de gastenregels gewijzigd in: ${rules}";

  static String m13(username) =>
      "${username} heeft de zichtbaarheid van de geschiedenis gewijzigd";

  static String m14(username, rules) =>
      "${username} heeft de zichtbaarheid van de geschiedenis gewijzigd in: ${rules}";

  static String m15(username) =>
      "${username} heeft de deelnameregels gewijzigd";

  static String m16(username, joinRules) =>
      "${username} heeft de deelnameregels gewijzigd in: ${joinRules}";

  static String m17(username) => "${username}\'s avatar is gewijzigd";

  static String m18(username) => "${username} heeft de kameraliassen gewijzigd";

  static String m19(username) =>
      "${username} heeft de uitnodigingslink gewijzigd";

  static String m20(command) => "${command} is geen opdracht.";

  static String m21(error) => "Kan het bericht niet ontsleutelen: ${error}";

  static String m22(count) => "${count} bestanden";

  static String m23(count) => "${count} personen";

  static String m24(username) => "💬 ${username} heeft de chat gemaakt";

  static String m25(senderName) => "${senderName} knuffelt je";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}-${month}-${year}";

  static String m28(month, day) => "${day}-${month}";

  static String m29(senderName) => "${senderName} heeft het gesprek beëindigd";

  static String m30(error) => "Locatie ophalen fout: ${error}";

  static String m31(path) => "Het bestand is opgeslagen op ${path}";

  static String m32(senderName) => "${senderName} stuurt je wiebelogen";

  static String m33(displayname) => "Groep met ${displayname}";

  static String m34(username, targetName) =>
      "${username} heeft de uitnodiging voor ${targetName} ingetrokken";

  static String m35(senderName) => "${senderName} omhelst je";

  static String m36(groupName) => "Contact voor ${groupName} uitnodigen";

  static String m37(username, link) =>
      "${username} heeft je uitgenodigd voor FluffyChat.\n1. Installeer FluffyChat: https://fluffychat.im\n2. Registreer of log in\n3. Open deze uitnodigingslink: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} heeft ${targetName} uitgenodigd";

  static String m39(username) => "👋 ${username} is toegetreden tot de chat";

  static String m40(username, targetName) =>
      "👞 ${username} heeft ${targetName} verwijderd";

  static String m41(username, targetName) =>
      "🙅 ${username} heeft ${targetName} verwijderd en verbannen";

  static String m42(localizedTimeShort) =>
      "Laatst actief: ${localizedTimeShort}";

  static String m43(count) => "Laad nog ${count} personen";

  static String m44(homeserver) => "Inloggen bij ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} is geen Matrix-server, wil je ${server2} gebruiken?";

  static String m46(number) => "${number} chats";

  static String m47(count) => "${count} personen typen…";

  static String m48(fileName) => "Speel ${fileName}";

  static String m49(min) => "Kies een wachtwoord met minimaal ${min} tekens.";

  static String m50(sender, reaction) => "${sender} reageerde met ${reaction}";

  static String m51(username) => "${username} heeft een event verwijderd";

  static String m52(username) => "${username} heeft de uitnodiging afgewezen";

  static String m53(username) => "Verwijderd door ${username}";

  static String m54(username) => "Gezien door ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Gezien door ${username} en ${count} anderen')}";

  static String m56(username, username2) =>
      "Gezien door ${username} en ${username2}";

  static String m57(username) => "📁 ${username} heeft een bestand verzonden";

  static String m58(username) =>
      "🖼️ ${username} heeft een afbeelding verzonden";

  static String m59(username) => "😊 ${username} heeft een sticker verzonden";

  static String m60(username) => "🎥 ${username} heeft een video verzonden";

  static String m61(username) => "🎤 ${username} heeft een audio verzonden";

  static String m62(senderName) =>
      "${senderName} heeft oproepgegevens verzonden";

  static String m63(username) => "${username} heeft deze locatie gedeeld";

  static String m64(senderName) => "${senderName} heeft een gesprek gestart";

  static String m65(date, body) => "Verhaal van ${date}:\n${body}";

  static String m66(mxid) => "Dit moet ${mxid} zijn";

  static String m67(number) => "Naar account ${number} overschakelen";

  static String m68(username, targetName) =>
      "${username} heeft verbanning ${targetName} ongedaan gemaakt";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 ongelezen chat', other: '${unreadCount} ongelezen chats')}";

  static String m70(username, count) =>
      "${username} en ${count} anderen zijn aan het typen …";

  static String m71(username, username2) =>
      "${username} en ${username2} zijn aan het typen …";

  static String m72(username) => "${username} is aan het typen …";

  static String m73(username) => "🚪 ${username} is vertrokken uit de chat";

  static String m74(username, type) =>
      "${username} heeft een ${type} -gebeurtenis gestuurd";

  static String m75(size) => "Video (${size})";

  static String m76(oldDisplayName) => "Lege chat (was ${oldDisplayName})";

  static String m77(user) => "Je hebt ${user} verbannen";

  static String m78(user) => "Je hebt de uitnodiging voor ${user} ingetrokken";

  static String m79(user) => "📩 Je bent uitgenodigd door ${user}";

  static String m80(user) => "📩 Je hebt ${user} uitgenodigd";

  static String m81(user) => "👞 Je hebt ${user} weggestuurd";

  static String m82(user) => "🙅 Je hebt weggestuurd en verbannen ${user}";

  static String m83(user) => "Je hebt de ban op ${user} opgeheven";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Over ons"),
        "accept": MessageLookupByLibrary.simpleMessage("Accepteren"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Account toevoegen"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Omschrijving toevoegen"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Email toevoegen"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Voeg een groepsomschrijving toe"),
        "addToBundle":
            MessageLookupByLibrary.simpleMessage("Aan bundel toevoegen"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Aan space toevoegen"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Selecteer een space om deze chat aan toe te voegen."),
        "addToStory":
            MessageLookupByLibrary.simpleMessage("Toevoegen aan verhaal"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Widget toevoegen"),
        "admin": MessageLookupByLibrary.simpleMessage("Beheerder"),
        "alias": MessageLookupByLibrary.simpleMessage("alias"),
        "all": MessageLookupByLibrary.simpleMessage("Alle"),
        "allChats": MessageLookupByLibrary.simpleMessage("Alle chats"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Alle spaces"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Iedereen kan deelnemen"),
        "appLock": MessageLookupByLibrary.simpleMessage("App-vergrendeling"),
        "appearOnTop":
            MessageLookupByLibrary.simpleMessage("Bovenaan verschijnen"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Laat de app bovenaan verschijnen (niet nodig als je FluffyChat al hebt ingesteld als een belaccount)"),
        "archive": MessageLookupByLibrary.simpleMessage("Archief"),
        "areGuestsAllowedToJoin":
            MessageLookupByLibrary.simpleMessage("Mogen gasten deelnemen"),
        "areYouSure":
            MessageLookupByLibrary.simpleMessage("Weet je het zeker?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Weet je zeker dat je wilt uitloggen?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Voer je beveiligde opslag wachtwoordzin of herstelsleutel in om de andere persoon te kunnen ondertekenen."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Automatisch geanimeerde stickers en emoticons afspelen"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Van chat verbannen"),
        "banned": MessageLookupByLibrary.simpleMessage("Verbannen"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Apparaat blokkeren"),
        "blocked": MessageLookupByLibrary.simpleMessage("Geblokkeerd"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Bot-berichten"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Bubbelgrootte"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Bundelnaam"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Telefoon-account"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Hiermee kan FluffyChat de Android telefoon-app gebruiken."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Telefoon-rechten"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annuleren"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Apparaatnaam wijzigen"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Wachtwoord wijzigen"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Homeserver wijzigen"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Groepsnaam wijzigen"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Stijl veranderen"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Achtergrond wijzigen"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Jouw avatar veranderen"),
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
            "De versleuteling is beschadigd"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("Chatback-up"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Je oude berichten zijn beveiligd met een herstelsleutel. Zorg ervoor dat je deze niet verliest."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Chatdetails"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "Chat is toegevoegd aan deze space"),
        "chats": MessageLookupByLibrary.simpleMessage("Chats"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Kies een sterk wachtwoord"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Kies een inlognaam"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Archief wissen"),
        "close": MessageLookupByLibrary.simpleMessage("Sluiten"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Persoon uit deze kamer verbannen"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Cache wissen"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Maak een lege groepschat\nGebruik --no-encryption om de versleuteling uit te schakelen"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Een knuffel versturen"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Sessie weggooien"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Start een directe chat\nGebruik --no-encryption om de versleuteling uit te schakelen"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Wat wiebelogen versturen"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Tekst met HTML-opmaak versturen"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Een knuffel versturen"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Persoon in deze kamer uitnodigen"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Deelnemen aan de kamer"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Persoon uit deze kamer verwijderen"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Deze kamer verlaten"),
        "commandHint_markasdm": MessageLookupByLibrary.simpleMessage(
            "Markeer als privéberichtenkamer"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Markeer als groep"),
        "commandHint_me":
            MessageLookupByLibrary.simpleMessage("Beschrijf jezelf"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Jouw avatar voor deze kamer instellen (met mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Jouw naam voor deze kamer instellen"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Machtsniveau van de persoon instellen (standaard: 50)"),
        "commandHint_plain": MessageLookupByLibrary.simpleMessage(
            "Niet-opgemaakte tekst versturen"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Antwoord als reactie versturen"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Tekst versturen"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Persoon weer in deze kamer toestaan"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Opdracht ongeldig"),
        "commandMissing": m20,
        "compareEmojiMatch":
            MessageLookupByLibrary.simpleMessage("Vergelijk de emoji\'s"),
        "compareNumbersMatch":
            MessageLookupByLibrary.simpleMessage("Vergelijk de cijfers"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Chat configureren"),
        "confirm": MessageLookupByLibrary.simpleMessage("Bevestigen"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Weet je zeker dat je de gebeurtenis definitief wilt losmaken?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Bevestig jouw Matrix-ID om je account te verwijderen."),
        "connect": MessageLookupByLibrary.simpleMessage("Verbinden"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Contact is voor de groep uitgenodigd"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Bevat naam"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Bevat gebruikersnaam"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "De inhoud is gerapporteerd aan de serverbeheerders"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Gekopieerd naar klembord"),
        "copy": MessageLookupByLibrary.simpleMessage("Bericht kopiëren"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Kopieer naar klembord"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Aanmaken"),
        "createNewGroup": MessageLookupByLibrary.simpleMessage("Nieuwe groep"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Nieuwe space"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Momenteel actief"),
        "custom": MessageLookupByLibrary.simpleMessage("Aangepast"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Donker"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Hierdoor wordt je account gedeactiveerd. Dit kan niet ongedaan gemaakt worden! Weet je het zeker?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Standaardmachtigingsniveau"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Sessie exporteren en apparaat wissen"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR-sessies: Exporteer sessie"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Voor TOR-sessies is het aanbevolen de sessie te exporteren alvorens het venster te sluiten."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Deze actie kan niet ongedaan worden gemaakt. Zorg ervoor dat je het back-upbestand veilig opslaat."),
        "delete": MessageLookupByLibrary.simpleMessage("Verwijderen"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Account verwijderen"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Bericht verwijderen"),
        "deny": MessageLookupByLibrary.simpleMessage("Weigeren"),
        "device": MessageLookupByLibrary.simpleMessage("Apparaat"),
        "deviceId": MessageLookupByLibrary.simpleMessage("Apparaat-ID"),
        "deviceKeys": MessageLookupByLibrary.simpleMessage("Apparaatsleutels:"),
        "devices": MessageLookupByLibrary.simpleMessage("Apparaten"),
        "directChats": MessageLookupByLibrary.simpleMessage("Directe chats"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Om veiligheidsredenen kun je versleuteling niet uitschakelen in een chat, waar deze eerder is ingeschakeld."),
        "dismiss": MessageLookupByLibrary.simpleMessage("Sluiten"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("De naam is gewijzigd"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Niet meer tonen"),
        "downloadFile":
            MessageLookupByLibrary.simpleMessage("Bestand downloaden"),
        "edit": MessageLookupByLibrary.simpleMessage("Wijzig"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Geblokkeerde servers wijzigen"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Bundels voor dit account wijzigen"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Chatrechten wijzigen"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Naam wijzigen"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Kameraliassen wijzigen"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Kameravatar wijzigen"),
        "editWidgets": MessageLookupByLibrary.simpleMessage("Widgets wijzigen"),
        "emailOrUsername":
            MessageLookupByLibrary.simpleMessage("Email of inlognaam"),
        "emojis": MessageLookupByLibrary.simpleMessage("Emoji\'s"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Emoticon bestaat al!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Ongeldige emoticon korte code!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Emoticonpakketten voor de kamer"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Emoticon-instellingen"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Emoticon korte code"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Je moet een emoticon korte code en afbeelding kiezen!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Lege chat"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Emoticonpakket overal inschakelen"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Versleuteling inschakelen"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Je kunt de versleuteling hierna niet meer uitschakelen. Weet je het zeker?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Multi-accounts inschakelen op dit apparaat"),
        "encryptThisChat":
            MessageLookupByLibrary.simpleMessage("Versleutel deze chat"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Versleuteld"),
        "encryption": MessageLookupByLibrary.simpleMessage("Versleuteling"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage(
            "Versleuteling is niet ingeschakeld"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("Eind-tot-eind-versleuteling"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Vul een groepsnaam in"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Vul een spacenaam in"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Voer een email in"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "Uitnodigingslink of Matrix-ID invoeren..."),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Kamer betreden"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Space betreden"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Vul je homeserver in"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Fout bij het toevoegen van de widget."),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("Alles klaar!"),
        "experimentalVideoCalls": MessageLookupByLibrary.simpleMessage(
            "Videogesprekken (experimenteel)"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extreem beledigend"),
        "fileHasBeenSavedAt": m31,
        "fileIsTooBigForServer": MessageLookupByLibrary.simpleMessage(
            "De server meldt dat het bestand te groot is om te verzenden."),
        "fileName": MessageLookupByLibrary.simpleMessage("Bestandsnaam"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Lettergrootte"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "Deze melding verschijnt wanneer de voorgronddienst draait."),
        "forward": MessageLookupByLibrary.simpleMessage("Stuur door"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("Vanaf deelname"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Vanaf uitnodiging"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Ga naar de nieuwe kamer"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Groep"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Groepsomschrijving"),
        "groupDescriptionHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Groepsomschrijving gewijzigd"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Groep is openbaar"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Groepen"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Gasten zijn verboden"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Gasten kunnen deelnemen"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Help"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage(
            "Bewerkte gebeurtenissen verbergen"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Onbelangrijke statusgebeurtenissen verbergen"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Onbekende gebeurtenissen verbergen"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Server"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Hoe beledigend is deze inhoud?"),
        "hugContent": m35,
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Herstellen vanuit back-upbestand"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "TOR-sessie: Importeren sessie export"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Heb je de vorige keer jouw sessie geëxporteerd met TOR? Importeer het dan snel en ga verder met chatten."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Ik heb op de link geklikt"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Ik begrijp het"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identiteit"),
        "ignore": MessageLookupByLibrary.simpleMessage("Negeer"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Je kunt personen die je storen negeren. Je kunt geen berichten of kameruitnodigingen ontvangen van de personen op je negeerlijst."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Negeer persoon"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Genegeerde personen"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Onjuiste wachtwoordzin of herstelsleutel"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "Het opslaan van berichten is helaas niet standaard ingeschakeld in de privémodus.\nBezoek alsjeblieft\n - about:config\n - stel dom.indexedDB.privateBrowsing.enabled in op true\nAnders is het niet mogelijk om FluffyChat op te starten."),
        "indexedDbErrorTitle":
            MessageLookupByLibrary.simpleMessage("Problemen met privémodus"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Niet beledigend"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Contact uitnodigen"),
        "inviteContactToGroup": m36,
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Persoonlijke uitnodiging"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Uitgenodigd"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage(
            "Alleen uitgenodigde personen"),
        "isTyping": MessageLookupByLibrary.simpleMessage("is aan het typen…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Deelnemen"),
        "joinedTheChat": m39,
        "jump": MessageLookupByLibrary.simpleMessage("Spring"),
        "jumpToLastReadMessage": MessageLookupByLibrary.simpleMessage(
            "Spring naar het laatst gelezen bericht"),
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Uit chat verwijderen"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Lang geleden gezien"),
        "leave": MessageLookupByLibrary.simpleMessage("Chat verlaten"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Verliet de chat"),
        "letsStart": MessageLookupByLibrary.simpleMessage("Laten we beginnen"),
        "license": MessageLookupByLibrary.simpleMessage("Licentie"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Licht"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Meer laden…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Bezig met laden… Even geduld."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Locatievoorzieningen is uitgeschakeld. Zet dit eerst aan om je locatie te delen."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Locatievoorzieningen is geweigerd. Zet hem aan om locatie delen te gebruiken."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Inloggen"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Inloggen met één klik"),
        "logout": MessageLookupByLibrary.simpleMessage("Uitloggen"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Zorg ervoor dat de identificatie geldig is"),
        "markAsRead":
            MessageLookupByLibrary.simpleMessage("Markeer als gelezen"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Matrix Widgets"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Persoon wijzigingen"),
        "mention": MessageLookupByLibrary.simpleMessage("Vermeld"),
        "messageInfo": MessageLookupByLibrary.simpleMessage("Berichtinfo"),
        "messageType": MessageLookupByLibrary.simpleMessage("Berichttype"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Bericht wordt verwijderd voor alle personen"),
        "messages": MessageLookupByLibrary.simpleMessage("Berichten"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderator"),
        "muteChat":
            MessageLookupByLibrary.simpleMessage("Meldingen uitschakelen"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Houd er rekening mee dat je voorlopig Pantalaimon nodig hebt om eind-tot-eindversleuteling te gebruiken."),
        "newChat": MessageLookupByLibrary.simpleMessage("Nieuwe chat"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Nieuwe groep"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 Nieuw bericht in FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Nieuwe space"),
        "newSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Met spaces kun je je chats samenvoegen en privé- of openbare community\'s bouwen."),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Nieuw verificatieverzoek!"),
        "next": MessageLookupByLibrary.simpleMessage("Volgende"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Volgende account"),
        "no": MessageLookupByLibrary.simpleMessage("Nee"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "Waarschuwing! Zonder de chatback-up in te schakelen, verlies je de toegang tot je versleutelde berichten. Het is sterk aanbevolen om eerst de chatback-up in te schakelen voordat je uitlogt."),
        "noConnectionToTheServer": MessageLookupByLibrary.simpleMessage(
            "Geen verbinding met de server"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Voer een geldig e-mailadres in. Anders kan je jouw wachtwoord niet opnieuw instellen. Als je dat niet wilt, tik je nogmaals op de knop om door te gaan."),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Geen emoticons gevonden. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Je kunt de versleuteling pas activeren zodra de kamer niet meer openbaar toegankelijk is."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Het lijkt erop dat je geen Google-services op je telefoon hebt. Dat is een goede beslissing voor je privacy! Om pushmeldingen in FluffyChat te ontvangen raden we je https://microg.org/ of https://unifiedpush.org aan."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "Dit kan gebeuren als het bericht is verzonden voordat je bij je account op dit apparaat hebt aangemeld.\n\nHet is ook mogelijk dat de afzender je apparaat heeft geblokkeerd of dat er iets mis is gegaan met de internetverbinding.\n\nKan je het bericht wel lezen op een andere sessie? Dan kan je het bericht daarvandaan overzetten! Ga naar Instellingen > Apparaten en zorg ervoor dat je apparaten elkaar hebben geverifieerd. Wanneer je de kamer de volgende keer opent en beide sessies op de voorgrond staan, zullen de sleutels automatisch worden verzonden.\n\nWil je de sleutels niet verliezen als je uitlogt of van apparaat wisselt? Zorg er dan voor dat je de chatback-up hebt aangezet in de instellingen."),
        "noMatrixServer": m45,
        "noOtherDevicesFound": MessageLookupByLibrary.simpleMessage(
            "Geen andere apparaten gevonden"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Je hebt nog geen manier toegevoegd om je wachtwoord te herstellen."),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Geen toestemming"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Geen kamers gevonden …"),
        "none": MessageLookupByLibrary.simpleMessage("Geen"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificaties"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Meldingen ingeschakeld voor dit account"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Locatie ophalen…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Beledigend"),
        "offline": MessageLookupByLibrary.simpleMessage("Offline"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Één van jouw apparaten is uitgelogd"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Online sleutelback-up is ingeschakeld"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Oeps! Helaas is er een fout opgetreden bij het instellen van de pushmeldingen."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Oeps, er ging iets mis…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Open app om de berichten te lezen"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Camera openen"),
        "openChat": MessageLookupByLibrary.simpleMessage("Chat openen"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Galerij openen"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("In kaarten openen"),
        "openLinkInBrowser":
            MessageLookupByLibrary.simpleMessage("Link in browser openen"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("Videocamera openen"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("Groepsnaam (optioneel)"),
        "or": MessageLookupByLibrary.simpleMessage("Of"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Microfoon, camera en andere FluffyChat-rechten"),
        "participant": MessageLookupByLibrary.simpleMessage("Personen"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "wachtwoordzin of herstelsleutel"),
        "password": MessageLookupByLibrary.simpleMessage("Wachtwoord"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Wachtwoord vergeten"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Wachtwoord gewijzigd"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Wachtwoordherstel"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "Wachtwoorden komen niet overeen!"),
        "people": MessageLookupByLibrary.simpleMessage("Personen"),
        "pickImage":
            MessageLookupByLibrary.simpleMessage("Kies een afbeelding"),
        "pin": MessageLookupByLibrary.simpleMessage("Pin"),
        "pinMessage":
            MessageLookupByLibrary.simpleMessage("Maak vast aan kamer"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Bellen"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Kies"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Kies een toegangscode"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("Kies een inlognaam"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Klik op de link in de email en ga dan verder."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Voer 4 cijfers in of laat leeg om app-vergrendeling uit te schakelen."),
        "pleaseEnterAMatrixIdentifier":
            MessageLookupByLibrary.simpleMessage("Voer een Matrix-ID in."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Voer jouw herstelsleutel in:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Om je oude berichten te ontgrendelen voer je jouw herstelsleutel in die gemaakt is in je vorige sessie. Je sleutel is niet je wachtwoord."),
        "pleaseEnterValidEmail":
            MessageLookupByLibrary.simpleMessage("Voor een geldige email in."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Voer jouw wachtwoord in"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Voer je pincode in"),
        "pleaseEnterYourUsername":
            MessageLookupByLibrary.simpleMessage("Voer je inlognaam in"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Volg de instructies op de website en tik op volgende."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Vorige account"),
        "privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Publieke Kamers"),
        "publish": MessageLookupByLibrary.simpleMessage("Publiceren"),
        "pushRules":
            MessageLookupByLibrary.simpleMessage("Meldingsinstellingen"),
        "reactedWith": m50,
        "readUpToHere": MessageLookupByLibrary.simpleMessage("Lees tot hier"),
        "reason": MessageLookupByLibrary.simpleMessage("Reden"),
        "recording": MessageLookupByLibrary.simpleMessage("Opnemen"),
        "recoveryKey": MessageLookupByLibrary.simpleMessage("Herstelsleutel"),
        "recoveryKeyLost":
            MessageLookupByLibrary.simpleMessage("Herstelsleutel verloren?"),
        "redactMessage": MessageLookupByLibrary.simpleMessage("Verwijder"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Registeren"),
        "reject": MessageLookupByLibrary.simpleMessage("Weigeren"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Opnieuw deelnemen"),
        "remove": MessageLookupByLibrary.simpleMessage("Verwijder"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Verwijder alle andere apparaten"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Verwijder apparaat"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Van bundel verwijderen"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Uit de space verwijderen"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Jouw avatar verwijderen"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Uitgebreide berichtinhoud weergeven"),
        "reopenChat": MessageLookupByLibrary.simpleMessage("Chat heropenen"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Wachtwoord herhalen"),
        "replaceRoomWithNewerVersion":
            MessageLookupByLibrary.simpleMessage("Kamerversie upgraden"),
        "reply": MessageLookupByLibrary.simpleMessage("Antwoord"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Antwoord is verzonden"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Bericht rapporteren"),
        "reportUser":
            MessageLookupByLibrary.simpleMessage("Persoon rapporteren"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Vraag toestemming"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Kamer is geüpgrade"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Kamerversie"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Bestand opslaan"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Sla deze sleutel handmatig op via delen of het klembord."),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("QR-code scannen"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Je deelt je scherm in FuffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("scherm delen"),
        "search": MessageLookupByLibrary.simpleMessage("Zoeken"),
        "security": MessageLookupByLibrary.simpleMessage("Beveiliging"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Verstuur"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Stuur een bericht"),
        "sendAsText":
            MessageLookupByLibrary.simpleMessage("Als tekst versturen"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Audio versturen"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Bestand versturen"),
        "sendImage":
            MessageLookupByLibrary.simpleMessage("Afbeelding versturen"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Berichten versturen"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Verstuur met enter"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Origineel versturen"),
        "sendSticker":
            MessageLookupByLibrary.simpleMessage("Sticker versturen"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Video versturen"),
        "sender": MessageLookupByLibrary.simpleMessage("Afzender"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Gescheiden directe chats en groepen"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Deze server wil je email laten bevestigen bij de registratie."),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("Instellen als hoofdalias"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Aangepaste emoticons inschakelen"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Stel een groepsomschrijving in"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Uitnodigingslink instellen"),
        "setPermissionsLevel":
            MessageLookupByLibrary.simpleMessage("Machtigingsniveau instellen"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Status instellen"),
        "settings": MessageLookupByLibrary.simpleMessage("Instellingen"),
        "share": MessageLookupByLibrary.simpleMessage("Delen"),
        "shareLocation": MessageLookupByLibrary.simpleMessage("Locatie delen"),
        "shareYourInviteLink":
            MessageLookupByLibrary.simpleMessage("Deel je uitnodigingslink"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Toon gerelateerde directe chats in spaces"),
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Wachtwoord weergeven"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registreren"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Eenmalig Inloggen"),
        "skip": MessageLookupByLibrary.simpleMessage("Overslaan"),
        "sorryThatsNotPossible":
            MessageLookupByLibrary.simpleMessage("Sorry, dat is niet mogelijk"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Broncode"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Space is openbaar"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Spacenaam"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "startFirstChat":
            MessageLookupByLibrary.simpleMessage("Begin je eerste chat"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "statusExampleMessage": MessageLookupByLibrary.simpleMessage(
            "Hoe gaat het met jouw vandaag?"),
        "storeInAndroidKeystore":
            MessageLookupByLibrary.simpleMessage("In Android KeyStore opslaan"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("In Apple KeyChain opslaan"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Sla de herstelsleutel op in de beveiligde opslag van dit apparaat."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Veilig opslaan op dit apparaat"),
        "stories": MessageLookupByLibrary.simpleMessage("Verhalen"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Houd er rekening mee dat personen elkaar kunnen zien en contacteren in je verhaal. Je verhalen zijn 24 uur zichtbaar, maar er is geen garantie dat ze van alle apparaten en servers worden verwijderd."),
        "submit": MessageLookupByLibrary.simpleMessage("Verstuur"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Synchroniseren... Even geduld."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Systeem"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Ze komen niet overeen"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Ze komen overeen"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Deze persoon heeft nog niets in zijn verhaal geplaatst"),
        "time": MessageLookupByLibrary.simpleMessage("Tijd"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite": MessageLookupByLibrary.simpleMessage(
            "Favoriet in- of uitschakelen"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage(
            "Meldingen in- of uitschakelen"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Markeer gelezen/ongelezen"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Te veel verzoeken. Probeer het later nog eens!"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Overzetten vanaf een ander apparaat"),
        "tryToSendAgain": MessageLookupByLibrary.simpleMessage(
            "Probeer nogmaals te verzenden"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Niet beschikbaar"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Verbanning opheffen"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Deblokkeer apparaat"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Onbekend apparaat"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Onbekend versleutelingsalgoritme"),
        "unlockOldMessages":
            MessageLookupByLibrary.simpleMessage("Oude berichten ontgrendelen"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Meldingen inschakelen"),
        "unpin": MessageLookupByLibrary.simpleMessage("Losmaken"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Verhalen afmelden"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Niet-ondersteunde Android-versie"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Voor deze functie is een nieuwere Android-versie vereist. Controleer op updates of Lineage OS-ondersteuning."),
        "unverified": MessageLookupByLibrary.simpleMessage("Niet geverifieerd"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "FluffyChat-update beschikbaar"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Update op de achtergrond starten"),
        "user": MessageLookupByLibrary.simpleMessage("Persoon"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Gebruikersnaam"),
        "users": MessageLookupByLibrary.simpleMessage("Personen"),
        "verified": MessageLookupByLibrary.simpleMessage("Geverifieerd"),
        "verify": MessageLookupByLibrary.simpleMessage("Verifieer"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Verificatie starten"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage(
            "Je bent succesvol geverifieerd!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Ander account verifiëren"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Videogesprek"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Houd er rekening mee dat videogesprekken momenteel in bèta zijn. Ze werken misschien niet zoals je verwacht of werken niet op alle platformen."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Chatgeschiedenis zichtbaarheid"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Zichtbaar voor alle personen"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Zichtbaar voor iedereen"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Spraakoproep"),
        "voiceMessage":
            MessageLookupByLibrary.simpleMessage("Spraakbericht versturen"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Wachten tot partner het verzoek accepteert …"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Wachten tot partner de emoji accepteert …"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Wachten tot partner de nummers accepteert …"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Achtergrond"),
        "warning": MessageLookupByLibrary.simpleMessage("Waarschuwing!"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "We hebben je een email gestuurd"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("Hoe gaat het nu?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Wie kan welke actie uitvoeren"),
        "whoCanSeeMyStories":
            MessageLookupByLibrary.simpleMessage("Wie kan mijn verhalen zien?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Houd er rekening mee dat personen elkaar in je verhaal kunnen zien en contact met elkaar kunnen opnemen."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Wie mag deelnemen aan deze groep"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Waarom wil je dit rapporteren?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "Waarom is dit bericht onleesbaar?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Aangepast"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("Tekstnotitie"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Naam"),
        "widgetNameError":
            MessageLookupByLibrary.simpleMessage("Geef een naam op."),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("Dit is geen geldige link."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Wil je de chatback-up wissen om een nieuwe herstelsleutel te kunnen maken?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Met deze adressen kan je je wachtwoord herstellen."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Schrijf een bericht…"),
        "yes": MessageLookupByLibrary.simpleMessage("Ja"),
        "you": MessageLookupByLibrary.simpleMessage("Jij"),
        "youAcceptedTheInvitation": MessageLookupByLibrary.simpleMessage(
            "👍 Je hebt de uitnodiging geaccepteerd"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Je bent uitgenodigd voor deze chat"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Je neemt niet langer deel aan deze chat"),
        "youBannedUser": m77,
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "Je kunt jezelf niet uitnodigen"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Je bent verbannen uit deze chat"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat": MessageLookupByLibrary.simpleMessage(
            "Je bent toegetreden tot de chat"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation": MessageLookupByLibrary.simpleMessage(
            "Je hebt de uitnodiging afgewezen"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Jouw chatback-up is ingesteld."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Je publieke sleutel"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Jouw verhaal")
      };
}
