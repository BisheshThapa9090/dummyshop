import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  List<RecipeModel> _recipes = [];
  List<String> _tags = [];
  String _selectedTag = 'All';
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  List<RecipeModel> get recipes => _recipes;
  List<String> get tags => _tags;
  String get selectedTag => _selectedTag;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadRecipes({bool refresh = false}) async {
    if (_isLoading) return;
    if (!_hasMore && !refresh) return;

    _isLoading = true;
    if (refresh) {
      _currentPage = 0;
      _recipes = [];
      _hasMore = true;
    }
    notifyListeners();

    try {
      final newRecipes = await _recipeService.getRecipes(
        limit: 20,
        skip: _currentPage * 20,
      );

      if (refresh) {
        _recipes = newRecipes;
      } else {
        _recipes.addAll(newRecipes);
      }

      _hasMore = newRecipes.length == 20;
      _currentPage++;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTags() async {
    try {
      _tags = await _recipeService.getTags();
      _tags.insert(0, 'All');
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> filterByTag(String tag) async {
    _selectedTag = tag;
    _isLoading = true;
    notifyListeners();

    try {
      if (tag == 'All') {
        await loadRecipes(refresh: true);
      } else {
        _recipes = await _recipeService.getRecipesByTag(tag);
        _hasMore = false;
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

