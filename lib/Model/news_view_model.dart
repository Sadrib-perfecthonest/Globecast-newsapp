import 'package:globecastnewsapp/Model/categories_news_model.dart';
import 'package:globecastnewsapp/Model/news_channel_headlines_model.dart';
import 'package:globecastnewsapp/Repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewschannelHeadlinesApi(
    String source,
  ) async {
    return await _rep.fetchNewschannelHeadlinesApi(source);
  }

  Future<CategoryNewsModel> fetchCategoriesNewsApi(
    String category,
    String source,
  ) async {
    return await _rep.fetchCategoriesNewsApi(category, source);
  }
}
