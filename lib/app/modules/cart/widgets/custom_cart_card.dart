import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:flutter/material.dart';

class CustomCartCard extends StatelessWidget {
  const CustomCartCard({
    super.key,
    required this.item,
    required this.controller,
  });

  final Item item;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(top: 5),
      child: ListTile(
        title: Text(item.nome!.toUpperCase()),
        subtitle: const Text(''),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () {
            controller.removeToCart(item);
          },
        ),
      ),
    );
  }
}
