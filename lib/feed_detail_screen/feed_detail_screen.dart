import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class FeedDetailScreen extends StatefulWidget {
  final String feedUrl;

  const FeedDetailScreen({super.key, required this.feedUrl});

  @override
  _FeedDetailScreenState createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  String _title = '';
  List<String> _titles = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(widget.feedUrl));
      if (response.statusCode == 200) {
        final feedXml = xml.XmlDocument.parse(response.body);
        final titleElement = feedXml.findAllElements('title').first;
        feedXml
            .findAllElements("entry")
            .map((element) => element.findElements("title").single.innerText)
            .forEach((e) => _titles.add(e));
        setState(() {
          _title = titleElement.innerText;
        });
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: ListView.builder(
            itemCount: _titles.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_titles[index]),
              );
            }));
  }
}
