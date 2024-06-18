import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/modules/cart/views/list_cart_view.dart';
import 'package:emprestimo/app/modules/home/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(actions: [
        IconButton(
          icon: GetX<HomeController>(
              builder: (controller) => Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Icon(Icons.shopping_cart_rounded),
                      if (controller.cartCount > 0)
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            controller.cartCount.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                    ],
                  )),
          onPressed: () {
            Get.to(() => const CartView());
          },
        ),
      ]),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, right: 12, left: 12, bottom: 5),
              child: TextFormField(
                decoration: InputDecoration(
                    label: const Text('Pesquise o equipamento'),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    )),
              ),
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          top: 12, right: 8, left: 8, bottom: 5),
                      itemCount: controller.listItems.length,
                      itemBuilder: (ctx, index) {
                        Item item = controller.listItems[index];
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Text(item.nome!),
                            subtitle: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Modelo: '),
                                Text('Cadastrado dia: 31/05/2024'),
                              ],
                            ),
                            leading: IconButton(
                                onPressed: () {
                                  controller.addToCart(item);
                                },
                                icon: const Icon(Icons.add_rounded)),
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF014acb),
        onPressed: () {
          showEquipmentModal(context);
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  void showEquipmentModal(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cadastro de Equipamento',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                      labelText: 'NOME')),
              const SizedBox(height: 10),
              TextFormField(
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
                      labelText: 'MODELO')),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.dateController,
                decoration: InputDecoration(
                  labelText: 'Data',
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
                    controller.dateController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
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
                      onPressed: () {},
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
        );
      },
    );
  }
}
