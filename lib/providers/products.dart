import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  String? token;
  void receiveToken(String auth, List<Product> items) {
    token = auth;
    _items = items;
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$token');
    try {
      final response = await http.get(url);

      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      print(response.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
        ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return (_items.where((prodItem) => prodItem.isFavorite).toList());
  }

  Product findbyId(String id) {
    return (items.firstWhere((element) => element.id == id));
  }

  Future<void> addProduct(Product product) async {
    try {
      final url = Uri.parse(
          'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$token');
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      // final url = Uri.https(
      //     'myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app',
      //     '/products/$id.json');
      final url = Uri.parse(
          'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$token');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      // print("Error in updating");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$token');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }
} //END OF CLASS
