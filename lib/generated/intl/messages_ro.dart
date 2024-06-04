// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ro locale. All the
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
  String get localeName => 'ro';

  static String m0(username) => "${username} a aceptat invitați";

  static String m1(username) => "${username} a activat criptarea end-to-end";

  static String m2(senderName) => "${senderName} a acceptat apelul";

  static String m3(username) =>
      "Accepți cererea de verificare de la ${username}?";

  static String m4(username, targetName) =>
      "${username} a interzis pe ${targetName}";

  static String m5(uri) => "Nu se poate deschide URI-ul ${uri}";

  static String m6(username) => "${username} a schimbat poza conversați";

  static String m7(username, description) =>
      "${username} a schimbat descrierea grupului în \'${description}\'";

  static String m8(username, chatname) =>
      "${username} a schimbat porecla în \'${chatname}\'";

  static String m9(username) => "${username} a schimbat permisiunile chatului";

  static String m10(username, displayname) =>
      "${username} s-a schimbat displayname la: \'${displayname}\'";

  static String m11(username) =>
      "${username} a schimbat regulile pentru acesul musafirilor";

  static String m12(username, rules) =>
      "${username} a schimbat regulile pentru acesul musafirilor la: ${rules}";

  static String m13(username) =>
      "${username} a schimbat vizibilitatea istoriei chatului";

  static String m14(username, rules) =>
      "${username} a schimbat vizibilitatea istoriei chatului la: ${rules}";

  static String m15(username) => "${username} a schimbat regulile de alăturare";

  static String m16(username, joinRules) =>
      "${username} a schimbat regulile de alăturare la: ${joinRules}";

  static String m17(username) => "${username} s-a schimbat avatarul";

  static String m18(username) => "${username} a schimbat pseudonimele camerei";

  static String m19(username) => "${username} a schimbat linkul de invitație";

  static String m20(command) => "${command} nu este o comandă.";

  static String m21(error) => "Dezcriptarea mesajului a eșuat: ${error}";

  static String m22(count) => "${count} fișiere";

  static String m23(count) => "${count} participanți";

  static String m24(username) => "💬${username} a creat chatul";

  static String m25(senderName) => "${senderName} vă îmbrățișează";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${year}-${month}-${day}";

  static String m28(month, day) => "${month}-${day}";

  static String m29(senderName) => "${senderName} a terminat apelul";

  static String m30(error) => "Obținerea locației a eșuat: ${error}";

  static String m31(path) => "Fișierul a fost salvat la ${path}";

  static String m32(senderName) => "${senderName} v-a trimis ochi googly";

  static String m33(displayname) => "Grup cu ${displayname}";

  static String m34(username, targetName) =>
      "${username} a retras invitația pentru ${targetName}";

  static String m35(senderName) => "${senderName} vă îmbrățișează";

  static String m36(groupName) => "Invitați contact la ${groupName}";

  static String m37(username, link) =>
      "${username} v-a invitat la FluffyChat.\n1. Instalați FluffyChat: https://fluffychat.im\n2. Înregistrați-vă sau conectați-vă\n3. Deschideți invitația: ${link}";

  static String m38(username, targetName) =>
      "📩${username} a invitat ${targetName}";

  static String m39(username) => "👋${username} a intrat în chat";

  static String m40(username, targetName) =>
      "👞${username} a dat afară pe ${targetName}";

  static String m41(username, targetName) =>
      "🙅${username} a dat afară și a interzis pe ${targetName} din cameră";

  static String m42(localizedTimeShort) =>
      "Ultima dată activ: ${localizedTimeShort}";

  static String m43(count) => "Încărcați încă mai ${count} participanți";

  static String m44(homeserver) => "Conectați-vă la ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} nu este server matrix, înlocuiți cu ${server2}?";

  static String m46(number) => "${number} chaturi";

  static String m47(count) => "${count} utilizatori tastează…";

  static String m48(fileName) => "Redați ${fileName}";

  static String m49(min) => "Vă rugăm să alegeți cel puțin ${min} caractere.";

  static String m50(sender, reaction) =>
      "${sender} a reacționat cu ${reaction}";

  static String m51(username) => "${username} a redactat un eveniment";

  static String m52(username) => "${username} a respins invitația";

  static String m53(username) => "Eliminat de ${username}";

  static String m54(username) => "Văzut de ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Văzut de ${username} și ${count} alți')}";

  static String m56(username, username2) =>
      "Văzut de ${username} și ${username2}";

  static String m57(username) => "📁${username} a trimis un fișier";

  static String m58(username) => "🖼️ ${username} a trimis o poză";

  static String m59(username) => "😊 ${username} a trimis un sticker";

  static String m60(username) => "🎥${username} a trimis un video";

  static String m61(username) => "🎤${username} a trimis audio";

  static String m62(senderName) => "${senderName} a trimis informație de apel";

  static String m63(username) => "${username} sa partajat locația";

  static String m64(senderName) => "${senderName} a început un apel";

  static String m65(date, body) => "Story de ${date}:\n${body}";

  static String m66(mxid) => "ID-ul ar trebuii să fie ${mxid}";

  static String m67(number) => "Schimbați la contul ${number}";

  static String m68(username, targetName) =>
      "${username} a ridicat interzicerea lui ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: 'Un chat necitit', other: '${unreadCount} chaturi necitite')}";

  static String m70(username, count) =>
      "${username} și ${count} alți tastează…";

  static String m71(username, username2) =>
      "${username} și ${username2} tastează…";

  static String m72(username) => "${username} tastează…";

  static String m73(username) => "🚪${username} a plecat din chat";

  static String m74(username, type) =>
      "${username} a trimis un eveniment ${type}";

  static String m75(size) => "Video (${size})";

  static String m76(oldDisplayName) => "Chat gol (a fost ${oldDisplayName})";

  static String m77(user) => "Ați interzis pe ${user}";

  static String m78(user) => "Ați retras invitația pentru ${user}";

  static String m79(user) => "📩Ați fost invitat de ${user}";

  static String m80(user) => "📩Ați invitat pe ${user}";

  static String m81(user) => "👞Ați dat afară pe ${user}";

  static String m82(user) => "🙅Ați dat afară și interzis pe ${user}";

  static String m83(user) => "Ați ridicat interzicerea lui ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Despre"),
        "accept": MessageLookupByLibrary.simpleMessage("Accept"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Cont"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Adăugați cont"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Adăugați descriere"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Adăugați email"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Adaugă o descriere de"),
        "addToBundle":
            MessageLookupByLibrary.simpleMessage("Adăugați în pachet"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Adăugați la spațiu"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Alegeți un spațiu în care să adăugați acest chat."),
        "addToStory": MessageLookupByLibrary.simpleMessage("Adăugați la story"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Adăugați widget"),
        "admin": MessageLookupByLibrary.simpleMessage("Administrator"),
        "alias": MessageLookupByLibrary.simpleMessage("poreclă"),
        "all": MessageLookupByLibrary.simpleMessage("Toate"),
        "allChats": MessageLookupByLibrary.simpleMessage("Toate Chaturile"),
        "allRooms":
            MessageLookupByLibrary.simpleMessage("Toate chaturi de grup"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Toate spațiile"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Oricine se poate alătura"),
        "appLock": MessageLookupByLibrary.simpleMessage("Lacăt aplicație"),
        "appearOnTop": MessageLookupByLibrary.simpleMessage("Apare deasupra"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Permite aplicația să apare deasupra (nu este necesar dacă aveți FluffyChat stabilit ca cont de apeluri)"),
        "archive": MessageLookupByLibrary.simpleMessage("Arhivă"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Vizitatorii \"guest\" se pot alătura"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Ești sigur?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Sunteți sigur că doriți să vă deconectați?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Pentru a putea conecta cealaltă persoană, te rog introdu parola sau cheia ta de recuperare."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Anima automatic stickere și emote animate"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Interzis din conversație"),
        "banned": MessageLookupByLibrary.simpleMessage("Interzis"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Blochează dispozitiv"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blocat"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Mesaje Bot"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Mărimea bulelor"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Numele pachetului"),
        "callingAccount": MessageLookupByLibrary.simpleMessage("Cont de apel"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Permite FluffyChat să folosească aplicația de apeluri nativă android."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Permisiuni de apel"),
        "cancel": MessageLookupByLibrary.simpleMessage("Anulează"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Schimbă numele dispozitiv"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Schimbați parola"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Schimbați homeserver-ul"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Schimbați numele grupului"),
        "changeTheme":
            MessageLookupByLibrary.simpleMessage("Schimbați tema aplicației"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage(
            "Schimbați imaginea de fundal"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Schimbați avatarul vostru"),
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
            MessageLookupByLibrary.simpleMessage("Criptarea a fost corupată"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "chatBackup": MessageLookupByLibrary.simpleMessage("Backup de chat"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Mesajele voastre vechi sunt sigurate cu o cheie de recuperare. Vă rugăm să nu o pierdeți."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Detalii de chat"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "Chatul a fost adăugat la acest spațiu"),
        "chats": MessageLookupByLibrary.simpleMessage("Chaturi"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Alegeți o parolă robustă"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Alegeți un username"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Ștergeți arhiva"),
        "close": MessageLookupByLibrary.simpleMessage("Închideți"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Interziceți acesul utilizatorului ales din această cameră"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Ștergeți cache"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Creați un grup de chat gol\nFolosiți --no-encryption să dezactivați criptare"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Trimiteți o îmbrățișare"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Renunțați sesiunea"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Porniți un chat direct\nFolosiți --no-encryption să dezactivați criptare"),
        "commandHint_googly": MessageLookupByLibrary.simpleMessage(
            "Trimiteți câțiva ochi googly"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Trimiteți text format ca HTML"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Trimiteți o îmbrățișare"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Invitați utilizatorul ales la această cameră"),
        "commandHint_join": MessageLookupByLibrary.simpleMessage(
            "Alăturați-vă la camera alesă"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Dați afară pe utilizatorul ales din această cameră"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Renunțați la această cameră"),
        "commandHint_markasdm": MessageLookupByLibrary.simpleMessage(
            "Marcați ca cameră de mesaje directe"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Marcați ca grup"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Descrieți-vă"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Alegeți un avatar pentru această cameră (foloșește mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Alegeți un displayname pentru această cameră"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Stabiliți nivelul de putere a utilizatorul ales (implicit: 50)"),
        "commandHint_plain": MessageLookupByLibrary.simpleMessage(
            "Trimiteți text simplu/neformatat"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Trimiteți răspuns ca reacție"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Trimiteți text"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Dezinterziceți utilizatorul ales din această cameră"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Comandă nevalibilă"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să comparați emoji-urile"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să comparați numerele"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Configurați chat"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmați"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Sunteți sigur că doriți să anulați permanent fixarea evenimentului?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să confirmați Matrix ID-ul vostru să ștergeți contul vostru."),
        "connect": MessageLookupByLibrary.simpleMessage("Conectați"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Contactul a fost invitat la grup"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Conține displayname"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Conține nume de utilizator"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "Conținutul a fost reportat la administratori serverului"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Copiat în clipboard"),
        "copy": MessageLookupByLibrary.simpleMessage("Copiați"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Copiați în clipboard"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Creați"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Creați grup nou"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Spațiu nou"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive": MessageLookupByLibrary.simpleMessage("Activ acum"),
        "custom": MessageLookupByLibrary.simpleMessage("Personalizat"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Întunecat"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Această acțiune va dezactiva contul vostru. Nu poate fi anulat! Sunteți sigur?"),
        "defaultPermissionLevel": MessageLookupByLibrary.simpleMessage(
            "Nivel de permisiuni implicită"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Exportați sesiunea și ștergeți dispozitivul"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "Utilizatori de TOR: Exportați sesiunea"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Pentru utilizatori de TOR, este recomandat să exportați sesiunea înainte de a închideți fereastra."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Această actiune nu poate fi anulată. Asigurați-vă că păstrați fișierul backup."),
        "delete": MessageLookupByLibrary.simpleMessage("Ștergeți"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Ștergeți contul"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Ștergeți mesajul"),
        "deny": MessageLookupByLibrary.simpleMessage("Refuza"),
        "device": MessageLookupByLibrary.simpleMessage("Dispozitiv"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ID-ul Dispozitiv"),
        "deviceKeys":
            MessageLookupByLibrary.simpleMessage("Cheile dispozitivului:"),
        "devices": MessageLookupByLibrary.simpleMessage("Dispozitive"),
        "directChats": MessageLookupByLibrary.simpleMessage("Chaturi directe"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Pentru motive de securitate, nu este posibil să dezactivați criptarea unui chat în care criptare este activată."),
        "discover": MessageLookupByLibrary.simpleMessage("Descoperă"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Respingeți"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Displayname a fost schimbat"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Nu se mai apară din nou"),
        "downloadFile":
            MessageLookupByLibrary.simpleMessage("Descărcați fișierul"),
        "edit": MessageLookupByLibrary.simpleMessage("Editați"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("Editați servere blocate"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Editați pachetele pentru acest cont"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage(
            "Schimbați permisiunele chatului"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Schimbați displayname"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage(
            "Schimbați pseudonimele camerei"),
        "editRoomAvatar": MessageLookupByLibrary.simpleMessage(
            "Schimbați avatarul din cameră"),
        "editWidgets":
            MessageLookupByLibrary.simpleMessage("Editați widget-uri"),
        "emailOrUsername": MessageLookupByLibrary.simpleMessage(
            "Email sau nume de utilizator"),
        "emojis": MessageLookupByLibrary.simpleMessage("Emoji-uri"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Emote deja există!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Shortcode de emote nevalibil!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Pachete de emoturi din cameră"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Configurări Emote"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Shortcode de emote"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Trebuie să alegeți shortcode pentru emote și o imagine!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Chat gol"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Activați pachet de emote global"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Activați criptare"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Activând criptare, nu mai puteți să o dezactivați în viitor. Sunteți sigur?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Activați multiple conturi pe acest dispozitiv"),
        "encryptThisChat":
            MessageLookupByLibrary.simpleMessage("Criptați acest chat"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Criptat"),
        "encryption": MessageLookupByLibrary.simpleMessage("Criptare"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("Criptare nu e activată"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("Criptare end-to-end"),
        "endedTheCall": m29,
        "enterAGroupName": MessageLookupByLibrary.simpleMessage(
            "Introduceți nume pentru grup"),
        "enterASpacepName": MessageLookupByLibrary.simpleMessage(
            "Introduceți nume pentru spațiu"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Introduceți o adresă email"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "Introduceți link de invitație sau ID Matrix..."),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Intrați în cameră"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Intrați în spațiu"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage(
            "Introduceți homeserverul vostru"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Adăugarea widget-ului a eșuat."),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Totul e gata!"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("Apeluri video experimentale"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("De foarte mare ofensă"),
        "fileHasBeenSavedAt": m31,
        "fileIsTooBigForServer": MessageLookupByLibrary.simpleMessage(
            "Serverul reportează că fișierul este prea mare să fie trimis."),
        "fileName": MessageLookupByLibrary.simpleMessage("Nume de fișier"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Mărimea fontului"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "Această notificare apare când serviciul de foreground rulează."),
        "forward": MessageLookupByLibrary.simpleMessage("Înainte"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("De la alăturare"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("De la invitația"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Mergeți la camera nouă"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Grup"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Descrierea grupului"),
        "groupDescriptionHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Descrierea grupului a fost schimbat"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Grupul este public"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Grupuri"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Musafiri sunt interziși"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Musafiri pot să se alăture"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Ajutor"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage(
            "Ascunde evenimente redactate"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Ascundeți evenimente de stare neimportante"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Ascunde evenimente necunoscute"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Homeserver"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Cât de ofensiv este acest conținut?"),
        "hugContent": m35,
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Restaurați din fișier backup"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "Utilizatori TOR: Importați sesiune exportată"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Ați exportat sesiunea vostră ultima dată pe TOR? Importați-o repede și continuați să conversați."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Am făcut click pe link"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Am înțeles"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identitate"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorați"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Puteți să ignorați utilizatori care vă deranjează. Nu ați să primiți mesaje sau invitații de cameră de la utilizatori pe lista voastră de ignorați."),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage(
            "Ignorați numele de utilizator"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Utilizatori ignorați"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Parolă sau cheie de recuperare incorectă"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "Stocarea de mesaje nu este activat implicit în modul privat.\nVă rugăm să vizitați\n- about:config\n- stabiliți dom.indexedDB.privateBrowsing.enabled la true\nAstfel, nu este posibil să folosiți FluffyChat."),
        "indexedDbErrorTitle":
            MessageLookupByLibrary.simpleMessage("Probleme cu modul privat"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Inofensiv"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Invitați contact"),
        "inviteContactToGroup": m36,
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Invitați pentru mine"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Invitat"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Numai utilizatori invitați"),
        "isTyping": MessageLookupByLibrary.simpleMessage("tastează…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Alăturați la cameră"),
        "joinedTheChat": m39,
        "jump": MessageLookupByLibrary.simpleMessage("Săriți"),
        "jumpToLastReadMessage": MessageLookupByLibrary.simpleMessage(
            "Săriți la ultimul citit mesaj"),
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Dați afară din chat"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo": MessageLookupByLibrary.simpleMessage(
            "Văzut de ultima dată cu mult timp în urmă"),
        "leave": MessageLookupByLibrary.simpleMessage("Renunțați"),
        "leftTheChat":
            MessageLookupByLibrary.simpleMessage("A plecat din chat"),
        "letsStart": MessageLookupByLibrary.simpleMessage("Hai să începem"),
        "license": MessageLookupByLibrary.simpleMessage("Permis"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Luminat"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Încarcă mai multe…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Încărcând... Vă rugăm să așteptați."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Servicile de locație sunt dezactivate. Vă rugăm să le activați să împărțiți locația voastră."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Permisiunea locației blocată. Vă rugăm să o dezblocați să împărțiți locația voastră."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Conectați-vă"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Conectați-vă cu un click"),
        "logout": MessageLookupByLibrary.simpleMessage("Deconectați-vă"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Verificați că identificatorul este valabil"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Marcați ca citit"),
        "matrixWidgets":
            MessageLookupByLibrary.simpleMessage("Widget-uri Matrix"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Schimbări de membri"),
        "mention": MessageLookupByLibrary.simpleMessage("Menționați"),
        "messageInfo": MessageLookupByLibrary.simpleMessage("Info mesajului"),
        "messageType": MessageLookupByLibrary.simpleMessage("Fel de mesaj"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Mesajul va fi șters pentru toți participanți"),
        "messages": MessageLookupByLibrary.simpleMessage("Mesaje"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderator"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Amuțați chatul"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să fiți conștienți că e nevoie de Pantalaimon să folosiți criptare end-to-end deocamdată."),
        "newChat": MessageLookupByLibrary.simpleMessage("Chat nou"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Grup nou"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("💬 Mesaj nou în FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Spațiu nou"),
        "newSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Spațiile vă permit să vă consolidați chaturile și să stabiliți comunități private sau publice."),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Cerere de verificare nouă!"),
        "next": MessageLookupByLibrary.simpleMessage("Următor"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Contul următor"),
        "no": MessageLookupByLibrary.simpleMessage("Nu"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "Avertisment! Fără să activați backup de chat, veți pierde accesul la mesajele voastre criptate. E foarte recomandat să activați backup de chat înainte să vă deconectați."),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Fără conexiune la server"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți o adresă de email valibilă. Altfel nu veți putea reseta parola. Dacă totuși nu doriți să introduceți, apăsați din nou pe buton să continuați."),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage(
            "Nu s-a găsit nici un emote. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Criptare nu poate fi activată până când camera este accesibilă public."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Se pare că nu aveți serviciile google pe dispozitivul vostru. Această decizie este bună pentru confidențialitatea voastră! Să primiți notificari push în FluffyChat vă recomandăm https://microg.org/ sau https://unifiedpush.org/."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "Această chestie poate să se întâmple când mesajul a fost trimis înainte să vă conectați contul cu acest dispozitiv.\n\nO altă explicație ar fi dacă trimițătorul a blocat dispozitivul vostru sau ceva s-a întâmplat cu conexiunea la internet\n\nPuteți să citiți mesajul în o altă seșiune? Atunci puteți să transferați mesajul de acolo! Mergeți la Configurări > Dispozitive și verificați că dispozitivele s-au verificat. Când deschideți camera în viitor și ambele seșiune sunt în foreground, cheile va fi transmise automat. \n\nDoriți să îți păstrați cheile când deconectați sau schimbați dispozitive? Fiți atenți să activați backup de chat în configurări."),
        "noMatrixServer": m45,
        "noOtherDevicesFound": MessageLookupByLibrary.simpleMessage(
            "Nu s-a găsit alte dispozitive"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Nu ați adăugat încă nici un mod de recuperare pentru parola voastră."),
        "noPermission": MessageLookupByLibrary.simpleMessage("Fără permisie"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Nici o cameră nu s-a găsit…"),
        "none": MessageLookupByLibrary.simpleMessage("Niciunul"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificări"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notificări activate pentru acest cont"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Obținând locație…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Ofensiv"),
        "offline": MessageLookupByLibrary.simpleMessage("Offline"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Unul dintre clienților voștri a fost deconectat"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Backup de cheie online este activat"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Ups! Din păcate, o eroare s-a întâmplat cu stabilirea de notificări push."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Ups, ceva a eșuat…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Deschideți aplicația să citiți mesajele"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Deschideți camera"),
        "openChat": MessageLookupByLibrary.simpleMessage("Deschideți Chat"),
        "openGallery":
            MessageLookupByLibrary.simpleMessage("Deschideți galeria"),
        "openInMaps":
            MessageLookupByLibrary.simpleMessage("Deschideți pe hartă"),
        "openLinkInBrowser": MessageLookupByLibrary.simpleMessage(
            "Deschideți linkul în browser"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage(
            "Deschideți camera pentru video"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Opțional) Numele grupului"),
        "or": MessageLookupByLibrary.simpleMessage("Sau"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Microfon, cameră și alte permisiuni lui FluffyChat"),
        "participant": MessageLookupByLibrary.simpleMessage("Participant"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "frază de acces sau cheie de recuperare"),
        "password": MessageLookupByLibrary.simpleMessage("Parolă"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Parola uitată"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Parola a fost schimbată"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Recuperare parolei"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Parolele nu corespund!"),
        "people": MessageLookupByLibrary.simpleMessage("Persoane"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Alegeți o imagine"),
        "pin": MessageLookupByLibrary.simpleMessage("Fixați"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("Fixați în cameră"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Faceți apel"),
        "play": m48,
        "pleaseChoose":
            MessageLookupByLibrary.simpleMessage("Vă rugăm să alegeți"),
        "pleaseChooseAPasscode": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să alegeți un passcode"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să alegeți un username"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să deschideți linkul din email și apoi să procedați."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți 4 cifre sau puteți să lăsați gol să dezactivați lacătul aplicației."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți un ID Matrix."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți cheia voastră de recuperare:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Să vă deblocați mesajele vechi, vă rugăm să introduceți cheia de recuperare creată de o seșiune anterioră. Cheia de recuperare NU este parola voastră."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți o adresă de email validă."),
        "pleaseEnterYourPassword": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți parola voastră"),
        "pleaseEnterYourPin": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți pinul vostru"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți username-ul vostru"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să urmați instrucțiunele pe website și apoi să apăsați pe următor."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Contul anterior"),
        "privacy": MessageLookupByLibrary.simpleMessage("Confidențialitate"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Camere Publice"),
        "publish": MessageLookupByLibrary.simpleMessage("Publicați"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Regulile Push"),
        "reactedWith": m50,
        "readUpToHere": MessageLookupByLibrary.simpleMessage("Citit până aici"),
        "reason": MessageLookupByLibrary.simpleMessage("Motiv"),
        "recording": MessageLookupByLibrary.simpleMessage("Înregistrare"),
        "recoveryKey":
            MessageLookupByLibrary.simpleMessage("Cheie de recuperare"),
        "recoveryKeyLost": MessageLookupByLibrary.simpleMessage(
            "Cheia de recuperare pierdută?"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Redactați mesaj"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Înregistrați-vă"),
        "reject": MessageLookupByLibrary.simpleMessage("Respingeți"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Reintrați"),
        "remove": MessageLookupByLibrary.simpleMessage("Eliminați"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Eliminați toate celelalte dispozitive"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Eliminați dispozitivul"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Stergeți din acest pachet"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Eliminați din spațiu"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Ștergeți avatarul"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Reda conținut bogat al mesajelor"),
        "reopenChat":
            MessageLookupByLibrary.simpleMessage("Deschide din nou chatul"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Repetați parola"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Înlocuiți camera cu versiune mai nouă"),
        "reply": MessageLookupByLibrary.simpleMessage("Răspundeți"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Răspunsul a fost trimis"),
        "report": MessageLookupByLibrary.simpleMessage("reportați"),
        "reportErrorDescription": MessageLookupByLibrary.simpleMessage(
            "Ceva a eșuat. Vă rugăm să încercați din nou mai tărziu. Dacă doriți, puteți să reportați problema la dezvoltatori."),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Raportați mesajul"),
        "reportUser":
            MessageLookupByLibrary.simpleMessage("Reportați utilizator"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Cereți permisiune"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Camera a fost actualizată"),
        "roomVersion":
            MessageLookupByLibrary.simpleMessage("Versiunea camerei"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Salvați fișierul"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Activați dialogul de partajare sistemului sau folosiți clipboard-ul să salvați manual această cheie."),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Scanați cod QR"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Partajați ecranul în FluffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("partajarea de ecran"),
        "search": MessageLookupByLibrary.simpleMessage("Căutați"),
        "security": MessageLookupByLibrary.simpleMessage("Securitate"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Trimiteți"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Trimiteți un mesaj"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Trimiteți ca text"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Trimiteți audio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Trimiteți fișier"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Trimiteți imagine"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Trimiteți mesaje"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Trimite cu tasta enter"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Trimiteți original"),
        "sendSticker":
            MessageLookupByLibrary.simpleMessage("Trimiteți sticker"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Trimiteți video"),
        "sender": MessageLookupByLibrary.simpleMessage("Trimițător"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Afișați chaturi directe și grupuri separat"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Acest server trebuie să valideze emailul vostru pentru înregistrare."),
        "setAsCanonicalAlias": MessageLookupByLibrary.simpleMessage(
            "Stabiliți ca pseudonimul primar"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Stabiliți emoji-uri personalizate"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Stabiliți descrierea grupului"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage(
            "Stabiliți linkul de invitație"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage(
            "Stabiliți nivelul de permisii"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Stabiliți status"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurări"),
        "share": MessageLookupByLibrary.simpleMessage("Partajați"),
        "shareLocation":
            MessageLookupByLibrary.simpleMessage("Partajați locația"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Partajați linkul de invitație"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Afișați chaturi directe relate în spatiuri"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Afișați parola"),
        "signUp": MessageLookupByLibrary.simpleMessage("Înregistrați-vă"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Autentificare unică"),
        "skip": MessageLookupByLibrary.simpleMessage("Săriți peste"),
        "sorryThatsNotPossible": MessageLookupByLibrary.simpleMessage(
            "Scuze... acest nu este posibil"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Codul surs"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Spațiul este public"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Numele spațiului"),
        "start": MessageLookupByLibrary.simpleMessage("Începeți"),
        "startFirstChat": MessageLookupByLibrary.simpleMessage(
            "Începeți primul chatul vostru"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Ce faceți?"),
        "storeInAndroidKeystore":
            MessageLookupByLibrary.simpleMessage("Stoca în Android KeyStore"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("Stoca în Apple KeyChain"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Păstrați cheia de recuperare în stocarea sigură a acestui dispozitiv."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Stoca sigur pe acest dispozitiv"),
        "stories": MessageLookupByLibrary.simpleMessage("Povești"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să țineți în minte că utilizatori poate să se vadă și contacta pe story-ul vostru. Story-urile voastre va fi disponibile pentru 24 de ore dar nu se poate garanta că va fi șterse de pe fie care dispozitiv și server."),
        "submit": MessageLookupByLibrary.simpleMessage("Trimiteți"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Sincronizează... Vă rugăm să așteptați."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Sistem"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Nu sunt asemănători"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Sunt asemănători"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Acest utilizator nu a postat nimic încă pe story"),
        "time": MessageLookupByLibrary.simpleMessage("Timp"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Comutați favoritul"),
        "toggleMuted":
            MessageLookupByLibrary.simpleMessage("Comutați amuțeștarea"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Marcați Citit/Necitit"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Prea multe cereri. Vă rugăm să încercați din nou mai tărziu!"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Transfera de la alt dispozitiv"),
        "tryToSendAgain": MessageLookupByLibrary.simpleMessage(
            "Încercați să trimiteți din nou"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Nedisponibil"),
        "unbanFromChat": MessageLookupByLibrary.simpleMessage(
            "Revoca interzicerea din chat"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Debloca dispozitiv"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Dispozitiv necunoscut"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Algoritm de criptare necunoscut"),
        "unlockOldMessages":
            MessageLookupByLibrary.simpleMessage("Deblocați mesajele vechi"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage("Dezamuțați chat"),
        "unpin": MessageLookupByLibrary.simpleMessage("Anulează fixarea"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Dezabonați stories"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Versiune de Android nesuportat"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Această funcție are nevoie de o versiune de Android mai nouă. Vă rugăm să verificați dacă sunt actualizări sau suport de la Lineage OS."),
        "unverified": MessageLookupByLibrary.simpleMessage("Neverificat"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "Actualizare FluffyChat disponibil"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Începeți actualizare în fundal"),
        "user": MessageLookupByLibrary.simpleMessage("Utilizator"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Nume de utilizator"),
        "users": MessageLookupByLibrary.simpleMessage("Utilizatori"),
        "verified": MessageLookupByLibrary.simpleMessage("Verificat"),
        "verify": MessageLookupByLibrary.simpleMessage("Verificați"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Începeți verificare"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("A reușit verificarea!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Verificând celălalt cont"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Apel video"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să luați notă că apeluri video sunt în beta. Se poate că nu funcționează normal sau de loc pe fie care platformă."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Vizibilitatea istoria chatului"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Vizibil pentru toți participanți"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Vizibil pentru toți"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Apel vocal"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Mesaj vocal"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Așteptând pe partenerul să accepte cererea…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Așteptând pe partenerul să accepte emoji-ul…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Așteptând pe partenerul să accepte numerele…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Imagine de fundal"),
        "warning": MessageLookupByLibrary.simpleMessage("Avertizment!"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail":
            MessageLookupByLibrary.simpleMessage("V-am trimis un email"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("Ce se întâmplă?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Cine poate face care acțiune"),
        "whoCanSeeMyStories": MessageLookupByLibrary.simpleMessage(
            "Cine poate să-mi vadă stories?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să țineți în minte că utilizatori pot să se vadă și contacta pe story-ul vostru."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Cine se poate alătura la acest grup"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "De ce doriți să reportați acest conținut?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "De ce este acest mesaj ilizibil?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Personalizat"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("Notiță text"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Nume"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage(
            "Vă rugăm să introduceți un nume de afișare."),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("Acest URL nu este valibil."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Ștergeți backup-ul vostru de chat să creați o nouă cheie de recuperare?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Cu acestea adrese puteți să vă recuperați parola."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Scrieți un mesaj…"),
        "yes": MessageLookupByLibrary.simpleMessage("Da"),
        "you": MessageLookupByLibrary.simpleMessage("Voi"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("👍Ați acceptat invitația"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Sunteți invitați la acest chat"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Nu mai participați în acest chat"),
        "youBannedUser": m77,
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "Nu puteți să vă invitați voi însivă"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Ați fost interzis din acest chat"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("Va-ți alăturat la chat"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Ați respins invitația"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Backup-ul vostru de chat a fost configurat."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Cheia voastră publică"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Story-ul vostru")
      };
}
