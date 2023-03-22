import 'dart:ui';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(
      {Key? key, required this.id, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: GridTile(
        footer: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: GridTileBar(
              backgroundColor: Colors.black26,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite)),
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.shopping_bag)),
            ),
          ),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
