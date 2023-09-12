import 'package:flutter/material.dart';

class SmartMenu extends StatefulWidget {
  const SmartMenu({super.key});

  @override
  State<SmartMenu> createState() => _SmartMenuState();
}

class _SmartMenuState extends State<SmartMenu> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Smart Menu', style: TextStyle(fontWeight: FontWeight.w200, fontFamily: 'SFPro',),),
        ),
        Row(children: [

        ],)
      ],
    );
  }
}