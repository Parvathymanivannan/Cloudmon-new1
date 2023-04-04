import 'package:Cloudmon/screens/chart.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../constants.dart';
import '../../responsive.dart';
import '../home/components/side_menu.dart';
import 'package:pie_chart/pie_chart.dart';

List _elements = [
  // {
  //   'image': Image.asset("assets/images/logo.png", width: 20),
  //   'group': '67%',
  // },
  // {'image': 'Device is experiencing high memory usage', 'group': '67%'},
  // {'image': 'Device is experiencing high memory usage', 'group': '67%'},
  // {'image': 'Device is experiencing high memory usage', 'group': '67%'},
  // {'image': Image.asset("assets/images/logo.png", width: 20), 'group': '90%'},
  // {'image': 'Device is experiencing high memory usage', 'group': '90%'},
];

class AlarmOuter extends StatelessWidget {
  const AlarmOuter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _isHide = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      home: Scaffold(
        appBar: AppBar(
          title:
              const Text('Alarm Triage', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: primaryColor),
        ),
        drawer: SideMenu(),

        // ignore: prefer_const_literals_to_create_immutables
        body: ListView(
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

            Row(children: <Widget>[
              Expanded(
                child: Image.asset("assets/images/alarm-error-1.png"),
              ),
            ]),
            Row(children: <Widget>[
              Expanded(
                child: Image.asset("assets/images/alarm-error-2.png"),
              ),
            ]),
            // Row(
            //   children: const <Widget>[
            //     Image.asset("assets/images/alarm-error-2.png"),
            //   ],
            // ),
            Row(
              children: [
                Container(
                  width: fullDegree,
                  // margin: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                )
              ],
            ),
            Row(
              children: const <Widget>[
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2.0),
                        // leading: const Icon(Icons.account_circle),
                        title: Text(
                          "MTTR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2.0),
                        // leading: const Icon(Icons.account_circle),
                        title: Text(
                          "Alarms",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            Row(
              children: const <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    "5h 30m34s",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "6",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: fullDegree,
                  // margin: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                )
              ],
            ),
            Row(
              children: const <Widget>[
                Expanded(
                    child: SizedBox(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    // leading: const Icon(Icons.account_circle),
                    title: Text(
                      "Active Alarms by Severity",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            Row(
              children: const <Widget>[
                Expanded(child: Chart3()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Alarm extends StatelessWidget {
  const Alarm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   // debugShowCheckedModeBanner: false,
    //   // title: 'Flutter Demo',
    //   // theme: ThemeData(
    //   //   primarySwatch: Colors.blue,
    //   // ),
    //   home: Scaffold(
    //     // appBar: AppBar(
    //     //   title: const Text('Grouped List View Example'),
    //     // ),
    //     body: GroupedListView<dynamic, String>(
    return SizedBox(
      height: 400,
      child: Stack(children: [
        GroupedListView<dynamic, String>(
          elements: _elements,
          groupBy: (element) => element['group'],
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1['image'].compareTo(item2['image']),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              // textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              child: SizedBox(
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  // leading: const Icon(Icons.account_circle),
                  title: Text(
                    element['image'],
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  // trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
