// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ie locale. All the
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
  String get localeName => 'ie';

  static String m0(username) => "${username} ha acceptat li invitation";

  static String m3(username) =>
      "Esque acceptar ti demanda de verification de ${username}?";

  static String m4(username, targetName) =>
      "${username} ha bannit ${targetName}";

  static String m5(uri) => "Ne successat aperter li adresse ${uri}";

  static String m22(count) => "${count} files";

  static String m23(count) => "${count} participantes";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}.${month}.${year}";

  static String m28(month, day) => "${day}.${month}";

  static String m33(displayname) => "Gruppe con ${displayname}";

  static String m38(username, targetName) =>
      "${username} invitat ${targetName}";

  static String m42(localizedTimeShort) =>
      "Ultim activité: ${localizedTimeShort}";

  static String m46(number) => "${number} conversationes";

  static String m48(fileName) => "Reproducter ${fileName}";

  static String m49(min) => "Ples usar adminim ${min} caracteres.";

  static String m66(mxid) => "To deve esser ${mxid}";

  static String m75(size) => "Video (${size})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Pri"),
        "accept": MessageLookupByLibrary.simpleMessage("Acceptar"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Conto"),
        "addAccount": MessageLookupByLibrary.simpleMessage("Adjunter un conto"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Adjunter un descrition"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Adjunter e-post"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Adjunter un descrition de gruppe"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Adjunter al spacie"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Adjunter un widget"),
        "admin": MessageLookupByLibrary.simpleMessage("Administrator"),
        "alias": MessageLookupByLibrary.simpleMessage("pseudonim"),
        "all": MessageLookupByLibrary.simpleMessage("Omni"),
        "allChats": MessageLookupByLibrary.simpleMessage("Omni conversationes"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Omni spacies"),
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Alquí posse adherer se"),
        "archive": MessageLookupByLibrary.simpleMessage("Archive"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Esque vu es cert?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Esque vu vole cluder li session?"),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Automaticmen reproducter animat images"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Bannir del conversation"),
        "banned": MessageLookupByLibrary.simpleMessage("Bannit"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Blocar li aparate"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blocat"),
        "botMessages":
            MessageLookupByLibrary.simpleMessage("Missages de robots"),
        "bubbleSize":
            MessageLookupByLibrary.simpleMessage("Dimension de parlada-bul"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Conto telefonante"),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Permissiones de telefonada"),
        "cancel": MessageLookupByLibrary.simpleMessage("Anullar"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage(
            "Cambiar li nómine de aparate"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Cambiar li contrasigne"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Cambiar li hem-servitor"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Cambiar li stil"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Cambiar li tapete"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Cambiar vor avatar"),
        "chat": MessageLookupByLibrary.simpleMessage("Conversation"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Archive de conversation"),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Detallies del conversation"),
        "chats": MessageLookupByLibrary.simpleMessage("Conversationes"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Selecte un nómine de usator"),
        "clearArchive":
            MessageLookupByLibrary.simpleMessage("Vacuar li archive"),
        "close": MessageLookupByLibrary.simpleMessage("Cluder"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Vacuar li cache"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("Inviar contenete HTML"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Forlassar ti chambre"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Marcar quam gruppe"),
        "commandHint_me":
            MessageLookupByLibrary.simpleMessage("Ples descrir vos"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Inviar textu sin formate"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Inviar li textu"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Comande es ínvalid"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Configurar li conversation"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Ples confirmar vor Matrix ID por destructer vor conto."),
        "connect": MessageLookupByLibrary.simpleMessage("Conexer"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Contene li visibil nómine"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Contene li nómine"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Copiat al Paperiere"),
        "copy": MessageLookupByLibrary.simpleMessage("Copiar"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Copiar al Paperiere"),
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Crear"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Crear un nov gruppe"),
        "createNewSpace":
            MessageLookupByLibrary.simpleMessage("Crear un spacie"),
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Activ actualmen"),
        "custom": MessageLookupByLibrary.simpleMessage("Personalisat"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Obscur"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "delete": MessageLookupByLibrary.simpleMessage("Remover"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Destructer li conto"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Remover li missage"),
        "deny": MessageLookupByLibrary.simpleMessage("Refusar"),
        "device": MessageLookupByLibrary.simpleMessage("Aparate"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ID de aparate"),
        "devices": MessageLookupByLibrary.simpleMessage("Aparates"),
        "directChats":
            MessageLookupByLibrary.simpleMessage("Direct conversationes"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Demisser"),
        "downloadFile":
            MessageLookupByLibrary.simpleMessage("Descargar li file"),
        "edit": MessageLookupByLibrary.simpleMessage("Redacter"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("Modificar blocat servitores"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Redacter li visibil nómine"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage(
            "Modificar pseudonimos del chambre"),
        "editRoomAvatar": MessageLookupByLibrary.simpleMessage(
            "Modificar li avatar del chambre"),
        "editWidgets":
            MessageLookupByLibrary.simpleMessage("Modificar li widgets"),
        "emojis": MessageLookupByLibrary.simpleMessage("Emoji"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Emotion ja existe!"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Parametres de emotiones"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Curt-code de emotion"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Vacui conversation"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Activar li ciffration"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Ciffrat"),
        "encryption": MessageLookupByLibrary.simpleMessage("Ciffration"),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Intrar li chambre"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Intrar li spacie"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Provide vor hem-servitor"),
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Omni es pret!"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extremmen offensiv"),
        "fileName": MessageLookupByLibrary.simpleMessage("Nómine de file"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Dimension de fonde"),
        "forward": MessageLookupByLibrary.simpleMessage("Avan"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("Pro adhesion"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Pro invitation"),
        "group": MessageLookupByLibrary.simpleMessage("Gruppe"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Descrition del gruppe"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Gruppe es public"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Gruppes"),
        "help": MessageLookupByLibrary.simpleMessage("Auxilie"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Celar ínconosset evenimentes"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Hem-servitor"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Yo comprende"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identitá"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorar"),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignorar un nómine"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Ignorat usatores"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Ínoffensiv"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Invitar un contacte"),
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Invitationes por me"),
        "invited": MessageLookupByLibrary.simpleMessage("Invitat"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Solmen invitat usatores"),
        "isTyping": MessageLookupByLibrary.simpleMessage("tippa…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Adherer al chambre"),
        "lastActiveAgo": m42,
        "leave": MessageLookupByLibrary.simpleMessage("Forlassar"),
        "leftTheChat":
            MessageLookupByLibrary.simpleMessage("Surtit ex li conversation"),
        "license": MessageLookupByLibrary.simpleMessage("Licentie"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Lucid"),
        "link": MessageLookupByLibrary.simpleMessage("Ligament"),
        "loadMore": MessageLookupByLibrary.simpleMessage("Cargar plu…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Cargante... ples atender."),
        "login": MessageLookupByLibrary.simpleMessage("Aperter li session"),
        "logout": MessageLookupByLibrary.simpleMessage("Cluder li session"),
        "matrixWidgets":
            MessageLookupByLibrary.simpleMessage("Widgets de Matrix"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Cambios inter membres"),
        "mention": MessageLookupByLibrary.simpleMessage("Mentionar"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Information pri li missage"),
        "messageType": MessageLookupByLibrary.simpleMessage("Tip de missage"),
        "messages": MessageLookupByLibrary.simpleMessage("Missages"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderator"),
        "muteChat":
            MessageLookupByLibrary.simpleMessage("Assurdar li conversation"),
        "newChat":
            MessageLookupByLibrary.simpleMessage("Crear un conversation"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Crear un gruppe"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Crear un spacie"),
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "Nov demanda de verification!"),
        "next": MessageLookupByLibrary.simpleMessage("Sequent"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Sequent conto"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noPermission": MessageLookupByLibrary.simpleMessage("Sin permission"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Null chambres trovat…"),
        "none": MessageLookupByLibrary.simpleMessage("Null"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificationes"),
        "numChats": m46,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Obtenente li localisation…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Offensiv"),
        "offline": MessageLookupByLibrary.simpleMessage("For del rete"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "online": MessageLookupByLibrary.simpleMessage("In li rete"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Aperter li cámera"),
        "openChat":
            MessageLookupByLibrary.simpleMessage("Aperter li conversation"),
        "openGallery":
            MessageLookupByLibrary.simpleMessage("Aperter li galerie"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Aperter in mappas"),
        "optionalGroupName": MessageLookupByLibrary.simpleMessage(
            "(Facultativ) Nómine de gruppe"),
        "or": MessageLookupByLibrary.simpleMessage("O"),
        "participant": MessageLookupByLibrary.simpleMessage("Participante"),
        "password": MessageLookupByLibrary.simpleMessage("Contrasigne"),
        "passwordForgotten": MessageLookupByLibrary.simpleMessage(
            "Li contrasigne esset obliviat"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Reganiar li contrasigne"),
        "people": MessageLookupByLibrary.simpleMessage("Homes"),
        "pin": MessageLookupByLibrary.simpleMessage("Fixar"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Ples selecter"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Ples provider un valid adresse de e-post."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Precedent conto"),
        "privacy": MessageLookupByLibrary.simpleMessage("Privatie"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Public chambres"),
        "publish": MessageLookupByLibrary.simpleMessage("Publicar"),
        "pushRules": MessageLookupByLibrary.simpleMessage(
            "Regules de push-notificationes"),
        "reason": MessageLookupByLibrary.simpleMessage("Cause"),
        "recording": MessageLookupByLibrary.simpleMessage("Registrante"),
        "recoveryKey": MessageLookupByLibrary.simpleMessage("Clave de regania"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Redacter li missage"),
        "register": MessageLookupByLibrary.simpleMessage("Inregistrar se"),
        "reject": MessageLookupByLibrary.simpleMessage("Refuser"),
        "rejoin": MessageLookupByLibrary.simpleMessage("Re-adherer"),
        "remove": MessageLookupByLibrary.simpleMessage("Remover"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Remover li aparate"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Repetir li contrasigne"),
        "reply": MessageLookupByLibrary.simpleMessage("Responder"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Raportar li missage"),
        "reportUser":
            MessageLookupByLibrary.simpleMessage("Raportar li usator"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Demandar li permission"),
        "roomVersion":
            MessageLookupByLibrary.simpleMessage("Version del chambre"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Gardar li file"),
        "scanQrCode":
            MessageLookupByLibrary.simpleMessage("Scannar un code QR"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("partir li ecran"),
        "search": MessageLookupByLibrary.simpleMessage("Sercha"),
        "security": MessageLookupByLibrary.simpleMessage("Securitá"),
        "send": MessageLookupByLibrary.simpleMessage("Inviar"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Inviar audio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Inviar un file"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Inviar un image"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("Inviar missages"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("Inviar per Enter"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Inviar li originale"),
        "sendSticker":
            MessageLookupByLibrary.simpleMessage("Inviar un nota adhesiv"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Inviar video"),
        "sender": MessageLookupByLibrary.simpleMessage("Autor"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Assignar li statu"),
        "settings": MessageLookupByLibrary.simpleMessage("Parametres"),
        "share": MessageLookupByLibrary.simpleMessage("Partir"),
        "shareLocation":
            MessageLookupByLibrary.simpleMessage("Partir un localisation"),
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Monstrar li contrasigne"),
        "signUp": MessageLookupByLibrary.simpleMessage("Inregistrar se"),
        "skip": MessageLookupByLibrary.simpleMessage("Omisser"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Code de fonte"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Nómine de spacie"),
        "start": MessageLookupByLibrary.simpleMessage("Iniciar"),
        "status": MessageLookupByLibrary.simpleMessage("Statu"),
        "stories": MessageLookupByLibrary.simpleMessage("Racontas"),
        "submit": MessageLookupByLibrary.simpleMessage("Inviar"),
        "supposedMxid": m66,
        "systemTheme": MessageLookupByLibrary.simpleMessage("Del sistema"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Corresponde"),
        "time": MessageLookupByLibrary.simpleMessage("Hora"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Marcar quam (ín)leet"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Índisponibil"),
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Deblocar li aparate"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Ínconosset aparate"),
        "unpin": MessageLookupByLibrary.simpleMessage("Defixar"),
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Desabonnar racontas"),
        "unverified": MessageLookupByLibrary.simpleMessage("Ínverificat"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "Un actualisament de FluffyChat es disponibil"),
        "updateNow":
            MessageLookupByLibrary.simpleMessage("Actualisar in li funde"),
        "user": MessageLookupByLibrary.simpleMessage("Usator"),
        "username": MessageLookupByLibrary.simpleMessage("Nómine de usator"),
        "users": MessageLookupByLibrary.simpleMessage("Usatores"),
        "verified": MessageLookupByLibrary.simpleMessage("Verificat"),
        "verify": MessageLookupByLibrary.simpleMessage("Verificar"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Iniciar li verification"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Videotelefonada"),
        "videoWithSize": m75,
        "voiceCall": MessageLookupByLibrary.simpleMessage("Telefonada"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Voce-missage"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Tapete"),
        "warning": MessageLookupByLibrary.simpleMessage("Avise!"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Personalisat"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("Textual nota"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Nómine"),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "you": MessageLookupByLibrary.simpleMessage("Vu"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Vor raconte")
      };
}
