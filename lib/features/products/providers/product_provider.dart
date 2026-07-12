import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isSearching = false;
  String _searchQuery = '';

  List<ProductModel> get products => _products;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;

  Future<void> loadProducts({bool refresh = false}) async {
    if (_isLoading) return;
    if (!_hasMore && !refresh) return;

    _isLoading = true;
    if (refresh) {
      _currentPage = 0;
      _products = [];
      _hasMore = true;
    }
    notifyListeners();

    try {
      final newProducts = await _productService.getProducts(
        limit: 20,
        skip: _currentPage * 20,
      );

      if (refresh) {
        _products = newProducts;
      } else {
        _products.addAll(newProducts);
      }

      _hasMore = newProducts.length == 20;
      _currentPage++;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    try {
      _categories = await _productService.getCategories();
      _categories.insert(0, 'All');
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> filterByCategory(String category) async {
    _selectedCategory = category;
    _currentPage = 0;
    _hasMore = true;
    _isSearching = false;
    _searchQuery = '';

    if (category == 'All') {
      await loadProducts(refresh: true);
    } else {
      _isLoading = true;
      notifyListeners();
      try {
        _products = await _productService.getProductsByCategory(category);
        _hasMore = false;
      } catch (e) {
        // Handle error
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> searchProducts(String query) async {
    _searchQuery = query;
    _isSearching = true;
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.searchProducts(query);
      _hasMore = false;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _isSearching = false;
    _searchQuery = '';
    _currentPage = 0;
    _hasMore = true;
    _products = [];
    loadProducts(refresh: true);
  }

  ProductModel? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}