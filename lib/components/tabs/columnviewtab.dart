import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/postmodels/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColumnViewTab extends StatefulWidget {
  const ColumnViewTab({super.key});

  @override
  State<ColumnViewTab> createState() => _ColumnViewTabState();
}

class _ColumnViewTabState extends State<ColumnViewTab> {
  bool isLoading = false;
  List<Post> posts = [];
  int postCount = 0;

  @override
  void initState() {
    super.initState();
  }

  void fetchTaprootAssets() async {
    setState(() {
      isLoading = true;
    });
    try {
      dynamic snapshot = await listTaprootAssets();
      print("RESPONSE: $snapshot");
      //posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
      //order by timestamp is still needed (decening)
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
          height: AppTheme.cardPadding * 5.h, child: dotProgress(context));
    } else if (posts.isEmpty && isLoading) {
      //hier noch design definitv ändern!!! irgendein 3d bild oder so
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            Text(
              'No posts found',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    } else {
      return Column(children: posts);
    }
  }
}
