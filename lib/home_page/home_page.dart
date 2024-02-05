import 'package:flutter/material.dart';
import '../feed_detail_screen/feed_detail_screen.dart';

class HomePage extends StatelessWidget {
  final List<String> feeds = [
    'https://feeds.feedburner.com/AndroidDagashi',
    'https://www.nhk.or.jp/rss/news/cat0.xml',
    // ここに他のフィードを追加できます
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("RSSリーダー"),
        ),
        body: ListView.builder(
            itemCount: feeds.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(feeds[index]),
                  onTap: () {
                    _navigateToFeedDetail(context, feeds[index]);
                  });
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }

  void _navigateToFeedDetail(BuildContext context, String feedTitle) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FeedDetailScreen(feedUrl: feedTitle)));
  }
}
