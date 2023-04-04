// ignore: avoid_web_libraries_in_flutter
// import "dart:js_util";

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../constants.dart';
import '../../responsive.dart';
import '../home/components/side_menu.dart';

// void main() => runApp(const MemberList());

List _elements = [
  {'name': 'John', 'group': 'Team A'},
  {'name': 'Will', 'group': 'Team A'},
  {'name': 'Beth', 'group': 'Team A'},
  {'name': 'Miranda', 'group': 'Team A'},
  {'name': 'Mike', 'group': 'Team A'},
  {'name': 'Danny', 'group': 'Team A'},
  {'name': 'John', 'group': 'Team A'},
  {'name': 'Will', 'group': 'Team A'},
  {'name': 'Beth', 'group': 'Team A'},
  {'name': 'Miranda', 'group': 'Team A'},
  {'name': 'Mike', 'group': 'Team A'},
  {'name': 'Danny', 'group': 'Team A'},
  {'name': 'Will', 'group': 'Team A'},
  {'name': 'Beth', 'group': 'Team A'},
  {'name': 'Miranda', 'group': 'Team A'},
  {'name': 'Mike', 'group': 'Team A'},
  {'name': 'Danny', 'group': 'Team A'},
];

class MemberList extends StatelessWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manage Customers',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // backgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Customers',
              style: TextStyle(color: Colors.black)),
          iconTheme: const IconThemeData(color: primaryColor),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.red,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        drawer: SideMenu(),
        body: GroupedListView<dynamic, String>(
          separator:
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
          ]),
          elements: _elements,
          groupBy: (element) => element['group'],
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1['name'].compareTo(item2['name']),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          // ignore: prefer_const_constructors
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            // const Padding(
            //   padding: EdgeInsets.all(15.0),
            // ignore: unnecessary_const
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search for devices or IP Endpoints',
              ),
            ),
          ),

          itemBuilder: (A, element) {
            return Card(
              elevation: 8.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: SizedBox(
                child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    leading: const Icon(Icons.account_circle),
                    title: Text(element['name']),
                    shape: const Border(bottom: BorderSide(color: Colors.grey))
                    // trailing: const Icon(Icons.arrow_forward),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
