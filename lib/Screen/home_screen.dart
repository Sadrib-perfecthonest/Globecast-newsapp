import 'package:flutter/material.dart';
import 'package:globecastnewsapp/Model/news_view_model.dart';
import 'package:globecastnewsapp/Screen/Category_screen.dart';
import 'package:globecastnewsapp/Screen/Settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _Homescreenstate();
}

enum FilterList {
  bbcNews,
  cnn,
  aryNews,
  cbcnews,
  espn,
  alJazzera,
  foxnews,
  thetimesofindia,
  newyorkmagazine,
}

class _Homescreenstate extends State<Homescreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedFilter;
  final format = DateFormat("yyyy-MM-dd");
  String selectedSource = 'bbc-news';
  String categoryName = 'general';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.category,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Categoryscreen()),
              );
            },
          ),
          title: Text(
            "Globecast",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<FilterList>(
              color: Theme.of(context).cardColor,
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              onSelected: (FilterList item) {
                setState(() {
                  switch (item) {
                    case FilterList.bbcNews:
                      selectedSource = 'bbc-news';
                      break;
                    case FilterList.cnn:
                      selectedSource = 'cnn';
                      break;
                    case FilterList.aryNews:
                      selectedSource = 'ary-news';
                      break;
                    case FilterList.cbcnews:
                      selectedSource = 'cbc-news';
                      break;
                    case FilterList.espn:
                      selectedSource = 'espn';
                      break;
                    case FilterList.alJazzera:
                      selectedSource = 'al-jazeera-english';
                      break;
                    case FilterList.foxnews:
                      selectedSource = 'fox-news';
                      break;
                    case FilterList.thetimesofindia:
                      selectedSource = 'the-times-of-india';
                      break;

                    case FilterList.newyorkmagazine:
                      selectedSource = 'new-york-magazine';
                      break;
                  }
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                  child: Text(
                    "BBC News",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text(
                    "CNN",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text(
                    "ARY News",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.cbcnews,
                  child: Text(
                    "CBC News",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.espn,
                  child: Text(
                    "Espn",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.alJazzera,
                  child: Text(
                    "Al Jazeera",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.foxnews,
                  child: Text(
                    "Fox News",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.thetimesofindia,
                  child: Text(
                    "the-times-of-india",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.newyorkmagazine,
                  child: Text(
                    "New-york-magazine",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Top Headlines",
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
