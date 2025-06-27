// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get restoreAccount => 'Restore Account';

  @override
  String get register => 'S\'inscrire';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get poweredByDIDs => 'Powered with DIDs by';

  @override
  String get usernameOrDID => 'Username or DID';

  @override
  String get privateKey => 'Private Key';

  @override
  String get privateKeyLogin => 'DID and Private Key Login';

  @override
  String get restoreWithSocialRecovery => 'Restore with social recovery';

  @override
  String get pinCodeVerification => 'Pin Code Verification';

  @override
  String get invitationCode => 'Invitation Code';

  @override
  String get noAccountYet => 'You don\'t have an account yet?';

  @override
  String get alreadyHaveAccount => 'You already have an registered Account?';

  @override
  String get codeAlreadyUsed => 'It seems like this code has already been used';

  @override
  String get codeNotValid => 'Code is not valid.';

  @override
  String get errorSomethingWrong => 'Something went wrong';

  @override
  String get powerToThePeople => 'Power to the people!';

  @override
  String get platformDemandText =>
      'We\'re thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users.';

  @override
  String get platformExlusivityText =>
      'We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration.';

  @override
  String get platformExpandCapacityText =>
      'Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas !';

  @override
  String get pleaseEnterValidEmail =>
      'Veuillez saisir une adresse électronique valide.';

  @override
  String get pleaseEnterValidUsername =>
      'The username you entered is not valid.';

  @override
  String get usernameTaken => 'This username is already taken.';

  @override
  String get enterWordsRightOrder => 'Enter your 24 words in the right order';

  @override
  String get confirmKey => 'Confirm Key';

  @override
  String get skipAtOwnRisk => 'Skip at own risk';

  @override
  String get yourPassowrdBackup => 'Your Password & Backup';

  @override
  String get saveYourmnemonicSecurely => 'Save your mnemonic securely!';

  @override
  String get continues => 'Continue';

  @override
  String get fixed => 'fixed';

  @override
  String get timeAgo => 'time ago...';

  @override
  String get noUserFound => 'No users found.';

  @override
  String get assets => 'Assets';

  @override
  String get bitcoin => 'Bitcoin';

  @override
  String get whaleBehavior => 'Whale Behaviour';

  @override
  String get nameBehavior => ' NAME';

  @override
  String get dateBehavior => ' DATE';

  @override
  String get valueBehavior => ' VALUE';

  @override
  String get sendBitcoin => ' Send Bitcoin';

  @override
  String get dontShareAnyone => 'DON\'T SHARE THIS QR CODE TO ANYONE!';

  @override
  String get typeBehavior => ' TYPE';

  @override
  String get inviteDescription =>
      'Our service is currently in beta and \nlimited to invited users. You can share these invitation \nkeys with your friends and family!';

  @override
  String get noResultsFound => ' No results found';

  @override
  String get bitcoinNews => 'Bitcoin News';

  @override
  String get quickLinks => 'Quick Links';

  @override
  String get fearAndGreedIndex => 'Fear & Greed Index';

  @override
  String get bitcoinDescription =>
      'Bitcoin (BTC) is the first cryptocurrency built. Unlike government-issued or fiat currencies such as US Dollars or Euro which are controlled by central banks, Bitcoin can operate without the need of a central authority like a central bank or a company. Users are able to send funds to each other without going through intermediaries.';

  @override
  String get people => 'Personnes';

  @override
  String get now => 'Now: ';

  @override
  String get lastUpdated => 'Last updated: ';

  @override
  String get buyBitcoin => 'Buy Bitcoin';

  @override
  String get saveCard => 'Save Card';

  @override
  String get addNewCard => 'Add New Card';

  @override
  String get payemntMethod => 'Payment Method';

  @override
  String get purchaseBitcoin => 'Purchase Bitcoin';

  @override
  String get fearAndGreed => 'Fear and Greed';

  @override
  String get hashrateDifficulty => 'Hashrate & Difficulty';

  @override
  String get groups => 'Groupes';

  @override
  String get liked => 'Liked';

  @override
  String get swap => 'Swap';

  @override
  String get autoLong => 'auto long';

  @override
  String get autoShort => 'auto short';

  @override
  String get noUsersFound => 'No users could be found';

  @override
  String get joinedRevolution =>
      'Hey there Bitcoiners! I joined the revolution!';

  @override
  String get mnemonicCorrect =>
      'Your mnemonic is correct! Please keep it safe.';

  @override
  String get mnemonicInCorrect =>
      'Your mnemonic does not match. Please try again.';

  @override
  String get saveYourmnemonicSecurelyDescription =>
      'Save this sequence on a piece of paper it acts as your password to your account, a loss of this sequence will result in a loss of your funds.';

  @override
  String get repeatPassword => 'Répétez le mot de passe';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Veuillez choisir au moins $min caractères.';
  }

  @override
  String get about => 'À propos';

  @override
  String get updateAvailable => 'Mise à jour de FluffyChat disponible';

  @override
  String get updateNow => 'Lancer la mise à jour en arrière-plan';

  @override
  String get accept => 'Accepter';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username a accepté l\'invitation';
  }

  @override
  String get account => 'Compte';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username a activé le chiffrement de bout en bout';
  }

  @override
  String get addEmail => 'Ajouter un courriel';

  @override
  String get confirmMatrixId =>
      'Veuillez confirmer votre identifiant Matrix afin de supprimer votre compte.';

  @override
  String supposedMxid(Object mxid) {
    return 'Cela devrait être $mxid';
  }

  @override
  String get addGroupDescription => 'Ajouter une description au groupe';

  @override
  String get addToSpace => 'Ajouter à l\'espace';

  @override
  String get admin => 'Administrateur';

  @override
  String get alias => 'adresse';

  @override
  String get all => 'Tout';

  @override
  String get allChats => 'Toutes les discussions';

  @override
  String get commandHint_googly => 'Envoyer des yeux écarquillés';

  @override
  String get commandHint_cuddle => 'Envoyer un câlin';

  @override
  String get commandHint_hug => 'Envoyer une accolade';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName vous envoie des yeux écarquillés';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName vous fait un câlin';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName vous fait une accolade';
  }

  @override
  String answeredTheCall(Object senderName) {
    return '$senderName a répondu à l\'appel';
  }

  @override
  String get anyoneCanJoin => 'Tout le monde peut rejoindre';

  @override
  String get appLock => 'Verrouillage de l’application';

  @override
  String get archive => 'Archiver';

  @override
  String get areGuestsAllowedToJoin => 'Les invités peuvent-i·e·ls rejoindre';

  @override
  String get areYouSure => 'Êtes-vous sûr·e ?';

  @override
  String get areYouSureYouWantToLogout =>
      'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get askSSSSSign =>
      'Pour pouvoir faire signer l\'autre personne, veuillez entrer la phrase de passe de votre trousseau sécurisé ou votre clé de récupération.';

  @override
  String askVerificationRequest(Object username) {
    return 'Accepter cette demande de vérification de la part de $username ?';
  }

  @override
  String get autoplayImages =>
      'Lire automatiquement les autocollants et les émojis animés';

  @override
  String get sendOnEnter => 'Envoyer avec Entrée';

  @override
  String get banFromChat => 'Bannir de la discussion';

  @override
  String get banned => 'Banni';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username a banni $targetName';
  }

  @override
  String get blockDevice => 'Bloquer l\'appareil';

  @override
  String get blocked => 'Bloqué';

  @override
  String get botMessages => 'Messages de bot';

  @override
  String get bubbleSize => 'Taille de la bulle';

  @override
  String get cancel => 'Annuler';

  @override
  String cantOpenUri(Object uri) {
    return 'Impossible d\'ouvrir l\'URI $uri';
  }

  @override
  String get changeDeviceName => 'Modifier le nom de l\'appareil';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username a changé l\'image de la discussion';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username a changé la description de la discussion en : \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username a renommé la discussion en : \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username a changé les permissions de la discussion';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username a changé son nom en : \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username a changé les règles d\'accès à la discussion pour les invités';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username a changé les règles d\'accès à la discussion pour les invités en : $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username a changé la visibilité de l\'historique de la discussion';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username a changé la visibilité de l\'historique de la discussion en : $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username a changé les règles d\'accès à la discussion';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username a changé les règles d\'accès à la discussion en : $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username a changé son avatar';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username a changé les adresses du salon';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username a changé le lien d\'invitation';
  }

  @override
  String get changePassword => 'Changer de mot de passe';

  @override
  String get changeTheHomeserver => 'Changer le serveur d\'accueil';

  @override
  String get changeTheme => 'Changez votre style';

  @override
  String get changeTheNameOfTheGroup => 'Changer le nom du groupe';

  @override
  String get changeWallpaper => 'Changer l\'image de fond';

  @override
  String get changeYourAvatar => 'Changer votre avatar';

  @override
  String get channelCorruptedDecryptError => 'Le chiffrement a été corrompu';

  @override
  String get chat => 'Discussion';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'Votre sauvegarde de la discussion a été mise en place.';

  @override
  String get chatBackup => 'Sauvegarde des discussions';

  @override
  String get chatBackupDescription =>
      'Vos anciens messages sont sécurisés par une clé de récupération. Veillez à ne pas la perdre.';

  @override
  String get chatDetails => 'Détails de la discussion';

  @override
  String get chatHasBeenAddedToThisSpace =>
      'La discussion a été ajoutée à cet espace';

  @override
  String get chats => 'Discussions';

  @override
  String get chooseAStrongPassword => 'Choisissez un mot de passe fort';

  @override
  String get chooseAUsername => 'Choisissez un nom d\'utilisateur·ice';

  @override
  String get clearArchive => 'Effacer les archives';

  @override
  String get close => 'Fermer';

  @override
  String get commandHint_markasdm =>
      'Marquer comme salon de messagerie directe';

  @override
  String get commandHint_markasgroup => 'Marquer comme groupe';

  @override
  String get commandHint_ban =>
      'Bannir l\'utilisateur/trice donné(e) de ce salon';

  @override
  String get commandHint_clearcache => 'Vider le cache';

  @override
  String get commandHint_create =>
      'Créer un groupe de discussion vide\nUtilisez --no-encryption pour désactiver le chiffrement';

  @override
  String get commandHint_discardsession => 'Abandonner la session';

  @override
  String get commandHint_dm =>
      'Commencer une discussion directe\nUtilisez --no-encryption pour désactiver le chiffrement';

  @override
  String get commandHint_html => 'Envoyer du texte au format HTML';

  @override
  String get commandHint_invite =>
      'Inviter l\'utilisateur/trice donné(e) dans ce salon';

  @override
  String get commandHint_join => 'Rejoindre le salon donné';

  @override
  String get commandHint_kick =>
      'Supprime l\'utilisateur/trice donné(e) de ce salon';

  @override
  String get commandHint_leave => 'Quitter ce salon';

  @override
  String get commandHint_me => 'Décrivez-vous';

  @override
  String get commandHint_myroomavatar =>
      'Définir votre image pour ce salon (par mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Définir votre nom d\'affichage pour ce salon';

  @override
  String get commandHint_op =>
      'Définir le niveau de puissance de l\'utilisateur/trice donné(e) (par défaut : 50)';

  @override
  String get commandHint_plain => 'Envoyer du texte non formaté';

  @override
  String get commandHint_react => 'Envoyer une réponse en tant que réaction';

  @override
  String get commandHint_send => 'Envoyer du texte';

  @override
  String get commandHint_unban =>
      'Débannir l\'utilisateur/trice donné(e) de ce salon';

  @override
  String get commandInvalid => 'Commande invalide';

  @override
  String commandMissing(Object command) {
    return '$command n\'est pas une commande.';
  }

  @override
  String get compareEmojiMatch => 'Veuillez comparer les émojis';

  @override
  String get compareNumbersMatch => 'Veuillez comparer les chiffres';

  @override
  String get configureChat => 'Configurer la discussion';

  @override
  String get confirm => 'Confirmer';

  @override
  String get connect => 'Se connecter';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Le contact a été invité au groupe';

  @override
  String get containsDisplayName => 'Contient un nom d\'affichage';

  @override
  String get containsUserName => 'Contient un nom d\'utilisateur·ice';

  @override
  String get contentHasBeenReported =>
      'Le contenu a été signalé aux administrateurs du serveur';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papier';

  @override
  String get copy => 'Copier';

  @override
  String get copyToClipboard => 'Copier dans le presse-papiers';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Impossible de déchiffrer le message : $error';
  }

  @override
  String countParticipants(Object count) {
    return '$count participant(s)';
  }

  @override
  String get create => 'Créer';

  @override
  String createdTheChat(Object username) {
    return '💬 $username a créé la discussion';
  }

  @override
  String get createNewGroup => 'Créer un nouveau groupe';

  @override
  String get createNewSpace => 'Nouvel espace';

  @override
  String get currentlyActive => 'Actif en ce moment';

  @override
  String get darkTheme => 'Sombre';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$day/$month';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$day/$month/$year';
  }

  @override
  String get deactivateAccountWarning =>
      'Cette opération va désactiver votre compte. Une fois cette action effectuée, aucun retour en arrière n\'est possible ! Êtes-vous sûr·e ?';

  @override
  String get defaultPermissionLevel => 'Niveau d\'autorisation par défaut';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteMessage => 'Supprimer le message';

  @override
  String get deny => 'Refuser';

  @override
  String get device => 'Appareil';

  @override
  String get deviceId => 'Identifiant de l\'appareil';

  @override
  String get devices => 'Appareils';

  @override
  String get directChats => 'Discussions directes';

  @override
  String get allRooms => 'All Group Chats';

  @override
  String get discover => 'Discover';

  @override
  String get displaynameHasBeenChanged => 'Renommage effectué';

  @override
  String get downloadFile => 'Télécharger le fichier';

  @override
  String get edit => 'Modifier';

  @override
  String get editBlockedServers => 'Modifier les serveurs bloqués';

  @override
  String get editChatPermissions => 'Modifier les permissions de la discussion';

  @override
  String get editDisplayname => 'Changer de nom d\'affichage';

  @override
  String get editRoomAliases => 'Modifier les adresses du salon';

  @override
  String get editRoomAvatar => 'Modifier l\'avatar du salon';

  @override
  String get emoteExists => 'Cette émoticône existe déjà !';

  @override
  String get emoteInvalid => 'Raccourci d\'émoticône invalide !';

  @override
  String get emotePacks => 'Packs d\'émoticônes pour le salon';

  @override
  String get emoteSettings => 'Paramètre des émoticônes';

  @override
  String get emoteShortcode => 'Raccourci de l\'émoticône';

  @override
  String get emoteWarnNeedToPick =>
      'Vous devez sélectionner un raccourci d\'émoticône et une image !';

  @override
  String get emptyChat => 'Discussion vide';

  @override
  String get enableEmotesGlobally =>
      'Activer globalement le pack d\'émoticônes';

  @override
  String get enableEncryption => 'Activer le chiffrement';

  @override
  String get enableEncryptionWarning =>
      'Vous ne pourrez plus désactiver le chiffrement. Êtes-vous sûr(e) ?';

  @override
  String get encrypted => 'Chiffré';

  @override
  String get encryption => 'Chiffrement';

  @override
  String get encryptionNotEnabled => 'Le chiffrement n\'est pas activé';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName a mis fin à l\'appel';
  }

  @override
  String get enterAGroupName => 'Entrez un nom de groupe';

  @override
  String get enterAnEmailAddress => 'Saisissez une adresse de courriel';

  @override
  String get enterASpacepName => 'Entrer un nom d\'espace';

  @override
  String get homeserver => 'Serveur d\'accueil';

  @override
  String get enterYourHomeserver => 'Renseignez votre serveur d\'accueil';

  @override
  String errorObtainingLocation(Object error) {
    return 'Erreur lors de l\'obtention de la localisation : $error';
  }

  @override
  String get everythingReady => 'Tout est prêt !';

  @override
  String get extremeOffensive => 'Extrêmement offensant';

  @override
  String get fileName => 'Nom du ficher';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Taille de la police';

  @override
  String get forward => 'Transférer';

  @override
  String get fromJoining => 'À partir de l\'entrée dans le salon';

  @override
  String get fromTheInvitation => 'À partir de l\'invitation';

  @override
  String get goToTheNewRoom => 'Aller dans le nouveau salon';

  @override
  String get group => 'Groupe';

  @override
  String get groupDescription => 'Description du groupe';

  @override
  String get groupDescriptionHasBeenChanged =>
      'La description du groupe a été modifiée';

  @override
  String get groupIsPublic => 'Le groupe est public';

  @override
  String groupWith(Object displayname) {
    return 'Groupe avec $displayname';
  }

  @override
  String get guestsAreForbidden => 'Les invités ne peuvent pas rejoindre';

  @override
  String get guestsCanJoin => 'Les invités peuvent rejoindre';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username a annulé l\'invitation de $targetName';
  }

  @override
  String get help => 'Aide';

  @override
  String get hideRedactedEvents => 'Cacher les évènements supprimés';

  @override
  String get hideUnknownEvents => 'Cacher les évènements inconnus';

  @override
  String get howOffensiveIsThisContent =>
      'À quel point ce contenu est-il offensant ?';

  @override
  String get id => 'Identifiant';

  @override
  String get identity => 'Identité';

  @override
  String get ignore => 'Ignorer';

  @override
  String get ignoredUsers => 'Utilisateur·ices ignoré·es';

  @override
  String get ignoreListDescription =>
      'Vous pouvez ignorer les utilisateur·ices qui vous dérangent en les mettant dans votre liste à ignorer personnelle. Vous ne recevrez plus de messages ou d\'invitations à participer à un salon de discussion de la part des utilisateur·ices figurant sur cette liste.';

  @override
  String get ignoreUsername => 'Ignorer l\'utilisateur·ice';

  @override
  String get iHaveClickedOnLink => 'J\'ai cliqué sur le lien';

  @override
  String get incorrectPassphraseOrKey =>
      'Phrase de passe ou clé de récupération incorrecte';

  @override
  String get inoffensive => 'Non offensant';

  @override
  String get inviteContact => 'Inviter un contact';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Inviter un contact dans $groupName';
  }

  @override
  String get invited => 'Invité·e';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username a invité $targetName';
  }

  @override
  String get invitedUsersOnly => 'Uniquement les utilisateur·ices invité·es';

  @override
  String get inviteForMe => 'Inviter pour moi';

  @override
  String inviteText(Object username, Object link) {
    return '$username vous a invité·e sur FluffyChat. \n1. Installez FluffyChat : https://fluffychat.im \n2. Inscrivez-vous ou connectez-vous \n3. Ouvrez le lien d\'invitation : $link';
  }

  @override
  String get isTyping => 'est en train d\'écrire…';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username a rejoint la discussion';
  }

  @override
  String get joinRoom => 'Rejoindre le salon';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username a expulsé $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username a expulsé et banni $targetName';
  }

  @override
  String get kickFromChat => 'Expulser de la discussion';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Vu·e pour la dernière fois : $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Vu pour la dernière fois il y a longtemps';

  @override
  String get leave => 'Partir';

  @override
  String get leftTheChat => 'A quitté la discussion';

  @override
  String get license => 'Licence';

  @override
  String get lightTheme => 'Clair';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Charger $count participant·es de plus';
  }

  @override
  String get dehydrate => 'Exporter la session et effacer l\'appareil';

  @override
  String get dehydrateWarning =>
      'Cette action ne peut pas être annulée. Assurez-vous d\'enregistrer convenablement le fichier de sauvegarde.';

  @override
  String get dehydrateTor => 'Utilisateurs/trices de TOR : Exporter la session';

  @override
  String get dehydrateTorLong =>
      'Pour les utilisateurs/trices de TOR, il est recommandé d\'exporter la session avant de fermer la fenêtre.';

  @override
  String get hydrateTor =>
      'Utilisateurs/trices de TOR : Importer une session exportée';

  @override
  String get hydrateTorLong =>
      'Vous avez exporté votre session la dernière fois sur TOR ? Importez-la rapidement et continuez à discuter.';

  @override
  String get hydrate => 'Restaurer à partir du fichier de sauvegarde';

  @override
  String get loadingPleaseWait => 'Chargement… Veuillez patienter.';

  @override
  String get loadMore => 'Charger plus…';

  @override
  String get locationDisabledNotice =>
      'Les services de localisation sont désactivés. Il est nécessaire de les activer avant de pouvoir partager votre localisation.';

  @override
  String get locationPermissionDeniedNotice =>
      'L\'application n\'a pas la permission d\'accéder à votre localisation. Merci de l\'accorder afin de pouvoir partager votre localisation.';

  @override
  String get login => 'Se connecter';

  @override
  String get previousOutputType => 'Previous output type';

  @override
  String get previousOutputScripts => 'Previous output script';

  @override
  String get witness => 'Witness';

  @override
  String get outputTx => 'Outputs\n';

  @override
  String get showDetails => 'Show Details';

  @override
  String get hideDetails => 'Hide Details';

  @override
  String get inputTx => 'Inputs\n';

  @override
  String get transactionReplaced => 'This transaction has been replaced by:';

  @override
  String get loading => 'Loading';

  @override
  String get replaced => 'Replaced';

  @override
  String get paymentNetwork => 'Payment Network';

  @override
  String logInTo(Object homeserver) {
    return 'Se connecter à $homeserver';
  }

  @override
  String get loginWithOneClick => 'Se connecter en un clic';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Vérifiez que l\'identifiant est valide';

  @override
  String get memberChanges => 'Changements de membres';

  @override
  String get mention => 'Mentionner';

  @override
  String get messages => 'Messages';

  @override
  String get messageWillBeRemovedWarning =>
      'Le message sera supprimé pour tous les participants';

  @override
  String get moderator => 'Modérateur·rice';

  @override
  String get muteChat => 'Mettre la discussion en sourdine';

  @override
  String get needPantalaimonWarning =>
      'Pour l\'instant, vous avez besoin de Pantalaimon pour utiliser le chiffrement de bout en bout.';

  @override
  String get newChat => 'Nouvelle discussion';

  @override
  String get newMessageInFluffyChat => '💬 Nouveau message dans FluffyChat';

  @override
  String get newVerificationRequest => 'Nouvelle demande de vérification !';

  @override
  String get next => 'Suivant';

  @override
  String get no => 'Non';

  @override
  String get noConnectionToTheServer => 'Aucune connexion au serveur';

  @override
  String get noEmotesFound => 'Aucune émoticône trouvée. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Vous pouvez activer le chiffrement seulement quand le salon n\'est plus accessible au public.';

  @override
  String get noGoogleServicesWarning =>
      'Il semble que vous n\'ayez aucun service Google sur votre téléphone. C\'est une bonne décision pour votre vie privée ! Pour recevoir des notifications dans FluffyChat, nous vous recommandons d\'utiliser https://microg.org/ ou https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 n\'est pas un serveur Matrix, souhaitez-vous utiliser $server2 à la place ?';
  }

  @override
  String get shareYourInviteLink => 'Partager votre lien d\'invitation';

  @override
  String get scanQrCode => 'Scanner un code QR';

  @override
  String get scanQr => 'Scan QR';

  @override
  String get filter => 'Filter';

  @override
  String get art => 'Art';

  @override
  String get supply => 'Supply';

  @override
  String get subTotal => 'Subtotal';

  @override
  String get favorite => 'Favourite';

  @override
  String get price => 'Price';

  @override
  String get pressedFavorite =>
      'Press the Favorites button again to unfavorite';

  @override
  String get networkFee => 'Network Fee';

  @override
  String get marketFee => 'Market Fee';

  @override
  String get buyNow => 'Buy Now';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get forSale => 'For Sale';

  @override
  String get owners => 'Owners';

  @override
  String get searchItemsAndCollections => 'Search items and collections';

  @override
  String get cryptoPills => 'Crypto-Pills';

  @override
  String get createdBy => 'Created By';

  @override
  String get viewOffers => 'View Offers';

  @override
  String get itemsTotal => 'Items total';

  @override
  String get newTopSellers => 'New Top Sellers';

  @override
  String get mostHypedNewDeals => 'Most Hyped New Deals';

  @override
  String get sold => 'Sold';

  @override
  String get cart => 'Cart';

  @override
  String get chains => 'Chains';

  @override
  String get collections => 'Collections';

  @override
  String get sortBy => 'Sort By';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get clearAll => 'Clear All';

  @override
  String get showAll => 'Show All';

  @override
  String get totalVolume => 'Total Volume';

  @override
  String get sales => 'Sales';

  @override
  String get listed => 'Listed';

  @override
  String get views => 'Views';

  @override
  String get currentPrice => 'Current Price';

  @override
  String get hotNewItems => 'Hot New Items';

  @override
  String get mostViewed => 'Most Viewed';

  @override
  String get floorPrice => 'Floor Price';

  @override
  String get recentlyListed => 'Recently Listed';

  @override
  String get tradingHistory => 'Trading History';

  @override
  String get priceHistory => 'Price History';

  @override
  String get activities => 'Activities';

  @override
  String get chainInfo => 'Chain Info';

  @override
  String get properties => 'Properties';

  @override
  String get ethereum => 'ETHEREUM';

  @override
  String get mission => 'Mission';

  @override
  String get download => 'Download';

  @override
  String get wowBitnet =>
      'Wow! Bitnet is the part that I was always missing for bitcoin. Now we will only see more and more bitcoin adoption.';

  @override
  String get soHappy =>
      'So happy to be part of the club 1 million! Lightning is the future.';

  @override
  String get iHaveAlways =>
      'I have always been a Bitcoin enthusiast, so BitNet was a no-brainer for me. Its great to see how far we have come with Bitcoin.';

  @override
  String get justJoinedBitnet => ' just joined the BitNet!';

  @override
  String get userCharged => ' User-change in the last 7 days!';

  @override
  String get weHaveBetaLiftOff =>
      'We have Beta liftoff! Exclusive Early Access for Invited Users.';

  @override
  String get joinUsToday => 'Join us Today!';

  @override
  String get weEmpowerTomorrow => 'Building Bitcoin, Together.';

  @override
  String get historyClaim => 'History in Making: Claim your free Bitcoin NFT.';

  @override
  String get claimNFT => 'Claim your free Bitcoin NFT';

  @override
  String get beAmongFirst =>
      'Be among the first million users and secure your exclusive early-bird Bitcoin inscription.';

  @override
  String get weUnlockAssets => 'We unlock our future of digital assets!';

  @override
  String get exploreBtc => 'Explore BTC';

  @override
  String get weBuildTransparent =>
      'We build a transparent platform that uses verification - not trust.';

  @override
  String get givePowerBack => 'Give power back to the people!';

  @override
  String get getAProfile => 'Get a profile';

  @override
  String get weDigitizeAllSorts =>
      'We digitize all sorts of assets on top of the Bitcoin Network.';

  @override
  String get growAFair => 'Grow a fair Cyberspace!';

  @override
  String get sendBtc => 'Send BTC';

  @override
  String get weOfferEasiest =>
      'We offer the easiest, most secure, and most advanced web wallet.';

  @override
  String get makeBitcoinEasy => 'Make Bitcoin easy for everyone!';

  @override
  String get ourMissionn => 'Our mission.';

  @override
  String get limitedSpotsLeft => 'limited spots left!';

  @override
  String get weAreGrowingBitcoin => 'Let\'s bring Bitcoin to the future.';

  @override
  String get weBuildBitcoin => 'We build the Bitcoin Network!';

  @override
  String get ourMission =>
      'Our mission is simple but profound: To innovate in the digital \neconomy by integrating blockchain technology with asset digitization, \ncreating a secure and transparent platform that empowers users to engage \nwith the metaverse through Bitcoin. We are dedicated to making digital interactions \nmore accessible, equitable, and efficient for everyone. To accelerate the adoption of Bitcoin and create a world\n where digital assets are accessible, understandable, and beneficial to all. Where people can verify information \n on their own.';

  @override
  String get openOnEtherscan => 'Open On Etherscan';

  @override
  String get tokenId => 'Token ID';

  @override
  String get contractAddress => 'Contract address';

  @override
  String get guardiansDesigned =>
      'Not only are Guardians dope designed character-collectibles, they also serve as your ticket to a world of exclusive content. From developing new collections to fill our universe, to metaverse avatars, we have bundles of awesome features in the pipeline.';

  @override
  String get guardiansStored =>
      'Guardians are stored as ERC721 tokens on the Ethereum blockchain. Owners can download their Guardians in .png format, they can also request a high resolution image of them, with 3D models coming soon for everyone.';

  @override
  String get propertiesDescription =>
      'Guardians of the Metaverse are a collection of 10,000 unique 3D hero-like avatars living as NFTs on the blockchain.';

  @override
  String get aboutCryptoPills => 'About Crypto-Pills';

  @override
  String get categories => 'Categories';

  @override
  String get spotlightProjects => 'Spotlight Projects';

  @override
  String get onSaleIn => 'On Sale In';

  @override
  String get allItems => 'All Items';

  @override
  String get trendingSellers => 'Trending Sellers';

  @override
  String get lightning => 'Lightning';

  @override
  String get onchain => 'Onchain';

  @override
  String get failedToLoadCertainData =>
      'Failed to load certain data in this page, please try again later';

  @override
  String get timeFrame => 'TimeFrame';

  @override
  String get failedToLoadOnchain => 'Failed to load Onchain Transactions';

  @override
  String get failedToLoadPayments => 'Failed to load Lightning Payments';

  @override
  String get failedToLoadLightning => 'Failed to load Lightning Invoices';

  @override
  String get failedToLoadOperations => 'Failed to load Loop Operations';

  @override
  String get clear => 'Clear';

  @override
  String get apply => 'Apply';

  @override
  String get sent => 'Sent';

  @override
  String get foundedIn2023 =>
      'Founded in 2023, BitNet was born out of the belief that Bitcoin is not just a digital asset for the tech-savvy and financial experts,\n but a revolutionary tool that has the potential to build the foundations of cyberspace empowering individuals worldwide.\n We recognized the complexity and the mystique surrounding Bitcoin and cryptocurrencies,\n and we decided it was time to demystify it and make it accessible to everyone.\n We are a pioneering platform dedicated to bringing Bitcoin closer to everyday people like you.';

  @override
  String get history => 'History';

  @override
  String get received => 'Received';

  @override
  String get pleaseGiveAccess =>
      'Please give the app photo access to use this feature.';

  @override
  String get noCodeFoundOverlayError => 'No code was found.';

  @override
  String get badCharacters => 'Bad characters';

  @override
  String get filterOptions => 'Filter Options';

  @override
  String get bitcoinInfoCard => 'Bitcoin Card Information';

  @override
  String get lightningCardInfo => 'Lightning Card Information';

  @override
  String get totalReceived => 'Total Received';

  @override
  String get totalSent => 'Total Sent';

  @override
  String get qrCode => 'QR Code';

  @override
  String get keyMetrics => 'Key metrics';

  @override
  String get intrinsicValue => 'Intrinsic Value:';

  @override
  String get hashrate => 'Hashrate';

  @override
  String get bear => 'Bear';

  @override
  String get coinBase => 'Coinbase (Newly Generated Coins)\n';

  @override
  String get transactions => 'Transactions';

  @override
  String get seeMore => 'See more';

  @override
  String get blockTransaction => 'Block Transactions';

  @override
  String get qrCodeFormatInvalid =>
      'The scanned QR code does not have an approved format';

  @override
  String get selectImageQrCode => 'Select Image for QR Scan';

  @override
  String get coudntChangeUsername => 'Couldn\'t change username';

  @override
  String get recoverAccount => 'Recovery account';

  @override
  String get contactFriendsForRecovery =>
      'Contact your friends and tell them to free-up your key! The free-ups will only be valid for 24 hours. After their keys are freed up the login sign will appear green and you\'ll have to wait additional 24hours before you can login to your recovered account.';

  @override
  String get friendsKeyIssuers => 'Friends / Key-Issuers';

  @override
  String get socialRecoveryInfo => 'Social Recovery Info';

  @override
  String get stepOneSocialRecovery => 'Step 1: Activate social recovery';

  @override
  String get socialRecoveryTrustSettings =>
      'Social recovery needs to activated in Settings by each user manually. You have to choose 3 friends whom you can meet in person and trust.';

  @override
  String get recoveryStep2 => 'Step 2. Contact each of your friends';

  @override
  String get askFriendsForRecovery =>
      'Ask your friends to open the app and navigate to Profile > Settings > Security > Social Recovery for friends.';

  @override
  String get recoveryStepThree => 'Step 3: Wait 24 hours and then login';

  @override
  String get recoverySecurityIncrease =>
      'To increase security, the recovered user will get contacted, if there is no awnser after 24 hours your account will be freed.';

  @override
  String get connectWithOtherDevices => 'Connect with other device';

  @override
  String get scanQrStepOne => 'Step 1: Open the app on a different device.';

  @override
  String get launchBitnetApp =>
      'Launch the bitnet app on an alternative device where your account is already active and logged in.';

  @override
  String get scanQrStepTwo => 'Step 2: Open the QR-Code';

  @override
  String get navQrRecovery =>
      'Navigate to Profile > Settings > Security > Scan QR-Code for Recovery. You will need to verify your identity now.';

  @override
  String get scanQrStepThree => 'Step 3: Scan the QR-Code with this device';

  @override
  String get pressBtnScanQr =>
      'Press the Button below and scan the QR Code. Wait until the process is finished don\'t leave the app.';

  @override
  String get none => 'Aucun';

  @override
  String get noPasswordRecoveryDescription =>
      'Vous n\'avez pas encore ajouté de moyen pour récupérer votre mot de passe.';

  @override
  String get noPermission => 'Aucune permission';

  @override
  String get noRoomsFound => 'Aucun salon trouvé…';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsEnabledForThisAccount =>
      'Notifications activées pour ce compte';

  @override
  String numUsersTyping(Object count) {
    return '$count utilisateur·ices écrivent…';
  }

  @override
  String get obtainingLocation => 'Obtention de la localisation…';

  @override
  String get offensive => 'Offensant';

  @override
  String get offline => 'Hors ligne';

  @override
  String get ok => 'Valider';

  @override
  String get online => 'En ligne';

  @override
  String get onlineKeyBackupEnabled =>
      'La sauvegarde en ligne des clés est activée';

  @override
  String get oopsPushError =>
      'Oups ! Une erreur s\'est malheureusement produite lors du réglage des notifications.';

  @override
  String get oopsSomethingWentWrong => 'Oups, un problème est survenu…';

  @override
  String get openAppToReadMessages =>
      'Ouvrez l\'application pour lire le message';

  @override
  String get openCamera => 'Ouvrir l\'appareil photo';

  @override
  String get openVideoCamera => 'Ouvrir la caméra pour une vidéo';

  @override
  String get oneClientLoggedOut => 'Un de vos clients a été déconnecté';

  @override
  String get addAccount => 'Ajouter un compte';

  @override
  String get editBundlesForAccount => 'Modifier les groupes pour ce compte';

  @override
  String get addToBundle => 'Ajouter au groupe';

  @override
  String get removeFromBundle => 'Retirer de ce groupe';

  @override
  String get bundleName => 'Nom du groupe';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get enableMultiAccounts =>
      '(BETA) Activer les comptes multiples sur cet appareil';

  @override
  String get openInMaps => 'Ouvrir dans maps';

  @override
  String get link => 'Lien';

  @override
  String get serverRequiresEmail =>
      'Ce serveur doit valider votre adresse électronique pour l\'inscription.';

  @override
  String get optionalGroupName => '(Optionnel) Nom du groupe';

  @override
  String get or => 'Ou';

  @override
  String get participant => 'Participant(e)';

  @override
  String get passphraseOrKey => 'Phrase de passe ou clé de récupération';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordForgotten => 'Mot de passe oublié';

  @override
  String get passwordHasBeenChanged => 'Le mot de passe a été modifié';

  @override
  String get passwordRecovery => 'Récupération du mot de passe';

  @override
  String get pickImage => 'Choisir une image';

  @override
  String get pin => 'Épingler';

  @override
  String play(Object fileName) {
    return 'Lire $fileName';
  }

  @override
  String get pleaseChoose => 'Veuillez choisir';

  @override
  String get pleaseChooseAPasscode => 'Veuillez choisir un code d’accès';

  @override
  String get pleaseChooseAUsername => 'Choisissez un nom d\'utilisateur·ice';

  @override
  String get pleaseClickOnLink =>
      'Veuillez cliquer sur le lien contenu dans le courriel puis continuez.';

  @override
  String get pleaseEnter4Digits =>
      'Veuillez saisir 4 chiffres ou laisser vide pour désactiver le verrouillage de l’application.';

  @override
  String get pleaseEnterAMatrixIdentifier =>
      'Renseignez un identifiant Matrix.';

  @override
  String get pleaseEnterRecoveryKey =>
      'Veuillez saisir votre clé de récupération :';

  @override
  String get pleaseEnterYourPassword => 'Renseignez votre mot de passe';

  @override
  String get passwordShouldBeSixDig =>
      'The password must contain at least 6 characters';

  @override
  String get pleaseEnterYourPin => 'Veuillez saisir votre code PIN';

  @override
  String get pleaseEnterYourUsername =>
      'Renseignez votre nom d\'utilisateur·ice';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Veuillez suivre les instructions sur le site et appuyer sur Suivant.';

  @override
  String get privacy => 'Vie privée';

  @override
  String get publicRooms => 'Salons publics';

  @override
  String get pushRules => 'Règles de notifications';

  @override
  String get reason => 'Motif';

  @override
  String get recording => 'Enregistrement';

  @override
  String redactedAnEvent(Object username) {
    return '$username a supprimé un évènement';
  }

  @override
  String get redactMessage => 'Supprimer un message';

  @override
  String get reject => 'Refuser';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username a refusé l\'invitation';
  }

  @override
  String get rejoin => 'Rejoindre de nouveau';

  @override
  String get remove => 'Supprimer';

  @override
  String get removeAllOtherDevices => 'Supprimer tous les autres appareils';

  @override
  String removedBy(Object username) {
    return 'Supprimé par $username';
  }

  @override
  String get removeDevice => 'Supprimer l\'appareil';

  @override
  String get unbanFromChat => 'Débannissement de la discussion';

  @override
  String get removeYourAvatar => 'Supprimer votre avatar';

  @override
  String get renderRichContent => 'Afficher les contenus riches des messages';

  @override
  String get replaceRoomWithNewerVersion =>
      'Remplacer le salon par une nouvelle version';

  @override
  String get reply => 'Répondre';

  @override
  String get reportMessage => 'Signaler un message';

  @override
  String get requestPermission => 'Demander la permission';

  @override
  String get roomHasBeenUpgraded => 'Le salon a été mis à niveau';

  @override
  String get roomVersion => 'Version du salon';

  @override
  String get saveFile => 'Enregistrer le fichier';

  @override
  String get search => 'Rechercher';

  @override
  String get security => 'Sécurité';

  @override
  String get recoveryKey => 'Clé de récupération';

  @override
  String get recoveryKeyLost => 'Clé de récupération perdue ?';

  @override
  String seenByUser(Object username) {
    return 'Vu par $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, int count) {
    return 'Vu par $username et $count autres';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Vu par $username et $username2';
  }

  @override
  String get send => 'Envoyer';

  @override
  String get sendAMessage => 'Envoyer un message';

  @override
  String get sendAsText => 'Envoyer un texte';

  @override
  String get sendAudio => 'Envoyer un fichier audio';

  @override
  String get sendFile => 'Envoyer un fichier';

  @override
  String get sendImage => 'Envoyer une image';

  @override
  String get sendMessages => 'Envoyer des messages';

  @override
  String get sendOriginal => 'Envoyer le fichier original';

  @override
  String get sendSticker => 'Envoyer un autocollant';

  @override
  String get sendVideo => 'Envoyer une vidéo';

  @override
  String sentAFile(Object username) {
    return '📁 $username a envoyé un fichier';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username a envoyé un fichier audio';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username a envoyé une image';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username a envoyé un autocollant';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username a envoyé une vidéo';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName a envoyé des informations sur l\'appel';
  }

  @override
  String get separateChatTypes =>
      'Séparer les discussions directes et les groupes';

  @override
  String get setAsCanonicalAlias => 'Définir comme adresse principale';

  @override
  String get setCustomEmotes => 'Définir des émoticônes personnalisées';

  @override
  String get setGroupDescription => 'Définir une description du groupe';

  @override
  String get setInvitationLink => 'Créer un lien d\'invitation';

  @override
  String get setPermissionsLevel => 'Définir le niveau de permissions';

  @override
  String get setStatus => 'Définir le statut';

  @override
  String get settings => 'Paramètres';

  @override
  String get share => 'Partager';

  @override
  String sharedTheLocation(Object username) {
    return '$username a partagé sa position';
  }

  @override
  String get shareLocation => 'Partager la localisation';

  @override
  String get showDirectChatsInSpaces =>
      'Afficher les discussions directes associées dans les espaces';

  @override
  String get showPassword => 'Afficher le mot de passe';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get singlesignon => 'Authentification unique';

  @override
  String get skip => 'Ignorer';

  @override
  String get sourceCode => 'Code source';

  @override
  String get spaceIsPublic => 'L\'espace est public';

  @override
  String get spaceName => 'Nom de l\'espace';

  @override
  String startedACall(Object senderName) {
    return '$senderName a démarré un appel';
  }

  @override
  String get startFirstChat => 'Commencez votre première discussion';

  @override
  String get status => 'Statut';

  @override
  String get statusExampleMessage => 'Comment allez-vous aujourd\'hui ?';

  @override
  String get submit => 'Soumettre';

  @override
  String get synchronizingPleaseWait =>
      'Synchronisation... Veuillez patienter.';

  @override
  String get systemTheme => 'Système';

  @override
  String get theyDontMatch => 'Elles ne correspondent pas';

  @override
  String get theyMatch => 'Elles correspondent';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Activer/désactiver en favori';

  @override
  String get toggleMuted => 'Activer/désactiver la sourdine';

  @override
  String get toggleUnread => 'Marquer comme lu / non lu';

  @override
  String get tooManyRequestsWarning =>
      'Trop de requêtes. Veuillez réessayer plus tard !';

  @override
  String get transferFromAnotherDevice =>
      'Transfert à partir d\'un autre appareil';

  @override
  String get tryToSendAgain => 'Retenter l\'envoi';

  @override
  String get unavailable => 'Indisponible';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username a annulé le bannissement de $targetName';
  }

  @override
  String get unblockDevice => 'Retirer le blocage sur l\'appareil';

  @override
  String get unknownDevice => 'Appareil inconnu';

  @override
  String get unknownEncryptionAlgorithm => 'Algorithme de chiffrement inconnu';

  @override
  String get unmuteChat => 'Retirer la sourdine de la discussion';

  @override
  String get unpin => 'Désépingler';

  @override
  String unreadChats(int unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount discussions non lues',
      one: '1 discussion non lue',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username et $count autres sont en train d\'écrire…';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username et $username2 sont en train d\'écrire…';
  }

  @override
  String userIsTyping(Object username) {
    return '$username est en train d\'écrire…';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username a quitté la discussion';
  }

  @override
  String get username => 'Nom d\'utilisateur·ice';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username a envoyé un évènement de type $type';
  }

  @override
  String get unverified => 'Non vérifié';

  @override
  String get verified => 'Vérifié';

  @override
  String get verify => 'Vérifier';

  @override
  String get verifyStart => 'Commencer la vérification';

  @override
  String get verifySuccess => 'La vérification a été effectuée avec succès !';

  @override
  String get verifyTitle => 'Vérification de l\'autre compte';

  @override
  String get videoCall => 'Appel vidéo';

  @override
  String get visibilityOfTheChatHistory =>
      'Visibilité de l\'historique de la discussion';

  @override
  String get visibleForAllParticipants =>
      'Visible pour tous les participant·es';

  @override
  String get visibleForEveryone => 'Visible pour tout le monde';

  @override
  String get voiceMessage => 'Message vocal';

  @override
  String get waitingPartnerAcceptRequest =>
      'En attente de l\'acceptation de la demande par le partenaire…';

  @override
  String get waitingPartnerEmoji =>
      'En attente de l\'acceptation de l\'émoji par le partenaire…';

  @override
  String get waitingPartnerNumbers =>
      'En attente de l\'acceptation des nombres par le partenaire…';

  @override
  String get wallpaper => 'Image de fond';

  @override
  String get warning => 'Attention !';

  @override
  String get weSentYouAnEmail => 'Nous vous avons envoyé un courriel';

  @override
  String get whoCanPerformWhichAction => 'Qui peut faire quelle action';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Qui est autorisé·e à rejoindre ce groupe';

  @override
  String get whyDoYouWantToReportThis => 'Pourquoi voulez-vous le signaler ?';

  @override
  String get wipeChatBackup =>
      'Effacer la sauvegarde de votre discussion pour créer une nouvelle clé de récupération ?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Grâce à ces adresses, vous pouvez récupérer votre mot de passe si vous en avez besoin.';

  @override
  String get writeAMessage => 'Écrivez un message…';

  @override
  String get yes => 'Oui';

  @override
  String get you => 'Vous';

  @override
  String get youAreInvitedToThisChat => 'Vous êtes invité·e à cette discussion';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Vous ne participez plus à cette discussion';

  @override
  String get youCannotInviteYourself =>
      'Vous ne pouvez pas vous inviter vous-même';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Vous avez été banni·e de cette discussion';

  @override
  String get yourPublicKey => 'Votre clé publique';

  @override
  String get messageInfo => 'Informations sur le message';

  @override
  String get time => 'Heure';

  @override
  String get messageType => 'Type de message';

  @override
  String get sender => 'Expéditeur/trice';

  @override
  String get openGallery => 'Ouvrir dans la Galerie';

  @override
  String get removeFromSpace => 'Supprimer de l’espace';

  @override
  String get addToSpaceDescription =>
      'Sélectionnez un espace pour y ajouter cette discussion.';

  @override
  String get start => 'Commencer';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Pour déverrouiller vos anciens messages, veuillez entrer votre clé de récupération qui a été générée lors d\'une session précédente. Votre clé de récupération n\'est PAS votre mot de passe.';

  @override
  String get addToStory => 'Ajouter à la story';

  @override
  String get publish => 'Publier';

  @override
  String get whoCanSeeMyStories => 'Qui peut voir mes stories ?';

  @override
  String get unsubscribeStories => 'Se désinscrire des stories';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Cet(te) utilisateur(trice) n\'a encore rien posté dans sa story';

  @override
  String get yourStory => 'Votre story';

  @override
  String get replyHasBeenSent => 'La réponse a été envoyée';

  @override
  String videoWithSize(Object size) {
    return 'Vidéo ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Story du $date : \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Veuillez noter que les personnes peuvent se voir et se contacter dans votre story.';

  @override
  String get whatIsGoingOn => 'Que se passe-t-il ?';

  @override
  String get addDescription => 'Ajouter une description';

  @override
  String get storyPrivacyWarning =>
      'Veuillez noter que les personnes peuvent se voir et se contacter dans votre story. Vos stories seront visibles pendant 24 heures, mais il n\'y a aucune garantie qu\'elles seront supprimées de tous les appareils et de tous les serveurs.';

  @override
  String get iUnderstand => 'Je comprends';

  @override
  String get openChat => 'Ouvrir la discussion';

  @override
  String get markAsRead => 'Marquer comme lu';

  @override
  String get reportUser => 'Signaler l\'utilisateur/trice';

  @override
  String get dismiss => 'Rejeter';

  @override
  String get matrixWidgets => 'Widgets Matrix';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender a réagi avec $reaction';
  }

  @override
  String get pinMessage => 'Épingler au salon';

  @override
  String get confirmEventUnpin =>
      'Voulez-vous vraiment désépingler définitivement l\'événement ?';

  @override
  String get emojis => 'Émojis';

  @override
  String get placeCall => 'Passer un appel';

  @override
  String get voiceCall => 'Appel vocal';

  @override
  String get unsupportedAndroidVersion =>
      'Version d\'Android non prise en charge';

  @override
  String get unsupportedAndroidVersionLong =>
      'Cette fonctionnalité nécessite une nouvelle version d\'Android. Veuillez vérifier les mises à jour ou la prise en charge de Lineage OS.';

  @override
  String get videoCallsBetaWarning =>
      'Veuillez noter que les appels vidéo sont actuellement en version bêta. Ils peuvent ne pas fonctionner comme prévu ou ne oas fonctionner du tout sur toutes les plateformes.';

  @override
  String get experimentalVideoCalls => 'Appels vidéo expérimentaux';

  @override
  String get emailOrUsername => 'Courriel ou identifiant';

  @override
  String get indexedDbErrorTitle => 'Problèmes relatifs au mode privé';

  @override
  String get indexedDbErrorLong =>
      'Le stockage des messages n\'est malheureusement pas activé par défaut en mode privé.\nVeuillez consulter :\n - about:config\n - Définir dom.indexedDB.privateBrowsing.enabled à « vrai ».\nSinon, il n\'est pas possible d\'exécuter FluffyChat.';

  @override
  String switchToAccount(Object number) {
    return 'Passer au compte $number';
  }

  @override
  String get nextAccount => 'Compte suivant';

  @override
  String get previousAccount => 'Compte précédent';

  @override
  String get editWidgets => 'Modifier les widgets';

  @override
  String get addWidget => 'Ajouter un widget';

  @override
  String get widgetVideo => 'Vidéo';

  @override
  String get widgetEtherpad => 'Note textuelle';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Personnalisé';

  @override
  String get widgetName => 'Nom';

  @override
  String get value => 'Value';

  @override
  String get currentBatches => 'Current Batches';

  @override
  String get createPost => 'Create Post';

  @override
  String get post => 'POST';

  @override
  String get nextBlock => 'Next Block';

  @override
  String get mempoolBlock => 'Mempool block';

  @override
  String get block => 'Block';

  @override
  String get minedAt => 'Mined at';

  @override
  String get miner => 'Miner';

  @override
  String get minerRewardAndFees => 'Miner Reward (Subsidy + fees)';

  @override
  String get blockChain => 'Blockchain';

  @override
  String get cancelDelete => 'Cancel and delete';

  @override
  String get uploadToBlockchain => 'Upload to Blockchain';

  @override
  String get bitnetUsageFee => 'BitNet usage fee';

  @override
  String get transactionFees => 'Transaction fees';

  @override
  String get costEstimation => 'Cost Estimation';

  @override
  String get addMore => 'Add more';

  @override
  String get errorFinalizingBatch => 'Error finalizing batch';

  @override
  String get fianlizePosts => 'Finalize Posts';

  @override
  String get assetMintError =>
      'Failed to mint asset: You might already have an asset with a similar name in your list.';

  @override
  String get addContent => 'Add Content';

  @override
  String get typeMessage => 'Type message';

  @override
  String get postContentError => 'Please add some content to your post';

  @override
  String get nameYourAsset => 'Name your Asset';

  @override
  String get widgetUrlError => 'Ceci n\'est pas un lien valide.';

  @override
  String get widgetNameError => 'Veuillez fournir un nom d\'affichage.';

  @override
  String get errorAddingWidget => 'Erreur lors de l\'ajout du widget.';

  @override
  String get youRejectedTheInvitation => 'Vous avez rejeté l\'invitation';

  @override
  String get youJoinedTheChat => 'Vous avez rejoint la discussion';

  @override
  String get youAcceptedTheInvitation => '👍 Vous avez accepté l\'invitation';

  @override
  String youBannedUser(Object user) {
    return 'Vous avez banni $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Vous avez retiré l\'invitation pour $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 Vous avez été invité par $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 Vous avez invité $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 Vous avez dégagé $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 Vous avez dégagé et banni $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Vous avez débanni $user';
  }

  @override
  String get noEmailWarning =>
      'Veuillez saisir une adresse électronique valide. Sinon, vous ne pourrez pas réinitialiser votre mot de passe. Si vous ne voulez pas le faire, appuyez à nouveau sur le bouton pour continuer.';

  @override
  String get stories => 'Stories';

  @override
  String get users => 'Utilisateurs/trices';

  @override
  String get unlockOldMessages => 'Déverrouiller les anciens messages';

  @override
  String get storeInSecureStorageDescription =>
      'Stocker la clé de récupération dans un espace sécurisé de cet appareil.';

  @override
  String get saveKeyManuallyDescription =>
      'Enregistrer cette clé manuellement en déclenchant la boîte de dialogue de partage du système ou le presse-papiers.';

  @override
  String get storeInAndroidKeystore => 'Stocker dans Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Stocker dans Apple KeyChain';

  @override
  String get storeSecurlyOnThisDevice =>
      'Stocker de manière sécurisé sur cet appareil';

  @override
  String countFiles(Object count) {
    return '$count fichiers';
  }

  @override
  String get user => 'Utilisateur/trice';

  @override
  String get custom => 'Personnalisé';

  @override
  String get foregroundServiceRunning =>
      'Cette notification s’affiche lorsque le service au premier plan est en cours d’exécution.';

  @override
  String get screenSharingTitle => 'Partage d\'écran';

  @override
  String get screenSharingDetail => 'Vous partagez votre écran dans FuffyChat';

  @override
  String get callingPermissions => 'Permissions d\'appel';

  @override
  String get callingAccount => 'Compte d\'appel';

  @override
  String get callingAccountDetails =>
      'Permet à FluffyChat d\'utiliser l\'application de numérotation native d\'Android.';

  @override
  String get appearOnTop => 'Apparaître en haut';

  @override
  String get appearOnTopDetails =>
      'Permet à l\'application d\'apparaître en haut de l\'écran (non nécessaire si vous avez déjà configuré Fluffychat comme compte d\'appel)';

  @override
  String get otherCallingPermissions =>
      'Microphone, caméra et autres autorisations de FluffyChat';

  @override
  String get whyIsThisMessageEncrypted =>
      'Pourquoi ce message est-il illisible ?';

  @override
  String get noKeyForThisMessage =>
      'Cela peut se produire si le message a été envoyé avant que vous ne vous soyez connecté à votre compte sur cet appareil.\n\nIl est également possible que l\'expéditeur ait bloqué votre appareil ou qu\'un problème de connexion Internet se soit produit.\n\nÊtes-vous capable de lire le message sur une autre session ? Vous pouvez alors transférer le message à partir de celle-ci ! Allez dans Paramètres > Appareils et assurez-vous que vos appareils se sont vérifiés mutuellement. Lorsque vous ouvrirez le salon la fois suivante et que les deux sessions seront au premier plan, les clés seront transmises automatiquement.\n\nVous ne voulez pas perdre les clés en vous déconnectant ou en changeant d\'appareil ? Assurez-vous que vous avez activé la sauvegarde de la discussion dans les paramètres.';

  @override
  String get newGroup => 'Nouveau groupe';

  @override
  String get newSpace => 'Nouvel espace';

  @override
  String get enterSpace => 'Entrer dans l’espace';

  @override
  String get enterRoom => 'Entrer dans le salon';

  @override
  String get allSpaces => 'Tous les espaces';

  @override
  String numChats(Object number) {
    return '$number discussions';
  }

  @override
  String get hideUnimportantStateEvents =>
      'Masquer les événements d\'état sans importance';

  @override
  String get doNotShowAgain => 'Ne plus afficher';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Discussion vide (était $oldDisplayName)';
  }

  @override
  String get language => 'English';

  @override
  String get searchC => 'Search Currency Here';

  @override
  String get searchL => 'Search Language Here';

  @override
  String get cc => 'Currency Converter';

  @override
  String get convert => 'Convert';

  @override
  String get enterA => 'Enter Amount';

  @override
  String get from => 'From';

  @override
  String get amount => 'Amount';

  @override
  String get bitcoinChart => 'Bitcoin chart';

  @override
  String get to => 'To';

  @override
  String get recentTransactions => 'Recent transactions';

  @override
  String get fee => 'Fee';

  @override
  String get analysis => 'Analysis';

  @override
  String get addAMessage => 'Add a message...';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get accelerate => 'Accelerate';

  @override
  String get generateInvoice => 'Generate Invoice';

  @override
  String get features => 'Features';

  @override
  String get sendNow => 'SEND NOW!';

  @override
  String get youAreOverLimit => 'You are over the sending limit.';

  @override
  String get youAreUnderLimit => 'You are under the sending baseline';

  @override
  String get walletAddressCopied => 'Wallet address copied to clipboard';

  @override
  String get invoice => 'Invoice';

  @override
  String get receiveBitcoin => 'Receive Bitcoin';

  @override
  String get changeAmount => 'Change Amount';

  @override
  String get optimal => 'Optimal';

  @override
  String get overpaid => 'Overpaid';

  @override
  String get searchReceipient => 'Search for recipients';

  @override
  String get chooseReceipient => 'Choose Receipient';

  @override
  String get feeRate => 'Fee rate';

  @override
  String get afterTx => 'After ';

  @override
  String get highestAssesment => 'Highest assesment:';

  @override
  String get lowestAssesment => 'Lowest assesment:';

  @override
  String get inSeveralHours => 'In Several hours (or more)';

  @override
  String get minutesTx => ' minutes';

  @override
  String get analysisStockCovered =>
      'The stock is covered by 67 analysts. The average assesment is:';

  @override
  String get low => 'Low';

  @override
  String get unknown => 'Unknown';

  @override
  String get timestamp => 'Timestamp';

  @override
  String get typeTx => 'Type';

  @override
  String get address => 'Address';

  @override
  String get rbf => 'RBF';

  @override
  String get mined => 'Mined ';

  @override
  String get fullRbf => 'Full RBF';

  @override
  String get newFee => 'New Fee';

  @override
  String get previousFee => 'Previous fee';

  @override
  String get recentReplacements => 'Recent replacements';

  @override
  String get median => 'Median: ';

  @override
  String get feeDistribution => 'Fee Distribution';

  @override
  String get blockSize => 'Block Size';

  @override
  String get health => 'Health';

  @override
  String get difficultyAdjustment => 'Difficulty Adjustment';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get his => 'History';

  @override
  String get qou => 'Currency Rates by Open Exchange Rates';

  @override
  String get newSpaceDescription =>
      'Les espaces vous permettent de consolider vos conversations et de construire des communautés privées ou publiques.';

  @override
  String get encryptThisChat => 'Chiffrer cette discussion';

  @override
  String get endToEndEncryption => 'Chiffrement de bout en bout';

  @override
  String get disableEncryptionWarning =>
      'Pour des raisons de sécurité, vous ne pouvez pas désactiver le chiffrement dans une discussion s\'il a été activé avant.';

  @override
  String get sorryThatsNotPossible => 'Désolé, ce n\'est pas possible';

  @override
  String get deviceKeys => 'Clés de l’appareil :';

  @override
  String get letsStart => 'C\'est parti';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Entrez le lien d\'invitation ou l\'ID Matrix...';

  @override
  String get reopenChat => 'Rouvrir la discussion';

  @override
  String get noBackupWarning =>
      'Attention ! Sans l\'activation de la sauvegarde de la discussion, vous perdrez l\'accès à vos messages chiffrés. Il est fortement recommandé d\'activer la sauvegarde de la discussion avant de se déconnecter.';

  @override
  String get noOtherDevicesFound => 'Aucun autre appareil trouvé';

  @override
  String get fileIsTooBigForServer =>
      'Le serveur signale que le fichier est trop volumineux pour être envoyé.';

  @override
  String fileHasBeenSavedAt(Object path) {
    return 'Le fichier a été enregistré dans $path';
  }

  @override
  String get jumpToLastReadMessage => 'Aller au dernier message lu';

  @override
  String get readUpToHere => 'Lisez jusqu’ici';

  @override
  String get jump => 'Jump';

  @override
  String get openLinkInBrowser => 'Open link in browser';

  @override
  String get reportErrorDescription =>
      'Oh no. Something went wrong. Please try again later. If you want, you can report the bug to the developers.';

  @override
  String get report => 'report';

  @override
  String get totalWalletBal => 'Total Wallet Balance';

  @override
  String get actions => 'Actions';

  @override
  String get buy => 'Buy';

  @override
  String get sell => 'Sell';

  @override
  String get balance => 'Balance';

  @override
  String get receive => 'Receive';

  @override
  String get rebalance => 'Rebalance';

  @override
  String get buySell => 'Buy & Sell';

  @override
  String get activity => 'Activity';

  @override
  String get add => 'Add';

  @override
  String get whitePaper => 'Whitepaper';

  @override
  String get fundUs => 'Fund us';

  @override
  String get ourTeam => 'Our Team';

  @override
  String get weAreLight => 'We are the light that helps others see Bitcoin.';

  @override
  String get aboutUs => 'About us';

  @override
  String get reportWeb => 'Report';

  @override
  String get beAPart => 'Be a Part of the Revolution - Download Our App Today!';

  @override
  String get moreAndMore =>
      'More and more decide to join our community each day! Let\'s build something extraordinary together.';

  @override
  String get pleaseLetUsKnow => 'Please let us know what went wrong...';

  @override
  String get reportError => 'Report error';

  @override
  String get pleaseProvideErrorMsg => 'Please provide an error message first.';

  @override
  String get yourErrorReportForwarded =>
      'Your error report has been forwarded.';

  @override
  String get imLiterallyOnlyPerson =>
      'I\'m literally the only person who has submitted an idea so far.';

  @override
  String get imLiterallyOnlyPerson2 =>
      'I\'m literally the only submitted an idea so far.';

  @override
  String get imLiterallyOnlyPerson3 =>
      'y the only person who has submitted an idea so far.';

  @override
  String get submitIdea => 'Submit Idea';

  @override
  String get ideaLeaderboard => 'Idea Leaderboard';

  @override
  String get shapeTheFuture =>
      'Shape the Future with us! We Want to Hear Your Brilliant Ideas!';

  @override
  String get submitReport => 'Submit report!';

  @override
  String get yourIssuesGoesHere => 'Your issue goes here';

  @override
  String get yourIdeasGoesHere => 'Your idea goes here';

  @override
  String get contactInfoHint => 'Contact information (Email, username, did...)';

  @override
  String get contactInfo => 'Contact information';

  @override
  String get reportIssue => 'Report Issue';

  @override
  String get email => 'Email:';

  @override
  String get phone => 'Phone:';

  @override
  String get disclaimer => 'Disclaimer:';

  @override
  String get referencesLinks =>
      'References and links: In the case of direct or indirect references \nto external websites that are outside the provider\'s area of responsibility, \na liability obligation would only come into effect in the event that the provider \nhas knowledge of the content and it is technically possible and reasonable to prevent \nthe use in the case of illegal content. The provider hereby expressly declares \nthat at the time the links were set, no illegal content was recognizable on the linked pages. \nThe provider has no influence on the current and future design, content, or authorship of \nthe linked/connected pages. Therefore, the provider hereby expressly distances himself from all contents \nof all linked/connected pages.';

  @override
  String get availabilityProvider =>
      'Availability: The provider expressly reserves the right to \nchange, supplement, delete parts of the pages or the entire offer without \nspecial notice, or to temporarily or permanently cease publication.';

  @override
  String get contentOnlineOffer =>
      'Content of the online offer: The provider assumes no responsibility for the timeliness, \ncorrectness, completeness, or quality of the provided \ninformation. Liability claims against the provider relating to \nmaterial or immaterial damage caused by the use or \nnon-use of the provided information or by the use of \nincorrect and incomplete information are \ngenerally excluded, provided that there is no demonstrable \nintentional or grossly negligent fault on the part of the provider.';

  @override
  String get responsibleForContent => 'Responsible for the content:';

  @override
  String get contact => 'Contact:';

  @override
  String get contacts => 'Contact';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get friedrichshafen => '88405 Friedrichshafen';

  @override
  String get imprint => 'Imprint';

  @override
  String get vision => 'Vision';

  @override
  String get product => 'Product';

  @override
  String get getStarted => 'Get Started';

  @override
  String get weBelieve =>
      'We believe in empowering our people and building true loyalty!';

  @override
  String get butBitcoin =>
      'But Bitcoin is more than just a digital asset; it\'s a movement. A movement towards a more open, accessible, and equitable future. \nBitNet wants be at the forefront of the digital age as a pioneer in asset digitization using Bitcoin,\n shaping a metaverse where equality, security, and sustainability\n are not just ideals, but realities. Our vision is to create an\n interconnected digital world where every user can seamlessly and\n fairly access, exchange, and grow their digital assets.';

  @override
  String get fallenBrunnen => 'Fallenbrunnen 12';

  @override
  String get bitnerGMBH => 'BitNet GmbH';

  @override
  String get functionality => 'Functionality:';

  @override
  String get termsAndConditionsDescription =>
      'These terms and conditions govern the use of the Bitcoin Wallet App\n(hereinafter referred to as BitNet), which is provided by BitNet GmbH.\nBy using the app, you agree to these terms and conditions.';

  @override
  String get scope => 'Scope:';

  @override
  String get provider => 'Provider:';

  @override
  String get fees => 'Fees:';

  @override
  String get changes => 'Changes:';

  @override
  String get termsAndConditionsEntire =>
      'These terms and conditions constitute the entire agreement between the user and BitNet.\nShould any provision be ineffective, the remaining provisions shall remain in force.';

  @override
  String get finalProvisions => 'Final Provisions:';

  @override
  String get walletReserves =>
      'BitNet reserves the right to change these terms and conditions at any time.\nThe user will be informed of such changes and must agree to them in order to continue using the app.';

  @override
  String get walletLiable =>
      'BitNet is only liable for damages caused by intentional or grossly negligent actions by\nBitNet. The company is not liable for damages resulting from the use of the app or the loss of Bitcoins.';

  @override
  String get limitationOfLiability => 'Limitation of Liability:';

  @override
  String get certainFeaturesOfApp =>
      'Certain features of the app may incur fees.\nThese fees will be communicated to the user in advance and\nare visible in the app.';

  @override
  String get userSolelyResponsible =>
      'The user is solely responsible for the security of their Bitcoins. The app offers security features such as password protection and two-factor authentication,\nbut it is the user\'s responsibility to use these features carefully.\nBitNet is not liable for losses due to negligence, loss of devices, or user access data.';

  @override
  String get userResponsibility => 'User Responsibility:';

  @override
  String get appAllowsUsers =>
      'The app allows users to receive, send, and manage Bitcoins.\nThe app is not a bank and does not offer banking services.';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get loopScreen => 'Loop Screen';

  @override
  String get onChainLightning => 'Onchain to Lightning';

  @override
  String get lightningTransactionSettled => 'Lightning invoice settled';

  @override
  String get onChainInvoiceSettled => 'Onchain transaction settled';

  @override
  String get lightningOnChain => 'Lightning to Onchain';

  @override
  String get shareQrCode => 'Share Profile QR Code';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get changeCurrency => 'Change Currency';

  @override
  String get plainKeyDID => 'Plain Key and DID';

  @override
  String get recoverQrCode => 'Recover with QR Code';

  @override
  String get recoveryPhrases => 'Recovery phrases';

  @override
  String get socialRecovery => 'Social recovery';

  @override
  String get humanIdentity => 'Human Identity';

  @override
  String get extendedSec => 'Extended Sec';

  @override
  String get verifyYourIdentity => 'Verify your identity';

  @override
  String get diDprivateKey => 'DID and private key';

  @override
  String get wordRecovery => 'Word recovery';

  @override
  String get color => 'Color';

  @override
  String get addAttributes => 'Add attributes';

  @override
  String get overlayErrorOccured => 'An error occured, please try again later.';

  @override
  String get restoreOptions => 'Restore options';

  @override
  String get useDidPrivateKey => 'Use DID and Private Key';

  @override
  String get locallySavedAccounts => 'Locally saved accounts';

  @override
  String get confirmMnemonic => 'Confirm your mnemonic';

  @override
  String get ownSecurity => 'Own Security';

  @override
  String get agbsImpress => 'Agbs and Impressum';
}
