import 'package:flutter/material.dart';
import 'google_books.dart';

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
                  leading: Image.network(book.thumbnail),
                  title: Text(book.title),
                  subtitle: Text(book.authors),
                  onTap: () {
                    // Navigate to book detail screen to download and read
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
