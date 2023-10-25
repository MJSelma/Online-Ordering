import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class SmartMenu extends StatefulWidget {
  const SmartMenu({super.key});

  @override
  State<SmartMenu> createState() => _SmartMenuState();
}

class _SmartMenuState extends State<SmartMenu> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Smart Menu',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontFamily: 'SFPro', fontSize: 20),
          ),
        ),
      ],
    );
  }
}
