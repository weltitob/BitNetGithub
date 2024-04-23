import 'dart:async';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/models/bitcoin/news.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/items/newsitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Article> newslist = [];
  bool _loading = true;

  Future<void> getNews() async {
    // Define the API endpoint URL for the News API with the required parameters
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&sortBy=publishedAt&language=de&apiKey=be561302ff234a908ac60730ef999db6");

    // Send a GET request to the API endpoint URL and wait for the response
    var response = await http.get(url);

    // Print the response to the console (for debugging purposes)
    print(response);

    // Decode the response body from JSON format to a Map object
    var jsonData = jsonDecode(response.body);

    // Check if the response status is "ok"
    if (jsonData['status'] == "ok") {
      int articleCount = 0; // Keep track of the number of articles added
      // Loop through each article in the "articles" list
      jsonData["articles"].forEach((element) {
        // Check if we already have 5 articles, and exit the loop if we do
        if (articleCount >= 5) {
          return;
        }
        // Check if the article has a title and an image URL
        if (element['urlToImage'] != null && element['description'] != null) {
          // Create a new Article object using the article data and add it to the newslist
          Article article = Article(
            title: element['title'].toString(),
            content: element['content'].toString(),
            author: element['author'].toString(),
            description: element['description'].toString(),
            url: element['url'].toString(),
            urlToImage: element['urlToImage'].toString(),
            publishedAt: DateTime.parse(element['publishedAt'].toString()),
          );
          newslist.add(article);
          articleCount++; // Increment the article count
        }
      });
    }
    // loading is complete
    setState(() {
      _loading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: "Bitcoin News",
        context: context,
        onTap: (){
          context.pop();
        },
      ),
      body: Container(child: _loading
          ? Center(
              child: Container(
                height: AppTheme.cardPadding * 10,
                child: dotProgress(context),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: AppTheme.elementSpacing / 2, left:  AppTheme.elementSpacing, right:  AppTheme.elementSpacing),
              child: Container(
                child: ListView.builder(
                    itemCount: newslist.length > 20
                        ? newslist.length = 20
                        : newslist.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imgUrl: newslist[index].urlToImage,
                        title: newslist[index].title,
                        desc: newslist[index].description,
                        content: newslist[index].content,
                        posturl: newslist[index].url,
                        publishedAt: newslist[index].publishedAt.toString(),
                        author: 'Ringer',
                      );
                    }),
              ),
            )),
    );
  }
}
