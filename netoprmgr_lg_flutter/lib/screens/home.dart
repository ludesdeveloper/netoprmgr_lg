import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netoprmgr_lg_flutter/controller/server_controller.dart';
import 'package:netoprmgr_lg_flutter/api/post_result.dart';
import 'package:netoprmgr_lg_flutter/screens/change_server.dart';
import 'package:netoprmgr_lg_flutter/widgets/dynamic_input.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ServerController serverController = Get.find();
  List<DynamicInput> listInput = [];
  List<String> listResult = [];

  PostResult postResult = null;

  addInput() {
    listInput.add(DynamicInput());
    setState(() {});
  }

  removeInput() {
    listInput.removeLast();
    setState(() {});
  }

  submitData() {
    listResult.clear();
    listInput.forEach((widget) {
      print(widget.sourceController.text);
      print(widget.destinationController.text);
      PostResult.connectToAPI(
              widget.sourceController.text, widget.destinationController.text)
          .then((value) {
        var convertListValue = value.traceroute;
        List<String> newListValue = new List<String>.from(convertListValue);

        for (String value in newListValue) {
          listResult.add(value);
        }
        setState(() {});
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trace Route'),
        actions: [
          RaisedButton(
              child: Text('Change Server'),
              onPressed: () {
                Get.to(ChangeServerPage());
              })
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                  child: Text('Add Column'),
                  onPressed: () {
                    addInput();
                  }),
              RaisedButton(
                  child: Text('Remove Column'),
                  onPressed: () {
                    removeInput();
                  }),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    submitData();
                  }),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: listInput.length,
              itemBuilder: (_, index) => listInput[index],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: listResult.length,
              itemBuilder: (_, index) => Text(listResult[index]),
            ),
          ),
        ],
      ),
    );
  }
}
