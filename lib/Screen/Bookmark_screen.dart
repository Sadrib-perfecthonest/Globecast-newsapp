import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Map<String, dynamic>> _bookmarkedArticles = [];
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedArticles =
        prefs.getStringList('bookmarkedArticles') ?? [];
    setState(() {
      _bookmarkedArticles = savedArticles
          .map(
            (articleString) =>
                jsonDecode(articleString) as Map<String, dynamic>,
          )
          .toList();
    });
  }

  Future<void> _removeBookmark(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedArticles =
        prefs.getStringList('bookmarkedArticles') ?? [];
    savedArticles.removeAt(index);
    await prefs.setStringList('bookmarkedArticles', savedArticles);
    _loadBookmarks();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Article removed from bookmarks!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmarks',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: _bookmarkedArticles.isEmpty
          ? Center(
              child: Text(
                'No Bookmarks Found',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = _bookmarkedArticles[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: article['urlToImage'] != null
                        ? Image.network(article['urlToImage'])
                        : null,
                    title: Text(article['title'] ?? 'No Title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article['author'] != null)
                          Text('Author: ${article['author']}'),
                        if (article['publishedAt'] != null)
                          Text(
                            'Published on: ${format.format(DateTime.parse(article['publishedAt']))}',
                          ),
                        if (article['description'] != null)
                          Text(article['description']),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeBookmark(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
