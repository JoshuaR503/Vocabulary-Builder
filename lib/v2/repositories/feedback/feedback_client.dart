import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/repositories/constants.dart';
import 'package:vocabulary_builder/v2/repositories/httpClient.dart';

class FeedbackApiClient {

  // HTTP Client.
  final FetchClient _httpClient = FetchClient();

  //// Makes an HTTP request to the Search endpoint 
  /// in the API and returns words matching [search].
  Future<int> post({Map<String, dynamic> data}) async {

    // API Endpoint.
    final Uri uri = Uri.http(kBaseUri, '/v1/feedback');

    // Make HTTP Request
    final Response<dynamic> response = await this._httpClient.post(uri: uri, data: data);
    final bool success = response.data['success'];
  
    // Handle other than 200 status code.
    if (success) {
      return 1;
    } else {
      return 0;
    }
  }
}