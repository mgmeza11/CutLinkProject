import 'package:cut_link_project/domain/repositories/link_repository.dart';
import 'package:cut_link_project/domain/usecases/link_usecases.dart';
import 'package:cut_link_project/view/controllers/main_controller.dart';
import 'package:cut_link_project/view/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'view/controllers/historical_controller.dart';
import 'view/pages/my_home_page.dart';

void main() {
  Get.put(LinkRepository());
  Get.put(LinkUseCases());
  Get.put(MainController());
  Get.put(HistoricalController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CutLink',
      debugShowCheckedModeBanner: false,
      theme: Themes.themeLight,
      darkTheme: Themes.themeDark,
      home: MyHomePage(),
    );
  }
}




