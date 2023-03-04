import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/items/newsitem.dart';
import 'package:nexus_wallet/components/news/news.dart';
import 'package:nexus_wallet/loaders.dart';
import 'package:nexus_wallet/theme.dart';
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
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&sortBy=publishedAt&apiKey=be561302ff234a908ac60730ef999db6");
    var response = await http.get(url);
    print(response);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      int articleCount = 0;
      jsonData["articles"].forEach((element) {
        if (articleCount >= 5) {
          return; // exit the loop if we already have 5 articles
        }
        if (element['urlToImage'] != null && element['description'] != null) {
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
          articleCount++;
        }
      });
    }
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
