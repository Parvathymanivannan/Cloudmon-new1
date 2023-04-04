import 'package:Cloudmon/screens/sort/sort2.dart';
import 'package:flutter/material.dart';
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

import 'link.dart';

class Data {
  final String name;
  final int alarms;
  // final String title;

  Data({required this.name, required this.alarms});

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      name: json['name'],
      alarms: json['alarms'],
      // title: json['title'],
    );
  }
}

class TabView extends StatelessWidget {
  String name;
  String xauthtoken;
  TabView({Key? key, required this.name, required this.xauthtoken})
      : super(key: key);

  Future<List<Data>> fetchData() async {
    var url = Uri.parse('https://demo-itim.veryxtech.com/api/devices');
    final response = await http.get(
      (url),
      headers: <String, String>{'x-auth-token': xauthtoken},
    );
    if (response.statusCode == 200) {
      print(xauthtoken);
      var jsonResponse = jsonDecode(response.body);
      List jsonData = jsonResponse["result"];
      List jsonAlarms =
          jsonData.map((data) => Data.fromJson(data).alarms).toList();
      if (jsonAlarms == 1) {
        print(jsonData.map((data) => Data.fromJson(data).name).toList());
      }
      return jsonData.map((data) => Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  Expanded(
                    // default flex = 1
                    // and it takes 1/6 part of the screen
                    child: SideMenu(),
                  ),
              ]),

              // padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              const Padding(
                  padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                  child: Text(
                    'Reporting%',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const <Widget>[
                        Text(
                          "Agent",
                          style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Chart()
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const <Widget>[
                        Text(
                          "Devices",
                          style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Chart1()
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const <Widget>[
                        Text(
                          "IP Endpoints",
                          style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Chart2()
                      ],
                    ),
                  )
                ],
              ),
              DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          indicatorColor: Colors.black,
                          tabs: [
                            Tab(text: 'Agent'),
                            Tab(text: 'Devices'),
                            Tab(text: 'IP Endpoints'),
                            // Tab(text: 'Tab 4'),
                          ],
                        ),
                        Container(
                            height: fullDegree,
                            //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: const TabBarView(children: <Widget>[
                              SignupScreen2(),
                              TabViewClass(),
                              TabViewClass(),
                            ])),
                        const Center(
                          child: LogoImg(),
                        ),
                      ])),
            ]),
      ),
    );
  }
}
