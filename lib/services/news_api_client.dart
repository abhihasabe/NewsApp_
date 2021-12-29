import 'dart:convert';
import 'dart:io';
import 'package:form_validation/model/news_model.dart';
import 'package:form_validation/utils/network_constants.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class NewsBaseClient {
  dynamic responseJson;
  Client client = Client();

  static const int TIME_OUT_DURATION = 20;

  Future<dynamic> getNews(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await client
          .get(uri)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on BadRequestException {
      throw BadRequestException('Bad Request', uri.toString());
    } on TimeOutException {
      throw TimeOutException('Time Out Exception', uri.toString());
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> postNews(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeOutException {
      throw TimeOutException('API not responded in time', uri.toString());
    }
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.statusCode.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.statusCode.toString());
      case 404:
        throw NotFoundException(response.statusCode.toString());
      case 408:
        throw TimeOutException(response.statusCode.toString());
      case 409:
        throw ConflictException(response.statusCode.toString());
      case 500:
        throw InternalServerErrorException(response.statusCode.toString());
      case 503:
        throw ServiceUnavailableException(response.statusCode.toString());
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
