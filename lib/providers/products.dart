import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  String? _token;
  String? _userId;
  void receiveToken(String auth, String userId, List<Product> items) {
    _token = auth;
    _items = items;
    _userId = userId;
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$_userId"' : "";
    var url = Uri.parse(
        'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$_token&$filterString');
    try {
      final response = await http.get(url);

      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

      url = Uri.parse(
          'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$_userId.json?auth=$_token');
      final favoriteResponse = await http.get(url);
      final favoriteData =
          json.decode(favoriteResponse.body) as Map<String, dynamic>?;

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite:
              (favoriteData == null ? false : favoriteData[prodId]) ?? false,
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
          'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$_token');
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId': _userId,
            // 'isFavorite': product.isFavorite,
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
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      // final url = Uri.https(
      //     'myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app',
      //     '/products/$id.json');
      final url = Uri.parse(
          'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$_token');
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
        'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$_token');
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
