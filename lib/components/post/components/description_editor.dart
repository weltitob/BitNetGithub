import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:flutter/material.dart';

// An editable description field for post creation
class DescriptionEditorLocal extends StatelessWidget {
  final PostFile postFile;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  
  const DescriptionEditorLocal({
    Key? key,
    required this.postFile,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the controller if provided, otherwise manage state locally
    // This allows external focus control while still updating the PostFile
    if (controller != null) {
      controller!.text = postFile.text ?? '';
    }
    
    return CommonHeading(
      headingText: 'Description',
      hasButton: false,
      collapseBtn: false,
      child: Container(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: controller != null ? 
          // Use the provided controller
          TextField(
            controller: controller,
            focusNode: focusNode,
            minLines: 3,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: "Enter description here...",
              border: InputBorder.none,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).hintColor,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.elementSpacing, 
                vertical: AppTheme.elementSpacing / 2
              ),
            ),
            onChanged: (value) {
              postFile.text = value;
            },
          )
          // Use local state
          : TextFormField(
            initialValue: postFile.text,
            focusNode: focusNode,
            minLines: 3,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: "Enter description here...",
              border: InputBorder.none,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).hintColor,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.elementSpacing, 
                vertical: AppTheme.elementSpacing / 2
              ),
            ),
            onChanged: (value) {
              postFile.text = value;
            },
          ),
      ),
    );
  }
}