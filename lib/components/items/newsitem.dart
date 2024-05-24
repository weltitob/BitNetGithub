import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

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
        print("Opening news article on the web implementation (clean)");
      },
      child: GlassContainer(
        child: Container(
          height: AppTheme.cardPadding * 4,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
          child: Row(
            children: [
              NewsPicture(imgUrl: imgUrl,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: AppTheme.elementSpacing * 1.25,),
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
                                style: Theme.of(context).textTheme.labelSmall
                            ),
                          ),
                          Text(
                            displayTimeAgoFromTimestamp(publishedAt),
                            style: Theme.of(context).textTheme.bodySmall
                          ),
                        ],
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall,
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
      width: AppTheme.cardPadding * 4,
      height: AppTheme.cardPadding * 4,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.elementSpacing * 0.625),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            borderRadius: AppTheme.cardRadiusMid,
          ),
          child: ClipRRect(
              borderRadius: AppTheme.cardRadiusMid,
              child: Image.network(
                imgUrl,
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
    );
  }
}
