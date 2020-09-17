import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netoprmgr_lg_flutter/controller/server_controller.dart';

class PostResult {
  List<String> traceroute;

  PostResult({this.traceroute});

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    var resultFromJson = object['traceroute'];
    List<String> resultList = new List<String>.from(resultFromJson);
    return PostResult(
      traceroute: resultList,
    );
  }

  static Future<PostResult> connectToAPI(
      String sourceIP, String destinationIP) async {
    ServerController serverController = Get.find();
    String apiURL = serverController.serverIP.toString() + "/api/v1/traceroute";

    var apiResult = await http.post(
      apiURL,
      body: {"sourceip": sourceIP, "destinationip": destinationIP},
    );

    var jsonObject = json.decode(apiResult.body);
    // print(jsonObject);

    return PostResult.createPostResult(jsonObject);
  }
}
