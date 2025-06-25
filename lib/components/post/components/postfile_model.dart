import 'dart:io';

import 'package:bitnet/backbone/helper/helpers.dart';

class PostFile {
  String? text;
  final File? file;
  final MediaType type;

  PostFile(this.type, {this.file, this.text});
}
