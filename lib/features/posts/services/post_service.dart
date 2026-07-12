import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../models/post_model.dart';

class PostService {
  final DioClient _dioClient = DioClient();
  
  // Local cache for created posts (since DummyJSON doesn't persist)
  static final Map<int, PostModel> _localPosts = {};

  Future<List<PostModel>> getPosts({int limit = 20, int skip = 0}) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.posts,
        queryParams: {'limit': limit, 'skip': skip},
      );
      
      final List<dynamic> postsData = response['posts'] ?? [];
      final posts = postsData.map((json) => PostModel.fromJson(json)).toList();
      
      // Add local posts to the list
      posts.addAll(_localPosts.values);
      
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  Future<PostModel> getPost(int id) async {
    try {
      // Check if it's a locally created post first
      if (_localPosts.containsKey(id)) {
        return _localPosts[id]!;
      }
      
      final response = await _dioClient.get(ApiEndpoints.postById(id));
      return PostModel.fromJson(response);
    } catch (e) {
      // If not found, check local cache again
      if (_localPosts.containsKey(id)) {
        return _localPosts[id]!;
      }
      rethrow;
    }
  }

  Future<PostModel> createPost(String title, String body, int userId) async {
    try {
      // Try to create on server
      final response = await _dioClient.post(
        ApiEndpoints.postsAdd,
        data: {
          'title': title,
          'body': body,
          'userId': userId,
        },
      );
      
      final post = PostModel.fromJson(response);
      
      // Store locally as well
      _localPosts[post.id] = post;
      
      return post;
    } catch (e) {
      // If API fails, create a local post with a fake ID
      final fakeId = DateTime.now().millisecondsSinceEpoch % 100000;
      final post = PostModel(
        id: fakeId,
        title: title,
        body: body,
        userId: userId,
        tags: [],
        reactions: 0,
        comments: 0,
      );
      
      // Store locally
      _localPosts[fakeId] = post;
      
      return post;
    }
  }

  Future<PostModel> updatePost(int id, String title, String body) async {
    try {
      // Check if local post
      if (_localPosts.containsKey(id)) {
        final post = _localPosts[id]!;
        final updatedPost = PostModel(
          id: post.id,
          title: title,
          body: body,
          userId: post.userId,
          tags: post.tags,
          reactions: post.reactions,
          comments: post.comments,
        );
        _localPosts[id] = updatedPost;
        return updatedPost;
      }
      
      final response = await _dioClient.put(
        ApiEndpoints.postById(id),
        data: {
          'title': title,
          'body': body,
        },
      );
      return PostModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(int id) async {
    try {
      // Remove from local cache if exists
      if (_localPosts.containsKey(id)) {
        _localPosts.remove(id);
        return;
      }
      
      await _dioClient.delete(ApiEndpoints.postById(id));
    } catch (e) {
      // If not found locally, try to delete from server anyway
      try {
        await _dioClient.delete(ApiEndpoints.postById(id));
      } catch (_) {
        // Ignore if already deleted
      }
    }
  }

  Future<List<PostModel>> getPostsByUser(int userId) async {
    try {
      final response = await _dioClient.get(ApiEndpoints.userPosts(userId));
      final List<dynamic> postsData = response['posts'] ?? [];
      final posts = postsData.map((json) => PostModel.fromJson(json)).toList();
      
      // Add local posts from this user
      final userLocalPosts = _localPosts.values
          .where((post) => post.userId == userId)
          .toList();
      posts.addAll(userLocalPosts);
      
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
