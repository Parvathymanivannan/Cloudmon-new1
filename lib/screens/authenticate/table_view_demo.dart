import 'package:Cloudmon/screens/authenticate/users.dart';
import 'package:flutter/material.dart';
import '../sort/sort2.dart';
import 'api_manager.dart';

class TabViewClass extends StatelessWidget {
  const TabViewClass({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Dashboard',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primarySwatch: Colors.amber),
        home: TabViewState());
  }
}

class TabViewState extends StatelessWidget {
  const TabViewState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('DataTable getting Future type data')),
        // Geting Future data from API
        body: FutureBuilder<List<Data>>(
            future: ApiManager().fetchData(),
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
  }
}

class DataClass extends StatelessWidget {
  const DataClass({Key? key, required this.datalist}) : super(key: key);
  final List<Data> datalist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      // Using scrollView for scrolling and formating
      scrollDirection: Axis.vertical,
      // using FittedBox for fitting complte table in screen horizontally.

      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0), child: Sort2()),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text(
                  "Alarms",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                // DataColumn(
                //     label: Text(
                //   "Status",
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // )),
              ],
              // Main logic and code for geting data and shoing it in table rows.
              rows: datalist
                  .map(
                      //maping each rows with datalist data
                      (data) => DataRow(cells: [
                            DataCell(
                              Text(data.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                            DataCell(
                              Text(data.alarms.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              // onTap: () => AlarmView(),
                            ),
                            // const DataCell(
                            //   Text("data",
                            //       style: TextStyle(
                            //           fontSize: 26,
                            //           fontWeight: FontWeight.w500)),
                            // ),
                          ]))
                  .toList(), // converting at last into list.
            )),
          ),
        ],
      ),
    ));
  }
}
