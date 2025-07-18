import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:globecastnewsapp/Model/categories_news_model.dart';
import 'package:globecastnewsapp/Model/news_view_model.dart';
import 'package:globecastnewsapp/Screen/Bookmark_screen.dart';
import 'package:globecastnewsapp/Screen/home_screen.dart';
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
          Expanded(
            child: FutureBuilder<CategoryNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi(
                categoryName,
                widget.selectedSource,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitSpinningLines(
                      color: Theme.of(context).colorScheme.primary,
                      size: 60.0,
                      lineWidth: 3.5,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.articles!.isEmpty) {
                  return Center(
                    child: Text(
                      "No News Available",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data!.articles![index];
                    DateTime date = DateTime.parse(
                      article.publishedAt.toString(),
                    );
                    return Card(
                      color: Theme.of(context).cardColor,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading:
                            article.urlToImage != null &&
                                article.urlToImage!.isNotEmpty
                            ? Image.network(
                                article.urlToImage!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 80,
                                      height: 80,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
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
                          article.title ?? "No Title",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).textTheme.titleMedium?.color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "${article.author ?? 'Unknown Author'} | ${format.format(date)}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.bookmark_border,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () => _saveArticle(article),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                imageUrl: article.urlToImage ?? "",
                                title: article.title ?? "No Title",
                                description:
                                    article.description ?? "No Description",
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
