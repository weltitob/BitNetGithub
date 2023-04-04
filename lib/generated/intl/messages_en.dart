// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
            "You already have an registered Account?"),
        "codeAlreadyUsed": MessageLookupByLibrary.simpleMessage(
            "It seems like this code has already been used"),
        "codeNotValid":
            MessageLookupByLibrary.simpleMessage("Code is not valid."),
        "errorSomethingWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "helloWorld": MessageLookupByLibrary.simpleMessage("Hello World!"),
        "invitationCode":
            MessageLookupByLibrary.simpleMessage("Invitation Code"),
        "noAccountYet": MessageLookupByLibrary.simpleMessage(
            "You don\'t have an account yet?"),
        "pinCodeVerification":
            MessageLookupByLibrary.simpleMessage("Pin Code Verification"),
        "platformDemandText": MessageLookupByLibrary.simpleMessage(
            "We\'re thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users."),
        "platformExlusivityText": MessageLookupByLibrary.simpleMessage(
            "We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration."),
        "platformExpandCapacityText": MessageLookupByLibrary.simpleMessage(
            "Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!"),
        "powerToThePeople":
            MessageLookupByLibrary.simpleMessage("Power to the people!"),
        "poweredByDIDs": MessageLookupByLibrary.simpleMessage(
            "Powered with decentralized IDs by"),
        "privateKey": MessageLookupByLibrary.simpleMessage("Private Key"),
        "publicIONKey": MessageLookupByLibrary.simpleMessage("Public ION Key"),
        "register": MessageLookupByLibrary.simpleMessage("Create Account"),
        "restoreWallet": MessageLookupByLibrary.simpleMessage("Restore Wallet"),
        "restoreWith24words": MessageLookupByLibrary.simpleMessage(
            "Restore Account with 24 words"),
        "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back!")
      };
}
