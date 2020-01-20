
import 'package:vocabulary_builder/v2/repositories/feedback/feedback_client.dart';

class FeedbackRepository {
  final FeedbackApiClient _client = FeedbackApiClient();

  Future<int> post({ Map<String, dynamic> data }) async {
    return await _client.post(data: data);
  }
}