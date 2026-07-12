class ApiEndpoints {
  static const String baseUrl = 'https://dummyjson.com';

  // Auth
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String me = '/auth/me';

  // Products
  static const String products = '/products';
  static const String productsSearch = '/products/search';
  static const String categories = '/products/categories';
  static const String category = '/products/category';

  // Cart
  static const String carts = '/carts';
  static const String cartAdd = '/carts/add';

  // Recipes
  static const String recipes = '/recipes';
  static const String recipeTags = '/recipes/tags';
  static const String recipeTag = '/recipes/tag';

  // Posts
  static const String posts = '/posts';
  static const String postsAdd = '/posts/add';

  // Comments
  static const String comments = '/comments';
  static const String commentsAdd = '/comments/add';
  static const String commentsByPost = '/comments/post';

  // Helper methods
  static String productById(int id) => '/products/$id';
  static String cartById(int id) => '/carts/$id';
  static String recipeById(int id) => '/recipes/$id';
  static String postById(int id) => '/posts/$id';
  static String userPosts(int userId) => '/users/$userId/posts';
  static String commentById(int id) => '/comments/$id';
}