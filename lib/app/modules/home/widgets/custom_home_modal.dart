import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeModal extends StatelessWidget {
  CustomHomeModal(
      {super.key,
      required this.controller,
      required this.tituloModal,
      required this.alterar,
      this.item});

  final HomeController controller;
  final String tituloModal;
  final bool alterar;
  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: controller.itemKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tituloModal,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.txtNomeController,
              decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                  labelText: 'NOME'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um nome válido.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.txtMarcaController,
              decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                  labelText: 'MARCA'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite uma marca válida.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.txtModeloController,
              decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                  labelText: 'MODELO'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um modelo válido.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Color(0xFF014acb)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () async {
                      dynamic retorno = alterar
                          ? await controller.updateItem(item!.id!)
                          : await controller.saveItem();

                      print(retorno);
                      if (retorno != null && retorno['message'] != null) {
                        Get.back();
                        if (retorno['message'] == 'success') {
                          Get.snackbar(
                              'Sucesso!', 'Operação realizada com sucesso!',
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          Get.snackbar(
                              'Falha!', 'Falha ao realizar a operação!',
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
                    child: Text(
                      alterar ? 'Alterar' : 'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
