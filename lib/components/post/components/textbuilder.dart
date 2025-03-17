import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:flutter/material.dart';

//USED FOR UPLOAD SCREEN (USER ENTERS TEXT LOCALLY)
class TextBuilderLocal extends StatelessWidget {
  final PostFile postFile;
  final bool isDescription;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  
  const TextBuilderLocal({
    Key? key,
    required this.postFile,
    this.isDescription = false,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For a description field with controller
    if (isDescription && controller != null) {
      // Sync controller with PostFile on first build
      if (controller!.text.isEmpty && postFile.text != null && postFile.text!.isNotEmpty) {
        controller!.text = postFile.text!;
      } else if (controller!.text.isNotEmpty && (postFile.text == null || postFile.text!.isEmpty)) {
        postFile.text = controller!.text;
      }
      
      return Container(
        child: TextField(
          minLines: 3,
          maxLines: 8,
          keyboardType: TextInputType.multiline,
          style: Theme.of(context).textTheme.bodyMedium,
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            hintText: "Enter description here...",
            border: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          onChanged: (value) {
            postFile.text = value;
          },
        ),
      );
    }
    
    // Standard implementation for non-description fields
    return Container(
      child: TextFormField(
        minLines: isDescription ? 3 : 1,
        maxLines: isDescription ? 8 : 5,
        keyboardType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodyMedium,
        initialValue: postFile.text,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: isDescription ? "Enter description here..." : "Enter Text Here",
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        onChanged: (value) {
          postFile.text = value;
        },
      ),
    );
  }
}

//USED FOR TEXT IN FEED ETC. TEXT IS FETCHED FROM DATABASE
class TextBuilderNetwork extends StatelessWidget {
  final String url;
  const TextBuilderNetwork({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(url,
      style: Theme.of(context).textTheme.bodyMedium,),
    );
  }
}

