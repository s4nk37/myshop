import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(
      {Key? key, required this.title, required this.imageUrl, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          tileColor: Theme.of(context).colorScheme.tertiaryContainer,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      try {
                        await Provider.of<Products>(context, listen: false)
                            .deleteProduct(id);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          EditProductScreen.routeName,
                          arguments: id);
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0.0,
          thickness: 0.4,
          color: Colors.black12,
        )
      ],
    );
  }
}
