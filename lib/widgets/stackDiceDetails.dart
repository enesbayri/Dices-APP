// ignore_for_file: file_names, avoid_unnecessary_containers, non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/uiHelper/colorHelper.dart';
import 'package:flutter_application_10/uiHelper/textUiHelper.dart';
import 'package:flutter_application_10/widgets/dices.dart';
import 'package:flutter_application_10/widgets/popupMenu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StackDiceDetails extends StatefulWidget {
  const StackDiceDetails({super.key});

  @override
  State<StackDiceDetails> createState() => StackDiceDetailsState();
}

class StackDiceDetailsState extends State<StackDiceDetails> {
  int numberOne = 1;
  int numberTwo = 1;
  bool oneDice = true;
  bool diceCheat = false;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    Future<int> diceAnimation() {
      return Future.delayed(
        const Duration(milliseconds: 1000),
        () {
          return 1;
        },
      );
    }

    return Stack(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Platform.isIOS==true? cupertinosettingsMenu(context):androidPopUpMenu(),

            ),
        FutureBuilder(
          key: UniqueKey(),
          future: diceAnimation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return dices(
                  oneDice: oneDice, numberOne: numberOne, numberTwo: numberTwo);
            } else {
              return Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/diceGif.gif"));
            }
          },
        ),
        OrientationBuilder(builder:(context, orientation) {
        double leftPosition;
        double bottomPosition;
        if(orientation==Orientation.portrait){
          leftPosition=MediaQuery.of(context).size.width / 2 - 35;
          bottomPosition=MediaQuery.of(context).size.height / 3.8;
          
        }else{
          if(oneDice){
            leftPosition=(MediaQuery.of(context).size.width*0.75);
            bottomPosition=MediaQuery.of(context).size.height/2-60;
          }else{
            leftPosition=MediaQuery.of(context).size.width / 2 - 35;
            bottomPosition=MediaQuery.of(context).size.height / 4.0;
          }
        
        }
        return rollDice(context,leftPosition,bottomPosition);
      }, )
        ,
        Platform.isIOS==true ?CupertinoButtonOneDice(context): androidButtonOneDice(context),
        Platform.isIOS==true ?CupertinoButtonTwoDice(context): androidButtonTwoDice(context),
        
      ],
    );
  }

  CupertinoButton cupertinosettingsMenu(BuildContext context) {
    return CupertinoButton(child: const Icon(CupertinoIcons.star_lefthalf_fill),
          onPressed: () {
            showCupertinoDialog(context: context, builder: (context) {
              return StatefulBuilder(
              builder: (context, setState) => SimpleDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: Column(
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.diceD20,
                          color: ColorHelper.MainColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "AYARLAR",
                          style: TextUiHelper.SettingsDialogTitleTextStyle,
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black,
                    )
                  ],
                ),
                children: [
                  Container(
                    child: Column(
                      children: [
                        SwitchListTile.adaptive(
                          value: diceCheat,
                          onChanged: (value) {
                            setState(() {
                              
                              diceCheat=value;
                            },);           
                          },
                          title: Text(
                            "HİLELİ ZAR:",
                            style: TextUiHelper.popupTextStyle,
                          ),
                        ),
                        diceCheat==false ? Container() : Padding(
                          padding: const EdgeInsets.only(left:12,right: 12),
                          child: Text("Tek ve Çift zarda 'ZAR AT' butonuna uzun bastığınızda hileli atış gerçekleşecektir. Normal bastığınızda hile olmayacaktır. Sıra sizdeyken uzun basmanız yeterlidir!",style:TextUiHelper.DiceCheatInfo,),
                        ),
                        Align(alignment: Alignment.bottomRight,
                          child: CupertinoButton(child: const Text("GERİ"), onPressed: () {
                            Navigator.of(context).pop();
                          },),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
            },);
          },
          );
  }

  Popupmenu androidPopUpMenu() {
    return Popupmenu(
            diceCheat: diceCheat,
            diceCheatExport: (value) {
              setState(() {
                diceCheat = value;
              });
            },
          );
  }

  Positioned androidButtonOneDice(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).size.height / 10,
        left: MediaQuery.of(context).size.width / 2 - 120,
        child: SizedBox(
          height: 30,
          width: 80,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                oneDice = true;
                numberOne = 1;
                numberTwo = 1;
                total = 0;
              });
            },
            child: const Text("Tek Zar")),
        ),
      );
  }
  Positioned CupertinoButtonOneDice(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).size.height / 7,
        right: MediaQuery.of(context).size.width / 2 - 90,
        child: Container(
          child: CupertinoButton.filled(
            onPressed: () {
              setState(() {
                oneDice = true;
                numberOne = 1;
                numberTwo = 1;
                total = 0;
              });
            },
            child: const Text("Tek Zar")),
        ),
      );
  }

  Positioned CupertinoButtonTwoDice(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: MediaQuery.of(context).size.width / 2 - 90,
        child: Container(
          child:CupertinoButton.filled(
            onPressed: () {
              setState(() {
                oneDice = false;
                numberOne = 1;
                numberTwo = 1;
                total = 0;
              });
            },
            child: const Text("Çift Zar")),
        ),
      );
  }
   Positioned androidButtonTwoDice(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).size.height / 10,
        right: MediaQuery.of(context).size.width / 2 - 120,
        child: SizedBox(
          height: 30,
          width: 80,
          child:ElevatedButton(
            onPressed: () {
              setState(() {
                oneDice = false;
                numberOne = 1;
                numberTwo = 1;
                total = 0;
              });
            },
            child: const Text("Çift Zar")),
        ),
      );
  }





  Stack rollDice(BuildContext context,double leftPosition,double bottomPosition) {
    return Stack(
      children: [
          Positioned(
            bottom: bottomPosition,
            left: leftPosition,
            child: GestureDetector(
              onTap: oneTapDice,
              onLongPress: longPressDiceCheat,
              child: SizedBox(
                width: 75,
                height: 75,
                child: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.dice,
                      color: ColorHelper.MainIconColor,
                      size: 36,
                    ),
                    Divider(
                      height: 18,
                      color: ColorHelper.MainIconColor,
                    ),
                    Text(
                      "ZAR AT",
                      style: TextUiHelper.buttonTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
    );
  }

  void oneTapDice() {
    if (oneDice) {
      setState(() {
        numberOne = Random().nextInt(6) + 1;
        total = numberOne;
      });
    } else {
      setState(() {
        numberOne = Random().nextInt(6) + 1;
        numberTwo = Random().nextInt(6) + 1;
        total = numberOne + numberTwo;
      });
    }
  }

  void longPressDiceCheat() {
    if (diceCheat) {
      if (oneDice) {
        if (total == 0) {
          numberOne = 6;
        } else {
          numberOne = Random().nextInt(7 - total) + total;
        }
        total = numberOne;
      } else {
        if (total == 0) {
          numberOne = 6;
          numberTwo = 6;
        } else {
          if (total >= 8) {
            int randomInt = Random().nextInt(2);
            switch (randomInt) {
              case 0:
                numberOne = Random().nextInt(7 - numberOne) + numberOne;
                numberTwo = Random().nextInt(7 - numberTwo) + numberTwo;
                break;
              case 1:
                numberOne = Random().nextInt(7 - numberTwo) + numberTwo;
                numberTwo = Random().nextInt(7 - numberOne) + numberOne;
              default:
            }
          } else {
            do {
              numberOne = Random().nextInt(6) + 1;
              numberTwo = Random().nextInt(6) + 1;
            } while (total >= numberOne + numberTwo);
          }
        }
        total = numberOne + numberTwo;
      }
      setState(() {});
    }
  }

  
}
