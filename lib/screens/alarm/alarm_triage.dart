import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../constants.dart';
import '../../responsive.dart';
import '../authenticate/table_main.dart';
import '../authenticate/table_view_demo.dart';
import '../chart.dart';
import '../home/components/side_menu.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<DemoAlarmJson>> fetchAlarms() async {
  var url = Uri.parse('https://demo-itim.veryxtech.com/api/alarms?status=open');
  final response = await http.get(
    url,
    headers: <String, String>{
      'x-auth-token': '33920778-9681-4252-8268-dd90b05e490f',
      // 'x-auth-token': ApiManager.getData.toString(),
    },
  );
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    final alarms = jsonResponse[0];
    print(alarms);
    return jsonResponse.map((data) => DemoAlarmJson.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class DemoAlarmJson {
  final String severity;
  final String description;
  final String metric;
  final String status;
  final int id;

  DemoAlarmJson({
    required this.severity,
    required this.description,
    required this.metric,
    required this.status,
    required this.id,
  });

  factory DemoAlarmJson.fromJson(Map<dynamic, dynamic> json) {
    return DemoAlarmJson(
      severity: json['severity'],
      description: json["description"],
      metric: json['metric'],
      status: json["status"],
      id: json["id"],
    );
  }
}

class AlarmTriage extends StatelessWidget {
  AlarmTriage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            const Text('Alarm Triage', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
          child: SizedBox(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
          const MyHomePage5()
        ]),

        // padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      )),
    );
  }
}

class MyHomePage5 extends StatefulWidget {
  const MyHomePage5({super.key});

  @override
  State<MyHomePage5> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyHomePage5> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   initDynamicLinks();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DemoAlarmJson>>(
      future: fetchAlarms(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var sev = snapshot.data![index].severity;
                  var metric = snapshot.data![index].metric;
                  var id = snapshot.data![index].id;
                  var status = snapshot.data![index].status;
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 1.0,
                      ),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // Row(
                          //   children: [
                          //     Flexible(
                          //       child: Text(
                          //         "Alarms from Critical ($length impacted)",
                          //         style: const TextStyle(
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //         textAlign: TextAlign.left,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data![index].description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              //   Flexible(
                              //   child: Text(
                              //     "Id: $id Severity: $sev Status: $status Metric: $metric",
                              //     textAlign: TextAlign.left,
                              //   ),
                              // )
                            ],
                          ),
                          Row(children: [
                            Flexible(
                              child: Text(
                                "Id: $id Severity: $sev Status: $status Metric: $metric",
                                textAlign: TextAlign.left,
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
