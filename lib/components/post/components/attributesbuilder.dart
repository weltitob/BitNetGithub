import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:flutter/material.dart';


//USED FOR UPLOAD SCREEN (USER PICKS FILE LOCALLY)
class AttributesBuilder extends StatelessWidget {
  final String attributes;
  const AttributesBuilder({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //cinvert the data to a map and then create a widget for each attribute
    print("Attributes should be displayed here: $attributes");
    return Text("Attributes should be displayed here: $attributes");
  }
}

