import 'package:emprestimo/app/data/controllers/collaborator_controller.dart';
import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class CartView extends GetView<HomeController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empréstimo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    var item = controller.cartItems[index];
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
                            // controller.cartItems.removeAt(index);
                          },
                        ),
                      ),
                    );
                  },
                )),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.cartItems.isNotEmpty
                        ? () {
                            final collaboratorController =
                                Get.put(CollaboratorController());
                            collaboratorController.getCollaborators();
                            showLoanModal(context);
                          }
                        : null,
                    child: const Text(
                      'AVANÇAR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void showLoanModal(BuildContext context) {
    final DateTime now = DateTime.now();
    final collaboratorController = Get.put(CollaboratorController());
    final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy HH:mm').format(now),
    );

    final SignatureController signatureController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Cadastro de Empréstimo',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  Obx(() {
                    return DropdownButtonFormField<int>(
                      isDense: true,
                      menuMaxHeight: Get.size.height / 2,
                      value:
                          collaboratorController.collaboratorSelected!.value > 0
                              ? collaboratorController
                                  .collaboratorSelected!.value
                              : null,
                      onChanged: (int? value) {
                        if (value != null) {
                          collaboratorController.collaboratorSelected!.value =
                              value;
                        }
                      },
                      items: [
                        const DropdownMenuItem<int>(
                          value: null,
                          child: Text('Recebido por'),
                        ),
                        ...collaboratorController.listCollaborators
                            .map<DropdownMenuItem<int>>(
                                (Collaborator collaborator) {
                          return DropdownMenuItem<int>(
                            value: collaborator.id,
                            child: Text(collaborator.nome!),
                          );
                        }),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Família',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Data e Hora',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          final dateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          dateController.text =
                              DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Assinatura'),
                  const SizedBox(height: 10),
                  InkWell(
                    onLongPress: () => signatureController.clear(),
                    child: Signature(
                      height: 450,
                      width: double.infinity,
                      controller: signatureController,
                      backgroundColor: Colors.grey[200]!,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            if (signatureController.isNotEmpty) {
                              var signature =
                                  await signatureController.toPngBytes();
                              if (signature != null) {
                                // controller.insertLoan(
                                //     collaboratorController
                                //         .collaboratorSelected!.value,
                                //     signature);
                                Get.back();
                              }
                            }
                          },
                          child: const Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
