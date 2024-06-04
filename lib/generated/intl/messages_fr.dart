// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(username) => "👍 ${username} a accepté l\'invitation";

  static String m1(username) =>
      "🔐 ${username} a activé le chiffrement de bout en bout";

  static String m2(senderName) => "${senderName} a répondu à l\'appel";

  static String m3(username) =>
      "Accepter cette demande de vérification de la part de ${username} ?";

  static String m4(username, targetName) => "${username} a banni ${targetName}";

  static String m5(uri) => "Impossible d\'ouvrir l\'URI ${uri}";

  static String m6(username) =>
      "${username} a changé l\'image de la discussion";

  static String m7(username, description) =>
      "${username} a changé la description de la discussion en : \'${description}\'";

  static String m8(username, chatname) =>
      "${username} a renommé la discussion en : \'${chatname}\'";

  static String m9(username) =>
      "${username} a changé les permissions de la discussion";

  static String m10(username, displayname) =>
      "${username} a changé son nom en : \'${displayname}\'";

  static String m11(username) =>
      "${username} a changé les règles d\'accès à la discussion pour les invités";

  static String m12(username, rules) =>
      "${username} a changé les règles d\'accès à la discussion pour les invités en : ${rules}";

  static String m13(username) =>
      "${username} a changé la visibilité de l\'historique de la discussion";

  static String m14(username, rules) =>
      "${username} a changé la visibilité de l\'historique de la discussion en : ${rules}";

  static String m15(username) =>
      "${username} a changé les règles d\'accès à la discussion";

  static String m16(username, joinRules) =>
      "${username} a changé les règles d\'accès à la discussion en : ${joinRules}";

  static String m17(username) => "${username} a changé son avatar";

  static String m18(username) => "${username} a changé les adresses du salon";

  static String m19(username) => "${username} a changé le lien d\'invitation";

  static String m20(command) => "${command} n\'est pas une commande.";

  static String m21(error) => "Impossible de déchiffrer le message : ${error}";

  static String m22(count) => "${count} fichiers";

  static String m23(count) => "${count} participant(s)";

  static String m24(username) => "💬 ${username} a créé la discussion";

  static String m25(senderName) => "${senderName} vous fait un câlin";

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}/${month}/${year}";

  static String m28(month, day) => "${day}/${month}";

  static String m29(senderName) => "${senderName} a mis fin à l\'appel";

  static String m30(error) =>
      "Erreur lors de l\'obtention de la localisation : ${error}";

  static String m31(path) => "Le fichier a été enregistré dans ${path}";

  static String m32(senderName) =>
      "${senderName} vous envoie des yeux écarquillés";

  static String m33(displayname) => "Groupe avec ${displayname}";

  static String m34(username, targetName) =>
      "${username} a annulé l\'invitation de ${targetName}";

  static String m35(senderName) => "${senderName} vous fait une accolade";

  static String m36(groupName) => "Inviter un contact dans ${groupName}";

  static String m37(username, link) =>
      "${username} vous a invité·e sur FluffyChat. \n1. Installez FluffyChat : https://fluffychat.im \n2. Inscrivez-vous ou connectez-vous \n3. Ouvrez le lien d\'invitation : ${link}";

  static String m38(username, targetName) =>
      "📩 ${username} a invité ${targetName}";

  static String m39(username) => "👋 ${username} a rejoint la discussion";

  static String m40(username, targetName) =>
      "👞 ${username} a expulsé ${targetName}";

  static String m41(username, targetName) =>
      "🙅 ${username} a expulsé et banni ${targetName}";

  static String m42(localizedTimeShort) =>
      "Vu·e pour la dernière fois : ${localizedTimeShort}";

  static String m43(count) => "Charger ${count} participant·es de plus";

  static String m44(homeserver) => "Se connecter à ${homeserver}";

  static String m45(server1, server2) =>
      "${server1} n\'est pas un serveur Matrix, souhaitez-vous utiliser ${server2} à la place ?";

  static String m46(number) => "${number} discussions";

  static String m47(count) => "${count} utilisateur·ices écrivent…";

  static String m48(fileName) => "Lire ${fileName}";

  static String m49(min) => "Veuillez choisir au moins ${min} caractères.";

  static String m50(sender, reaction) => "${sender} a réagi avec ${reaction}";

  static String m51(username) => "${username} a supprimé un évènement";

  static String m52(username) => "${username} a refusé l\'invitation";

  static String m53(username) => "Supprimé par ${username}";

  static String m54(username) => "Vu par ${username}";

  static String m55(username, count) =>
      "${Intl.plural(count, other: 'Vu par ${username} et ${count} autres')}";

  static String m56(username, username2) =>
      "Vu par ${username} et ${username2}";

  static String m57(username) => "📁 ${username} a envoyé un fichier";

  static String m58(username) => "🖼️ ${username} a envoyé une image";

  static String m59(username) => "😊 ${username} a envoyé un autocollant";

  static String m60(username) => "🎥 ${username} a envoyé une vidéo";

  static String m61(username) => "🎤 ${username} a envoyé un fichier audio";

  static String m62(senderName) =>
      "${senderName} a envoyé des informations sur l\'appel";

  static String m63(username) => "${username} a partagé sa position";

  static String m64(senderName) => "${senderName} a démarré un appel";

  static String m65(date, body) => "Story du ${date} : \n${body}";

  static String m66(mxid) => "Cela devrait être ${mxid}";

  static String m67(number) => "Passer au compte ${number}";

  static String m68(username, targetName) =>
      "${username} a annulé le bannissement de ${targetName}";

  static String m69(unreadCount) =>
      "${Intl.plural(unreadCount, one: '1 discussion non lue', other: '${unreadCount} discussions non lues')}";

  static String m70(username, count) =>
      "${username} et ${count} autres sont en train d\'écrire…";

  static String m71(username, username2) =>
      "${username} et ${username2} sont en train d\'écrire…";

  static String m72(username) => "${username} est en train d\'écrire…";

  static String m73(username) => "🚪 ${username} a quitté la discussion";

  static String m74(username, type) =>
      "${username} a envoyé un évènement de type ${type}";

  static String m75(size) => "Vidéo (${size})";

  static String m76(oldDisplayName) =>
      "Discussion vide (était ${oldDisplayName})";

  static String m77(user) => "Vous avez banni ${user}";

  static String m78(user) => "Vous avez retiré l\'invitation pour ${user}";

  static String m79(user) => "📩 Vous avez été invité par ${user}";

  static String m80(user) => "📩 Vous avez invité ${user}";

  static String m81(user) => "👞 Vous avez dégagé ${user}";

  static String m82(user) => "🙅 Vous avez dégagé et banni ${user}";

  static String m83(user) => "Vous avez débanni ${user}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("À propos"),
        "accept": MessageLookupByLibrary.simpleMessage("Accepter"),
        "acceptedTheInvitation": m0,
        "account": MessageLookupByLibrary.simpleMessage("Compte"),
        "activatedEndToEndEncryption": m1,
        "addAccount": MessageLookupByLibrary.simpleMessage("Ajouter un compte"),
        "addDescription":
            MessageLookupByLibrary.simpleMessage("Ajouter une description"),
        "addEmail": MessageLookupByLibrary.simpleMessage("Ajouter un courriel"),
        "addGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Ajouter une description au groupe"),
        "addToBundle":
            MessageLookupByLibrary.simpleMessage("Ajouter au groupe"),
        "addToSpace":
            MessageLookupByLibrary.simpleMessage("Ajouter à l\'espace"),
        "addToSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Sélectionnez un espace pour y ajouter cette discussion."),
        "addToStory":
            MessageLookupByLibrary.simpleMessage("Ajouter à la story"),
        "addWidget": MessageLookupByLibrary.simpleMessage("Ajouter un widget"),
        "admin": MessageLookupByLibrary.simpleMessage("Administrateur"),
        "alias": MessageLookupByLibrary.simpleMessage("adresse"),
        "all": MessageLookupByLibrary.simpleMessage("Tout"),
        "allChats":
            MessageLookupByLibrary.simpleMessage("Toutes les discussions"),
        "allSpaces": MessageLookupByLibrary.simpleMessage("Tous les espaces"),
        "answeredTheCall": m2,
        "anyoneCanJoin": MessageLookupByLibrary.simpleMessage(
            "Tout le monde peut rejoindre"),
        "appLock": MessageLookupByLibrary.simpleMessage(
            "Verrouillage de l’application"),
        "appearOnTop":
            MessageLookupByLibrary.simpleMessage("Apparaître en haut"),
        "appearOnTopDetails": MessageLookupByLibrary.simpleMessage(
            "Permet à l\'application d\'apparaître en haut de l\'écran (non nécessaire si vous avez déjà configuré Fluffychat comme compte d\'appel)"),
        "archive": MessageLookupByLibrary.simpleMessage("Archiver"),
        "areGuestsAllowedToJoin": MessageLookupByLibrary.simpleMessage(
            "Les invités peuvent-i·e·ls rejoindre"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Êtes-vous sûr·e ?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment vous déconnecter ?"),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Pour pouvoir faire signer l\'autre personne, veuillez entrer la phrase de passe de votre trousseau sécurisé ou votre clé de récupération."),
        "askVerificationRequest": m3,
        "autoplayImages": MessageLookupByLibrary.simpleMessage(
            "Lire automatiquement les autocollants et les émojis animés"),
        "banFromChat":
            MessageLookupByLibrary.simpleMessage("Bannir de la discussion"),
        "banned": MessageLookupByLibrary.simpleMessage("Banni"),
        "bannedUser": m4,
        "blockDevice":
            MessageLookupByLibrary.simpleMessage("Bloquer l\'appareil"),
        "blocked": MessageLookupByLibrary.simpleMessage("Bloqué"),
        "botMessages": MessageLookupByLibrary.simpleMessage("Messages de bot"),
        "bubbleSize":
            MessageLookupByLibrary.simpleMessage("Taille de la bulle"),
        "bundleName": MessageLookupByLibrary.simpleMessage("Nom du groupe"),
        "callingAccount":
            MessageLookupByLibrary.simpleMessage("Compte d\'appel"),
        "callingAccountDetails": MessageLookupByLibrary.simpleMessage(
            "Permet à FluffyChat d\'utiliser l\'application de numérotation native d\'Android."),
        "callingPermissions":
            MessageLookupByLibrary.simpleMessage("Permissions d\'appel"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "cantOpenUri": m5,
        "changeDeviceName": MessageLookupByLibrary.simpleMessage(
            "Modifier le nom de l\'appareil"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Changer de mot de passe"),
        "changeTheHomeserver": MessageLookupByLibrary.simpleMessage(
            "Changer le serveur d\'accueil"),
        "changeTheNameOfTheGroup":
            MessageLookupByLibrary.simpleMessage("Changer le nom du groupe"),
        "changeTheme":
            MessageLookupByLibrary.simpleMessage("Changez votre style"),
        "changeWallpaper":
            MessageLookupByLibrary.simpleMessage("Changer l\'image de fond"),
        "changeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Changer votre avatar"),
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
            "Le chiffrement a été corrompu"),
        "chat": MessageLookupByLibrary.simpleMessage("Discussion"),
        "chatBackup":
            MessageLookupByLibrary.simpleMessage("Sauvegarde des discussions"),
        "chatBackupDescription": MessageLookupByLibrary.simpleMessage(
            "Vos anciens messages sont sécurisés par une clé de récupération. Veillez à ne pas la perdre."),
        "chatDetails":
            MessageLookupByLibrary.simpleMessage("Détails de la discussion"),
        "chatHasBeenAddedToThisSpace": MessageLookupByLibrary.simpleMessage(
            "La discussion a été ajoutée à cet espace"),
        "chats": MessageLookupByLibrary.simpleMessage("Discussions"),
        "chooseAStrongPassword": MessageLookupByLibrary.simpleMessage(
            "Choisissez un mot de passe fort"),
        "chooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Choisissez un nom d\'utilisateur·ice"),
        "clearArchive":
            MessageLookupByLibrary.simpleMessage("Effacer les archives"),
        "close": MessageLookupByLibrary.simpleMessage("Fermer"),
        "commandHint_ban": MessageLookupByLibrary.simpleMessage(
            "Bannir l\'utilisateur/trice donné(e) de ce salon"),
        "commandHint_clearcache":
            MessageLookupByLibrary.simpleMessage("Vider le cache"),
        "commandHint_create": MessageLookupByLibrary.simpleMessage(
            "Créer un groupe de discussion vide\nUtilisez --no-encryption pour désactiver le chiffrement"),
        "commandHint_cuddle":
            MessageLookupByLibrary.simpleMessage("Envoyer un câlin"),
        "commandHint_discardsession":
            MessageLookupByLibrary.simpleMessage("Abandonner la session"),
        "commandHint_dm": MessageLookupByLibrary.simpleMessage(
            "Commencer une discussion directe\nUtilisez --no-encryption pour désactiver le chiffrement"),
        "commandHint_googly": MessageLookupByLibrary.simpleMessage(
            "Envoyer des yeux écarquillés"),
        "commandHint_html": MessageLookupByLibrary.simpleMessage(
            "Envoyer du texte au format HTML"),
        "commandHint_hug":
            MessageLookupByLibrary.simpleMessage("Envoyer une accolade"),
        "commandHint_invite": MessageLookupByLibrary.simpleMessage(
            "Inviter l\'utilisateur/trice donné(e) dans ce salon"),
        "commandHint_join":
            MessageLookupByLibrary.simpleMessage("Rejoindre le salon donné"),
        "commandHint_kick": MessageLookupByLibrary.simpleMessage(
            "Supprime l\'utilisateur/trice donné(e) de ce salon"),
        "commandHint_leave":
            MessageLookupByLibrary.simpleMessage("Quitter ce salon"),
        "commandHint_markasdm": MessageLookupByLibrary.simpleMessage(
            "Marquer comme salon de messagerie directe"),
        "commandHint_markasgroup":
            MessageLookupByLibrary.simpleMessage("Marquer comme groupe"),
        "commandHint_me": MessageLookupByLibrary.simpleMessage("Décrivez-vous"),
        "commandHint_myroomavatar": MessageLookupByLibrary.simpleMessage(
            "Définir votre image pour ce salon (par mxc-uri)"),
        "commandHint_myroomnick": MessageLookupByLibrary.simpleMessage(
            "Définir votre nom d\'affichage pour ce salon"),
        "commandHint_op": MessageLookupByLibrary.simpleMessage(
            "Définir le niveau de puissance de l\'utilisateur/trice donné(e) (par défaut : 50)"),
        "commandHint_plain": MessageLookupByLibrary.simpleMessage(
            "Envoyer du texte non formaté"),
        "commandHint_react": MessageLookupByLibrary.simpleMessage(
            "Envoyer une réponse en tant que réaction"),
        "commandHint_send":
            MessageLookupByLibrary.simpleMessage("Envoyer du texte"),
        "commandHint_unban": MessageLookupByLibrary.simpleMessage(
            "Débannir l\'utilisateur/trice donné(e) de ce salon"),
        "commandInvalid":
            MessageLookupByLibrary.simpleMessage("Commande invalide"),
        "commandMissing": m20,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Veuillez comparer les émojis"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Veuillez comparer les chiffres"),
        "configureChat":
            MessageLookupByLibrary.simpleMessage("Configurer la discussion"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmer"),
        "confirmEventUnpin": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment désépingler définitivement l\'événement ?"),
        "confirmMatrixId": MessageLookupByLibrary.simpleMessage(
            "Veuillez confirmer votre identifiant Matrix afin de supprimer votre compte."),
        "connect": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "contactHasBeenInvitedToTheGroup": MessageLookupByLibrary.simpleMessage(
            "Le contact a été invité au groupe"),
        "containsDisplayName": MessageLookupByLibrary.simpleMessage(
            "Contient un nom d\'affichage"),
        "containsUserName": MessageLookupByLibrary.simpleMessage(
            "Contient un nom d\'utilisateur·ice"),
        "contentHasBeenReported": MessageLookupByLibrary.simpleMessage(
            "Le contenu a été signalé aux administrateurs du serveur"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Copié dans le presse-papier"),
        "copy": MessageLookupByLibrary.simpleMessage("Copier"),
        "copyToClipboard": MessageLookupByLibrary.simpleMessage(
            "Copier dans le presse-papiers"),
        "couldNotDecryptMessage": m21,
        "countFiles": m22,
        "countParticipants": m23,
        "create": MessageLookupByLibrary.simpleMessage("Créer"),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Créer un nouveau groupe"),
        "createNewSpace": MessageLookupByLibrary.simpleMessage("Nouvel espace"),
        "createdTheChat": m24,
        "cuddleContent": m25,
        "currentlyActive":
            MessageLookupByLibrary.simpleMessage("Actif en ce moment"),
        "custom": MessageLookupByLibrary.simpleMessage("Personnalisé"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Sombre"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "deactivateAccountWarning": MessageLookupByLibrary.simpleMessage(
            "Cette opération va désactiver votre compte. Une fois cette action effectuée, aucun retour en arrière n\'est possible ! Êtes-vous sûr·e ?"),
        "defaultPermissionLevel": MessageLookupByLibrary.simpleMessage(
            "Niveau d\'autorisation par défaut"),
        "dehydrate": MessageLookupByLibrary.simpleMessage(
            "Exporter la session et effacer l\'appareil"),
        "dehydrateTor": MessageLookupByLibrary.simpleMessage(
            "Utilisateurs/trices de TOR : Exporter la session"),
        "dehydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Pour les utilisateurs/trices de TOR, il est recommandé d\'exporter la session avant de fermer la fenêtre."),
        "dehydrateWarning": MessageLookupByLibrary.simpleMessage(
            "Cette action ne peut pas être annulée. Assurez-vous d\'enregistrer convenablement le fichier de sauvegarde."),
        "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Supprimer le compte"),
        "deleteMessage":
            MessageLookupByLibrary.simpleMessage("Supprimer le message"),
        "deny": MessageLookupByLibrary.simpleMessage("Refuser"),
        "device": MessageLookupByLibrary.simpleMessage("Appareil"),
        "deviceId":
            MessageLookupByLibrary.simpleMessage("Identifiant de l\'appareil"),
        "deviceKeys":
            MessageLookupByLibrary.simpleMessage("Clés de l’appareil :"),
        "devices": MessageLookupByLibrary.simpleMessage("Appareils"),
        "directChats":
            MessageLookupByLibrary.simpleMessage("Discussions directes"),
        "disableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Pour des raisons de sécurité, vous ne pouvez pas désactiver le chiffrement dans une discussion s\'il a été activé avant."),
        "dismiss": MessageLookupByLibrary.simpleMessage("Rejeter"),
        "displaynameHasBeenChanged":
            MessageLookupByLibrary.simpleMessage("Renommage effectué"),
        "doNotShowAgain":
            MessageLookupByLibrary.simpleMessage("Ne plus afficher"),
        "downloadFile":
            MessageLookupByLibrary.simpleMessage("Télécharger le fichier"),
        "edit": MessageLookupByLibrary.simpleMessage("Modifier"),
        "editBlockedServers": MessageLookupByLibrary.simpleMessage(
            "Modifier les serveurs bloqués"),
        "editBundlesForAccount": MessageLookupByLibrary.simpleMessage(
            "Modifier les groupes pour ce compte"),
        "editChatPermissions": MessageLookupByLibrary.simpleMessage(
            "Modifier les permissions de la discussion"),
        "editDisplayname":
            MessageLookupByLibrary.simpleMessage("Changer de nom d\'affichage"),
        "editRoomAliases": MessageLookupByLibrary.simpleMessage(
            "Modifier les adresses du salon"),
        "editRoomAvatar":
            MessageLookupByLibrary.simpleMessage("Modifier l\'avatar du salon"),
        "editWidgets":
            MessageLookupByLibrary.simpleMessage("Modifier les widgets"),
        "emailOrUsername":
            MessageLookupByLibrary.simpleMessage("Courriel ou identifiant"),
        "emojis": MessageLookupByLibrary.simpleMessage("Émojis"),
        "emoteExists": MessageLookupByLibrary.simpleMessage(
            "Cette émoticône existe déjà !"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Raccourci d\'émoticône invalide !"),
        "emotePacks": MessageLookupByLibrary.simpleMessage(
            "Packs d\'émoticônes pour le salon"),
        "emoteSettings":
            MessageLookupByLibrary.simpleMessage("Paramètre des émoticônes"),
        "emoteShortcode":
            MessageLookupByLibrary.simpleMessage("Raccourci de l\'émoticône"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Vous devez sélectionner un raccourci d\'émoticône et une image !"),
        "emptyChat": MessageLookupByLibrary.simpleMessage("Discussion vide"),
        "enableEmotesGlobally": MessageLookupByLibrary.simpleMessage(
            "Activer globalement le pack d\'émoticônes"),
        "enableEncryption":
            MessageLookupByLibrary.simpleMessage("Activer le chiffrement"),
        "enableEncryptionWarning": MessageLookupByLibrary.simpleMessage(
            "Vous ne pourrez plus désactiver le chiffrement. Êtes-vous sûr(e) ?"),
        "enableMultiAccounts": MessageLookupByLibrary.simpleMessage(
            "(BETA) Activer les comptes multiples sur cet appareil"),
        "encryptThisChat":
            MessageLookupByLibrary.simpleMessage("Chiffrer cette discussion"),
        "encrypted": MessageLookupByLibrary.simpleMessage("Chiffré"),
        "encryption": MessageLookupByLibrary.simpleMessage("Chiffrement"),
        "encryptionNotEnabled": MessageLookupByLibrary.simpleMessage(
            "Le chiffrement n\'est pas activé"),
        "endToEndEncryption":
            MessageLookupByLibrary.simpleMessage("Chiffrement de bout en bout"),
        "endedTheCall": m29,
        "enterAGroupName":
            MessageLookupByLibrary.simpleMessage("Entrez un nom de groupe"),
        "enterASpacepName":
            MessageLookupByLibrary.simpleMessage("Entrer un nom d\'espace"),
        "enterAnEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Saisissez une adresse de courriel"),
        "enterInviteLinkOrMatrixId": MessageLookupByLibrary.simpleMessage(
            "Entrez le lien d\'invitation ou l\'ID Matrix..."),
        "enterRoom":
            MessageLookupByLibrary.simpleMessage("Entrer dans le salon"),
        "enterSpace":
            MessageLookupByLibrary.simpleMessage("Entrer dans l’espace"),
        "enterYourHomeserver": MessageLookupByLibrary.simpleMessage(
            "Renseignez votre serveur d\'accueil"),
        "errorAddingWidget": MessageLookupByLibrary.simpleMessage(
            "Erreur lors de l\'ajout du widget."),
        "errorObtainingLocation": m30,
        "everythingReady":
            MessageLookupByLibrary.simpleMessage("Tout est prêt !"),
        "experimentalVideoCalls":
            MessageLookupByLibrary.simpleMessage("Appels vidéo expérimentaux"),
        "extremeOffensive":
            MessageLookupByLibrary.simpleMessage("Extrêmement offensant"),
        "fileHasBeenSavedAt": m31,
        "fileIsTooBigForServer": MessageLookupByLibrary.simpleMessage(
            "Le serveur signale que le fichier est trop volumineux pour être envoyé."),
        "fileName": MessageLookupByLibrary.simpleMessage("Nom du ficher"),
        "fluffychat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "fontSize": MessageLookupByLibrary.simpleMessage("Taille de la police"),
        "foregroundServiceRunning": MessageLookupByLibrary.simpleMessage(
            "Cette notification s’affiche lorsque le service au premier plan est en cours d’exécution."),
        "forward": MessageLookupByLibrary.simpleMessage("Transférer"),
        "fromJoining": MessageLookupByLibrary.simpleMessage(
            "À partir de l\'entrée dans le salon"),
        "fromTheInvitation":
            MessageLookupByLibrary.simpleMessage("À partir de l\'invitation"),
        "goToTheNewRoom":
            MessageLookupByLibrary.simpleMessage("Aller dans le nouveau salon"),
        "googlyEyesContent": m32,
        "group": MessageLookupByLibrary.simpleMessage("Groupe"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Description du groupe"),
        "groupDescriptionHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "La description du groupe a été modifiée"),
        "groupIsPublic":
            MessageLookupByLibrary.simpleMessage("Le groupe est public"),
        "groupWith": m33,
        "groups": MessageLookupByLibrary.simpleMessage("Groupes"),
        "guestsAreForbidden": MessageLookupByLibrary.simpleMessage(
            "Les invités ne peuvent pas rejoindre"),
        "guestsCanJoin": MessageLookupByLibrary.simpleMessage(
            "Les invités peuvent rejoindre"),
        "hasWithdrawnTheInvitationFor": m34,
        "help": MessageLookupByLibrary.simpleMessage("Aide"),
        "hideRedactedEvents": MessageLookupByLibrary.simpleMessage(
            "Cacher les évènements supprimés"),
        "hideUnimportantStateEvents": MessageLookupByLibrary.simpleMessage(
            "Masquer les événements d\'état sans importance"),
        "hideUnknownEvents": MessageLookupByLibrary.simpleMessage(
            "Cacher les évènements inconnus"),
        "homeserver":
            MessageLookupByLibrary.simpleMessage("Serveur d\'accueil"),
        "howOffensiveIsThisContent": MessageLookupByLibrary.simpleMessage(
            "À quel point ce contenu est-il offensant ?"),
        "hugContent": m35,
        "hydrate": MessageLookupByLibrary.simpleMessage(
            "Restaurer à partir du fichier de sauvegarde"),
        "hydrateTor": MessageLookupByLibrary.simpleMessage(
            "Utilisateurs/trices de TOR : Importer une session exportée"),
        "hydrateTorLong": MessageLookupByLibrary.simpleMessage(
            "Vous avez exporté votre session la dernière fois sur TOR ? Importez-la rapidement et continuez à discuter."),
        "iHaveClickedOnLink":
            MessageLookupByLibrary.simpleMessage("J\'ai cliqué sur le lien"),
        "iUnderstand": MessageLookupByLibrary.simpleMessage("Je comprends"),
        "id": MessageLookupByLibrary.simpleMessage("Identifiant"),
        "identity": MessageLookupByLibrary.simpleMessage("Identité"),
        "ignore": MessageLookupByLibrary.simpleMessage("Ignorer"),
        "ignoreListDescription": MessageLookupByLibrary.simpleMessage(
            "Vous pouvez ignorer les utilisateur·ices qui vous dérangent en les mettant dans votre liste à ignorer personnelle. Vous ne recevrez plus de messages ou d\'invitations à participer à un salon de discussion de la part des utilisateur·ices figurant sur cette liste."),
        "ignoreUsername":
            MessageLookupByLibrary.simpleMessage("Ignorer l\'utilisateur·ice"),
        "ignoredUsers":
            MessageLookupByLibrary.simpleMessage("Utilisateur·ices ignoré·es"),
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Phrase de passe ou clé de récupération incorrecte"),
        "indexedDbErrorLong": MessageLookupByLibrary.simpleMessage(
            "Le stockage des messages n\'est malheureusement pas activé par défaut en mode privé.\nVeuillez consulter :\n - about:config\n - Définir dom.indexedDB.privateBrowsing.enabled à « vrai ».\nSinon, il n\'est pas possible d\'exécuter FluffyChat."),
        "indexedDbErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Problèmes relatifs au mode privé"),
        "inoffensive": MessageLookupByLibrary.simpleMessage("Non offensant"),
        "inviteContact":
            MessageLookupByLibrary.simpleMessage("Inviter un contact"),
        "inviteContactToGroup": m36,
        "inviteForMe": MessageLookupByLibrary.simpleMessage("Inviter pour moi"),
        "inviteText": m37,
        "invited": MessageLookupByLibrary.simpleMessage("Invité·e"),
        "invitedUser": m38,
        "invitedUsersOnly": MessageLookupByLibrary.simpleMessage(
            "Uniquement les utilisateur·ices invité·es"),
        "isTyping":
            MessageLookupByLibrary.simpleMessage("est en train d\'écrire…"),
        "joinRoom": MessageLookupByLibrary.simpleMessage("Rejoindre le salon"),
        "joinedTheChat": m39,
        "jumpToLastReadMessage":
            MessageLookupByLibrary.simpleMessage("Aller au dernier message lu"),
        "kickFromChat":
            MessageLookupByLibrary.simpleMessage("Expulser de la discussion"),
        "kicked": m40,
        "kickedAndBanned": m41,
        "lastActiveAgo": m42,
        "lastSeenLongTimeAgo": MessageLookupByLibrary.simpleMessage(
            "Vu pour la dernière fois il y a longtemps"),
        "leave": MessageLookupByLibrary.simpleMessage("Partir"),
        "leftTheChat":
            MessageLookupByLibrary.simpleMessage("A quitté la discussion"),
        "letsStart": MessageLookupByLibrary.simpleMessage("C\'est parti"),
        "license": MessageLookupByLibrary.simpleMessage("Licence"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Clair"),
        "link": MessageLookupByLibrary.simpleMessage("Lien"),
        "loadCountMoreParticipants": m43,
        "loadMore": MessageLookupByLibrary.simpleMessage("Charger plus…"),
        "loadingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Chargement… Veuillez patienter."),
        "locationDisabledNotice": MessageLookupByLibrary.simpleMessage(
            "Les services de localisation sont désactivés. Il est nécessaire de les activer avant de pouvoir partager votre localisation."),
        "locationPermissionDeniedNotice": MessageLookupByLibrary.simpleMessage(
            "L\'application n\'a pas la permission d\'accéder à votre localisation. Merci de l\'accorder afin de pouvoir partager votre localisation."),
        "logInTo": m44,
        "login": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "loginWithOneClick":
            MessageLookupByLibrary.simpleMessage("Se connecter en un clic"),
        "logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
        "makeSureTheIdentifierIsValid": MessageLookupByLibrary.simpleMessage(
            "Vérifiez que l\'identifiant est valide"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Marquer comme lu"),
        "matrixWidgets": MessageLookupByLibrary.simpleMessage("Widgets Matrix"),
        "memberChanges":
            MessageLookupByLibrary.simpleMessage("Changements de membres"),
        "mention": MessageLookupByLibrary.simpleMessage("Mentionner"),
        "messageInfo":
            MessageLookupByLibrary.simpleMessage("Informations sur le message"),
        "messageType": MessageLookupByLibrary.simpleMessage("Type de message"),
        "messageWillBeRemovedWarning": MessageLookupByLibrary.simpleMessage(
            "Le message sera supprimé pour tous les participants"),
        "messages": MessageLookupByLibrary.simpleMessage("Messages"),
        "moderator": MessageLookupByLibrary.simpleMessage("Modérateur·rice"),
        "muteChat": MessageLookupByLibrary.simpleMessage(
            "Mettre la discussion en sourdine"),
        "needPantalaimonWarning": MessageLookupByLibrary.simpleMessage(
            "Pour l\'instant, vous avez besoin de Pantalaimon pour utiliser le chiffrement de bout en bout."),
        "newChat": MessageLookupByLibrary.simpleMessage("Nouvelle discussion"),
        "newGroup": MessageLookupByLibrary.simpleMessage("Nouveau groupe"),
        "newMessageInFluffyChat": MessageLookupByLibrary.simpleMessage(
            "💬 Nouveau message dans FluffyChat"),
        "newSpace": MessageLookupByLibrary.simpleMessage("Nouvel espace"),
        "newSpaceDescription": MessageLookupByLibrary.simpleMessage(
            "Les espaces vous permettent de consolider vos conversations et de construire des communautés privées ou publiques."),
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "Nouvelle demande de vérification !"),
        "next": MessageLookupByLibrary.simpleMessage("Suivant"),
        "nextAccount": MessageLookupByLibrary.simpleMessage("Compte suivant"),
        "no": MessageLookupByLibrary.simpleMessage("Non"),
        "noBackupWarning": MessageLookupByLibrary.simpleMessage(
            "Attention ! Sans l\'activation de la sauvegarde de la discussion, vous perdrez l\'accès à vos messages chiffrés. Il est fortement recommandé d\'activer la sauvegarde de la discussion avant de se déconnecter."),
        "noConnectionToTheServer":
            MessageLookupByLibrary.simpleMessage("Aucune connexion au serveur"),
        "noEmailWarning": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir une adresse électronique valide. Sinon, vous ne pourrez pas réinitialiser votre mot de passe. Si vous ne voulez pas le faire, appuyez à nouveau sur le bouton pour continuer."),
        "noEmotesFound": MessageLookupByLibrary.simpleMessage(
            "Aucune émoticône trouvée. 😕"),
        "noEncryptionForPublicRooms": MessageLookupByLibrary.simpleMessage(
            "Vous pouvez activer le chiffrement seulement quand le salon n\'est plus accessible au public."),
        "noGoogleServicesWarning": MessageLookupByLibrary.simpleMessage(
            "Il semble que vous n\'ayez aucun service Google sur votre téléphone. C\'est une bonne décision pour votre vie privée ! Pour recevoir des notifications dans FluffyChat, nous vous recommandons d\'utiliser https://microg.org/ ou https://unifiedpush.org/."),
        "noKeyForThisMessage": MessageLookupByLibrary.simpleMessage(
            "Cela peut se produire si le message a été envoyé avant que vous ne vous soyez connecté à votre compte sur cet appareil.\n\nIl est également possible que l\'expéditeur ait bloqué votre appareil ou qu\'un problème de connexion Internet se soit produit.\n\nÊtes-vous capable de lire le message sur une autre session ? Vous pouvez alors transférer le message à partir de celle-ci ! Allez dans Paramètres > Appareils et assurez-vous que vos appareils se sont vérifiés mutuellement. Lorsque vous ouvrirez le salon la fois suivante et que les deux sessions seront au premier plan, les clés seront transmises automatiquement.\n\nVous ne voulez pas perdre les clés en vous déconnectant ou en changeant d\'appareil ? Assurez-vous que vous avez activé la sauvegarde de la discussion dans les paramètres."),
        "noMatrixServer": m45,
        "noOtherDevicesFound":
            MessageLookupByLibrary.simpleMessage("Aucun autre appareil trouvé"),
        "noPasswordRecoveryDescription": MessageLookupByLibrary.simpleMessage(
            "Vous n\'avez pas encore ajouté de moyen pour récupérer votre mot de passe."),
        "noPermission":
            MessageLookupByLibrary.simpleMessage("Aucune permission"),
        "noRoomsFound":
            MessageLookupByLibrary.simpleMessage("Aucun salon trouvé…"),
        "none": MessageLookupByLibrary.simpleMessage("Aucun"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "notificationsEnabledForThisAccount":
            MessageLookupByLibrary.simpleMessage(
                "Notifications activées pour ce compte"),
        "numChats": m46,
        "numUsersTyping": m47,
        "obtainingLocation": MessageLookupByLibrary.simpleMessage(
            "Obtention de la localisation…"),
        "offensive": MessageLookupByLibrary.simpleMessage("Offensant"),
        "offline": MessageLookupByLibrary.simpleMessage("Hors ligne"),
        "ok": MessageLookupByLibrary.simpleMessage("Valider"),
        "oneClientLoggedOut": MessageLookupByLibrary.simpleMessage(
            "Un de vos clients a été déconnecté"),
        "online": MessageLookupByLibrary.simpleMessage("En ligne"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "La sauvegarde en ligne des clés est activée"),
        "oopsPushError": MessageLookupByLibrary.simpleMessage(
            "Oups ! Une erreur s\'est malheureusement produite lors du réglage des notifications."),
        "oopsSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "Oups, un problème est survenu…"),
        "openAppToReadMessages": MessageLookupByLibrary.simpleMessage(
            "Ouvrez l\'application pour lire le message"),
        "openCamera":
            MessageLookupByLibrary.simpleMessage("Ouvrir l\'appareil photo"),
        "openChat":
            MessageLookupByLibrary.simpleMessage("Ouvrir la discussion"),
        "openGallery":
            MessageLookupByLibrary.simpleMessage("Ouvrir dans la Galerie"),
        "openInMaps": MessageLookupByLibrary.simpleMessage("Ouvrir dans maps"),
        "openVideoCamera": MessageLookupByLibrary.simpleMessage(
            "Ouvrir la caméra pour une vidéo"),
        "optionalGroupName":
            MessageLookupByLibrary.simpleMessage("(Optionnel) Nom du groupe"),
        "or": MessageLookupByLibrary.simpleMessage("Ou"),
        "otherCallingPermissions": MessageLookupByLibrary.simpleMessage(
            "Microphone, caméra et autres autorisations de FluffyChat"),
        "participant": MessageLookupByLibrary.simpleMessage("Participant(e)"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Phrase de passe ou clé de récupération"),
        "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "passwordForgotten":
            MessageLookupByLibrary.simpleMessage("Mot de passe oublié"),
        "passwordHasBeenChanged": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe a été modifié"),
        "passwordRecovery": MessageLookupByLibrary.simpleMessage(
            "Récupération du mot de passe"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "Les mots de passe ne correspondent pas !"),
        "people": MessageLookupByLibrary.simpleMessage("Personnes"),
        "pickImage": MessageLookupByLibrary.simpleMessage("Choisir une image"),
        "pin": MessageLookupByLibrary.simpleMessage("Épingler"),
        "pinMessage": MessageLookupByLibrary.simpleMessage("Épingler au salon"),
        "placeCall": MessageLookupByLibrary.simpleMessage("Passer un appel"),
        "play": m48,
        "pleaseChoose":
            MessageLookupByLibrary.simpleMessage("Veuillez choisir"),
        "pleaseChooseAPasscode": MessageLookupByLibrary.simpleMessage(
            "Veuillez choisir un code d’accès"),
        "pleaseChooseAUsername": MessageLookupByLibrary.simpleMessage(
            "Choisissez un nom d\'utilisateur·ice"),
        "pleaseChooseAtLeastChars": m49,
        "pleaseClickOnLink": MessageLookupByLibrary.simpleMessage(
            "Veuillez cliquer sur le lien contenu dans le courriel puis continuez."),
        "pleaseEnter4Digits": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir 4 chiffres ou laisser vide pour désactiver le verrouillage de l’application."),
        "pleaseEnterAMatrixIdentifier": MessageLookupByLibrary.simpleMessage(
            "Renseignez un identifiant Matrix."),
        "pleaseEnterRecoveryKey": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir votre clé de récupération :"),
        "pleaseEnterRecoveryKeyDescription": MessageLookupByLibrary.simpleMessage(
            "Pour déverrouiller vos anciens messages, veuillez entrer votre clé de récupération qui a été générée lors d\'une session précédente. Votre clé de récupération n\'est PAS votre mot de passe."),
        "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir une adresse électronique valide."),
        "pleaseEnterYourPassword": MessageLookupByLibrary.simpleMessage(
            "Renseignez votre mot de passe"),
        "pleaseEnterYourPin": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir votre code PIN"),
        "pleaseEnterYourUsername": MessageLookupByLibrary.simpleMessage(
            "Renseignez votre nom d\'utilisateur·ice"),
        "pleaseFollowInstructionsOnWeb": MessageLookupByLibrary.simpleMessage(
            "Veuillez suivre les instructions sur le site et appuyer sur Suivant."),
        "previousAccount":
            MessageLookupByLibrary.simpleMessage("Compte précédent"),
        "privacy": MessageLookupByLibrary.simpleMessage("Vie privée"),
        "publicRooms": MessageLookupByLibrary.simpleMessage("Salons publics"),
        "publish": MessageLookupByLibrary.simpleMessage("Publier"),
        "pushRules":
            MessageLookupByLibrary.simpleMessage("Règles de notifications"),
        "reactedWith": m50,
        "readUpToHere": MessageLookupByLibrary.simpleMessage("Lisez jusqu’ici"),
        "reason": MessageLookupByLibrary.simpleMessage("Motif"),
        "recording": MessageLookupByLibrary.simpleMessage("Enregistrement"),
        "recoveryKey":
            MessageLookupByLibrary.simpleMessage("Clé de récupération"),
        "recoveryKeyLost": MessageLookupByLibrary.simpleMessage(
            "Clé de récupération perdue ?"),
        "redactMessage":
            MessageLookupByLibrary.simpleMessage("Supprimer un message"),
        "redactedAnEvent": m51,
        "register": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
        "reject": MessageLookupByLibrary.simpleMessage("Refuser"),
        "rejectedTheInvitation": m52,
        "rejoin": MessageLookupByLibrary.simpleMessage("Rejoindre de nouveau"),
        "remove": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "removeAllOtherDevices": MessageLookupByLibrary.simpleMessage(
            "Supprimer tous les autres appareils"),
        "removeDevice":
            MessageLookupByLibrary.simpleMessage("Supprimer l\'appareil"),
        "removeFromBundle":
            MessageLookupByLibrary.simpleMessage("Retirer de ce groupe"),
        "removeFromSpace":
            MessageLookupByLibrary.simpleMessage("Supprimer de l’espace"),
        "removeYourAvatar":
            MessageLookupByLibrary.simpleMessage("Supprimer votre avatar"),
        "removedBy": m53,
        "renderRichContent": MessageLookupByLibrary.simpleMessage(
            "Afficher les contenus riches des messages"),
        "reopenChat":
            MessageLookupByLibrary.simpleMessage("Rouvrir la discussion"),
        "repeatPassword":
            MessageLookupByLibrary.simpleMessage("Répétez le mot de passe"),
        "replaceRoomWithNewerVersion": MessageLookupByLibrary.simpleMessage(
            "Remplacer le salon par une nouvelle version"),
        "reply": MessageLookupByLibrary.simpleMessage("Répondre"),
        "replyHasBeenSent":
            MessageLookupByLibrary.simpleMessage("La réponse a été envoyée"),
        "reportMessage":
            MessageLookupByLibrary.simpleMessage("Signaler un message"),
        "reportUser": MessageLookupByLibrary.simpleMessage(
            "Signaler l\'utilisateur/trice"),
        "requestPermission":
            MessageLookupByLibrary.simpleMessage("Demander la permission"),
        "roomHasBeenUpgraded":
            MessageLookupByLibrary.simpleMessage("Le salon a été mis à niveau"),
        "roomVersion": MessageLookupByLibrary.simpleMessage("Version du salon"),
        "saveFile":
            MessageLookupByLibrary.simpleMessage("Enregistrer le fichier"),
        "saveKeyManuallyDescription": MessageLookupByLibrary.simpleMessage(
            "Enregistrer cette clé manuellement en déclenchant la boîte de dialogue de partage du système ou le presse-papiers."),
        "scanQrCode":
            MessageLookupByLibrary.simpleMessage("Scanner un code QR"),
        "screenSharingDetail": MessageLookupByLibrary.simpleMessage(
            "Vous partagez votre écran dans FuffyChat"),
        "screenSharingTitle":
            MessageLookupByLibrary.simpleMessage("Partage d\'écran"),
        "search": MessageLookupByLibrary.simpleMessage("Rechercher"),
        "security": MessageLookupByLibrary.simpleMessage("Sécurité"),
        "seenByUser": m54,
        "seenByUserAndCountOthers": m55,
        "seenByUserAndUser": m56,
        "send": MessageLookupByLibrary.simpleMessage("Envoyer"),
        "sendAMessage":
            MessageLookupByLibrary.simpleMessage("Envoyer un message"),
        "sendAsText": MessageLookupByLibrary.simpleMessage("Envoyer un texte"),
        "sendAudio":
            MessageLookupByLibrary.simpleMessage("Envoyer un fichier audio"),
        "sendFile": MessageLookupByLibrary.simpleMessage("Envoyer un fichier"),
        "sendImage": MessageLookupByLibrary.simpleMessage("Envoyer une image"),
        "sendMessages":
            MessageLookupByLibrary.simpleMessage("Envoyer des messages"),
        "sendOnEnter":
            MessageLookupByLibrary.simpleMessage("Envoyer avec Entrée"),
        "sendOriginal":
            MessageLookupByLibrary.simpleMessage("Envoyer le fichier original"),
        "sendSticker":
            MessageLookupByLibrary.simpleMessage("Envoyer un autocollant"),
        "sendVideo": MessageLookupByLibrary.simpleMessage("Envoyer une vidéo"),
        "sender": MessageLookupByLibrary.simpleMessage("Expéditeur/trice"),
        "sentAFile": m57,
        "sentAPicture": m58,
        "sentASticker": m59,
        "sentAVideo": m60,
        "sentAnAudio": m61,
        "sentCallInformations": m62,
        "separateChatTypes": MessageLookupByLibrary.simpleMessage(
            "Séparer les discussions directes et les groupes"),
        "serverRequiresEmail": MessageLookupByLibrary.simpleMessage(
            "Ce serveur doit valider votre adresse électronique pour l\'inscription."),
        "setAsCanonicalAlias": MessageLookupByLibrary.simpleMessage(
            "Définir comme adresse principale"),
        "setCustomEmotes": MessageLookupByLibrary.simpleMessage(
            "Définir des émoticônes personnalisées"),
        "setGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Définir une description du groupe"),
        "setInvitationLink":
            MessageLookupByLibrary.simpleMessage("Créer un lien d\'invitation"),
        "setPermissionsLevel": MessageLookupByLibrary.simpleMessage(
            "Définir le niveau de permissions"),
        "setStatus": MessageLookupByLibrary.simpleMessage("Définir le statut"),
        "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "share": MessageLookupByLibrary.simpleMessage("Partager"),
        "shareLocation":
            MessageLookupByLibrary.simpleMessage("Partager la localisation"),
        "shareYourInviteLink": MessageLookupByLibrary.simpleMessage(
            "Partager votre lien d\'invitation"),
        "sharedTheLocation": m63,
        "showDirectChatsInSpaces": MessageLookupByLibrary.simpleMessage(
            "Afficher les discussions directes associées dans les espaces"),
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Afficher le mot de passe"),
        "signUp": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
        "singlesignon":
            MessageLookupByLibrary.simpleMessage("Authentification unique"),
        "skip": MessageLookupByLibrary.simpleMessage("Ignorer"),
        "sorryThatsNotPossible": MessageLookupByLibrary.simpleMessage(
            "Désolé, ce n\'est pas possible"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Code source"),
        "spaceIsPublic":
            MessageLookupByLibrary.simpleMessage("L\'espace est public"),
        "spaceName": MessageLookupByLibrary.simpleMessage("Nom de l\'espace"),
        "start": MessageLookupByLibrary.simpleMessage("Commencer"),
        "startFirstChat": MessageLookupByLibrary.simpleMessage(
            "Commencez votre première discussion"),
        "startedACall": m64,
        "status": MessageLookupByLibrary.simpleMessage("Statut"),
        "statusExampleMessage": MessageLookupByLibrary.simpleMessage(
            "Comment allez-vous aujourd\'hui ?"),
        "storeInAndroidKeystore": MessageLookupByLibrary.simpleMessage(
            "Stocker dans Android KeyStore"),
        "storeInAppleKeyChain":
            MessageLookupByLibrary.simpleMessage("Stocker dans Apple KeyChain"),
        "storeInSecureStorageDescription": MessageLookupByLibrary.simpleMessage(
            "Stocker la clé de récupération dans un espace sécurisé de cet appareil."),
        "storeSecurlyOnThisDevice": MessageLookupByLibrary.simpleMessage(
            "Stocker de manière sécurisé sur cet appareil"),
        "stories": MessageLookupByLibrary.simpleMessage("Stories"),
        "storyFrom": m65,
        "storyPrivacyWarning": MessageLookupByLibrary.simpleMessage(
            "Veuillez noter que les personnes peuvent se voir et se contacter dans votre story. Vos stories seront visibles pendant 24 heures, mais il n\'y a aucune garantie qu\'elles seront supprimées de tous les appareils et de tous les serveurs."),
        "submit": MessageLookupByLibrary.simpleMessage("Soumettre"),
        "supposedMxid": m66,
        "switchToAccount": m67,
        "synchronizingPleaseWait": MessageLookupByLibrary.simpleMessage(
            "Synchronisation... Veuillez patienter."),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Système"),
        "theyDontMatch":
            MessageLookupByLibrary.simpleMessage("Elles ne correspondent pas"),
        "theyMatch":
            MessageLookupByLibrary.simpleMessage("Elles correspondent"),
        "thisUserHasNotPostedAnythingYet": MessageLookupByLibrary.simpleMessage(
            "Cet(te) utilisateur(trice) n\'a encore rien posté dans sa story"),
        "time": MessageLookupByLibrary.simpleMessage("Heure"),
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "toggleFavorite": MessageLookupByLibrary.simpleMessage(
            "Activer/désactiver en favori"),
        "toggleMuted": MessageLookupByLibrary.simpleMessage(
            "Activer/désactiver la sourdine"),
        "toggleUnread":
            MessageLookupByLibrary.simpleMessage("Marquer comme lu / non lu"),
        "tooManyRequestsWarning": MessageLookupByLibrary.simpleMessage(
            "Trop de requêtes. Veuillez réessayer plus tard !"),
        "transferFromAnotherDevice": MessageLookupByLibrary.simpleMessage(
            "Transfert à partir d\'un autre appareil"),
        "tryToSendAgain":
            MessageLookupByLibrary.simpleMessage("Retenter l\'envoi"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Indisponible"),
        "unbanFromChat": MessageLookupByLibrary.simpleMessage(
            "Débannissement de la discussion"),
        "unbannedUser": m68,
        "unblockDevice": MessageLookupByLibrary.simpleMessage(
            "Retirer le blocage sur l\'appareil"),
        "unknownDevice":
            MessageLookupByLibrary.simpleMessage("Appareil inconnu"),
        "unknownEncryptionAlgorithm": MessageLookupByLibrary.simpleMessage(
            "Algorithme de chiffrement inconnu"),
        "unlockOldMessages": MessageLookupByLibrary.simpleMessage(
            "Déverrouiller les anciens messages"),
        "unmuteChat": MessageLookupByLibrary.simpleMessage(
            "Retirer la sourdine de la discussion"),
        "unpin": MessageLookupByLibrary.simpleMessage("Désépingler"),
        "unreadChats": m69,
        "unsubscribeStories":
            MessageLookupByLibrary.simpleMessage("Se désinscrire des stories"),
        "unsupportedAndroidVersion": MessageLookupByLibrary.simpleMessage(
            "Version d\'Android non prise en charge"),
        "unsupportedAndroidVersionLong": MessageLookupByLibrary.simpleMessage(
            "Cette fonctionnalité nécessite une nouvelle version d\'Android. Veuillez vérifier les mises à jour ou la prise en charge de Lineage OS."),
        "unverified": MessageLookupByLibrary.simpleMessage("Non vérifié"),
        "updateAvailable": MessageLookupByLibrary.simpleMessage(
            "Mise à jour de FluffyChat disponible"),
        "updateNow": MessageLookupByLibrary.simpleMessage(
            "Lancer la mise à jour en arrière-plan"),
        "user": MessageLookupByLibrary.simpleMessage("Utilisateur/trice"),
        "userAndOthersAreTyping": m70,
        "userAndUserAreTyping": m71,
        "userIsTyping": m72,
        "userLeftTheChat": m73,
        "userSentUnknownEvent": m74,
        "username":
            MessageLookupByLibrary.simpleMessage("Nom d\'utilisateur·ice"),
        "users": MessageLookupByLibrary.simpleMessage("Utilisateurs/trices"),
        "verified": MessageLookupByLibrary.simpleMessage("Vérifié"),
        "verify": MessageLookupByLibrary.simpleMessage("Vérifier"),
        "verifyStart":
            MessageLookupByLibrary.simpleMessage("Commencer la vérification"),
        "verifySuccess": MessageLookupByLibrary.simpleMessage(
            "La vérification a été effectuée avec succès !"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage(
            "Vérification de l\'autre compte"),
        "videoCall": MessageLookupByLibrary.simpleMessage("Appel vidéo"),
        "videoCallsBetaWarning": MessageLookupByLibrary.simpleMessage(
            "Veuillez noter que les appels vidéo sont actuellement en version bêta. Ils peuvent ne pas fonctionner comme prévu ou ne oas fonctionner du tout sur toutes les plateformes."),
        "videoWithSize": m75,
        "visibilityOfTheChatHistory": MessageLookupByLibrary.simpleMessage(
            "Visibilité de l\'historique de la discussion"),
        "visibleForAllParticipants": MessageLookupByLibrary.simpleMessage(
            "Visible pour tous les participant·es"),
        "visibleForEveryone":
            MessageLookupByLibrary.simpleMessage("Visible pour tout le monde"),
        "voiceCall": MessageLookupByLibrary.simpleMessage("Appel vocal"),
        "voiceMessage": MessageLookupByLibrary.simpleMessage("Message vocal"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "En attente de l\'acceptation de la demande par le partenaire…"),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "En attente de l\'acceptation de l\'émoji par le partenaire…"),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "En attente de l\'acceptation des nombres par le partenaire…"),
        "wallpaper": MessageLookupByLibrary.simpleMessage("Image de fond"),
        "warning": MessageLookupByLibrary.simpleMessage("Attention !"),
        "wasDirectChatDisplayName": m76,
        "weSentYouAnEmail": MessageLookupByLibrary.simpleMessage(
            "Nous vous avons envoyé un courriel"),
        "whatIsGoingOn":
            MessageLookupByLibrary.simpleMessage("Que se passe-t-il ?"),
        "whoCanPerformWhichAction": MessageLookupByLibrary.simpleMessage(
            "Qui peut faire quelle action"),
        "whoCanSeeMyStories":
            MessageLookupByLibrary.simpleMessage("Qui peut voir mes stories ?"),
        "whoCanSeeMyStoriesDesc": MessageLookupByLibrary.simpleMessage(
            "Veuillez noter que les personnes peuvent se voir et se contacter dans votre story."),
        "whoIsAllowedToJoinThisGroup": MessageLookupByLibrary.simpleMessage(
            "Qui est autorisé·e à rejoindre ce groupe"),
        "whyDoYouWantToReportThis": MessageLookupByLibrary.simpleMessage(
            "Pourquoi voulez-vous le signaler ?"),
        "whyIsThisMessageEncrypted": MessageLookupByLibrary.simpleMessage(
            "Pourquoi ce message est-il illisible ?"),
        "widgetCustom": MessageLookupByLibrary.simpleMessage("Personnalisé"),
        "widgetEtherpad":
            MessageLookupByLibrary.simpleMessage("Note textuelle"),
        "widgetJitsi": MessageLookupByLibrary.simpleMessage("Jitsi Meet"),
        "widgetName": MessageLookupByLibrary.simpleMessage("Nom"),
        "widgetNameError": MessageLookupByLibrary.simpleMessage(
            "Veuillez fournir un nom d\'affichage."),
        "widgetUrlError": MessageLookupByLibrary.simpleMessage(
            "Ceci n\'est pas un lien valide."),
        "widgetVideo": MessageLookupByLibrary.simpleMessage("Vidéo"),
        "wipeChatBackup": MessageLookupByLibrary.simpleMessage(
            "Effacer la sauvegarde de votre discussion pour créer une nouvelle clé de récupération ?"),
        "withTheseAddressesRecoveryDescription":
            MessageLookupByLibrary.simpleMessage(
                "Grâce à ces adresses, vous pouvez récupérer votre mot de passe si vous en avez besoin."),
        "writeAMessage":
            MessageLookupByLibrary.simpleMessage("Écrivez un message…"),
        "yes": MessageLookupByLibrary.simpleMessage("Oui"),
        "you": MessageLookupByLibrary.simpleMessage("Vous"),
        "youAcceptedTheInvitation": MessageLookupByLibrary.simpleMessage(
            "👍 Vous avez accepté l\'invitation"),
        "youAreInvitedToThisChat": MessageLookupByLibrary.simpleMessage(
            "Vous êtes invité·e à cette discussion"),
        "youAreNoLongerParticipatingInThisChat":
            MessageLookupByLibrary.simpleMessage(
                "Vous ne participez plus à cette discussion"),
        "youBannedUser": m77,
        "youCannotInviteYourself": MessageLookupByLibrary.simpleMessage(
            "Vous ne pouvez pas vous inviter vous-même"),
        "youHaveBeenBannedFromThisChat": MessageLookupByLibrary.simpleMessage(
            "Vous avez été banni·e de cette discussion"),
        "youHaveWithdrawnTheInvitationFor": m78,
        "youInvitedBy": m79,
        "youInvitedUser": m80,
        "youJoinedTheChat": MessageLookupByLibrary.simpleMessage(
            "Vous avez rejoint la discussion"),
        "youKicked": m81,
        "youKickedAndBanned": m82,
        "youRejectedTheInvitation": MessageLookupByLibrary.simpleMessage(
            "Vous avez rejeté l\'invitation"),
        "youUnbannedUser": m83,
        "yourChatBackupHasBeenSetUp": MessageLookupByLibrary.simpleMessage(
            "Votre sauvegarde de la discussion a été mise en place."),
        "yourPublicKey":
            MessageLookupByLibrary.simpleMessage("Votre clé publique"),
        "yourStory": MessageLookupByLibrary.simpleMessage("Votre story")
      };
}
