import 'package:flutter/material.dart';
import 'package:globecastnewsapp/Screen/home_screen.dart';
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
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          "Saved Articles",
          style: GoogleFonts.poppins(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: _bookmarkedArticles.isEmpty
          ? Center(
              child: Text(
                "No Saved Articles Yet",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _bookmarkedArticles.length,
              itemBuilder: (context, index) {
                var article = _bookmarkedArticles[index];
                DateTime date = DateTime.parse(
                  article['publishedAt'].toString(),
                );
                return Card(
                  color: Theme.of(context).cardColor,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading:
                        article['urlToImage'] != null &&
                            article['urlToImage'].isNotEmpty
                        ? Image.network(
                            article['urlToImage']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            color: Theme.of(context).colorScheme.surface,
                            child: Icon(
                              Icons.image,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                    title: Text(
                      article['title'] ?? "No Title",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "${article['author'] ?? 'Unknown Author'} | ${format.format(date)}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.bookmark, color: Colors.red),
                      onPressed: () => _removeBookmark(index),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            imageUrl: article['urlToImage'] ?? "",
                            title: article['title'] ?? "No Title",
                            description:
                                article['description'] ?? "No Description",
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
