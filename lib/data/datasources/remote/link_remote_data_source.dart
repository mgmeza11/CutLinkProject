import 'dart:convert';
import 'dart:developer';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;

class LinkRemoteDataSource {
  Future<String> getShortLink(String link) async {
    var request = Uri.parse("https://cleanuri.com/api/v1/shorten");
    var response = await http.post(request,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {'url': link})
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      log.printInfo(info: "status 200");
      final String jsonString = response.body;
      final String result = jsonDecode(jsonString)['result_url'];
      log.printInfo(info: 'status 200 $result');
      return result;
    }else{
      log.printInfo(info: "status failed");
    }

    return Future.error("error");
  }
}
