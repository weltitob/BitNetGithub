import 'dart:io';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {
  final MediaType mediaType;

  FilePickerService(this.mediaType);

  Future<File?> pickFile() async {
    if (mediaType == MediaType.image){
      final file = await ImagePicker().pickImage(
          source: ImageSource.camera, imageQuality: 10
      );
      if (file ==  null)return null;
      return File(file.path);
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: _getFileTypeFromMediaType(),
        allowedExtensions: _getAllowedExtensionFromMediaType(), // ['jpg', 'pdf', 'doc'],
        allowMultiple: false,);
        if (result == null  || result.files.isEmpty)return null;
        return File(result.files.first.path!) ;
  }

  FileType _getFileTypeFromMediaType() {
    if (mediaType == MediaType.image) return FileType.image;

    if (mediaType == MediaType.audio) return FileType.audio;
    return FileType.custom;
  }

  List<String>? _getAllowedExtensionFromMediaType() {
    if (mediaType == MediaType.document) return ['doc'];
    //if (mediaType == MediaType.d) return ['pdf'];
    return null;
  }
}
//todo sich das angucken und image compression clean machen
// showFilePicker(FileType fileType) async {
//   File file;
//   if (fileType == FileType.IMAGE)
//     file = await ImagePicker.pickImage(
//         source: ImageSource.gallery, imageQuality: 70);
//   else
//     file = await FilePicker.getFile(type: fileType);
//
//   if (file == null) return;
//   chatBloc.dispatch(SendAttachmentEvent(chat.chatId, file, fileType));
//   Navigator.pop(context);
//   GradientSnackBar.showMessage(context, 'Sending attachment..');
// }
