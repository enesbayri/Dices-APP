
// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_application_10/uiHelper/colorHelper.dart';
import 'package:flutter_application_10/uiHelper/textUiHelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class Popupmenu extends StatefulWidget {
  Popupmenu({
    super.key,
    required this.diceCheat,
    required this.diceCheatExport,
  });

  bool diceCheat;
  final Function diceCheatExport;

  @override
  State<Popupmenu> createState() => _PopupmenuState();
}

class _PopupmenuState extends State<Popupmenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.star_half,
          color: ColorHelper.MainIconColor,
          size: 36,
        ),
      ),
      itemBuilder: (context) => popupItems(context)
    );
  }

  List<PopupMenuEntry> popupItems(context) {
    List<PopupMenuEntry> items = [
      PopupMenuItem(
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.diceD20,
              color: ColorHelper.MainColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              "Ayarlar",
              style: TextUiHelper.popupTextStyle,
            )
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => SimpleDialog(
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
                          SwitchListTile(
                            value: widget.diceCheat,
                            onChanged: (value) {
                              setState(() {
                                widget.diceCheatExport(value);
                                widget.diceCheat=value;
                              },);           
                            },
                            title: Text(
                              "HİLELİ ZAR:",
                              style: TextUiHelper.popupTextStyle,
                            ),
                          ),
                          widget.diceCheat==false ? Container() : Padding(
                            padding: const EdgeInsets.only(left:12,right: 12),
                            child: Text("Tek ve Çift zarda 'ZAR AT' butonuna uzun bastığınızda hileli atış gerçekleşecektir. Normal bastığınızda hile olmayacaktır. Sıra sizdeyken uzun basmanız yeterlidir!",style:TextUiHelper.DiceCheatInfo,),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      )
    ];
    return items;
  }
}