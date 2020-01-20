import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/repositories/badges/badgeManager.dart';
import 'package:vocabulary_builder/v2/repositories/constants.dart';

class FetchClient {

  // HTTP Client
  final Dio _httpClient = Dio();

  // Badge Manager.
  final BadgeManager _badgeManager = BadgeManager();

  // Updates badge count.
  Future<void> _fetchBadgeCount() async {

    // Fetch amount of words added this week.
    final Response<dynamic> response = await this._httpClient.get(kFirebaseBaseUrl);
    // Fetch amount of badges.
    final int badgesCount = response.data;

    // Update Badge.
    _badgeManager.updateBadgeCount(badgesCount);
  }

  // Fetches data.
  Future<Response> fetchData({Uri uri}) async {

    // Add badges. 
    await this._fetchBadgeCount();

    // Make HTTP request.
    final Response<dynamic> response = await this._httpClient.getUri(uri);
    return response;
  }

  // Posts data.
  Future<Response> post({Uri uri, Map<String, dynamic> data}) async {
    // Make HTTP request.
    final Response<dynamic> response = await this._httpClient.postUri(uri, data: data);
    return response;
  }
}