import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/global/show_confirmation_dialog.dart';
import 'package:emprestimo/app/modules/home/widgets/custom_home_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          showConfirmationDialog(
            titulo: 'Confirmação',
            subtitulo: 'Confirma a exclusão do registro selecionado?',
            onConfirm: () async {
              dynamic retorno = await controller.deleteItem(item);
              Get.back();
              if (retorno != null && retorno['message'] != null) {
                if (retorno['message'] == 'success') {
                  Get.snackbar('Sucesso!', 'Operação realizada com sucesso!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  Get.snackbar('Falha!', 'Falha ao realizar a operação!',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM);
                }
              } else {
                Get.snackbar('Falha!', 'Nenhum retorno informado!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            onCancel: () {
              Get.back();
            },
          );
        }
        return false;
      },
      background: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red.shade500),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.check_rounded, color: Colors.white, size: 25)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.all(5),
        elevation: 1,
        child: ListTile(
          leading: IconButton(
              onPressed: () {
                controller.fillInFieldsItem(item);
                showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: false,
                  context: context,
                  builder: (context) => CustomHomeModal(
                    item: item,
                    alterar: true,
                    tituloModal: "Alterar Item",
                    controller: controller,
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
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
      ),
    );
  }
}
