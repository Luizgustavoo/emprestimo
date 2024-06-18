import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:flutter/material.dart';

class CustomHomeCard extends StatelessWidget {
  const CustomHomeCard({
    super.key,
    required this.controller,
    required this.item,
  });

  final HomeController controller;
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 1,
      child: ListTile(
        onTap: () => controller.addToCart(item),
        contentPadding: const EdgeInsets.all(12),
        title: Text(item.nome!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MODELO: ${item.modelo}'),
          ],
        ),
      ),
    );
  }
}
