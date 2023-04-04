import 'package:Cloudmon/screens/authenticate/users.dart';
import 'package:flutter/material.dart';
import 'api_manager.dart';
import 'demo_alarm.dart';

// void main() {
//   runApp(const SignupScreen2());
// }

class SignupScreen2 extends StatelessWidget {
  const SignupScreen2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primarySwatch: Colors.amber),
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        // stream: null,
        builder: (context, snapshot) {
      return Scaffold(
          // appBar: AppBar(title: const Text('DataTable getting Future type data')),
          // Geting Future data from API
          body: FutureBuilder<List<Data>>(
              future: ApiManager().fetchDatas(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                if (!snapshot.hasData) {
                  // checking if API has data & if no data then loading bar
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // return data after recieving it in snapshot.
                  return Container(
                      padding: const EdgeInsets.all(5),
                      // Data Table logic and code is in DataClass
                      child: DataClass(datalist: snapshot.data as List<Data>));
                }
              }));
    });
  }
}

class DataClass extends StatelessWidget {
  const DataClass({Key? key, required this.datalist}) : super(key: key);
  final List<Data> datalist;

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Builder(builder: (context) {
      return Scaffold(
          body: SingleChildScrollView(
              // Using scrollView for scrolling and formating
              scrollDirection: Axis.vertical,
              // using FittedBox for fitting complte table in screen horizontally.
              child: FittedBox(
                  child: DataTable(
                sortColumnIndex: 1,
                showCheckboxColumn: false,
                border: TableBorder.all(width: 1.0),
                // Data columns as required by APIs data.
                columns: const [
                  DataColumn(
                      label: Text(
                    "Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    "Alarms",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    "Status",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ],
                // Main logic and code for geting data and shoing it in table rows.
                rows: datalist
                    .map(
                        //maping each rows with datalist data
                        (data) => DataRow(cells: [
                              DataCell(
                                  Text(data.name,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500)),
                                  onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DemoAlarm(
                                    i: datalist.indexOf(data),
                                  ),
                                  settings: RouteSettings(
                                    arguments: datalist.indexOf(data),
                                  ),
                                  // DemoAlarm(i: datalist.indexOf(data))
                                ));
                              }),
                              DataCell(Text(data.alarms.toString(),
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500))),
                              DataCell(
                                Text(data.alarm_status,
                                    style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ]))
                    .toList(), // converting at last into list.
              ))));
    });
  }
}
