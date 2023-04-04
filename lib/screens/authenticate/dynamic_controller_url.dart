import 'dart:convert';

import 'package:Cloudmon/screens/authenticate/api_manager.dart';
import 'package:Cloudmon/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/components/side_menu.dart';
import '../tabs/tabController.dart';
import 'api_manager.dart';
import 'login_1.dart';

void dynamanicUrl() async {
  final formKey = GlobalKey<FormState>();
  formKey.currentState!.save();
}

Future<bool> checkIfUrlIsValid({required String url}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    return true;
  }
  return false;
}

class DynamicController extends StatefulWidget {
  const DynamicController({Key? key}) : super(key: key);

  @override
  _DynamicControllerState createState() => _DynamicControllerState();
}

class _DynamicControllerState extends State<DynamicController> {
  final _formKey = GlobalKey<FormState>();
  final bool _hasBeenPressed = false;
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 80),
              const SizedBox(height: 32.0),
              // const Center(
              //   child: Text(
              //     "Welcome!",
              //     style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              //   ),
              // ),
              const SizedBox(height: 25.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Controller URL',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {},
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: const Color(0xFF2948cb),
                    padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                    backgroundColor: _hasBeenPressed
                        ? const Color(0xFF2948cb)
                        : const Color(0xFFFF4040),
                    // 3
                  ),
                  // linear-gradient(100deg,#d52a37 0%,#3f45bf 75%)
                  child: const Text(
                    'Let\'s Begin',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
