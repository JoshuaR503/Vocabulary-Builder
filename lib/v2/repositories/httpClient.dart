import 'package:dio/dio.dart';

class FetchClient {

  // HTTP Client
  final Dio httpClient = Dio();

  // Fetches data.
  Future<Response> fetchData({String url}) async {
    final response = await this.httpClient.get(url);
    return response;
  }
}