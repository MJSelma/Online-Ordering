import 'package:drinklinkmerchant/splash_page.dart';
import 'package:drinklinkmerchant/ui/dashboard.dart';
import 'package:drinklinkmerchant/ui/web_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => const SplashPage());

      case Routes.webMain:
        return CupertinoPageRoute(builder: (_) => const WebMainPage());

      case Routes.dashBoard:
        return CupertinoPageRoute(builder: (_) => const DashBoard());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
