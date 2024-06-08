//THIS FETCHES EL KOTOB MN GOOGLE BOOKKSSS

import 'dart:convert';
import 'package:http/http.dart' as http;

class BookService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List books = data['items'];
      return books.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}

class Book {
  final String title;
  final String authors;
  final String thumbnail;

  Book({required this.title, required this.authors, required this.thumbnail});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'],
      authors: (json['volumeInfo']['authors'] as List<dynamic>).join(', '),
      thumbnail: json['volumeInfo']['imageLinks']['thumbnail'],
    );
  }
}
