import 'package:drinklinkmerchant/ui/data_class/cases_class.dart';
import 'package:drinklinkmerchant/provider/messageProvider.dart';
import 'package:drinklinkmerchant/routes/route_generator.dart';
import 'package:drinklinkmerchant/routes/routes.dart';
import 'package:drinklinkmerchant/ui/web_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/services/cases_services.dart';

bool isFlutterLocalNotificationsInitialized = false;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBJY62BrXSL1nAYg_HBz7p3QyCenryX4mk",
      appId: "1:64421969736:web:1c6871cb405c2fd034fd7d",
      messagingSenderId: "64421969736",
      projectId: "drinklinkv2-d84fe",
      storageBucket: "gs://drinklinkv2-d84fe.appspot.com",
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MessageProvider()),
      StreamProvider<List<CasesClass>>.value(
          value: CasesServices().getCasesList, initialData: const []),
      // StreamProvider<List<CasesMessagesClass>>.value(
      //     value: CasesMessagesServices().getCasesMessagesList,
      //     initialData: const []),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DrinkLink',
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Nunito",
        canvasColor: Colors.white,
        primarySwatch: Colors.indigo,
      ),
      home: const WebMainPage(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
