// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_10/widgets/stackDiceDetails.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final keydice=GlobalKey<StackDiceDetailsState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return  Platform.isIOS==true? Scaffold(
      resizeToAvoidBottomInset: false,
      body: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: content(context),
      ),
    )
    :
    Scaffold(
      resizeToAvoidBottomInset: false,
      body: content(context),
    );
  }

  Container content(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpeg"),
                  fit: BoxFit.fill)),

      child: Stack(
        children: [
          portraitLogo(context),
          SafeArea(child: StackDiceDetails(key: keydice,)),    
          
        ],
      ),
    );
  }

  Positioned portraitLogo(BuildContext context) {
    return Positioned(
                left: MediaQuery.of(context).size.width / 2 - 75,
                top: MediaQuery.of(context).size.height / 10,
                child: SizedBox(
                  width: 150,
                  height: 100,
                  child: Image.asset("assets/images/logo.png"),
                ));
  }

     
}
