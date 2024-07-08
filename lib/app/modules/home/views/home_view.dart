import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/modules/cart/views/list_cart_view.dart';
import 'package:emprestimo/app/modules/home/widgets/custom_drawer.dart';
import 'package:emprestimo/app/modules/home/widgets/custom_home_card.dart';
import 'package:emprestimo/app/modules/home/widgets/custom_home_modal.dart';
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
        child: RefreshIndicator(
          onRefresh: () => controller.getItens(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 12, right: 12, left: 12, bottom: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFf1f5ff),
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
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        itemCount: controller.listItems.length,
                        itemBuilder: (ctx, index) {
                          Item item = controller.listItems[index];
                          return CustomHomeCard(
                              controller: controller, item: item);
                        }),
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF014acb),
        onPressed: () {
          controller.clearItem();
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) => CustomHomeModal(
              alterar: false,
              tituloModal: "Cadastro de Item",
              controller: controller,
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
