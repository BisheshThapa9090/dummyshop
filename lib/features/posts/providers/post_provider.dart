import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostService _postService = PostService();

  List<PostModel> _posts = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;

  Future<void> loadPosts({bool refresh = false}) async {
    if (_isLoading) return;
    if (!_hasMore && !refresh) return;

    _isLoading = true;
    if (refresh) {
      _currentPage = 0;
      _posts = [];
      _hasMore = true;
    }
    _error = null;
    notifyListeners();

    try {
      final newPosts = await _postService.getPosts(
        limit: 20,
        skip: _currentPage * 20,
      );

      if (refresh) {
        _posts = newPosts;
      } else {
        _posts.addAll(newPosts);
      }

      _hasMore = newPosts.length == 20;
      _currentPage++;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createPost(String title, String body, int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final post = await _postService.createPost(title, body, userId);
      _posts.insert(0, post);
      _error = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deletePost(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _postService.deletePost(id);
      _posts.removeWhere((post) => post.id == id);
      _error = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
