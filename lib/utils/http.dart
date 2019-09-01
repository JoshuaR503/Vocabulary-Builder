import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class SimpleHttpClient {

  int _statusCode;
  int get statusCode =>  _statusCode;
  Dio dio = new Dio();

  Future<dynamic> fetchData({String url, String token}) async {
    // Fectch Status Code
    final int statusCode = await this.fetchStatusCode(url);

    // Headers.
    final Map<String, String> headers = {
      "Content-type": "application/json",
      "Content-type": "application/json"
    };

    // Set http status code.
    this._statusCode = statusCode;

    // Return esponse body.
    return await this.dio.get(url)
      .then((res) => res.data)
      .catchError((error) => print(error));
  }

  Future<int> fetchStatusCode(String url) async {

    final http.Response response = await http.get(url);
    final int statusCode = response.statusCode;

    return statusCode;
  }
} 