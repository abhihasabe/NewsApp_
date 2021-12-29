import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/model/news_model.dart';
import 'package:form_validation/utils/network_constants.dart';
import 'package:form_validation/services/news_api_client.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  test("Testing the News Api call", () async {
    final newsApiClient = NewsBaseClient();
    newsApiClient.client = MockClient((request) async {
      final mapJson = {'status': "ok", 'totalResults': 38};
      return Response(json.encode(mapJson), 200);
    });

    final item = await newsApiClient.getNews(AppConstants.base_url, AppConstants.key);
    NewsModel newsModel = NewsModel.fromJson(item);
    expect(newsModel.status, "ok");
    expect(newsModel.totalResults, 38);
  });
}
