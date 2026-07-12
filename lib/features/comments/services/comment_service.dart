import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../models/comment_model.dart';

class CommentService {
  final DioClient _dioClient = DioClient();

  Future<List<CommentModel>> getCommentsByPost(int postId) async {
    try {
      final response = await _dioClient.get(
        '${ApiEndpoints.commentsByPost}/$postId',
      );
      final List<dynamic> comments = response['comments'] ?? [];
      return comments.map((json) => CommentModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentModel> addComment(String body, int postId, int userId) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.commentsAdd,
        data: {
          'body': body,
          'postId': postId,
          'userId': userId,
        },
      );
      return CommentModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentModel> updateComment(int id, String body) async {
    try {
      final response = await _dioClient.put(
        ApiEndpoints.commentById(id),
        data: {'body': body},
      );
      return CommentModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteComment(int id) async {
    try {
      await _dioClient.delete(ApiEndpoints.commentById(id));
    } catch (e) {
      rethrow;
    }
  }
}

