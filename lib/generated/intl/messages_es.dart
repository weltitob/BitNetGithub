// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(username) => "${username} aceptó la invitación";

  static String m1(username) =>
      "${username} activó el cifrado de extremo a extremo";

  static String m2(senderName) => "${senderName} respondió a la llamada";

  static String m3(username) =>
      "¿Aceptar esta solicitud de verificación de ${username}?";

  static String m4(username, targetName) => "${username} vetó a ${targetName}";

  static String m5(uri) => "No puedo abrir el URI ${uri}";

  static String m6(username) => "${username} cambió el icono del chat";

  static String m7(username, description) =>
      "${username} cambió la descripción del chat a: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} cambió el nombre del chat a: \'${chatname}\'";

  static String m9(username) => "${username} cambió los permisos del chat";

  static String m10(username, displayname) =>
      "${username} cambió su nombre visible a: ${displayname}";

  static String m11(username) =>
      "${username} cambió las reglas de acceso de visitantes";

  static String m12(username, rules) =>
      "${username} cambió las reglas de acceso de visitantes a: ${rules}";

  static String m13(username) =>
      "${username} cambió la visibilidad del historial";

  static String m14(username, rules) =>
      "${username} cambió la visibilidad del historial a: ${rules}";

  static String m15(username) => "${username} cambió las reglas de ingreso";

  static String m16(username, joinRules) =>
      "${username} cambió las reglas de ingreso a ${joinRules}";

  static String m17(username) => "${username} cambió su imagen de perfil";

  static String m18(username) => "${username} cambió el alias de la sala";

  static String m19(username) => "${username} cambió el enlace de invitación";

  static String m20(command) => "${command} no es un comando.";

  static String m21(error) => "No se pudo descifrar el mensaje: ${error}";

  static String m23(count) => "${count} participantes";

  static String m24(username) => "💬${username} creó el chat";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}-${month}-${year}";

  static String m28(month, day) => "${day}-${month}";

  static String m29(senderName) => "${senderName} terminó la llamada";

  static String m30(error) => "Error al obtener la ubicación: ${error}";

  static String m33(displayname) => "Grupo con ${displayname}";

  static String m34(username, targetName) =>
      "${username} ha retirado la invitación para ${targetName}";

  static String m36(groupName) => "Invitar contacto a ${groupName}";

  static String m37(username, link) =>
      "${username} te invitó a FluffyChat.\n1. Instale FluffyChat: https://fluffychat.im\n2. Regístrate o inicia sesión \n3. Abra el enlace de invitación: ${link}";

  static String m38(username, targetName) =>
      "📩${username} invitó a ${targetName}";

  static String m39(username) => "👋${username} se unió al chat";

  static String m40(username, targetName) => "${username} echó a ${targetName}";

  static String m41(username, targetName) =>
      "${username} echó y vetó a ${targetName}";

  static String m42(localizedTimeShort) =>
      "Última vez activo: ${localizedTimeShort}";

  static String m43(count) => "Mostrar ${count} participantes más";

  static String m44(homeserver) => "Iniciar sesión en ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} no es un servidor matrix, usar ${server2} en su lugar?";

  static String m47(count) => "${count} usuarios están escribiendo…";

  static String m48(fileName) => "Reproducir ${fileName}";

  static String m49(min) => "Por favor elige al menos ${min} carácteres.";

  static String m51(username) => "${username} censuró un suceso";

  static String m52(username) => "${username} rechazó la invitación";

  static String m53(username) => "Eliminado por ${username}";

  static String m54(username) => "Visto por ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Visto por ${username} y ${count} más')}";

  static String m56(username, username2) =>
      "Visto por ${username} y ${username2}";

  static String m57(username) => "${username} envió un archivo";

  static String m58(username) => "${username} envió una imagen";

  static String m59(username) => "${username} envió un sticker";

  static String m60(username) => "${username} envió un video";

  static String m61(username) => "${username} envió un audio";

  static String m62(senderName) =>
      "${senderName} envió información de la llamada";

  static String m63(username) => "${username} compartió la ubicación";

  static String m64(senderName) => "${senderName} comenzó una llamada";

  static String m68(username, targetName) =>
      "${username} admitió a ${targetName} nuevamente";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 chat no leído', other: '${unreadCount} chats no leídos')}";

  static String m70(username, count) =>
      "${username} y ${count} más están escribiendo…";

  static String m71(username, username2) =>
      "${username} y ${username2} están escribiendo…";

  static String m72(username) => "${username} está escribiendo…";

  static String m73(username) => "${username} abandonó el chat";

  static String m74(username, type) => "${username} envió un evento ${type}";

  static String m75(size) => "Video (${size})";

  static String m79(user) => "📩 Has sido invitado por ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
        "accept": MessageLookupByLibrary.simpleMessage("Aceptar"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Cuenta"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Añadir cuenta"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Añadir descripción"),
        "addEmail":
            MessageLookupByLibrary.simpleMessage("Añadir dirección de correo"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Agregar una descripción al grupo"),
        "addToBundle":
            MessageLookupByLibrary.simpleMessage("Agregar al paquete"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Agregar al espacio"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Elige un espacio para añadir este chat a el."),
        "admin": MessageLookupByLibrary.simpleMessage("Administrador"),
        "alias": MessageLookupByLibrary.simpleMessage("alias"),
        "all": MessageLookupByLibrary.simpleMessage("Todo"),
        "allChats": MessageLookupByLibrary.simpleMessage("Todos los chats"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Todos los espacios"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Cualquiera puede unirse"),
        "appLock":
            MessageLookupByLibrary.simpleMessage("Bloqueo de aplicación"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivo"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "¿Pueden unirse los usuarios visitantes?"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("¿Estás seguro?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "¿Confirma que quiere cerrar sesión?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Para poder confirmar a la otra persona, ingrese su contraseña de almacenamiento segura o la clave de recuperación."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Reproducir emoticonos y stickers animados automáticamente"),
        "banFromChat": MessageLookupByLibrary.simpleMessage("Vetar del chat"),
        "banned": MessageLookupByLibrary.simpleMessage("Vetado"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Bloquear dispositivo"),
        "blocked": MessageLookupByLibrary.simpleMessage("Bloqueado"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Mensajes de bot"),
        "bundleName":
            MessageLookupByLibrary.simpleMessage("Nombre del paquete"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage(
            "Cambiar el nombre del dispositivo"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Cambiar la contraseña"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Cambiar el servidor"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Cambiar el nombre del grupo"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Cambia tu estilo"),
        "changeWallpaper": MessageLookupByLibrary.simpleMessage(
            "Cambiar el fondo de pantalla"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Cambiar tu avatar"),
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
            MessageLookupByLibrary.simpleMessage("El cifrado se ha corrompido"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Copia de respaldo del chat"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "La copia de respaldo del chat está protegida por una clave de seguridad. Procure no perderla."),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Detalles del chat"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "El chat se ha agregado a este espacio"),
        "chats": MessageLookupByLibrary.simpleMessage("Conversaciones"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Elija una contraseña segura"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Elija un nombre de usuario"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Borrar archivo"),
        "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Prohibir al usuario dado en esta sala"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Limpiar cache"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Descartar sesión"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Enviar texto con formato HTML"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Invitar al usuario indicado a esta sala"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Únete a la sala indicada"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Eliminar el usuario indicado de esta sala"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Deja esta sala"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Marcar como grupo"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Descríbete"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Selecciona tu foto para esta sala (by mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Establece tu nombre para mostrar para esta sala"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Establece el nivel de potencia del usuario dado (default: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Enviar texto sin formato"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Enviar respuesta como reacción"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Enviar texto"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Des banear al usuario dado en esta sala"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Comando inválido"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Por favor compare los emojis"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Por favor compare los números"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Configurar chat"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "connect": MessageLookupByLibrary.simpleMessage("Conectar"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "El contacto ha sido invitado al grupo"),
        "containsDisplayName": MessageLookupByLibrary.simpleMessage(
            "Contiene nombre para mostrar"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Contiene nombre de usuario"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "El contenido ha sido reportado a los administradores del servidor"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Copiado al portapapeles"),
        "copy": MessageLookupByLibrary.simpleMessage("Copiar"),
        "copyToClipboard":
            MessageLookupByLibrary.simpleMessage("Copiar al portapapeles"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Crear"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Crear grupo nuevo"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Nuevo espacio"),
        "createdTheChat": m24,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Actualmente activo"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Oscuro"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Se desactivará su cuenta de usuario. ¡La operación no se puede cancelar! ¿Está seguro?"),
        "defaultPermissionLevel": MessageLookupByLibrary.simpleMessage(
            "Nivel de permiso predeterminado"),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Cancelar cuenta"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Eliminar mensaje"),
        "deny": MessageLookupByLibrary.simpleMessage("Rechazar"),
        "device": MessageLookupByLibrary.simpleMessage("Dispositivo"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ID del dispositivo"),
        "devices": MessageLookupByLibrary.simpleMessage("Dispositivos"),
        "directChats": MessageLookupByLibrary.simpleMessage("Chat directo"),
        "displaynameHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "El nombre visible ha cambiado"),
        "downloadFile":
            MessageLookupByLibrary.simpleMessage("Descargar archivo"),
        "edit": MessageLookupByLibrary.simpleMessage("Editar"),
        "editBlockedServers":
            MessageLookupByLibrary.simpleMessage("Editar servidores bloqueado"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Editar paquetes para esta cuenta"),
        "editChatPermissions":
            MessageLookupByLibrary.simpleMessage("Editar permisos de chat"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Editar nombre visible"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Editar alias de la sala"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Editar avatar de sala"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("¡El emote ya existe!"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "¡El atajo del emote es inválido!"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Paquetes de emoticonos para la habitación"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Configuración de emotes"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Atajo de emote"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "¡Debes elegir un atajo de emote y una imagen!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Chat vacío"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Habilitar paquete de emoticonos a nivel general"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Habilitar la encriptación"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Ya no podrá deshabilitar el cifrado. ¿Estás seguro?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) habilite varias cuenta en este dispositivo"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Encriptado"),
        "encryption": MessageLookupByLibrary.simpleMessage("Cifrado"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage(
            "El cifrado no está habilitado"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Ingrese un nombre de grupo"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Ingrese nombre de espacio"),
        "enterAnEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Introducir una dirección de correo electrónico"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Ingrese su servidor"),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("¡Todo listo!"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extremadamente ofensivo"),
        "fileName": MessageLookupByLibrary.simpleMessage("Nombre del archivo"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Tamaño de fuente"),
        "forward": MessageLookupByLibrary.simpleMessage("Reenviar"),
        "fromJoining":
            MessageLookupByLibrary.simpleMessage("Desde que se unió"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Desde la invitación"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Ir a la nueva sala"),
        "group": MessageLookupByLibrary.simpleMessage("Grupo"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Descripción del grupo"),
        "groupDescriptionHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "La descripción del grupo ha sido cambiada"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("El grupo es público"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Grupos"),
        "guestsAreForbidden": MessageLookupByLibrary.simpleMessage(
            "Los visitantes están prohibidos"),
        "guestsCanJoin": MessageLookupByLibrary.simpleMessage(
            "Los visitantes pueden unirse"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Ayuda"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Ocultar sucesos censurados"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Ocultar sucesos desconocidos"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Homeserver"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "¿Cuán ofensivo es este contenido?"),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("He hecho clic en el enlace"),
        "id": MessageLookupByLibrary.simpleMessage("Identificación"),
        "identity": MessageLookupByLibrary.simpleMessage("Identidad"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorar"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Puede ignorar a los usuarios que le molesten. No podrá recibir mensajes ni invitaciones a salas de los usuarios de su lista personal de ignorados."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignorar nombre de usuario"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Usuarios ignorados"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Frase de contraseña o clave de recuperación incorrecta"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Inofensivo"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Invitar contacto"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Invitar por mí"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Invitado"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Sólo usuarios invitados"),
        "isTyping": MessageLookupByLibrary.simpleMessage("está escribiendo…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Unirse a la sala"),
        "joinedTheChat": m39,
        "kickFromChat": MessageLookupByLibrary.simpleMessage("Echar del chat"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Visto hace mucho tiempo"),
        "leave": MessageLookupByLibrary.simpleMessage("Abandonar"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Abandonó el chat"),
        "license": MessageLookupByLibrary.simpleMessage("Licencia"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Claro"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Mostrar más…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Cargando… Por favor espere."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Los servicios de ubicación están deshabilitado. Habilite para poder compartir su ubicación."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Permiso de ubicación denegado. Concédeles que puedan compartir tu ubicación."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Acceso"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión con un click"),
        "logout": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Asegúrese de que el identificador es válido"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Cambios de miembros"),
        "mention": MessageLookupByLibrary.simpleMessage("Mencionar"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Información del mensaje"),
        "messageType": MessageLookupByLibrary.simpleMessage("Tipo de Mensaje"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "El mensaje será eliminado para todos los participantes"),
        "messages": MessageLookupByLibrary.simpleMessage("Mensajes"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderador"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Silenciar chat"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Tenga en cuenta que necesita Pantalaimon para utilizar el cifrado de extremo a extremo por ahora."),
        "newChat": MessageLookupByLibrary.simpleMessage("Nuevo chat"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Nuevo grupo"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("Nuevo mensaje en FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Nuevo espacio"),
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "¡Nueva solicitud de verificación!"),
        "next": MessageLookupByLibrary.simpleMessage("Siguiente"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Siguiente cuenta"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Sin conexión al servidor"),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Ningún emote encontrado. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Sólo se puede activar el cifrado en cuanto la sala deja de ser de acceso público."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Parece que no tienes servicios de Google en tu teléfono. ¡Esa es una buena decisión para tu privacidad! Para recibir notificaciones instantáneas en FluffyChat, recomendamos usar microG: https://microg.org/"),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Aún no ha agregado una forma de recuperar su contraseña."),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Sin autorización"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Ninguna sala encontrada…"),
        "none": MessageLookupByLibrary.simpleMessage("Ninguno"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificaciones"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notificaciones habilitadas para esta cuenta"),
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Obteniendo ubicación…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Ofensiva"),
        "offline": MessageLookupByLibrary.simpleMessage("Desconectado"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Se ha cerrado en la sesión de uno de sus clientes"),
        "online": MessageLookupByLibrary.simpleMessage("Conectado"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "La copia de seguridad de la clave en línea está habilitada"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "¡UPS¡ Desafortunadamente, se produjo un error al configurar las notificaciones push."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Ups, algo salió mal…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Abrir la aplicación para leer los mensajes"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Abrir cámara"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Abrir galería"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Abrir en maps"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage(
            "Abrir la cámara para un video"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Opcional) Nombre del grupo"),
        "or": MessageLookupByLibrary.simpleMessage("O"),
        "participant": MessageLookupByLibrary.simpleMessage("Participante"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "contraseña o clave de recuperación"),
        "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Contraseña olvidada"),
        "passwordHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "La contraseña ha sido cambiada"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Recuperación de contraseña"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "¡Las contraseñas no coinciden!"),
        "people": MessageLookupByLibrary.simpleMessage("Personas"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Elegir imagen"),
        "pin": MessageLookupByLibrary.simpleMessage("Pin"),
        "play": m48,
        "pleaseChoose": MessageLookupByLibrary.simpleMessage("Por favor elija"),
        "pleaseChooseAPasscode":
            MessageLookupByLibrary.simpleMessage("Elija un código de acceso"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Por favor, elija un nombre de usuario"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Haga clic en el enlace del correo electrónico y luego continúe."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Ingrese 4 dígitos o déjelo en blanco para deshabilitar el bloqueo de la aplicación."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Por favor, ingrese un identificador Matrix."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Por favor ingrese un correo electrónico válido."),
        "pleaseEnterYourPassword": MessageLookupByLibrary.simpleMessage(
            "Por favor ingrese su contraseña"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Por favor ingrese su PIN"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Por favor ingrese su nombre de usuario"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Por favor, siga las instrucciones del sitio web y presione \"siguiente\"."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Cuenta anterior"),
        "privacy": MessageLookupByLibrary.simpleMessage("Privacidad"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Salas públicas"),
        "publish": MessageLookupByLibrary.simpleMessage("Publicar"),
        "pushRules": MessageLookupByLibrary.simpleMessage("Regla de Push"),
        "reason": MessageLookupByLibrary.simpleMessage("Razón"),
        "recording": MessageLookupByLibrary.simpleMessage("Grabando"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Censurar mensaje"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Registrarse"),
        "reject": MessageLookupByLibrary.simpleMessage("Rechazar"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Volver a unirse"),
        "remove": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Eliminar todos los otros dispositivos"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Eliminar dispositivo"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Quitar de este paquete"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Eliminar del espacio"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Quitar tu avatar"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Mostrar el contenido con mensajes enriquecidos"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Repetir la contraseña"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Reemplazar habitación con una versión más nueva"),
        "reply": MessageLookupByLibrary.simpleMessage("Responder"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("La respuesta se ha enviado"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Mensaje de informe"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Solicitar permiso"),
        "roomHasBeenUpgraded": MessageLookupByLibrary.simpleMessage(
            "La sala ha subido de categoría"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Versión de sala"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Guardar el archivo"),
        "scanQrCode":
            MessageLookupByLibrary.simpleMessage("Escanear código QR"),
        "search": MessageLookupByLibrary.simpleMessage("Buscar"),
        "security": MessageLookupByLibrary.simpleMessage("Seguridad"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Enviar"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Enviar un mensaje"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Enviar como texto"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Enviar audio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Enviar un archivo"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Enviar una imagen"),
        "sendMessages": MessageLookupByLibrary.simpleMessage("Enviar mensajes"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("Enviar con enter"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Enviar el original"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Enviar stickers"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Enviar video"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Este servidor necesita validar su dirección de correo electrónico para registrarse."),
        "setAsCanonicalAlias":
            MessageLookupByLibrary.simpleMessage("Fijar alias principal"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Establecer emoticonos personalizados"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Establecer descripción del grupo"),
        "setInvitationLink": MessageLookupByLibrary.simpleMessage(
            "Establecer enlace de invitación"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage(
            "Establecer nivel de permisos"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Establecer estado"),
        "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
        "share": MessageLookupByLibrary.simpleMessage("Compartir"),
        "shareLocation":
            MessageLookupByLibrary.simpleMessage("Compartir ubicación"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Compartir tu enlace de invitación"),
        "sharedTheLocation": m63,
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Mostrar contraseña"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registrarse"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Inicio de sesión único"),
        "skip": MessageLookupByLibrary.simpleMessage("Omitir"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Código fuente"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("El espacio es público"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Nombre del espacio"),
        "start": MessageLookupByLibrary.simpleMessage("Iniciar"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Estado"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("¿Cómo estás hoy?"),
        "stories": MessageLookupByLibrary.simpleMessage("Historias"),
        "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Sincronizando... por favor espere."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Sistema"),
        "theyDontMatch": MessageLookupByLibrary.simpleMessage("No coinciden"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Coinciden"),
        "time": MessageLookupByLibrary.simpleMessage("Tiempo"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Alternar favorito"),
        "toggleMuted":
            MessageLookupByLibrary.simpleMessage("Alternar silenciado"),
        "toggleUnread": MessageLookupByLibrary.simpleMessage(
            "Marcar como: leído / no leído"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Demasiadas solicitudes. ¡Por favor inténtelo más tarde!"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Transferir desde otro dispositivo"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Intentar enviar nuevamente"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Indisponible"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Eliminar la expulsión"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Desbloquear dispositivo"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Dispositivo desconocido"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Algoritmo de cifrado desconocido"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Dejar de silenciar el chat"),
        "unpin": MessageLookupByLibrary.simpleMessage("Despinchar"),
        "unreadChats": m69,
        "unverified": MessageLookupByLibrary.simpleMessage("No verificado"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
        "users": MessageLookupByLibrary.simpleMessage("Usuarios"),
        "verified": MessageLookupByLibrary.simpleMessage("Verificado"),
        "verify": MessageLookupByLibrary.simpleMessage("Verificar"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Comenzar verificación"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage(
            "¡Has verificado exitosamente!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Verificando la otra cuenta"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Video llamada"),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Visibilidad del historial del chat"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Visible para todos los participantes"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Visible para todo el mundo"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Mensaje de voz"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Esperando a que el socio acepte la solicitud…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Esperando a que el socio acepte los emojis…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Esperando a que el socio acepte los números…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Fondo de pantalla"),
        "warning": MessageLookupByLibrary.simpleMessage("¡Advertencia!"),
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "Te enviamos un correo electrónico"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("¿Qué está pasando?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Quién puede realizar qué acción"),
        "whoCanSeeMyStories": MessageLookupByLibrary.simpleMessage(
            "¿Quién puede ver mis historias?"),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Quién tiene permitido unirse al grupo"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "¿Por qué quieres denunciar esto?"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("Nota de texto"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("Esta no es una URL válida."),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "¿Limpiar la copia de seguridad de su chat para crear una nueva clave de seguridad?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Con esta dirección puede recuperar su contraseña."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Escribe un mensaje…"),
        "yes": MessageLookupByLibrary.simpleMessage("Sí"),
        "you": MessageLookupByLibrary.simpleMessage("Tú"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("👍 Aceptaste la invitación"),
        "youAreInvitedToThisChat":
            MessageLookupByLibrary.simpleMessage("Estás invitado a este chat"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Ya no estás participando en este chat"),
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "No puedes invitarte a tí mismo"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Has sido vetado de este chat"),
        "youInvitedBy": m79,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Rechazaste la invitación"),
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Se ha configurado la copia de respaldo del chat."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Tu clave pública"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Tu historia")
      };
}
