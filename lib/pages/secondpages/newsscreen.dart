import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/items/newsitem.dart';
import 'package:nexus_wallet/loaders.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';


class buildNews extends StatefulWidget {
  @override
  _buildNewsState createState() => _buildNewsState();
}

class _buildNewsState extends State<buildNews> {
  var newslist;
  late bool _loading;

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    newslist = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
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
            itemCount: newslist.length > 4
                ? newslist.length = 4
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
                author: 'Riinger',
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

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News")
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController){
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