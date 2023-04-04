import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/alarm/alarm_triage.dart';
import 'screens/authenticate/login_1.dart';
import 'screens/authenticate/tableSort_demo.dart';
import 'screens/tabs/tabController.dart';
import 'services/auth.dart';
import 'models/FirebaseUser.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.notification!.title);
  print(message.notification!.body);
  // Navigator.pop(1, const GreenPage());
}

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("e450a9a3-02ac-4129-b187-851a0e946c1f");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accept) {
    print("Accepted permission: $accept");
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  // Future<void> initState() async {
  //   //   TODO: implement initState
  //   // super.initState();
  //   // on message works properly when use this line
  //   // await Firebase.initializeApp();

  //   // Works when the app is in foreground
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (message.notification != null) {
  //       print(message.notification!.body);
  //       print(message.notification!.title);
  //     }
  //   });

  //   FirebaseMessaging.instance.getInitialMessage().then((message) {
  //     if (message != null) {
  //       final routeFromMessage = message.data["route"];
  //       print(routeFromMessage);
  //       // Navigator.of(context).pushNamed(routeFromMessage);
  //     }
  //   });

  //   // Works when the app is in background and the user the notify
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     final routeFromMessage = message.data["route"];
  //     print(routeFromMessage);
  //     // Navigator.of(context).pushNamed(routeFromMessage)
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    return StreamProvider<FirebaseUser?>.value(
      value: AuthController().user,
      initialData: null,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xfff10000),
          buttonTheme: ButtonThemeData(
            buttonColor: const Color(0xfff10000),
            textTheme: ButtonTextTheme.primary,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(
              fontSize: 20.0,
            ),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
          ),
          // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[600]),
        ),
        // home:  Album(alarms: "null"),
        // home: const SignUpScreen(),
        routes: {'/alarm_triage': (context) => AlarmTriage()},
        home: FutureBuilder(
          future: authController.tryAutoLogin(),
          builder: (context, authResult) {
            if (authResult.connectionState == ConnectionState) {
              return const CircularProgressIndicator();
            } else {
              if (authResult.data == true) {
                return TabView(
                  name: '',
                  xauthtoken: '',
                );
              } else {
                return const SignUpScreen();
              }
            }
          },
        ),
      ),
    );
  }
}

void initDynamicLinks() async {
  FirebaseDynamicLinks.instance.onLink.listen(
    (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deeplink = dynamicLink?.link;
      if (deeplink != null) {
        // print(deeplink.toString());
        Get.toNamed(deeplink.queryParameters.values.first);
      }
    },
  );
}
