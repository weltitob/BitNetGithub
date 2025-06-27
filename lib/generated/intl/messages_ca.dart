// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static String m0(username) => "${username} ha acceptat la invitació";

  static String m1(username) =>
      "${username} ha activat el xifratge d’extrem a extrem";

  static String m2(senderName) => "${senderName} ha respost a la trucada";

  static String m3(username) =>
      "Voleu acceptar aquesta sol·licitud de verificació de: ${username}?";

  static String m4(username, targetName) =>
      "${username} ha vetat a ${targetName}";

  static String m5(uri) => "No es pot obrir l’URI ${uri}";

  static String m6(username) => "${username} ha canviat la imatge del xat";

  static String m7(username, description) =>
      "${username} ha canviat la descripció del xat a: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} ha canviat el nom del xat a: \'${chatname}\'";

  static String m9(username) => "${username} ha canviat els permisos del xat";

  static String m10(username, displayname) =>
      "${username} ha canviat el seu àlies a: \'${displayname}\'";

  static String m11(username) =>
      "${username} ha canviat les normes d’accés dels convidats";

  static String m12(username, rules) =>
      "${username} ha canviat les normes d’accés dels convidats a: ${rules}";

  static String m13(username) =>
      "${username} ha canviat la visibilitat de l’historial";

  static String m14(username, rules) =>
      "${username} ha canviat la visibilitat de l’historial a: ${rules}";

  static String m15(username) => "${username} ha canviat les normes d’unió";

  static String m16(username, joinRules) =>
      "${username} ha canviat les normes d’unió a: ${joinRules}";

  static String m17(username) =>
      "${username} ha canviat la seva imatge de perfil";

  static String m18(username) => "${username} ha canviat l’àlies de la sala";

  static String m19(username) =>
      "${username} ha canviat l’enllaç per a convidar";

  static String m20(command) => "${command} no és una ordre.";

  static String m21(error) => "No s\'ha pogut desxifrar el missatge: ${error}";

  static String m23(count) => "${count} participants";

  static String m24(username) => "${username} ha creat el xat";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}-${month}-${year}";

  static String m28(month, day) => "${day}-${month}";

  static String m29(senderName) => "${senderName} ha finalitzat la trucada";

  static String m30(error) =>
      "S’ha produït un error en obtenir la ubicació: ${error}";

  static String m33(displayname) => "Grup amb ${displayname}";

  static String m34(username, targetName) =>
      "${username} ha retirat la invitació de ${targetName}";

  static String m36(groupName) => "Convida contacte a ${groupName}";

  static String m37(username, link) =>
      "${username} t\'ha convidat a FluffyChat.\n1. Instal·la FluffyChat: https://fluffychat.im\n2. Registra\'t o inicia sessió\n3. Obre l\'enllaç d\'invitació: ${link}";

  static String m38(username, targetName) =>
      "${username} ha convidat a ${targetName}";

  static String m39(username) => "${username} s\'ha unit al xat";

  static String m40(username, targetName) =>
      "${username} ha expulsat a ${targetName}";

  static String m41(username, targetName) =>
      "${username} ha expulsat i vetat a ${targetName}";

  static String m42(localizedTimeShort) =>
      "Actiu per última vegada: ${localizedTimeShort}";

  static String m43(count) => "Carrega ${count} participants més";

  static String m44(homeserver) => "Inicia sessió a ${homeserver}";

  static String m47(count) => "${count} usuaris escrivint…";

  static String m48(fileName) => "Reproduir ${fileName}";

  static String m49(min) => "Seleccioneu almenys ${min} caràcters.";

  static String m51(username) => "${username} ha velat un esdeveniment";

  static String m52(username) => "${username} ha rebutjat la invitació";

  static String m53(username) => "Eliminat per ${username}";

  static String m54(username) => "Vist per ${username}";

  static String m55(username, count) => "Vist per ${username} i ${count} més";

  static String m56(username, username2) =>
      "Vist per ${username} i ${username2}";

  static String m57(username) => "${username} ha enviat un fitxer";

  static String m58(username) => "${username} ha enviat una imatge";

  static String m59(username) => "${username} ha enviat un adhesiu";

  static String m60(username) => "${username} ha enviat un vídeo";

  static String m61(username) => "${username} ha enviat un àudio";

  static String m62(senderName) =>
      "${senderName} ha enviat informació de trucada";

  static String m63(username) => "${username} n’ha compartit la ubicació";

  static String m64(senderName) => "${senderName} ha iniciat una trucada";

  static String m68(username, targetName) =>
      "${username} ha tret el veto a ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 xat no llegit', other: '${unreadCount} xats no llegits')}";

  static String m70(username, count) =>
      "${username} i ${count} més estan escrivint…";

  static String m71(username, username2) =>
      "${username} i ${username2} estan escrivint…";

  static String m72(username) => "${username} està escrivint…";

  static String m73(username) => "${username} ha marxat del xat";

  static String m74(username, type) =>
      "${username} ha enviat un esdeveniment ${type}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Quant a"),
        "accept": MessageLookupByLibrary.simpleMessage("Accepta"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Compte"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Afegeix un compte"),
        "addEmail": MessageLookupByLibrary.simpleMessage(
            "Afegeix una adreça electrònica"),
        "addGroupDescription":
            MessageLookupByLibrary.simpleMessage("Afegeix descripció de grup"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Afegeix a un espai"),
        "admin": MessageLookupByLibrary.simpleMessage("Administració"),
        "alias": MessageLookupByLibrary.simpleMessage("àlies"),
        "all": MessageLookupByLibrary.simpleMessage("Tot"),
        "allChats": MessageLookupByLibrary.simpleMessage("Tots els xats"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Qualsevol pot unir-se"),
        "appLock":
            MessageLookupByLibrary.simpleMessage("Blocatge de l’aplicació"),
        "archive": MessageLookupByLibrary.simpleMessage("Arxiu"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Accés dels usuaris convidats"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("N’esteu segur?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Segur que voleu finalitzar la sessió?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Per a poder donar accés a l’altra persona, introduïu la frase de seguretat o clau de recuperació."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Reprodueix automàticament enganxines i emoticones animades"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("Veta del xat"),
        "banned": MessageLookupByLibrary.simpleMessage("Vetat"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Bloca el dispositiu"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blocat"),
        "botMessages":
            MessageLookupByLibrary.simpleMessage("Missatges del bot"),
        "bubbleSize":
            MessageLookupByLibrary.simpleMessage("Mida de la bombolla"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel·la"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage(
            "Canvia el nom del dispositiu"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Canvia la contrasenya"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Canvia el servidor"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Canvia el nom del grup"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Canvia l’estil"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Canvia el fons"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Canvia l’avatar"),
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
            MessageLookupByLibrary.simpleMessage("El xifratge s’ha corromput"),
        "chat": MessageLookupByLibrary.simpleMessage("Xat"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Còpia de seguretat del xat"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "La còpia de seguretat dels xats és protegida amb una clau. Assegureu-vos de no perdre-la."),
        "chatDetails": MessageLookupByLibrary.simpleMessage("Detalls del xat"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "El xat s’ha afegit a aquest espai"),
        "chats": MessageLookupByLibrary.simpleMessage("Xats"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Trieu una contrasenya forta"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Trieu un nom d’usuari"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Neteja l’arxiu"),
        "close": MessageLookupByLibrary.simpleMessage("Tanca"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Prohibeix l\'usuari indicat d\'aquesta sala"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Neteja la memòria cau"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Crea un xat de grup buit\nUsa --no-encryption per desactivar l\'encriptatge"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Descarta la sessió"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Inicia un xat directe\nUsa --no-encryption per desactivar l\'encriptatge"),
        "commandHint_html":
            MessageLookupByLibrary.simpleMessage("Envia text en format HTML"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Convida l\'usuari indicat a aquesta sala"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Uneix-te a la sala"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Elimina l\'usuari indicat d\'aquesta sala"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Abandona aquesta sala"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Descriviu-vos"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Establiu la imatge per a aquesta sala (per mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Estableix el teu àlies per a aquesta sala"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Estableix el nivell d\'autoritat de l\'usuari (per defecte: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Envia text sense format"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Envia una resposta com a reacció"),
        "commandHint_send": MessageLookupByLibrary.simpleMessage("Envia text"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("L’ordre no és vàlida"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Compareu i assegureu-vos que els emojis següents coincideixen amb els de l’altre dispositiu:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Compareu i assegureu-vos que els nombres següents coincideixen amb els de l’altre dispositiu:"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Configura el xat"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirma"),
        "connect": MessageLookupByLibrary.simpleMessage("Connecta"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "El contacte ha estat convidat al grup"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Conté l\'àlies"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Conté el nom d’usuari"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "El contingut s’ha denunciat als administradors del servidor"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage(
            "S’ha copiat al porta-retalls"),
        "copy": MessageLookupByLibrary.simpleMessage("Copia"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Copia al porta-retalls"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Crea"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Crea un grup nou"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Espai nou"),
        "createdTheChat": m24,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Actiu actualment"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Fosc"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Es desactivarà el vostre compte d’usuari. Això no es pot desfer! Esteu segur de fer-ho?"),
        "defaultPermissionLevel": MessageLookupByLibrary.simpleMessage(
            "Nivell de permisos per defecte"),
        "delete": MessageLookupByLibrary.simpleMessage("Suprimeix"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Suprimeix el compte"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Suprimeix el missatge"),
        "deny": MessageLookupByLibrary.simpleMessage("Denega"),
        "device": MessageLookupByLibrary.simpleMessage("Dispositiu"),
        "deviceId": MessageLookupByLibrary.simpleMessage("Id. de dispositiu"),
        "devices": MessageLookupByLibrary.simpleMessage("Dispositius"),
        "directChats": MessageLookupByLibrary.simpleMessage("Xats directes"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Ha canviat l\'àlies"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Baixa el fitxer"),
        "edit": MessageLookupByLibrary.simpleMessage("Edita"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Edita els servidors bloquejats"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Edita els permisos del xat"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Edita l\'àlies"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("L\'emoticona ja existeix!"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("Codi d\'emoticona invàlid!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Paquet d\'emoticones de la sala"),
        "emoteSettings": MessageLookupByLibrary.simpleMessage(
            "Paràmetres de les emoticones"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Codi d\'emoticona"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Has de seleccionar un codi d\'emoticona i una imatge!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Xat buit"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Activa el paquet d\'emoticones global"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Activa el xifratge"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "No podreu desactivar el xifratge mai més. N’esteu segur?"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Xifrat"),
        "encryption": MessageLookupByLibrary.simpleMessage("Xifratge"),
        "encryptionNotEnabled":
            MessageLookupByLibrary.simpleMessage("El xifratge no s’ha activat"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Introduïu un nom de grup"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Introduïu un nom d’espai"),
        "enterAnEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Introduïu una adreça electrònica"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Introdueix el teu servidor"),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Tot és a punt!"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extremadament ofensiu"),
        "fileName": MessageLookupByLibrary.simpleMessage("Nom del fitxer"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Mida de la lletra"),
        "forward": MessageLookupByLibrary.simpleMessage("Reenvia"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("Des de la unió"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Des de la invitació"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Ves a la sala nova"),
        "group": MessageLookupByLibrary.simpleMessage("Grup"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Descripció de grup"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Descripció de grup canviada"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("El grup és públic"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Grups"),
        "guestsAreForbidden": MessageLookupByLibrary.simpleMessage(
            "Els convidats no poden unir-se"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Els convidats es poden unir"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Ajuda"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage(
            "Amaga els esdeveniments velats"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Amaga els esdeveniments desconeguts"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Com d’ofensiu és aquest contingut?"),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("He fet clic a l\'enllaç"),
        "id": MessageLookupByLibrary.simpleMessage("Id."),
        "identity": MessageLookupByLibrary.simpleMessage("Identitat"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignora"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Pots ignorar els usuaris que et molestin. No rebràs els missatges ni les invitacions dels usuaris que es trobin a la teva llista personal d\'ignorats."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignora nom d\'usuari"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Usuaris ignorats"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Frase de seguretat o clau de recuperació incorrecta"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Convida contacte"),
        "inviteContactToGroup": m36,
        "inviteForMe":
            MessageLookupByLibrary.simpleMessage("Invitació per a mi"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Convidat"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Només usuaris convidats"),
        "isTyping": MessageLookupByLibrary.simpleMessage("escrivint…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Uneix-te a la sala"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("Expulsa del xat"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Vist va molt de temps"),
        "leave": MessageLookupByLibrary.simpleMessage("Abandona"),
        "leftTheChat":
            MessageLookupByLibrary.simpleMessage("Ha marxat del xat"),
        "license": MessageLookupByLibrary.simpleMessage("Llicència"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Clar"),
        "link": MessageLookupByLibrary.simpleMessage("Enllaç"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Carrega’n més…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("S’està carregant… Espereu."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "S’han desactivat els serveis d’ubicació. Activeu-los per a compartir la vostra ubicació."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "S’ha rebutjat el permís d’ubicació. Atorgueu-lo per a poder compartir la vostra ubicació."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Inicia la sessió"),
        "logout": MessageLookupByLibrary.simpleMessage("Finalitza la sessió"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Assegura\'t que l\'identificador sigui vàlid"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Canvis de participants"),
        "mention": MessageLookupByLibrary.simpleMessage("Menciona"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "El missatge s\'eliminarà per a tots els participants"),
        "messages": MessageLookupByLibrary.simpleMessage("Missatges"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderador"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Silencia el xat"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Tingueu en compte que, ara per ara, us cal el Pantalaimon per a poder utilitzar el xifratge d’extrem a extrem."),
        "newChat": MessageLookupByLibrary.simpleMessage("Xat nou"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("Missatge nou al FluffyChat"),
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "Nova sol·licitud de verificació!"),
        "next": MessageLookupByLibrary.simpleMessage("Següent"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Sense connexió al servidor"),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage(
            "No s’ha trobat cap emoticona. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Només podreu activar el xifratge quan la sala ja no sigui accessible públicament."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Sembla que no teniu els Serveis de Google al telèfon. Això és una bona decisió respecte a la vostra privadesa! Per a rebre notificacions automàtiques del FluffyChat, us recomanem utilitzar https://microg.org/ o https://unifiedpush.org/."),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Encara no heu afegit cap mètode per a poder recuperar la contrasenya."),
        "noPermission": MessageLookupByLibrary.simpleMessage("Sense permís"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("No s’ha trobat cap sala…"),
        "none": MessageLookupByLibrary.simpleMessage("Cap"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificacions"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notificacions activades per a aquest compte"),
        "numUsersTyping": m47,
        "obtainingLocation": MessageLookupByLibrary.simpleMessage(
            "S’està obtenint la ubicació…"),
        "offline": MessageLookupByLibrary.simpleMessage("Fora de línia"),
        "ok": MessageLookupByLibrary.simpleMessage("D\'acord"),
        "online": MessageLookupByLibrary.simpleMessage("En línia"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "La còpia de seguretat de claus en línia està activada"),
        "oopsSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "Alguna cosa ha anat malament…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Obre l\'aplicació per llegir els missatges"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Obre la càmera"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Opcional) Nom del grup"),
        "or": MessageLookupByLibrary.simpleMessage("O"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "contrasenya o clau de recuperació"),
        "password": MessageLookupByLibrary.simpleMessage("Contrasenya"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Contrasenya oblidada"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("La contrasenya ha canviat"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Recuperació de contrassenya"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "Les contrasenyes no coincideixen!"),
        "people": MessageLookupByLibrary.simpleMessage("Gent"),
        "pickImage":
            MessageLookupByLibrary.simpleMessage("Selecciona una imatge"),
        "pin": MessageLookupByLibrary.simpleMessage("Fixa"),
        "play": m48,
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Tria un codi d\'accés"),
        "pleaseChooseAUsername":
            MessageLookupByLibrary.simpleMessage("Tria un nom d\'usuari"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Fes clic a l\'enllaç del correu i, després, segueix."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Introdueix 4 dígits o deixa-ho buit per desactivar el bloqueig."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Introdueix un identificador de Matrix."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Introduïu una adreça electrònica vàlida."),
        "pleaseEnterYourPassword": MessageLookupByLibrary.simpleMessage(
            "Introdueix la teva contrasenya"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Introdueix el teu nom d\'usuari"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Seguiu les instruccions al lloc web i toqueu «Següent»."),
        "privacy": MessageLookupByLibrary.simpleMessage("Privadesa"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Sales públiques"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Regles push"),
        "reason": MessageLookupByLibrary.simpleMessage("Raó"),
        "recording": MessageLookupByLibrary.simpleMessage("Enregistrant"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Vela el missatge"),
        "redactedAnEvent": m51,
        "reject": MessageLookupByLibrary.simpleMessage("Rebutja"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Torna-t\'hi a unir"),
        "remove": MessageLookupByLibrary.simpleMessage("Elimina"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Elimina tots els altres dispositius"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Elimina dispositiu"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Mostra el contingut enriquit dels missatges"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Repetiu la contrasenya"),
        "reply": MessageLookupByLibrary.simpleMessage("Respon"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Denuncia el missatge"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Sol·licita permís"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("La sala s\'ha actualitzat"),
        "roomVersion":
            MessageLookupByLibrary.simpleMessage("Versió de la sala"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Desa el fitxer"),
        "scanQrCode":
            MessageLookupByLibrary.simpleMessage("Escaneja un codi QR"),
        "search": MessageLookupByLibrary.simpleMessage("Cerca"),
        "security": MessageLookupByLibrary.simpleMessage("Seguretat"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Envia"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Envia un missatge"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Envia com a text"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Envia un àudio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Envia un fitxer"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Envia una imatge"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("Envia missatges"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Envia en prémer Retorn"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Envia l’original"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Envia adhesiu"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Envia un vídeo"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "setAsCanonicalAlias": MessageLookupByLibrary.simpleMessage(
            "Defineix com a àlies principal"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Defineix emoticones personalitzades"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Defineix la descripció del grup"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage(
            "Defineix l’enllaç per a convidar"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage(
            "Defineix el nivell de permisos"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Defineix l’estat"),
        "settings": MessageLookupByLibrary.simpleMessage("Paràmetres"),
        "share": MessageLookupByLibrary.simpleMessage("Comparteix"),
        "shareLocation":
            MessageLookupByLibrary.simpleMessage("Comparteix la ubicació"),
        "sharedTheLocation": m63,
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Mostra la contrasenya"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registre"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Autenticació única"),
        "skip": MessageLookupByLibrary.simpleMessage("Omet"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Codi font"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("L’espai és públic"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Nom de l’espai"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Estat"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Com us sentiu avui?"),
        "submit": MessageLookupByLibrary.simpleMessage("Envia"),
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "S’està sincronitzant… Espereu."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Sistema"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("No coincideixen"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Coincideixen"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Commuta l’estat «preferit»"),
        "toggleMuted":
            MessageLookupByLibrary.simpleMessage("Commuta l’estat «silenci»"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage(
            "Marca com a llegit/sense llegir"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Massa sol·licituds. Torna-ho a provar més tard!"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Transfereix des d’un altre dispositiu"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Intenta tornar a enviar"),
        "unavailable": MessageLookupByLibrary.simpleMessage("No disponible"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Desfés l\'expulsió"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Desbloqueja dispositiu"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Dispositiu desconegut"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "L’algorisme de xifratge és desconegut"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Deixa de silenciar el xat"),
        "unpin": MessageLookupByLibrary.simpleMessage("Deixa de fixar"),
        "unreadChats": m69,
        "unverified": MessageLookupByLibrary.simpleMessage("No verificat"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Nom d’usuari"),
        "verified": MessageLookupByLibrary.simpleMessage("Verificat"),
        "verify": MessageLookupByLibrary.simpleMessage("Verifica"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Inicia la verificació"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage(
            "T\'has verificat correctament!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Verificant un altre compte"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Videotrucada"),
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Visibilitat de l’historial del xat"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Visible per a tots els participants"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Visible per a tothom"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Missatge de veu"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "S’està esperant que l’altre accepti la sol·licitud…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "S’està esperant que l’altre accepti l’emoji…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "S’està esperant que l’altre accepti els nombres…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Fons"),
        "warning": MessageLookupByLibrary.simpleMessage("Atenció!"),
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "Us hem enviat un missatge de correu electrònic"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Qui pot efectuar quina acció"),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Qui pot unir-se a aquest grup"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Per què voleu denunciar això?"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Voleu suprimir la còpia de seguretat dels xats per a crear una clau de seguretat nova?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Amb aquestes adreces, si ho necessiteu, podeu recuperar la vostra contrasenya."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Escriviu un missatge…"),
        "yes": MessageLookupByLibrary.simpleMessage("Sí"),
        "you": MessageLookupByLibrary.simpleMessage("Vós"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Us han convidat a aquest xat"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Ja no participeu en aquest xat"),
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "No us podeu convidar a vós mateix"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Has estat vetat d\'aquest xat"),
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "S’ha configurat la còpia de seguretat del xat."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("La vostra clau pública")
      };
}
