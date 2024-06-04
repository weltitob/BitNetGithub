// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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
  String get localeName => 'pt_BR';

  static String m0(username) => "👍 ${username} aceitou o convite";

  static String m1(username) =>
      "🔐 ${username} ativou a criptografia ponta-a-ponta";

  static String m2(senderName) => "${senderName} atendeu à chamada";

  static String m3(username) =>
      "Aceitar esta solicitação de verificação de ${username}?";

  static String m4(username, targetName) => "${username} baniu ${targetName}";

  static String m5(uri) => "Não foi possível abrir a URI ${uri}";

  static String m6(username) => "${username} alterou o avatar da conversa";

  static String m7(username, description) =>
      "${username} alterou a descrição da conversa para: \'${description}\'";

  static String m8(username, chatname) =>
      "${username} alterou o nome da conversa para: \'${chatname}\'";

  static String m9(username) => "${username} alterou as permissões na conversa";

  static String m10(username, displayname) =>
      "${username} mudou o seu nome de exibição para: \'${displayname}\'";

  static String m11(username) =>
      "${username} alterou as regras de acesso dos convidados";

  static String m12(username, rules) =>
      "${username} alterou as regras de acesso dos convidados para: ${rules}";

  static String m13(username) =>
      "${username} alterou a visibilidade do histórico";

  static String m14(username, rules) =>
      "${username} alterou a visibilidade do histórico para: ${rules}";

  static String m15(username) =>
      "${username} alterou as regras para participação";

  static String m16(username, joinRules) =>
      "${username} alterou as regras para participação para: ${joinRules}";

  static String m17(username) => "${username} alterou seu avatar";

  static String m18(username) => "${username} alterou os cognomes da sala";

  static String m19(username) => "${username} alterou o link de convite";

  static String m20(command) => "${command} não é um comando.";

  static String m21(error) => "Não foi possível decriptar a mensagem: ${error}";

  static String m22(count) => "${count} arquivos";

  static String m23(count) => "${count} participantes";

  static String m24(username) => "💬 ${username} criou a conversa";

  static String m25(senderName) => "${senderName} afagou você";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}/${month}/${year}";

  static String m28(month, day) => "${day}/${month}";

  static String m29(senderName) => "${senderName} finalizou a chamada";

  static String m30(error) => "Erro ao obter local: ${error}";

  static String m32(senderName) => "${senderName} enviou olhos arregalados";

  static String m33(displayname) => "Grupo com ${displayname}";

  static String m34(username, targetName) =>
      "${username} revogou o convite para ${targetName}";

  static String m35(senderName) => "${senderName} abraçou você";

  static String m36(groupName) => "Convidar contato para ${groupName}";

  static String m37(username, link) =>
      "${username} convidou você para o FluffyChat. \n1. Instale o FluffyChat: https://fluffychat.im \n2. Entre ou crie uma conta \n3. Abra o link do convite: ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} convidou ${targetName}";

  static String m39(username) => "👋 ${username} entrou na conversa";

  static String m40(username, targetName) =>
      "👞 ${username} enxotou ${targetName}";

  static String m41(username, targetName) =>
      "🙅 ${username} expulsou e baniu ${targetName}";

  static String m42(localizedTimeShort) =>
      "Última vez ativo: ${localizedTimeShort}";

  static String m43(count) => "Carregue ${count} mais participantes";

  static String m44(homeserver) => "Conectar a ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} não é um servidor matrix, usar ${server2} talvez?";

  static String m46(number) => "${number} conversas";

  static String m47(count) => "${count} usuários estão digitando…";

  static String m48(fileName) => "Tocar ${fileName}";

  static String m49(min) => "Por favor, use ao menos ${min} caracteres.";

  static String m50(sender, reaction) => "${sender} reagiu com ${reaction}";

  static String m51(username) => "${username} removeu um evento";

  static String m52(username) => "${username} recusou o convite";

  static String m53(username) => "Removido por ${username}";

  static String m54(username) => "Visto por ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Visto por ${username} e mais ${count} pessoas')}";

  static String m56(username, username2) =>
      "Visto por ${username} e ${username2}";

  static String m57(username) => "📁 ${username} enviou um arquivo";

  static String m58(username) => "🖼️ ${username} enviou uma imagem";

  static String m59(username) => "😊 ${username} enviou uma figurinha";

  static String m60(username) => "🎥 ${username} enviou um vídeo";

  static String m61(username) => "🎤 ${username} enviou um audio";

  static String m62(senderName) =>
      "${senderName} enviou informações de chamada";

  static String m63(username) => "${username} compartilhou sua localização";

  static String m64(senderName) => "${senderName} iniciou uma chamada";

  static String m65(date, body) => "Painel de ${date}:\n${body}";

  static String m66(mxid) => "Isto deveria ser ${mxid}";

  static String m67(number) => "Alternar para a conta ${number}";

  static String m68(username, targetName) =>
      "${username} revogou o banimento de ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 conversa não lida', other: '${unreadCount} conversas não lidas')}";

  static String m70(username, count) =>
      "${username} e mais ${count} pessoas estão digitando…";

  static String m71(username, username2) =>
      "${username} e ${username2} estão digitando…";

  static String m72(username) => "${username} está digitando…";

  static String m73(username) => "🚪 ${username} saiu da conversa";

  static String m74(username, type) => "${username} enviou um evento ${type}";

  static String m75(size) => "Vídeo (${size})";

  static String m77(user) => "Você baniu ${user}";

  static String m78(user) => "Você revogou o convite para ${user}";

  static String m79(user) => "📩 Você foi convidado por ${user}";

  static String m80(user) => "📩 Você convidou ${user}";

  static String m81(user) => "👞 Você expulsou ${user}";

  static String m82(user) => "🙅 Você expulsou e baniu ${user}";

  static String m83(user) => "Você revogou o banimento de ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Sobre"),
        "accept": MessageLookupByLibrary.simpleMessage("Aceitar"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Conta"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Adicionar conta"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Adicionar descrição"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Adicionar email"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Adicionar uma descrição para o grupo"),
        "addToBundle":
            MessageLookupByLibrary.simpleMessage("Adicionar à coleção"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Adicionar ao espaço"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Selecione um espaço para adicionar esta conversa."),
        "addToStory":
            MessageLookupByLibrary.simpleMessage("Adicionar ao painel"),
        "addWidget":
            MessageLookupByLibrary.simpleMessage("Adicionar ferramenta"),
        "admin": MessageLookupByLibrary.simpleMessage("Admin"),
        "alias": MessageLookupByLibrary.simpleMessage("cognome"),
        "all": MessageLookupByLibrary.simpleMessage("Todas"),
        "allChats": MessageLookupByLibrary.simpleMessage("Todas as conversas"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Todos espaços"),
        "answeredTheCall": m2,
        "anyoneCanJoin": MessageLookupByLibrary.simpleMessage(
            "Qualquer pessoa pode participar"),
        "appLock": MessageLookupByLibrary.simpleMessage("Trava do aplicativo"),
        "appearOnTop": MessageLookupByLibrary.simpleMessage("Aparecer no topo"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Permitir que o app apareça no topo (desnecessário caso FluffyChat já esteja configurado como conta para chamadas)"),
        "archive": MessageLookupByLibrary.simpleMessage("Arquivo"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Usuários convidados podem participar"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Tem certeza?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Tem certeza que deseja encerrar a sessão?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Para poder validar a outra pessoa, por favor, insira sua frase secreta ou chave de recuperação."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Reproduzir automaticamente figurinhas animadas e emojis"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Banir da conversa"),
        "banned": MessageLookupByLibrary.simpleMessage("Banido"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Bloquear dispositivo"),
        "blocked": MessageLookupByLibrary.simpleMessage("Bloqueado"),
        "botMessages":
            MessageLookupByLibrary.simpleMessage("Mensagens de robôs"),
        "bubbleSize": MessageLookupByLibrary.simpleMessage("Tamanho do balão"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Nome da coleção"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Conta para chamadas"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Permitir que o FluffyChat use o app de chamadas nativo do Android."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Permissões de chamada"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage(
            "Alterar o nome do dispositivo"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Alterar a senha"),
        "changeTheHomeserver":
            MessageLookupByLibrary.simpleMessage("Alterar o servidor matriz"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Alterar o nome do grupo"),
        "changeTheme": MessageLookupByLibrary.simpleMessage("Alterar o tema"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Alterar o pano de fundo"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Alterar seu avatar"),
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
            "A criptografia foi corrompida"),
        "chat": MessageLookupByLibrary.simpleMessage("Conversas"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Backup da conversa"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Suas mensagens antigas são protegidas com sua chave de recuperação. Por favor, evite perdê-la."),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Detalhes da conversa"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "A conversa foi adicionada a este espaço"),
        "chats": MessageLookupByLibrary.simpleMessage("Conversas"),
        "chooseAStrongPassword":
            MessageLookupByLibrary.simpleMessage("Escolha uma senha forte"),
        "chooseAUsername":
            MessageLookupByLibrary.simpleMessage("Escolha um nome de usuário"),
        "clearArchive": MessageLookupByLibrary.simpleMessage("Limpar arquivo"),
        "close": MessageLookupByLibrary.simpleMessage("Fechar"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Banir um(a) usuário(a) desta sala"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Limpar dados temporários"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Criar uma sala vazia.\nUse --no-encryption para desabilitar a criptografia"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Enviar um afago"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Descartar sessão"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Iniciar uma conversa direta\nUse --no-encryption para desabilitar a criptografia"),
        "commandHint_googly":
            MessageLookupByLibrary.simpleMessage("Enviar olhos arregalados"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Enviar mensagem formatada em HTML"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Enviar um abraço"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Convidar um(a) usuário(a) para esta sala"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Entrar numa sala"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Remover um(a) usuário(a) desta sala"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Sair desta sala"),
        "commandHint_markasdm":
            MessageLookupByLibrary.simpleMessage("Marcar como conversa direta"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Marcar como grupo"),
        "commandHint_me":
            MessageLookupByLibrary.simpleMessage("Descrever você mesmo"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Determinar sua imagem para esta sala (via mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Determinar seu nome de exibição para esta sala"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Determinar o grau de poderes de um(a) usuário(a) (padrão: 50)"),
        "commandHint_plain": MessageLookupByLibrary.simpleMessage(
            "Enviar mensagem sem formatação"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Enviar uma resposta como reação"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Enviar mensagem"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Revogar o banimento de um(a) usuário(a) desta sala"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Comando inválido"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Compare e certifique-se que os seguintes emojis batem com os do outro dispositivo:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Compare e certifique-se de que os seguintes números batem com os do outro dispositivo:"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Configurar conversa"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirma"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Tem certeza que quer desafixar o evento permanentemente?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Por favor, confirme seu ID Matrix para apagar sua conta."),
        "connect": MessageLookupByLibrary.simpleMessage("Conectar"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "O contato foi convidado ao grupo"),
        "containsDisplayName":
            MessageLookupByLibrary.simpleMessage("Contém nome de exibição"),
        "containsUserName":
            MessageLookupByLibrary.simpleMessage("Contém nome de usuário"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "O conteúdo foi denunciado para quem administra o servidor"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage(
            "Copiado para área de transferência"),
        "copy": MessageLookupByLibrary.simpleMessage("Copiar"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage(
            "Copiar para a área de transferência"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Criar"),
        "createNewGroup": MessageLookupByLibrary.simpleMessage("Novo grupo"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Novo espaço"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive": MessageLookupByLibrary.simpleMessage("Ativo"),
        "custom": MessageLookupByLibrary.simpleMessage("Personalizado"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Escuro"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Isto desativará a conta do usuário. É irreversível! Tem certeza?"),
        "defaultPermissionLevel":
            MessageLookupByLibrary.simpleMessage("Nível de permissão padrão"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Exportar sessão e limpar dispositivo"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "Usuários TOR: Exportar sessão"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Para usuários TOR, é recomendado exportar a sessão antes de fechar a janela."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Esta ação não pode ser desfeita. Certifique-se de que o arquivo backup está guardado e seguro."),
        "delete": MessageLookupByLibrary.simpleMessage("Apagar"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Apagar conta"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Apagar mensagem"),
        "deny": MessageLookupByLibrary.simpleMessage("Rejeitar"),
        "device": MessageLookupByLibrary.simpleMessage("Dispositivo"),
        "deviceId": MessageLookupByLibrary.simpleMessage("ID do dispositivo"),
        "devices": MessageLookupByLibrary.simpleMessage("Dispositivos"),
        "directChats":
            MessageLookupByLibrary.simpleMessage("Conversas diretas"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Descartar"),
        "displaynameHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "O nome de exibição foi alterado"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Não mostrar novamente"),
        "downloadFile": MessageLookupByLibrary.simpleMessage("Baixar arquivo"),
        "edit": MessageLookupByLibrary.simpleMessage("Editar"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Editar servidores bloqueados"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Editar coleções para esta conta"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage(
            "Editar permissões da conversa"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Editar nome de exibição"),
        "editRoomAliases":
            MessageLookupByLibrary.simpleMessage("Editar cognome da sala"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Editar o avatar da sala"),
        "editWidgets":
            MessageLookupByLibrary.simpleMessage("Editar ferramentas"),
        "emailOrUsername":
            MessageLookupByLibrary.simpleMessage("Email ou nome de usuário"),
        "emojis": MessageLookupByLibrary.simpleMessage("Emojis"),
        "emoteExists": MessageLookupByLibrary.simpleMessage("Emoji já existe!"),
        "emoteInvalid":
            MessageLookupByLibrary.simpleMessage("Código emoji inválido!"),
        "emotePacks":
            MessageLookupByLibrary.simpleMessage("Pacote de emoji para a sala"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Configuração dos Emoji"),
        "emoteShortcode": MessageLookupByLibrary.simpleMessage("Código Emoji"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Você tem que escolher um código emoji e uma imagem!"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Conversa vazia"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Habilitar globalmente o pacote de emoji"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Habilitar criptografia"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Você não poderá desabilitar a criptografia posteriormente. Tem certeza?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Habilitar múltiplas contas neste dispositivo"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Criptografado"),
        "encryption": MessageLookupByLibrary.simpleMessage("Criptografia"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage(
            "A criptografia não está habilitada"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Insira um nome de grupo"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Insira um nome pro espaço"),
        "enterAnEmailAddress":
            MessageLookupByLibrary.simpleMessage("Inserir endereço de e-mail"),
        "enterRoom": MessageLookupByLibrary.simpleMessage("Entrar na conversa"),
        "enterSpace": MessageLookupByLibrary.simpleMessage("Entrar no espaço"),
        "enterYourHomeserver":
            MessageLookupByLibrary.simpleMessage("Insira um servidor matriz"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Erro ao adicionar a ferramenta."),
        "errorObtainingLocation": m30,
        "everythingReady": MessageLookupByLibrary.simpleMessage("Tudo pronto!"),
        "experimentalVideoCalls": MessageLookupByLibrary.simpleMessage(
            "Vídeo chamadas experimentais"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extremamente ofensivo"),
        "fileName": MessageLookupByLibrary.simpleMessage("Nome do arquivo"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Tamanho da fonte"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "Esta notificação aparece quando um serviço está executando."),
        "forward": MessageLookupByLibrary.simpleMessage("Encaminhar"),
        "fromJoining": MessageLookupByLibrary.simpleMessage("Desde que entrou"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("Desde o convite"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Ir para a sala nova"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Grupo"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Descrição do grupo"),
        "groupDescriptionHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Descrição do grupo alterada"),
        "groupIsPublic": MessageLookupByLibrary.simpleMessage("Grupo público"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Grupos"),
        "guestsAreForbidden":
            MessageLookupByLibrary.simpleMessage("Convidados estão proibidos"),
        "guestsCanJoin":
            MessageLookupByLibrary.simpleMessage("Convidados podem participar"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Ajuda"),
        "hideRedactedEvents":
            MessageLookupByLibrary.simpleMessage("Ocultar eventos removidos"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Ocultar eventos desimportantes"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Ocultar eventos desconhecidos"),
        "homeserver": MessageLookupByLibrary.simpleMessage("Servidor matriz"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "O quão ofensivo é este conteúdo?"),
        "hugContent": m35,
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Restaurar a partir de arquivo backup"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "Usuários TOR: Importar sessão"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Você exportou sua última sessão no TOR? Importe ela rapidamente e continue conversando."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("Eu cliquei no link"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Eu compreendo"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "identity": MessageLookupByLibrary.simpleMessage("Identidade"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorar"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Você pode ignorar usuários que estão lhe pertubando. Não será possível receber mensagens ou convites de usuários na sua lista pessoal de ignorados."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignorar usuário"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Usuários ignorados"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Frase secreta ou chave de recuperação incorreta"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "Infelizmente, o armazenamento de mensagens não é habilitado por padrão no modo privado.\nPor favor, visite\n- about:config\n- atribua \"true\" a \"dom.indexedDB.privateBrowsing.enabled\"\nDe outro modo, não será possível executar o FluffyChat."),
        "indexedDbErrorTitle":
            MessageLookupByLibrary.simpleMessage("Problemas no modo privado"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Inofensivo"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Convidar contato"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Convite para mim"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Foi convidado"),
        "invitedUser": m38,
        "invitedUsersOnly":
            MessageLookupByLibrary.simpleMessage("Apenas usuários convidados"),
        "isTyping": MessageLookupByLibrary.simpleMessage("está escrevendo…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Entrar na sala"),
        "joinedTheChat": m39,
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Expulso da conversa"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo":
            MessageLookupByLibrary.simpleMessage("Visto há muito tempo atrás"),
        "leave": MessageLookupByLibrary.simpleMessage("Sair"),
        "leftTheChat": MessageLookupByLibrary.simpleMessage("Sair da conversa"),
        "license": MessageLookupByLibrary.simpleMessage("Licença"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Claro"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Carregando mais…"),
        "loadingPleaseWait":
            MessageLookupByLibrary.simpleMessage("Carregando... Aguarde."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "O serviço de localização está desabilitado. Por favor, habilite-o para compartilhar sua localização."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "Permissão de localização negada. Conceda as permissões para habilitar o compartilhamento de localização."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Iniciar sessão"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Entrar com um clique"),
        "logout": MessageLookupByLibrary.simpleMessage("Encerrar sessão"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Certifique-se de que a identificação é válida"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Marcar como lido"),
        "matrixWidgets":
            MessageLookupByLibrary.simpleMessage("Ferramentas Matrix"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Alterações de membros"),
        "mention": MessageLookupByLibrary.simpleMessage("Mencionar"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Informações da mensagem"),
        "messageType": MessageLookupByLibrary.simpleMessage("Tipo da mensagem"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Mensagem será removida para todos os participantes"),
        "messages": MessageLookupByLibrary.simpleMessage("Mensagens"),
        "moderator": MessageLookupByLibrary.simpleMessage("Moderador"),
        "muteChat": MessageLookupByLibrary.simpleMessage("Silenciar"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Por favor, observe que, por enquanto, você precisa do Pantalaimon para usar criptografia ponta-a-ponta."),
        "newChat": MessageLookupByLibrary.simpleMessage("Nova conversa"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Novo grupo"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 Nova mensagem no FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Novo espaço"),
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "Nova solicitação de verificação!"),
        "next": MessageLookupByLibrary.simpleMessage("Próximo"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Próxima conta"),
        "no": MessageLookupByLibrary.simpleMessage("Não"),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Sem conexão com o servidor"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira um e-mail válido. De outro modo, você não conseguirá recuperar sua senha. Caso prefira assim, toque novamente no botão para continuar."),
        "noEmotesFound":
            MessageLookupByLibrary.simpleMessage("Nenhum emoji encontrado. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Você só pode ativar criptografia quando a sala não for mais publicamente acessível."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Aparentemente você não tem serviços Google no seu celular. Boa decisão para a sua privacidade! Para receber notificações no FluffyChat, recomendamos usar https://microg.org/ ou https://unifiedpush.org."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "Isto pode ocorrer caso a mensagem tenha sido enviada antes da entrada na sua conta com este dispositivo.\n\nTambém é possível que o remetente tenha bloqueado o seu dispositivo ou ocorreu algum problema com a conexão.\n\nVocê consegue ler as mensagens em outra sessão? Então, pode transferir as mensagens de lá! Vá em Configurações > Dispositivos e confira se os dispositivos verificaram um ao outro. Quando abrir a conversa da próxima vez e ambas as sessões estiverem abertas, as chaves serão transmitidas automaticamente.\n\nNão gostaria de perder suas chaves quando sair ou trocar de dispositivos? Certifique-se que o backup de conversas esteja habilitado nas configurações."),
        "noMatrixServer": m45,
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Você ainda não adicionou uma forma de recuparar sua senha."),
        "noPermission": MessageLookupByLibrary.simpleMessage("Sem permissão"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Nenhuma sala encontrada…"),
        "none": MessageLookupByLibrary.simpleMessage("Nenhum"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificações"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notificações habilitadas para esta conta"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation":
            MessageLookupByLibrary.simpleMessage("Obtendo localização…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Ofensivo"),
        "offline": MessageLookupByLibrary.simpleMessage("Desconectado"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Um dos seus clientes foi desvinculado"),
        "online": MessageLookupByLibrary.simpleMessage("Disponível"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Backup de chaves está ativado"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Opa! Infelizmente, um erro ocorreu ao configurar as notificações."),
        "oopsSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Opa, algo deu errado…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Abra o app para ler as mensagens"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Abra a câmera"),
        "openChat": MessageLookupByLibrary.simpleMessage("Abrir conversa"),
        "openGallery": MessageLookupByLibrary.simpleMessage("Abrir galeria"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Abrir no mapas"),
        "openVideoCamera":
            MessageLookupByLibrary.simpleMessage("Abra a câmera para um vídeo"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Opcional) Nome do Grupo"),
        "or": MessageLookupByLibrary.simpleMessage("Ou"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Microfone, câmera e outras permissões do FluffyChat"),
        "participant": MessageLookupByLibrary.simpleMessage("Participante"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "frase secreta ou chave de recuperação"),
        "password": MessageLookupByLibrary.simpleMessage("Senha"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Esqueci a senha"),
        "passwordHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Senha foi alterada"),
        "passwordRecovery":
            MessageLookupByLibrary.simpleMessage("Recuperação de senha"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Senhas diferentes!"),
        "people": MessageLookupByLibrary.simpleMessage("Pessoas"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Escolha uma imagem"),
        "pin": MessageLookupByLibrary.simpleMessage("Alfinetar"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("Afixar à sala"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Chamar"),
        "play": m48,
        "pleaseChoose":
            MessageLookupByLibrary.simpleMessage("Por favor, selecione"),
        "pleaseChooseAPasscode": MessageLookupByLibrary.simpleMessage(
            "Por favor, escolha um código"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Por favor, escolha um nome de usuário"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Por favor, clique a ligação no e-mail para prosseguir."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira 4 dígitos ou deixe em branco para desativar a trava do aplicativo."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira o ID Matrix."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira sua chave de recuperação:"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Para destrancar suas mensagens antigas, por favor, insira sua chave de recuperação gerada numa sessão prévia. Suas chave de recuperação NÃO é sua senha."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira um email válido."),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("Por favor, insira sua senha"),
        "pleaseEnterYourPin":
            MessageLookupByLibrary.simpleMessage("Por favor, insira seu PIN"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira seu nome de usuário"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Por favor, siga as instruções no site e toque em próximo."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Conta anterior"),
        "privacy": MessageLookupByLibrary.simpleMessage("Privacidade"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Salas públicas"),
        "publish": MessageLookupByLibrary.simpleMessage("Publicar"),
        "pushRules":
            MessageLookupByLibrary.simpleMessage("Regras de notificação"),
        "reactedWith": m50,
        "reason": MessageLookupByLibrary.simpleMessage("Motivo"),
        "recording": MessageLookupByLibrary.simpleMessage("Gravando"),
        "recoveryKey":
            MessageLookupByLibrary.simpleMessage("Chave de recuperação"),
        "recoveryKeyLost": MessageLookupByLibrary.simpleMessage(
            "Perdeu a chave de recuperação?"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Retratar mensagem"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("Registrar"),
        "reject": MessageLookupByLibrary.simpleMessage("Recusar"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Retornar"),
        "remove": MessageLookupByLibrary.simpleMessage("Remover"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Remover todos os outros dispositivos"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Remover dispositivo"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Remover desta coleção"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Remover do espaço"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Remover seu avatar"),
        "removedBy": m53,
        "renderRichContent":
            MessageLookupByLibrary.simpleMessage("Exibir conteúdo formatado"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Repita a senha"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Substituir sala por uma nova versão"),
        "reply": MessageLookupByLibrary.simpleMessage("Responder"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("Resposta enviada"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Denunciar mensagem"),
        "reportUser": MessageLookupByLibrary.simpleMessage("Delatar usuário"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Solicitar permissão"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Sala foi atualizada"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Versão da sala"),
        "saveFile": MessageLookupByLibrary.simpleMessage("Salvar arquivo"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Salvar esta chave manualmente via compartilhamento do sistema ou área de transferência."),
        "scanQrCode":
            MessageLookupByLibrary.simpleMessage("Escanear o código QR"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Você está compartilhando sua tela no FluffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("Compartilhar tela"),
        "search": MessageLookupByLibrary.simpleMessage("Buscar"),
        "security": MessageLookupByLibrary.simpleMessage("Segurança"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Enviar"),
        "sendAMessage": MessageLookupByLibrary.simpleMessage("Enviar mensagem"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Enviar como texto"),
        "sendAudio": MessageLookupByLibrary.simpleMessage("Enviar audio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Enviar arquivo"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Enviar imagem"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Enviar mensagens"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Enviar ao pressionar enter"),
        "sendOriginal": MessageLookupByLibrary.simpleMessage("Enviar original"),
        "sendSticker": MessageLookupByLibrary.simpleMessage("Enviar figurinha"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Enviar vídeo"),
        "sender": MessageLookupByLibrary.simpleMessage("Remetente"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Separar Conversas Diretas e Grupos"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Este servidor precisa validar seu email para efetuar o registro."),
        "setAsCanonicalAlias": MessageLookupByLibrary.simpleMessage(
            "Fixar como cognome principal"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Implantar emojis personalizados"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Fixar uma descrição do grupo"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Enviar link de convite"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage(
            "Determinar níveis de permissão"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Alterar o status"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
        "share": MessageLookupByLibrary.simpleMessage("Compartilhar"),
        "shareLocation":
            MessageLookupByLibrary.simpleMessage("Compartilhar localização"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Compartilhar o link do convite"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Mostrar Conversas Diretas relacionadas nos Espaços"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Mostrar senha"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registrar"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Identidade Única"),
        "skip": MessageLookupByLibrary.simpleMessage("Pular"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Código fonte"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("Espaço é público"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Nome do espaço"),
        "start": MessageLookupByLibrary.simpleMessage("Começar"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "statusExampleMessage":
            MessageLookupByLibrary.simpleMessage("Como vai você?"),
        "storeInAndroidKeystore":
            MessageLookupByLibrary.simpleMessage("Guardar no cofre do Android"),
        "storeInAppleKeyChain": MessageLookupByLibrary.simpleMessage(
            "Guardar no chaveiro da Apple"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Guardar a chave de recuperação no armazenamento seguro deste dispositivo."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Guardar de modo seguro neste dispositivo"),
        "stories": MessageLookupByLibrary.simpleMessage("Stories"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Por favor, note que pessoas podem ver e contactar umas às outras no seu painel. Ele ficará visível por apenas 24 horas, mas não há garantias de que será apagado por todos dispositivos e servidores."),
        "submit": MessageLookupByLibrary.simpleMessage("Submeter"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Sincronizando… Por favor, aguarde."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Sistema"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Não correspondem"),
        "theyMatch": MessageLookupByLibrary.simpleMessage("Correspondem"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Este(a) usuário(a) ainda não postou no seu painel"),
        "time": MessageLookupByLibrary.simpleMessage("Hora"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite":
            MessageLookupByLibrary.simpleMessage("Alternar favorito"),
        "toggleMuted":
            MessageLookupByLibrary.simpleMessage("Alternar Silenciado"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Marcar lido/não lido"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Demasiadas requisições. Por favor, tente novamente mais tarde!"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Transferir de outro dispositivo"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Tente enviar novamente"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Indisponível"),
        "unbanFromChat":
            MessageLookupByLibrary.simpleMessage("Revogar banimento"),
        "unbannedUser": m68,
        "unblockDevice":
            MessageLookupByLibrary.simpleMessage("Desbloquear dispositivo"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Dispositivo desconhecido"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Algoritmo de criptografia desconhecido"),
        "unlockOldMessages": MessageLookupByLibrary.simpleMessage(
            "Destrancar mensagens antigas"),
        "unmuteChat":
            MessageLookupByLibrary.simpleMessage("Cancelar silenciamento"),
        "unpin": MessageLookupByLibrary.simpleMessage("Desalfinetar"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Desinscrever de painéis"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Versão Android não suportada"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Esta funcionalidade requer uma versão mais nova do Android. Por favor, busque atualizações ou suporte ao Lineage OS."),
        "unverified": MessageLookupByLibrary.simpleMessage("Não verificado"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "Atualização do FluffyChat disponível"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Iniciar atualização nos bastidores"),
        "user": MessageLookupByLibrary.simpleMessage("Usuário"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username": MessageLookupByLibrary.simpleMessage("Nome de usuário"),
        "users": MessageLookupByLibrary.simpleMessage("Usuários"),
        "verified": MessageLookupByLibrary.simpleMessage("Verificado"),
        "verify": MessageLookupByLibrary.simpleMessage("Verificar"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Iniciar verificação"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Verificação efetivada!"),
        "verifyTitle":
            MessageLookupByLibrary.simpleMessage("Verificando outra conta"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Vídeochamada"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Por favor, note que chamadas de vídeo estão atualmente em teste. Podem não funcionar como esperado ou sequer funcionar em algumas plataformas."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Visibilidade do histórico da conversa"),
        "visibleForAllParticipants":
            MessageLookupByLibrary.simpleMessage("Visível aos participantes"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Visível a qualquer pessoa"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Chamada de voz"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Mensagem de voz"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "Esperando que a outra pessoa aceite a solicitação…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "Esperando que a outra pessoa aceite os emoji…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "Aguardando a outra pessoa aceitar os números…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Pano de fundo"),
        "warning": MessageLookupByLibrary.simpleMessage("Atenção!"),
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "Enviamos um e-mail para você"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("O que está acontecendo?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Quem pode desempenhar quais ações"),
        "whoCanSeeMyStories":
            MessageLookupByLibrary.simpleMessage("Quem pode ver meu painel?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Por favor, note que pessoas podem ver e contactar umas às outras no seu painel."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Quais pessoas são permitidas participar deste grupo"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Por que você quer denunciar isto?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "Por que esta mensagem está ilegível?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Personalizado"),
        "widgetEtherpad": MessageLookupByLibrary.simpleMessage("Anotação"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Nome"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage(
            "Por favor, forneça um nome de exibição."),
        "widgetUrlError":
            MessageLookupByLibrary.simpleMessage("Isto não é uma URL válida."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Vídeo"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Limpar o backup da conversa para criar uma nova chave de recuperação?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Você pode recuperar a sua senha com estes endereços."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Escreva uma mensagem…"),
        "yes": MessageLookupByLibrary.simpleMessage("Sim"),
        "you": MessageLookupByLibrary.simpleMessage("Você"),
        "youAcceptedTheInvitation":
            MessageLookupByLibrary.simpleMessage("👍 Você aceitou o convite"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Você foi convidada(o) a esta conversa"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Você não está mais participando desta conversa"),
        "youBannedUser": m77,
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "Você não pode se autoconvidar"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Você foi banido desta conversa"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat":
            MessageLookupByLibrary.simpleMessage("Você entrou na conversa"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation":
            MessageLookupByLibrary.simpleMessage("Você rejeitou o convite"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Seu backup de conversas foi configurado."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Sua chave pública"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Seu painel")
      };
}
