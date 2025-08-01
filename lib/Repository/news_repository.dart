import 'dart:convert';
import 'package:globecastnewsapp/Model/categories_news_model.dart';
import 'package:globecastnewsapp/Model/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewschannelHeadlinesApi(
    String source,
  ) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=cb72762cd0864584893d604b79062546';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Failed to load news channel headlines');
  }

  Future<CategoryNewsModel> fetchCategoriesNewsApi(
    String category,
    String source,
  ) async {
    String url =
        'https://newsapi.org/v2/everything?sources=${source}&q=${category}&apiKey=cb72762cd0864584893d604b79062546';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoryNewsModel.fromJson(body);
    }
    throw Exception('Failed to load news channel headlines');
  }
}
