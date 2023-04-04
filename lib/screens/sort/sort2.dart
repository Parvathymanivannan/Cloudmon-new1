import 'package:Cloudmon/screens/authenticate/api_manager.dart';
import 'package:Cloudmon/screens/tabs/tabController.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authenticate/api_manager.dart';
import '../authenticate/table_main.dart';

class Sort2 extends StatefulWidget {
  const Sort2({super.key});

  @override
  State<Sort2> createState() => _Sort2State();
}

class _Sort2State extends State<Sort2> {
  @override
  void initState() {
    super.initState();
    ddValue();
  }

  String val = "";
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: const TextStyle(color: Colors.black),

      // underline: Container(
      //   height: 2,
      //   color: Colors.red,
      // ),
      decoration: const InputDecoration(
        labelText: 'Sort',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
          //<-- SEE HERE
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),

      // value: selected,
      items: ["Alarmed", "All"]
          .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
          .toList(),
      onChanged: (value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('alarm', value!);
        ApiManager().fetchData();
        // setState(() {
        //   var setState = value;
        // });

        // if (value == "") {
        //   setState(() => {value, const SignupScreen2()});
        // }
        // if (value == "Alarmed") {
        //   setState(() => {value, const SignupScreen2()});
        // }
        // if (value == "All") {
        //   setState(() => {value, const SignupScreen2()});
        // }
      },
      // onTap: () async {
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   prefs.getString('tkn');
      //   setState(() {
      //     prefs.getString('tkn');
      //   });
      //   ApiManager.fetchData;
      // },
      // onTap: (value) => ApiManager().fetchData(),
    );
  }
}

ddValue() async {
  var pref = await SharedPreferences.getInstance();
  final val = pref.getString("alarm");
  print("value $val");
  return val;
}
