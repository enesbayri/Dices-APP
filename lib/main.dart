

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_10/pages/homePage.dart';
import 'package:flutter_application_10/uiHelper/colorHelper.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle( systemNavigationBarColor: Colors.transparent,statusBarColor: Colors.transparent,));
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ZAR",
      theme: ThemeData(primarySwatch: ColorHelper.createMaterialColor(const Color.fromRGBO(155,29,32,1))),
      home:HomePage() ,
    );
  }
}