import 'dart:convert';
import 'package:Cloudmon/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../tabs/tabController.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_manager.dart';
import 'dynamic_controller_url.dart';
import 'package:dio/dio.dart';

Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class Value {}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _hasBeenPressed = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getValue();
  }

  void login(String username, password) async {
    Map<String, String> data = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('https://demo-itim.veryxtech.com/api/auth/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    _formKey.currentState!.save();
    AuthController.login(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var controllerUrl = prefs.getString("controllerUrl");

    if (response.statusCode == 200) {
      // Authentication successful, parse the response for the access token
      final responseData = jsonDecode(response.body.toString());
      final responseHeader = jsonEncode(response.headers["x-auth-token"]);
      final accessToken = responseData['data'];
      final username = accessToken["name"];

      // auth token
      final responseHeaders = jsonEncode(response.headers["x-auth-token"]!);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', responseHeaders);
      // Get Name
      await prefs.setString('username', username);
      // secure storage
      final storageToken = FlutterSecureStorage();
      var auth_token =
          await storageToken.write(key: 'auth_token', value: responseHeader);

      // Navigation to Dashboard
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TabView(
                  name: accessToken["name"], xauthtoken: responseHeaders)));

      // Save the access token to secure storage for future use
      // (e.g. using the flutter_secure_storage package)
    } else {
      // Authentication failed, handle the error accordingly
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    var controllerurl;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 80),
              const SizedBox(height: 25.0),
              Column(children: const [
                Text(
                  "Sign In",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Hi there! Nice to see you again.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 186, 186, 186)),
                  textAlign: TextAlign.left,
                ),
              ]),
              const SizedBox(height: 25.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        suffixIcon: Icon(Icons.verified_user),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  obscureText: _obscureText,
                  obscuringCharacter: "*",
                  controller: passwordController,
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.trim().length < 6) {
                      return 'Password must be at least 6 characters in length';
                    }
                    // Return null if the entered password is valid
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                },
                // child: Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //       color:  const Color(0x002948cb),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: const Center(
                //     child: Text(
                //       'Login',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
                child: ElevatedButton(
                  onPressed: () {
                    login(emailController.text.toString(),
                        passwordController.text.toString());

                    setState(() {
                      _hasBeenPressed = !_hasBeenPressed;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: const Color(0xFF2948cb),
                    padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                    backgroundColor: _hasBeenPressed
                        ? const Color(0xFF2948cb)
                        : const Color(0xFFFF4040),
                    // 3
                  ),
                  // linear-gradient(100deg,#d52a37 0%,#3f45bf 75%)
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              const Center(
                child: Text(
                  "Controller URL",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  baseUrl,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DynamicController()));
                },
                style: ElevatedButton.styleFrom(
                  // backgroundColor: const Color(0xFF2948cb),
                  padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                  backgroundColor: _hasBeenPressed
                      ? const Color(0xFF2948cb)
                      : const Color(0xFFFF4040),
                  // 3
                ),
                // linear-gradient(100deg,#d52a37 0%,#3f45bf 75%)
                child: const Text(
                  'Change',
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Roboto", fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
