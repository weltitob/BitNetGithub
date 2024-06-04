// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m26(date, timeOfDay) => "${date}, ${timeOfDay}";

  static String m27(year, month, day) => "${day}-${month}-${year}";

  static String m28(month, day) => "${day}-${month}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Sobre"),
        "account": MessageLookupByLibrary.simpleMessage("Conta"),
        "admin": MessageLookupByLibrary.simpleMessage("Admin"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Tens a certeza?"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "close": MessageLookupByLibrary.simpleMessage("Fechar"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage(
            "Copiada para a área de transferência"),
        "dateAndTimeOfDay": m26,
        "dateWithYear": m27,
        "dateWithoutYear": m28,
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "help": MessageLookupByLibrary.simpleMessage("Ajuda"),
        "login": MessageLookupByLibrary.simpleMessage("Iniciar sessão"),
        "logout": MessageLookupByLibrary.simpleMessage("Terminar sessão"),
        "messages": MessageLookupByLibrary.simpleMessage("Mensagens"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notificações"),
        "openCamera": MessageLookupByLibrary.simpleMessage("Abrir câmara"),
        "privacy": MessageLookupByLibrary.simpleMessage("Privacidade"),
        "reason": MessageLookupByLibrary.simpleMessage("Razão"),
        "search": MessageLookupByLibrary.simpleMessage("Pesquisar"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
        "users": MessageLookupByLibrary.simpleMessage("Utilizadores")
      };
}
