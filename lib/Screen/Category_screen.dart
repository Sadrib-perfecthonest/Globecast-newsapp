import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globecastnewsapp/Model/categories_news_model.dart';
import 'package:globecastnewsapp/Model/news_view_model.dart';
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
    // TODO: implement build
    throw UnimplementedError();
  }
}
