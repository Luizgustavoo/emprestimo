import 'package:emprestimo/app/data/repositories/collaborator_repository.dart';
import 'package:emprestimo/app/data/repositories/home_repository.dart';
import 'package:emprestimo/routes/app_pages.dart';
import 'package:emprestimo/routes/app_routes.dart';
import 'package:emprestimo/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init('emp');

  Get.put(HomeRepository());
  Get.put(CollaboratorRepository());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empréstimo',
      theme: appThemeData,
      initialRoute: Routes.initial,
      getPages: AppPages.routes,
    );
  }
}
