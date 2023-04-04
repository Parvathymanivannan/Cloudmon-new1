import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DemoAlarmJson {
  final String alarm_status;
  // final String alarmrule;
  // final int id;
  final int alarms;
  // final String metric;

  // final String title;

  DemoAlarmJson({
    required this.alarm_status,
    // required this.alarmrule,
    required this.alarms,
    // required this.metric
  });

  factory DemoAlarmJson.fromJson(Map<dynamic, dynamic> json) {
    return DemoAlarmJson(
      alarm_status: json['alarm_status'],
      // alarmrule: json['alarmrule'],
      alarms: json["alarms"],
      // metric: json["metric"],

      // title: json['title'],
    );
  }
}

class Alarmrule {
  final String rules;
  Alarmrule({
    required this.rules,
  });
  factory Alarmrule.fromJson(Map<dynamic, dynamic> json) {
    return Alarmrule(
      rules: json["rules"],
    );
  }
}

class Rule {
  final String metric;
  Rule({
    required this.metric,
  });
  factory Rule.fromJson(Map<dynamic, dynamic> json) {
    return Rule(metric: json["metric"]);
  }
}

class ApiManagerAlarm {}

class DemoAlarm extends StatelessWidget {
  int i;
  DemoAlarm({
    Key? key,
    required this.i,
  }) : super(key: key);

  Future<List<DemoAlarmJson>> fetchData() async {
    // geting response from API.
    var response = await http.get(
      Uri.parse("https://demo-itim.veryxtech.com/api/devices/"),
      headers: <String, String>{
        'x-auth-token': 'c75a71d6-8e7c-4b61-ad3a-9153e76bba5b'
      },
    );
    // checking if Get request is successful by 200 status.
    if (response.statusCode == 200) {
      // decoding recieved string data into JSON data.
      var results = jsonDecode(response.body);
      // getting only Contries data from whole covid data which we convert into json.
      List jsonResponse = results["result"];

      jsonResponse.removeWhere((element) => element["alarms"] == 0);
      final finalResponse = results["result"];
      print(jsonResponse[i]);
      // return finalResponse[i];
      // return list by maping it with Result class.
      return jsonResponse[i]
          .map((data) => DemoAlarmJson.fromJson(data))
          .toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DemoAlarmJson>?>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (int j = 0; j <= i;) {
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  var aS = snapshot.data![i].alarm_status;
                  var aM = "snapshot.data![i].metric";
                  print(i);
                  return Container(
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(
                          child: Text(
                              "Device is experiencing high memory storage",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          child: Text("$aS $aM",
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  );
                });
          }
        } else {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString(),
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black));
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
