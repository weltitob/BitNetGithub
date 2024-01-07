import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:flutter/material.dart';

//USED FOR UPLOAD SCREEN (USER ENTERS TEXT LOCALLY)
class TextBuilderLocal extends StatelessWidget {
  final PostFile postFile;
  const TextBuilderLocal({
    Key? key,
    required this.postFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        minLines: 1,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodyMedium,
        initialValue: postFile.text,
        decoration: InputDecoration(
          hintText: "Enter Text Here",
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

