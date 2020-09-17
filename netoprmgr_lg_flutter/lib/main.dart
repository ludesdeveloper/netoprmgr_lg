import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netoprmgr_lg_flutter/screens/home.dart';
import 'package:netoprmgr_lg_flutter/controller/server_controller.dart';

void main() => runApp(MyApp());
// void main() => runApp(GetMaterialApp(home: HomePage()));

class MyApp extends StatelessWidget {
  ServerController serverController = Get.put(ServerController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
