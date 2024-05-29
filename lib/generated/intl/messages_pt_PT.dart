// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_PT locale. All the
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
  String get localeName => 'pt_PT';

  static String m0(username) => "${username} aceitou o convite";

  static String m1(username) => "${username} ativou encriptação ponta-a-ponta";

  static String m2(senderName) => "${senderName} atendeu a chamada";

  static String m3(username) =>
      "Aceitar este pedido de verificação de ${username}?";

  static String m4(username, targetName) => "${username} baniu ${targetName}";

  static String m5(uri) => "Não é possível abrir o URI ${uri}";

  static String m6(username) => "${username} alterou o avatar da conversa";

  static String m7(username, description) =>
      "${username} alterou a descrição da conversa para: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} alterou o nome da conversa para: \'${chatname}\'";

  static String m9(username) => "${username} alterou as permissões da conversa";

  static String m10(username, displayname) =>
      "${username} alterou o seu nome para: \'${displayname}\'";

  static String m11(username) =>
      "${username} alterou as regras de acesso de visitantes";

  static String m12(username, rules) =>
      "${username} alterou as regras de acesso de visitantes para: ${rules}";

  static String m13(username) =>
      "${username} alterou a visibilidade do histórico";

  static String m14(username, rules) =>
      "${username} alterou a visibilidade do histórico para: ${rules}";

  static String m15(username) => "${username} alterou as regras de entrada";

  static String m16(username, joinRules) =>
      "${username} alterou as regras de entrada para: ${joinRules}";

  static String m17(username) => "${username} alterou o seu avatar";

  static String m18(username) => "${username} alterou as alcunhas da sala";

  static String m19(username) => "${username} alterou a ligação de convite";

  static String m20(command) => "${command} não é um comando.";

  static String m21(error) =>
      "Não foi possível desencriptar mensagem: ${error}";

  static String m23(count) => "${count} participantes";

  static String m24(username) => "${username} criou a conversa";

  static String m26(date, timeOfDay) => "${date} às ${timeOfDay}";

  static String m27(year, month, day) => "${day}-${month}-${year}";

  static String m28(month, day) => "${day}-${month}";

  static String m29(senderName) => "${senderName} terminou a chamada";

  static String m30(error) => "Erro ao obter localização: ${error}";

  static String m33(displayname) => "Grupo com ${displayname}";

  static String m34(username, targetName) =>
      "${username} revogou o convite para ${targetName}";

  static String m36(groupName) => "Convidar contacto para ${groupName}";

  static String m37(username, link) =>
      "${username} convidou-te para o FluffyChat.\n1. Instala o FluffyChat: https://fluffychat.im\n2. Regista-te ou inicia sessão.\n3. Abre a ligação de convite: ${link}";

  static String m38(username, targetName) =>
      "${username} convidou ${targetName}";

  static String m39(username) => "${username} entrou na conversa";

  static String m40(username, targetName) =>
      "${username} expulsou ${targetName}";

  static String m41(username, targetName) =>
      "${username} expulsou e baniu ${targetName}";

  static String m42(localizedTimeShort) =>
      "Ativo(a) pela última vez: ${localizedTimeShort}";

  static String m43(count) => "Carregar mais ${count} participantes";

  static String m44(homeserver) => "Entrar em ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} não é um servidor Matrix, usar ${server2}?";

  static String m47(count) => "Estão ${count} utilizadores(as) a escrever…";

  static String m48(fileName) => "Reproduzir ${fileName}";

  static String m49(min) => "Por favor, usa no mínimo ${min} caracteres.";

  static String m51(username) => "${username} eliminou um evento";

  static String m52(username) => "${username} rejeitou o convite";

  static String m53(username) => "Removido por ${username}";

  static String m54(username) => "Visto por ${username}";

  static String m56(username, username2) =>
      "Visto por ${username} e por ${username2}";

  static String m57(username) => "${username} enviar um ficheiro";

  static String m58(username) => "${username} enviar uma imagem";

  static String m59(username) => "${username} enviou um autocolante";

  static String m60(username) => "${username} enviou um vídeo";

  static String m61(username) => "${username} enviar um áudio";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
        "accept": MessageLookupByLibrary.simpleMessage("Aceitar"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Conta"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Adicionar conta"),
        "addEmail": MessageLookupByLibrary.simpleMessage(
            "Adicionar correio eletrónico"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Adicionar descrição de grupo"),
        "addToBundle":
            MessageLookupByLibrary.simpleMessage("Adicionar ao pacote"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Adicionar ao espaço"),
        "admin": MessageLookupByLibrary.simpleMessage("Admin"),
        "alias": MessageLookupByLibrary.simpleMessage("alcunha"),
        "all": MessageLookupByLibrary.simpleMessage("Todos(as)"),
        "allChats": MessageLookupByLibrary.simpleMessage("Todas as conversas"),
        "answeredTheCall": m2,
        "anyoneCanJoin":
            MessageLookupByLibrary.simpleMessage("Qualquer pessoa pode entrar"),
        "appLock":
            MessageLookupByLibrary.simpleMessage("Bloqueio da aplicação"),
        "archive": MessageLookupByLibrary.simpleMessage("Arquivo"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Todos os visitantes podem entrar"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Tens a certeza?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Tens a certeza que queres sair?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Para poderes assinar a outra pessoa, por favor, insere a tua senha de armazenamento seguro ou a chave de recuperação."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Automaticamente reproduzir autocolantes e emotes animados"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Banir da conversa"),
        "banned": MessageLookupByLibrary.simpleMessage("Banido(a)"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Bloquear dispositivo"),
        "blocked": MessageLookupByLibrary.simpleMessage("Bloqueado"),
        "botMessages":
            MessageLookupByLibrary.simpleMessage("Mensagens de robôs"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Tamanho da bolha"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Nome do pacote"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "cantOpenUri": m5,
        "changeDeviceName":
            MessageLookupByLibrary.simpleMessage("Alterar nome do dispositivo"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Alterar palavra-passe"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Alterar o servidor"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Alterar o nome do grupo"),
        "changeTheme":
            MessageLookupByLibrary.simpleMessage("Alterar o teu estilo"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Alterar o fundo"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Alterar o teu avatar"),
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
            "A encriptação foi corrompida"),
        "chat": MessageLookupByLibrary.simpleMessage("Conversa"),
        "chatBackup": MessageLookupByLibrary.simpleMessage(
            "Cópia de segurança de conversas"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "A tuas mensagens antigas estão protegidas com uma chave de recuperação. Por favor, certifica-te que não a perdes."),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Detalhes de conversa"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "A conversa foi adicionada a este espaço"),
        "chats": MessageLookupByLibrary.simpleMessage("Conversas"),
        "chooseAStrongPassword": MessageLookupByLibrary.simpleMessage(
            "Escolhe uma palavra-passe forte"),
        "chooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Escolhe um nome de utilizador"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Limpar arquivo"),
        "close": MessageLookupByLibrary.simpleMessage("Fechar"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Banir o utilizador dado desta sala"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Limpar cache"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Criar uma conversa de grupo vazia\nUsa --no-encryption para desativar a encriptação"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Descartar sessão"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Iniciar uma conversa direta\nUsa --no-encryption para desativar a encriptação"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Enviar texto formatado com HTML"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Convidar o utilizador dado a esta sala"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Entrar na sala dada"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Remover o utilizador dado desta sala"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Sair desta sala"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Descreve-te"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Definir a tua imagem para esta sala (por mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Definir o teu nome para esta sala"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Definir o nível de poder do utilizador dado (por omissão: 50)"),
        "commandHint_plain":
            MessageLookupByLibrary.simpleMessage("Enviar texto não formatado"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Enviar respostas como reações"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Enviar texto"),
        "commandHint_unban":
            MessageLookupByLibrary.simpleMessage("Perdoar o utilizador dado"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Comando inválido"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Compara e certifica-te que os emojis que se seguem correspondem aos do outro dispositivo:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Compara e certifica-te que os números que se seguem correspondem aos do outro dispositivo:"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Configurar conversa"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "connect": MessageLookupByLibrary.simpleMessage("Ligar"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "O contacto foi convidado para o grupo"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Contém nome de exibição"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Contém nome de utilizador"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "O conteúdo foi denunciado aos admins do servidor"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage(
            "Copiado para a área de transferência"),
        "copy": MessageLookupByLibrary.simpleMessage("Copiar"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage(
            "Copiar para a área de transferência"),
        "couldNotDecryptMessage": m21,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Criar"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Criar novo grupo"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Novo espaço"),
        "createdTheChat": m24,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Ativo(a) agora"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Escuro"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Isto irá desativar a tua conta. Não é reversível! Tens a certeza?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Nível de permissão normal"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Exportar sessão e limpar dispositivo"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "Utilizadores do TOR: Exportar sessão"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Para utilizadores do TOR, é recomendado exportar a sessão antes de fechar a janela."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Esta ação não pode ser revertida. Assegura-te que guardas bem a cópia de segurança."),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Eliminar conta"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Eliminar mensagem"),
        "deny": MessageLookupByLibrary.simpleMessage("Recusar"),
        "device": MessageLookupByLibrary.simpleMessage("Dispositivo"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ID de dispositivo"),
        "devices": MessageLookupByLibrary.simpleMessage("Dispositivos"),
        "directChats":
            MessageLookupByLibrary.simpleMessage("Conversas diretas"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Nome de exibição alterado"),
        "downloadFile":
            MessageLookupByLibrary.simpleMessage("Descarregar ficheiro"),
        "edit": MessageLookupByLibrary.simpleMessage("Editar"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Editar servidores bloqueados"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Editar pacotes para esta conta"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage(
            "Editar permissões de conversa"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Editar nome de exibição"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Editar alcunhas da sala"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Editar avatar da sala"),
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Emote já existente!"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("Código de emote inválido!"),
        "emotePacks":
            MessageLookupByLibrary.simpleMessage("Pacotes de emotes da sala"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Configurações de emotes"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Código do emote"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Precisas de escolher um código de emote e uma imagem!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Conversa vazia"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Ativar pacote de emotes globalmente"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Ativar encriptação"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Nunca mais poderás desativar a encriptação. Tens a certeza?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Ativar múltiplas contas neste dispositivo"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Encriptada"),
        "encryption": MessageLookupByLibrary.simpleMessage("Encriptação"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage(
            "A encriptação não está ativada"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Insere o nome do grupo"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Insere o nome do espaço"),
        "enterAnEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Insere um endereço de correio eletrónico"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Insere o teu servidor"),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Tudo a postos!"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extremamente ofensivo"),
        "fileName": MessageLookupByLibrary.simpleMessage("Nome do ficheiro"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Tamanho da letra"),
        "forward": MessageLookupByLibrary.simpleMessage("Reencaminhar"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Ir para a nova sala"),
        "group": MessageLookupByLibrary.simpleMessage("Grupo"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Descrição do grupo"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Descrição do grupo alterada"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("O grupo é público"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Grupos"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("São proibidos visitantes"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Podem entrar visitantes"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Ajuda"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Esconder eventos eliminados"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Esconder eventos desconhecidos"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Servidor"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "Quão ofensivo é este conteúdo?"),
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Restaurar a partir de cópia de segurança"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "Utilizadores do TOR: Importar sessão"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Exportaste a tua sessão na última vez que estiveste no TOR? Importa-a rapidamente e continua a conversar."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Eu cliquei na ligação"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identidade"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorar"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Podes ignorar utilizadores que te incomodem. Não irás poder receber quaisquer mensagens ou convites para salas de utilizadores na tua lista pessoal de ignorados."),
        "ignoreUsername": MessageLookupByLibrary.simpleMessage(
            "Nome do utilizador a ignorar"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Utilizadores ignorados"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Senha ou chave de recuperação incorretos"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Inofensivo"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Convidar contacto"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Convite para mim"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Convidado(a)"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage(
            "Utilizadores(as) convidados(as) apenas"),
        "isTyping": MessageLookupByLibrary.simpleMessage("está a escrever…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Entrar na sala"),
        "joinedTheChat": m39,
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Expulsar da conversa"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Visto(a) há muito tempo"),
        "leave": MessageLookupByLibrary.simpleMessage("Sair"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Saiu da conversa"),
        "license": MessageLookupByLibrary.simpleMessage("Licença"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Claro"),
        "link": MessageLookupByLibrary.simpleMessage("Ligação"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Carregar mais…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "A carregar... Por favor aguarde."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Os serviços de localização estão desativados. Por favor, ativa-os para poder partilhar a sua localização."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Permissão de localização recusada. Por favor, concede permissão para poderes partilhar a tua posição."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Entrar"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Entrar com um clique"),
        "logout": MessageLookupByLibrary.simpleMessage("Sair"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Certifica-te que o identificador é válido"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Alterações de membros"),
        "mention": MessageLookupByLibrary.simpleMessage("Mencionar"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "A mensagem será eliminada para todos os participantes"),
        "messages": MessageLookupByLibrary.simpleMessage("Mensagens"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderador"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Silenciar conversa"),
        "needPantalaimonWarning":
            MessageLookupByLibrary.simpleMessage("Por favor,"),
        "newChat": MessageLookupByLibrary.simpleMessage("Nova conversa"),
        "newMessageInFluffyChat":
            MessageLookupByLibrary.simpleMessage("Nova mensagem no FluffyChat"),
        "newVerificationRequest":
            MessageLookupByLibrary.simpleMessage("Novo pedido de verificação!"),
        "next": MessageLookupByLibrary.simpleMessage("Próximo"),
        "no": MessageLookupByLibrary.simpleMessage("Não"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Nenhuma ligação ao servidor"),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage(
            "Nenhuns emotes encontrados. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Só podes ativar a encriptação quando a sala não for publicamente acessível."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Parece que não tens nenhuns serviços da Google no seu telemóvel. É uma boa decisão para a sua privacidade! Para receber notificações instantâneas no FluffyChat, recomendamos que uses https://microg.org/ ou https://unifiedpush.org/."),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Ainda não adicionaste uma forma de recuperar a tua palavra-passe."),
        "noPermission": MessageLookupByLibrary.simpleMessage("Sem permissão"),
        "noRoomsFound": MessageLookupByLibrary.simpleMessage(
            "Não foram encontradas nenhumas salas…"),
        "none": MessageLookupByLibrary.simpleMessage("Nenhum"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificações"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notificações ativadas para esta conta"),
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("A obter localização…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Offensivo"),
        "offline": MessageLookupByLibrary.simpleMessage("Offline"),
        "ok": MessageLookupByLibrary.simpleMessage("ok"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Um dos teus clientes terminou sessão"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "A cópia de segurança online de chaves está ativada"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Ups! Infelizmente, ocorreu um erro ao configurar as notificações instantâneas."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Ups, algo correu mal…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Abrir aplicação para ler mensagens"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Abrir câmara"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Abrir nos mapas"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Opcional) Nome do grupo"),
        "or": MessageLookupByLibrary.simpleMessage("Ou"),
        "participant": MessageLookupByLibrary.simpleMessage("Participante"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "senha ou chave de recuperação"),
        "password": MessageLookupByLibrary.simpleMessage("Palavra-passe"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Palavra-passe esquecida"),
        "passwordHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "A palavra-passe foi alterada"),
        "passwordRecovery": MessageLookupByLibrary.simpleMessage(
            "Recuperação de palavra-passe"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "As palavras-passe não correspondem!"),
        "people": MessageLookupByLibrary.simpleMessage("Pessoas"),
        "pickImage":
            MessageLookupByLibrary.simpleMessage("Escolher uma imagem"),
        "pin": MessageLookupByLibrary.simpleMessage("Afixar"),
        "play": m48,
        "pleaseChoose":
            MessageLookupByLibrary.simpleMessage("Por favor, escolhe"),
        "pleaseChooseAPasscode": MessageLookupByLibrary.simpleMessage(
            "Por favor, escolhe um código-passe"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Por favor, escolhe um nome de utilizador"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Por favor, clica na ligação no correio eletrónico e depois continua."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Por favor, insere 4 dígitos ou deixa vazio para desativar o bloqueio da aplicação."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Por favor, insere um ID Matrix."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Por favor, insere um endereço de correio eletrónico válido."),
        "pleaseEnterYourPassword": MessageLookupByLibrary.simpleMessage(
            "Por favor, insere a tua palavra-passe"),
        "pleaseEnterYourPin": MessageLookupByLibrary.simpleMessage(
            "Por favor, insere o teu código"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Por favor, insere o teu nome de utilizador"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Por favor, segue as instruções no website e clica em \"Seguinte\"."),
        "privacy": MessageLookupByLibrary.simpleMessage("Privacidade"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Salas públicas"),
        "reason": MessageLookupByLibrary.simpleMessage("Razão"),
        "recording": MessageLookupByLibrary.simpleMessage("A gravar"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Eliminar mensagem"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Registar"),
        "reject": MessageLookupByLibrary.simpleMessage("Rejeitar"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Reentrar"),
        "remove": MessageLookupByLibrary.simpleMessage("Remover"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Remover todos os outros dispositivos"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Remover dispositivo"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Remover deste pacote"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Remover o teu avatar"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Exibir conteúdo de mensagem rico"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Repete a palavra-passe"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Substituir sala com versão mais recente"),
        "reply": MessageLookupByLibrary.simpleMessage("Responder"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Reportar mensagem"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Pedir permissão"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("A sala foi atualizada"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Versão da sala"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Guardar ficheiro"),
        "search": MessageLookupByLibrary.simpleMessage("Procurar"),
        "security": MessageLookupByLibrary.simpleMessage("Segurança"),
        "seenByUser": m54,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Enviar"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Enviar a mensagem"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Enviar como texto"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Enviar áudio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Enviar ficheiro"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Enviar imagem"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Enviar mensagens"),
        "sendOnEnter": MessageLookupByLibrary.simpleMessage("Enviar com Enter"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("Enviar original"),
        "sendSticker":
            MessageLookupByLibrary.simpleMessage("Enviar autocolante"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Enviar vídeo"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Este servidor precisa de validar o teu endereço de correio eletrónico para o registo."),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Partilhar a ligação de convite"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Perdoar nesta conversa"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "Atualização do FluffyChat disponível"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Iniciar atualização me segundo plano"),
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "A cópia de segurança foi configurada.")
      };
}
