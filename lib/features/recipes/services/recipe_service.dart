import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../models/recipe_model.dart';

class RecipeService {
  final DioClient _dioClient = DioClient();

  Future<List<RecipeModel>> getRecipes({int limit = 20, int skip = 0}) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.recipes,
        queryParams: {'limit': limit, 'skip': skip},
      );
      final List<dynamic> recipes = response['recipes'] ?? [];
      return recipes.map((json) => RecipeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<RecipeModel> getRecipe(int id) async {
    try {
      final response = await _dioClient.get(ApiEndpoints.recipeById(id));
      return RecipeModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getTags() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.recipeTags);
      return List<String>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RecipeModel>> getRecipesByTag(String tag) async {
    try {
      final response = await _dioClient.get(
        '${ApiEndpoints.recipeTag}/$tag',
      );
      final List<dynamic> recipes = response['recipes'] ?? [];
      return recipes.map((json) => RecipeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.recipes,
        queryParams: {'q': query},
      );
      final List<dynamic> recipes = response['recipes'] ?? [];
      return recipes.map((json) => RecipeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

