import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


//USED FOR UPLOAD SCREEN (USER PICKS FILE LOCALLY)
class ImageBuilderLocal extends StatelessWidget {
  final PostFile postFile;
  const ImageBuilderLocal({
    Key? key,
    required this.postFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ImageBox(
      child: Image.file(
        postFile.file!,
        height: size.height * 0.4,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

//USED FOR POSTS IN FEED ETC. IMAGE IS FETCHED FROM DATABASE
class ImageBuilderNetwork extends StatelessWidget {
  final String url;
  const ImageBuilderNetwork({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageBox(
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => Padding(
                child: Center(child: CircularProgressIndicator()),
                padding: EdgeInsets.all(25.0),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
            ));
  }
}

class ImageBox extends StatelessWidget {
  final Widget child;

  const ImageBox({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 2.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: child)),
      ],
    );
  }
}

