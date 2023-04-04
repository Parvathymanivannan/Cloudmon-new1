import 'package:Cloudmon/screens/authenticate/login_1.dart';
import 'package:Cloudmon/screens/members/member_list.dart';
import 'package:flutter/material.dart';
import 'package:Cloudmon/services/auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../alarm/alarm.dart';
import '../../alarm/alarm_triage.dart';
import '../../authenticate/dynamic_controller_url.dart';
import '../../tabs/tabController.dart';

class UserName {
  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('tkn');
    return name;
  }
}

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);

  // String getUser(String username) async {
  //   // print(username);
  //   return username;
  // }

  // String name = getUser;
  @override
  Widget build(BuildContext context) {
    String name = getName.toString();
    return Drawer(
      child: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(30)),
          Center(
            child: ListTile(
              title: Text("Hello $name",
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              onTap: () {},
            ),
          ),
          ListTile(
            title: const Text('Home',
                style: TextStyle(color: Colors.black, fontSize: 18)),
            leading: const Icon(
              Icons.home,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return TabView(
                    name: 'name',
                    xauthtoken: 'token',
                  );
                }),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.graphic_eq,
            ),
            title: const Text("Alarm Triage",
                style: TextStyle(color: Colors.black, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlarmTriage(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Device",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DynamicController()),
              );
            },
          ),
          // DrawerListTile(
          //   title: "IP Endpoints",
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const MemberList()),
          //     );
          //   },
          // ),
          // DrawerListTile(
          //   title: "Support",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Settings",
          //   press: () {},
          // ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text("Sign Out",
                style: TextStyle(color: Colors.black, fontSize: 18)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Get.off(const SignUpScreen());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SignUpScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      // leading: SvgPicture.asset(
      //   svgSrc,
      //   color: Colors.white54,
      //   height: 16,
      // ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('tkn');
  return name;
}
