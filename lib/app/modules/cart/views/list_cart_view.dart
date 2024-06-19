import 'dart:convert';
import 'dart:typed_data';

import 'package:emprestimo/app/data/controllers/collaborator_controller.dart';
import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:emprestimo/app/modules/cart/widgets/custom_cart_card.dart';
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
                    return CustomCartCard(item: item, controller: controller);
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
      penStrokeWidth: 3,
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
              Form(
                key: controller.loanKey,
                child: Column(
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
                        validator: (value) {
                          if (value == null || value <= 0) {
                            return 'Por favor, selecione uma colaborador';
                          }
                          return null;
                        },
                        isDense: true,
                        menuMaxHeight: Get.size.height / 2,
                        value: collaboratorController
                                    .collaboratorSelected!.value >
                                0
                            ? collaboratorController.collaboratorSelected!.value
                            : null,
                        onChanged: (int? value) {
                          if (value != null) {
                            collaboratorController.collaboratorSelected!.value =
                                value;
                          }
                        },
                        items: [
                          const DropdownMenuItem<int>(
                            value: 0,
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
                          labelText: 'Colaborador',
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
                                final Uint8List? data =
                                    await signatureController.toPngBytes(
                                        width: 1080, height: 1080);

                                String base64Image = "";

                                if (data != null) {
                                  base64Image = base64Encode(data);
                                }

                                if (base64Image.isNotEmpty) {
                                  Map<String, dynamic> retorno =
                                      await controller.insertLoan(
                                          collaboratorController
                                              .collaboratorSelected!.value,
                                          base64Image);

                                  if (retorno['return'] == 0) {
                                    controller.cartItems.clear();
                                    Get.toNamed('/');
                                  }

                                  Get.snackbar(
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    retorno['return'] == 0
                                        ? 'Sucesso'
                                        : "Falha",
                                    retorno['message'],
                                    backgroundColor: retorno['return'] == 0
                                        ? Colors.green
                                        : Colors.red,
                                    colorText: Colors.white,
                                  );
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
              ),
            ],
          ),
        );
      },
    );
  }
}
