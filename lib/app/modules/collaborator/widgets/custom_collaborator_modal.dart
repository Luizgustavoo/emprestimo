import 'package:emprestimo/app/data/controllers/collaborator_controller.dart';
import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCollaboratorModal extends StatelessWidget {
  const CustomCollaboratorModal(
      {super.key,
      required this.controller,
      required this.tituloModal,
      required this.alterar,
      this.collaborator});

  final CollaboratorController controller;
  final String tituloModal;
  final bool alterar;
  final Collaborator? collaborator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Form(
            key: controller.collaboratorKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tituloModal,
                  style: const TextStyle(fontSize: 20),
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
                Obx(() {
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'TIPO DO COLABORADOR',
                    ),
                    isDense: true,
                    menuMaxHeight: Get.size.height / 2,
                    items: controller.typeCollaborators!
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    hint: const Text('Selecione uma opção'),
                    value: controller.txtTipoController.value.isEmpty
                        ? null
                        : controller.txtTipoController.value.toString(),
                    onChanged: (value) {
                      controller.txtTipoController.value = value!;
                    },
                    validator: (value) {
                      if (value == null || value == 'null' || value.isEmpty) {
                        return 'Por favor, selecione uma opção';
                      }
                      return null;
                    },
                  );
                }),
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
                              ? await controller
                                  .updateCollaborator(collaborator!.id!)
                              : await controller.saveCollaborator();

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
                          }
                        },
                        child: Text(
                          alterar ? 'Alterar' : 'Salvar',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
