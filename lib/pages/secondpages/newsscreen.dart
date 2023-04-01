import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/items/newsitem.dart';
import 'package:nexus_wallet/models/news.dart';
import 'package:nexus_wallet/backbone/helper/loaders.dart';
import 'package:nexus_wallet/backbone/helper/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class buildNews extends StatefulWidget {
  @override
  _buildNewsState createState() => _buildNewsState();
}

class _buildNewsState extends State<buildNews> {
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
    return _loading
        ? Center(
            child: Container(
              height: 200,
              child: dotProgress(context),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              child: ListView.builder(
                  itemCount: newslist.length > 5
                      ? newslist.length = 5
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
          );
  }
}

class NewsScreen extends StatefulWidget {
  final String postUrl;
  NewsScreen({required this.postUrl});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("NextNews"),
        backgroundColor: lighten(AppTheme.colorBackground, 10),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: AppTheme.cardPadding),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Zurück'),
          elevation: 500,
          icon: const Icon(Icons.arrow_back_rounded),
          backgroundColor: Colors.purple.shade800,
        ),
      ),
    );
  }

  Widget MyDivider3() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: VerticalDivider(
        thickness: 2,
        width: 2,
        color: Colors.grey,
      ),
    );
  }
}
