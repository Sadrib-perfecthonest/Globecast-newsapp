import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globecastnewsapp/Model/categories_news_model.dart';
import 'package:globecastnewsapp/Model/news_view_model.dart';
import 'package:globecastnewsapp/Screen/Bookmark_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categoryscreen extends StatefulWidget {
  final String selectedSource;
  const Categoryscreen({super.key, required this.selectedSource});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat("yyyy-MM-dd");
  String categoryName = 'general';

  List<String> btnCategories = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  Future<void> _saveArticle(Articles article) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedArticles =
        prefs.getStringList('bookmarkedArticles') ?? [];
    Map<String, dynamic> articleMap = {
      'title': article.title,
      'description': article.description,
      'urlToImage': article.urlToImage,
      'author': article.author,
      'publishedAt': DateTime.parse(article.publishedAt!).toIso8601String(),
    };
    savedArticles.add(jsonEncode(articleMap));
    await prefs.setStringList('bookmarkedArticles', savedArticles);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Article saved to bookmarks!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          "Categories",
          style: GoogleFonts.poppins(
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: btnCategories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        categoryName = btnCategories[index].toLowerCase();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          categoryName == btnCategories[index].toLowerCase()
                          ? Colors.blue
                          : Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[700]
                          : Colors.grey[300],
                    ),
                    child: Text(
                      btnCategories[index],
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
