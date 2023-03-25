import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductItem({Key? key, required this.title, required this.imageUrl})
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
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
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
