import 'package:emprestimo/app/data/controllers/collaborator_controller.dart';
import 'package:emprestimo/app/utils/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                CustomDrawerItem(
                  onTap: () {
                    final collaboratoController =
                        Get.put(CollaboratorController());
                    collaboratoController.getCollaborators();
                    Get.toNamed('/collaborator');
                  },
                  title: 'Listagem de Colaboradores',
                  icon: Icons.add_rounded,
                ),
                CustomDrawerItem(
                  onTap: () {
                    Get.toNamed('/loan');
                  },
                  title: 'Listagem de Empréstimos',
                  icon: Icons.settings,
                ),
                // CustomDrawerItem(
                //   onTap: () {
                //     Get.toNamed('/equipment');
                //   },
                //   title: 'Listagem de Equipamentos',
                //   icon: Icons.settings,
                // ),
                CustomDrawerItem(
                  onTap: () {},
                  title: 'Relatórios',
                  icon: Icons.trending_up_rounded,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair do aplicativo'),
            onTap: () {
              if (UserService.clearBox()) {
                Get.offAllNamed('/login');
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomDrawerItem extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData icon;

  const CustomDrawerItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
