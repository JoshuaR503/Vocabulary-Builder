import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class SimpleHttpClient {

  int _statusCode;
  int get statusCode =>  _statusCode;
  Dio dio = new Dio();


  SimpleHttpClient() {
    this.fetchStatusCode('https://google.com');
  }

  Future<dynamic> fetchData({String url, String token}) async {
    // Headers.
    final Map<String, String> headers = {
      "Content-type": "application/json",
      "Content-type": "application/json"
    };

    // Return esponse body.
    return await this.dio.get(url, queryParameters: headers)
      .then((res) => res.data)
      .catchError((error) => print('There was an error'));
  }

  void fetchStatusCode(String url) async {
    final http.Response response = await http.get(url);
    final int statusCode = response.statusCode;

    // Set status code.
    this._statusCode = statusCode;

    print('Status code ${this._statusCode}');
  }
}