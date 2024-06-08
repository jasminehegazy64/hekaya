import 'package:flutter/material.dart';
import 'package:epub_viewer/epub_viewer.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookUrl;

  BookDetailScreen({required this.bookUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Book'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await EpubViewer.open(bookUrl);
          },
          child: Text('Read Book'),
        ),
      ),
    );
  }
}
