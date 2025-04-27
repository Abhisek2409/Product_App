import 'package:flutter/material.dart';
import 'package:task/model/product.dart';
import 'package:task/services/api_services.dart';



class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch products from API
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ApiService.getProducts();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new product
  Future<void> addProduct({
    required String name,
    required double price,
    required String description,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final product = await ApiService.addProduct(name, price, description);
      _products.add(product);
    } catch (e) {
      _errorMessage = e.toString();
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Edit product
  Future<void> editProduct({
    required String id,
    required String name,
    required double price,
    required String description,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedProduct = await ApiService.updateProduct(id, name, price, description);
      int index = _products.indexWhere((product) => product.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Delete product
  Future<void> deleteProduct(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await ApiService.deleteProduct(id);
      _products.removeWhere((product) => product.id == id);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
