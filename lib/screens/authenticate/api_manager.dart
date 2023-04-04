import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'users.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

class ApiServiceLocator {
  static String get apiUrl => baseUrl;
}

class ApiManager {
  Future<List<Data>> fetchData() async {
    final storageToken = FlutterSecureStorage();
    final token = await storageToken.read(key: 'auth_token');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? alarm = prefs.getString('alarm');
    String? auth = prefs.getString('token');
    String ann = auth!;
    String aN = "7785668f-d48c-44b2-a1fa-d87bfeb78d72";

    // geting response from API.
    var response = await http.get(
      Uri.parse("https://demo-itim.veryxtech.com/api/devices"),
      headers: <String, String>{
        'x-auth-token': "c02232b7-5d2f-43f2-a223-63314ffff166",
      },
    );
    print(token);
    print("Printing Token $auth'");
    print("Printing Alarm $alarm");
    print(response.statusCode);
    print(ann);
    // checking if Get request is successful by 200 status.
    if (response.statusCode == 200) {
      // decoding recieved string data into JSON data.
      var results = jsonDecode(response.body);

      List jsonResponse = results["result"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? alarm = prefs.getString('alarm');

      if (alarm == "Alarmed") {
        jsonResponse.removeWhere((element) => element["alarms"] == 0);
        return jsonResponse.map((data) => Data.fromJson(data)).toList();
      } else {
        return jsonResponse.map((data) => Data.fromJson(data)).toList();
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Data>> fetchDatas() async {
    String baseUrl = "https://demo-itim.veryxtech.com/api";
    final client = http.Client();
    String apiUrl = ApiServiceLocator.apiUrl;
    String endpoint = "/devices";
    print(apiUrl + endpoint);
    // var response = await http.get(
    //   Uri.parse(apiUrl + endpoint),
    //   headers: <String, String>{
    //     'x-auth-token': "c02232b7-5d2f-43f2-a223-63314ffff166",
    //   },
    // );

    final response = await client.get(Uri.parse('$baseUrl/devices'));
    const baseUrls = "https://demo-itim.veryxtech.com/api";
    const endpoints = "/devices";
    final responseNew = await client.get(
      Uri.parse('https://demo-itim.veryxtech.com/api/devices'),
      headers: <String, String>{
        'x-auth-token': "c02232b7-5d2f-43f2-a223-63314ffff166",
      },
    );
    print(responseNew);
    print(response.statusCode);

    // checking if Get request is successful by 200 status.
    if (response.statusCode == 200) {
      // decoding recieved string data into JSON data.
      var results = jsonDecode(responseNew.body);
      print(results);
      List jsonResponse = results["result"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? alarm = prefs.getString('alarm');

      if (alarm == "Alarmed") {
        jsonResponse.removeWhere((element) => element["alarms"] == 0);
        return jsonResponse.map((data) => Data.fromJson(data)).toList();
      } else {
        return jsonResponse.map((data) => Data.fromJson(data)).toList();
      }
    } else {
      throw Exception("response.reasonPhrase");
    }
  }
}

getValue() async {
  var pref = await SharedPreferences.getInstance();
  final getAuth = pref.getString("token");
  final tkn = getAuth;

  return getAuth;
}
