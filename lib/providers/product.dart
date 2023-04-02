import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus(String token) async {
    final oldStatus = isFavorite;
    try {
      isFavorite = !isFavorite;

      final url = Uri.parse(
          'https://myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$token');
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));

      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
      notifyListeners();
      // print('End');
    } catch (e) {
      isFavorite = oldStatus;
      notifyListeners();
      // print("Error");
    }
  }

  // void toggleFavoriteStatus() {
  //   final url = Uri.https(
  //       'myshop-93710-default-rtdb.asia-southeast1.firebasedatabase.app',
  //       '/products/$id.jon');
  //   isFavorite = !isFavorite;
  //   http
  //       .patch(url,
  //           body: json.encode({
  //             'isFavorite': isFavorite,
  //           }))
  //       .then((response) {
  //     print(response);
  //   });
  //
  //   notifyListeners();
  // }
}
