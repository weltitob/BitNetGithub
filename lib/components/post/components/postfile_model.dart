import 'dart:io';

import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/pages/create/create_post_screen.dart';

class PostFile {
  String? text;
  final File? file;
  final MediaType type;

  PostFile(
      this.type,
      {this.file, this.text});
}