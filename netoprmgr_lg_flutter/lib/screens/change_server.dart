import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netoprmgr_lg_flutter/controller/server_controller.dart';
import 'package:netoprmgr_lg_flutter/screens/home.dart';

class ChangeServerPage extends StatelessWidget {
  ServerController serverController = Get.find();
  TextEditingController serverInputController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Server'),
      ),
      body: Column(
        children: [
          Obx(() => Text(serverController.serverIP.toString())),
          TextFormField(
            controller: serverInputController,
          ),
          RaisedButton(
              child: Text('Submit New Server'),
              onPressed: () {
                serverController.serverIP =
                    RxString(serverInputController.text);
                Get.off(HomePage());
              })
        ],
      ),
    );
  }
}
