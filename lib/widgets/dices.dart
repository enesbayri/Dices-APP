// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

class dices extends StatelessWidget {
  const dices({
    super.key,
    required this.oneDice,
    required this.numberOne,
    required this.numberTwo,
  });

  final bool oneDice;
  final int numberOne;
  final int numberTwo;

  @override
  Widget build(BuildContext context) {
    if (oneDice) {
      return OrientationBuilder(builder:(context, orientation) {
        if(orientation==Orientation.portrait){
          return OneDice(context,(MediaQuery.of(context).size.width/2-50));
        }else{
          return OneDice(context,(MediaQuery.of(context).size.width*0.1));
        }
      }, );
    } else {
      return Align(
          alignment: Alignment.center,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FadeInImage(
                    image: AssetImage(
                        ("assets/images/${numberOne.toString()}.jpeg")),
                    placeholder: const AssetImage(("assets/images/diceGif.gif")),
                  ),
                  FadeInImage(
                    image: AssetImage(
                        ("assets/images/${numberTwo.toString()}.jpeg")),
                    placeholder: const AssetImage(("assets/images/diceGif.gif")),
                  ),
                ],
              )));
    }
  }

  Stack OneDice(BuildContext context,double leftAlign) {
    return Stack(
      children: [
        Positioned(
          top:MediaQuery.of(context).size.height/2-60,
          left: leftAlign,
          child: FadeInImage(
            image: AssetImage(("assets/images/${numberOne.toString()}.jpeg")),
            placeholder: const AssetImage(("assets/images/diceGif.gif")),
          ),
        ),
      ],
    );
  }
}
