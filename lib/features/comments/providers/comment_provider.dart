import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../services/comment_service.dart';

class CommentProvider extends ChangeNotifier {
  final CommentService _commentService = CommentService();

  List<CommentModel> _comments = [];
  bool _isLoading = false;
  String? _error;

  List<CommentModel> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadComments(int postId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _comments = await _commentService.getCommentsByPost(postId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addComment(String body, int postId, int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final comment = await _commentService.addComment(body, postId, userId);
      _comments.insert(0, comment);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteComment(int id) async {
    try {
      await _commentService.deleteComment(id);
      _comments.removeWhere((comment) => comment.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}

