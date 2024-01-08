// Function to generate and store verification codes
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> generateAndStoreVerificationCodes({
  required int numCodes,
  required int codeLength,
  required String issuer,
  required CollectionReference codesCollection,
}) async {
  try{
    List<String> codes = [];

    for (var i = 0; i < numCodes; i++) {
      String code = getRandomString(codeLength);
      codes.add(code);
    }

    codes.forEach((element) async {
      final code = VerificationCode(
        used: false,
        code: element,
        issuer: issuer,
        receiver: '',
      );
      await codesCollection.doc(element).set(code.toJson());
    });

    print('Generated and stored verification codes');
  } catch (e){
    print("Error trying to generate new verification codes: $e");
  }
}

// Function to mark a verification code as used and update the data
Future<void> markVerificationCodeAsUsed({
  required VerificationCode code,
  required String receiver,
  required CollectionReference codesCollection,
}) async {
  try{
    print("Marking verification code as used...");
    VerificationCode newCode = VerificationCode(
      issuer: code.issuer,
      used: true,
      code: code.code,
      receiver: receiver,
    );

    print("Code being used: ${code.code}");
    await codesCollection.doc(code.code).update(newCode.toJson());
    print('Marked verification code as used');
  } catch (e){
    print("Error trying to mark verification code: $e");
  }
}
