class RecipeModel {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final String difficulty;
  final double rating;
  final int servings;
  final String image;
  final List<String> tags;

  RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.rating,
    required this.servings,
    required this.image,
    required this.tags,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      difficulty: json['difficulty'] ?? 'Easy',
      rating: (json['rating'] ?? 0).toDouble(),
      servings: json['servings'] ?? 0,
      image: json['image'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  int get totalTime => prepTimeMinutes + cookTimeMinutes;
}

