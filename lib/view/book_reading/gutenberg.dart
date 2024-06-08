import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:epub_viewer/epub_viewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListScreen(),
    );
  }
}

class BookService {
  static const String _baseUrl = 'http://gutendex.com/books';

  Future<List<Book>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl?search=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List books = data['results'];
      print('Books fetched successfully: ${books.length}');
      return books.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}

class Book {
  final String title;
  final String authors;
  final String? thumbnail;
  final String epubLink;

  Book({
    required this.title,
    required this.authors,
    this.thumbnail,
    required this.epubLink,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final List authorsList = json['authors'];
    final String authors = authorsList.isNotEmpty
        ? authorsList.map((author) => author['name']).join(', ')
        : 'Unknown Author';
    final String epubLink = json['formats']['application/epub+zip'];
    final String? thumbnail = json['formats']['image/jpeg'];

    return Book(
      title: json['title'],
      authors: authors,
      thumbnail: thumbnail,
      epubLink: epubLink,
    );
  }
}

class BookListScreen extends StatelessWidget {
  final BookService _bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
      ),
      body: FutureBuilder<List<Book>>(
        future: _bookService.fetchBooks('free+books'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return ListTile(
                  leading: book.thumbnail != null
                      ? Image.network(book.thumbnail!)
                      : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey,
                          child: Icon(Icons.book),
                        ),
                  title: Text(book.title),
                  subtitle: Text(book.authors),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetailScreen(bookUrl: book.epubLink),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

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
            print('Opening EPUB link: $bookUrl');
            await EpubViewer.open(bookUrl);
          },
          child: Text('Read Book'),
        ),
      ),
    );
  }
}
