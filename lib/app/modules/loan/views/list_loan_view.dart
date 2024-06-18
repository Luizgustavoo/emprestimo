// ignore_for_file: use_build_context_synchronously

import 'package:emprestimo/app/data/controllers/loan_controller.dart';
import 'package:emprestimo/app/data/models/loan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanView extends GetView<LoanController> {
  const LoanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listagem de Empréstimos')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, right: 12, left: 12, bottom: 5),
              child: TextFormField(
                decoration: InputDecoration(
                    label: const Text('Pesquise o empréstimo'),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    )),
              ),
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          top: 8, right: 8, left: 8, bottom: 5),
                      itemCount: controller.listLoan.length,
                      itemBuilder: (ctx, index) {
                        Loan loan = controller.listLoan[index];

                        String dataEmprestimo =
                            controller.formatApiDate(loan.createdAt!);
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.endToStart) {
                              showDialog(context, loan.id!);
                            }
                            return false;
                          },
                          background: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green.shade500),
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.check_rounded,
                                            color: Colors.white, size: 25)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Card(
                            child: ExpansionTile(
                                dense: true,
                                tilePadding: const EdgeInsets.all(5),
                                title: Text(
                                    'Recebido por:  ${loan.colaborador!.nome}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Entregue por: ${loan.user!.name}'),
                                    Text('Data Emp: $dataEmprestimo'),
                                    const Text('Data Dev: '),
                                  ],
                                ),
                                leading: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit)),
                                children: loan.itens!.map((item) {
                                  return Card(
                                    child: ListTile(
                                      dense: true,
                                      title: Text('ITEM: ${item.nome}'),
                                      subtitle: Text('MODELO: ${item.modelo}'),
                                      trailing: IconButton(
                                          onPressed: () {
                                            controller.deleteItemLoan(item.id!);
                                          },
                                          icon: const Icon(CupertinoIcons
                                              .arrowshape_turn_up_left_2_fill)),
                                    ),
                                  );
                                }).toList()),
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }

  void showDialog(context, int id) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16),
      title: "Confirmação",
      content: const Text(
        textAlign: TextAlign.center,
        'Tem certeza que deseja finalizar esse empréstimo?',
        style: TextStyle(
          fontFamily: 'Poppinss',
          fontSize: 18,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Color(0xFF014acb)),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // controller.deleteLoan(id);
          },
          child: const Text(
            "Confirmar",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
