// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';

// import '../../constants.dart';
// import '../../responsive.dart';
// import '../home/components/side_menu.dart';

// class WriteDb extends StatefulWidget {
//   const WriteDb({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }

// class _WriteDbState extends State<WriteDb> {
//   final database = FirebaseDatabase.instance.ref();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Manage Customers',
//         theme: ThemeData(
//           primarySwatch: Colors.green,
//           // backgroundColor: Colors.white,
//         ),
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Manage Customers',
//                 style: TextStyle(color: Colors.black)),
//             iconTheme: const IconThemeData(color: primaryColor),
//             backgroundColor: Colors.white,
//             actions: <Widget>[
//               IconButton(
//                 icon: const Icon(
//                   Icons.add,
//                   color: Colors.red,
//                 ),
//                 onPressed: () {
//                   // do something
//                 },
//               )
//             ],
//           ),
//           drawer: const SideMenu(),
//         ));
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FBM extends StatefulWidget {
  @override
  _FBMState createState() => _FBMState();
}

class _FBMState extends State<FBM> {
  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    getToken();

    super.initState();
  }

  void getToken() async {
    token = (await firebaseMessaging.getToken())!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Token : $token")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(token);
        },
        child: const Icon(Icons.print),
      ),
    );
  }
}
