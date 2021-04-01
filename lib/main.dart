// main.dart

import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'pages/pages.dart';
import 'utils/utils.dart';

void main() {
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ganin Solution',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      // home: HomePage(),
      initialRoute: '/',

      ///* tapi kalau routesnya ga ada mereka ga akan mengeluarkan routes di route bar.
      routes: {
        '/': (context) => HomePage(),
        '/00': (context) => HomePage00(),
      },

      ///* onGenerateRoute digunakan untuk menghilangkan animasi default dari flutter. yang katanya kaya bledeg _LS
      onGenerateRoute: (setting) {
        switch (setting.name) {
          case "/":
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => HomePage(),
              transitionDuration: Duration(seconds: 0),
              // transitionsBuilder: (_, a, __, c) =>
              //     FadeTransition(opacity: a, child: c),
            );
          case "/00":
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => HomePage00(),
              transitionDuration: Duration(seconds: 0),
            );
          default:
        }
      },
    );
  }
}
