// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../tabs/tabController.dart';

// class Splachscreen extends StatefulWidget {
//   const Splachscreen({super.key});

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<Splachscreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         const Duration(seconds: 5),
//         () => Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => const TabviewClass())));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       // child: FlutterLogo(size: MediaQuery.of(context).size.height));
//       child: Image.asset("assets/images/logo.png", width: 20),
//     );
//   }
// }
