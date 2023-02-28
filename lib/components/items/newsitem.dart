import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/pages/secondpages/newsscreen.dart';
import 'package:nexus_wallet/theme.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl, author, publishedAt;

  NewsTile({
    required this.imgUrl,
    required this.desc,
    required this.title,
    required this.publishedAt,
    required this.content,
    required this.author,
    required this.posturl
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsScreen(
              postUrl: posturl,
            )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 1.5),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          ),
          child: Row(
            children: [
              NewsPicture(imgUrl: imgUrl,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: AppTheme.elementSpacing, top: 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            child: Text(
                                posturl.replaceAll("https://", "").replaceAll("www.", ""),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.overline
                            ),
                          ),
                          Text(
                            displayTimeAgoFromTimestamp(publishedAt),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsPicture extends StatelessWidget {
  final String imgUrl;

  const NewsPicture({
    Key? key,
    required this.imgUrl,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.elementSpacing * 0.5),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            borderRadius: AppTheme.cardRadiusSmall,
          ),
          child: ClipRRect(
              borderRadius: AppTheme.cardRadiusSmall,
              child: Image.network(
                imgUrl,
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
    );
  }
}
