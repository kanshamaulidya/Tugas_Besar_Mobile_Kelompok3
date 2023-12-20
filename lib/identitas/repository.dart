import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tubes_mobile/model/model.dart';

class Repository {
  String final_baseUrl = 'https://reqres.in/api/unknown';

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(final_baseUrl));
      //print("masuk api");
      //print(response.body);

      if (response.statusCode == HttpStatus.ok) {
        if (kDebugMode) {}
        //print(response.body);
        final jsonResponse = json.decode(response.body);
        final datablog = jsonResponse['data'];
        List blog = datablog.map((i) => Blog.fromJson(i)).toList();
        return blog;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future postData(
      String color, int id, int year, String pantone_value, String name) async {
    try {
      http.Response response = await http.post(Uri.parse(final_baseUrl));
      //print("masuk api");
      //print(response.body);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
