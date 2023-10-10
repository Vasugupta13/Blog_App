import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:subspace/controllers/home_list_controller.dart';
import 'package:subspace/model/hive_model.dart';
import 'package:subspace/utils/dependancy_injection.dart';
import 'package:subspace/view/home_screen.dart';

Future<void>main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeListController());
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      initialBinding: BindingsBuilder(() {
      }),
    );
  }
}

