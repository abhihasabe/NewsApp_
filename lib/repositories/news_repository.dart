import 'package:form_validation/model/news_model.dart';
import 'package:form_validation/utils/network_constants.dart';
import 'package:form_validation/services/news_api_client.dart';

class NewsArticleRepository {
  final newsApiProvider = NewsBaseClient();

  // Get news from server
  Future<dynamic> fetchAllNews() =>
      newsApiProvider.getNews(
          AppConstants.base_url, AppConstants.key);
}
