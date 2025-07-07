import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:globecastnewsapp/Model/categories_news_model.dart';
import 'package:globecastnewsapp/Model/news_channel_headlines_model.dart';
import 'package:globecastnewsapp/Model/news_view_model.dart';
import 'package:globecastnewsapp/Screen/Category_screen.dart';
import 'package:globecastnewsapp/Screen/Settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
            Expanded(
              child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewschannelHeadlinesApi(
                  selectedSource,
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
                  return CarouselSlider.builder(
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index, realIndex) {
                      DateTime date = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                imageUrl:
                                    snapshot
                                        .data!
                                        .articles![index]
                                        .urlToImage ??
                                    "",
                                title:
                                    snapshot.data!.articles![index].title ??
                                    "No Title",
                                description:
                                    snapshot
                                        .data!
                                        .articles![index]
                                        .description ??
                                    "No Description",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width,
                                height: height * 0.28,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshot
                                              .data!
                                              .articles![index]
                                              .urlToImage ??
                                          "https://placehold.co/600x400/000000/FFFFFF?text=No+Image",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  snapshot.data!.articles![index].title ??
                                      "No Title",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.color,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data!.articles![index].author ??
                                        "Unknown Author",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    format.format(date),
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: height * 0.7,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "General News",
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<CategoryNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(
                  categoryName,
                  selectedSource,
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
                        "No General News Available",
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
                      var articles = snapshot.data!.articles!.reversed.toList();
                      var article = articles[index];

                      return Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
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
                            "${article.author ?? 'Unknown Author'} | ${article.publishedAt ?? ''}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                            ),
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
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const DetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    debugPrint('Error loading image: $exception');
                  },
                ),
              ),
              child: imageUrl.isEmpty
                  ? Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
