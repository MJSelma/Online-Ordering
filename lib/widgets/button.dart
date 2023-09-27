import 'package:flutter/material.dart';

import '../ui/constant/theme_color.dart';

class ButtonMenu extends StatelessWidget {
  String text;
  double height;
  double width;
  Color backColor;
  Color textColor;

  ButtonMenu(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      required this.backColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: const Border.fromBorderSide(BorderSide(
            strokeAlign: 1,
            color: Colors.white,
          )),
          color: backColor,
          boxShadow: [
            BoxShadow(
              color: button_color_grey,
              offset: const Offset(
                0.0,
                2.0,
              ),
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            // BoxShadow(
            //   color: Colors.white,
            //   offset: Offset(0.0, 0.0),
            //   blurRadius: 0.0,
            //   spreadRadius: 0.0,
            // ), //BoxShad
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
