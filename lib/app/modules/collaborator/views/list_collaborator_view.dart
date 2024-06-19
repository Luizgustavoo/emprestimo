import 'package:emprestimo/app/data/controllers/collaborator_controller.dart';
import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:emprestimo/app/global/show_confirmation_dialog.dart';
import 'package:emprestimo/app/modules/collaborator/widgets/custom_collaborator_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollaboratorView extends GetView<CollaboratorController> {
  const CollaboratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listagem de Colaborador')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, right: 12, left: 12, bottom: 5),
              child: TextFormField(
                decoration: InputDecoration(
                    label: const Text('Pesquise o colaborador'),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    )),
              ),
            ),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        top: 12, right: 8, left: 8, bottom: 5),
                    itemCount: controller.listCollaborators.length,
                    itemBuilder: (ctx, index) {
                      Collaborator collaborator =
                          controller.listCollaborators[index];
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.endToStart) {
                            showConfirmationDialog(
                              titulo: 'Confirmação',
                              subtitulo:
                                  'Confirma a exclusão do registro selecionado?',
                              onConfirm: () async {
                                dynamic retorno = await controller
                                    .deleteCollaborator(collaborator);
                                Get.back();
                                if (retorno != null &&
                                    retorno['message'] != null) {
                                  if (retorno['message'] == 'success') {
                                    Get.snackbar('Sucesso!',
                                        'Operação realizada com sucesso!',
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 2),
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    Get.snackbar('Falha!',
                                        'Falha ao realizar a operação!',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 2),
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                } else {
                                  Get.snackbar(
                                      'Falha!', 'Nenhum retorno informado!',
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
                                      Icon(Icons.delete,
                                          color: Colors.white, size: 25)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Text(collaborator.nome!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(collaborator.tipo!.toUpperCase()),
                              ],
                            ),
                            leading: IconButton(
                                onPressed: () {
                                  controller.fillInFieldsItem(collaborator);
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        CustomCollaboratorModal(
                                      collaborator: collaborator,
                                      controller: controller,
                                      tituloModal: "Alterar Colaborador",
                                      alterar: true,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        ),
                      );
                    }),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF014acb),
        onPressed: () {
          controller.clear();
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) => CustomCollaboratorModal(
              controller: controller,
              tituloModal: "Inserir Colaborador",
              alterar: false,
            ),
          );
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
