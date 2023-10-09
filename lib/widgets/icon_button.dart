import 'package:flutter/material.dart';

import '../ui/constant/theme_color.dart';

class IconButtonMenu extends StatelessWidget {
  String text;
  IconData iconMenu;
  double height;
  double width;
  Color backColor;
  Color textColor;
  IconButtonMenu(
      {super.key,
      required this.text,
      required this.iconMenu,
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
              color: btn_color_gray2dark,
              offset: const Offset(
                0.0,
                2.0,
              ),
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            // const BoxShadow(
            //   color: Colors.red,
            //   offset: Offset(0.0, 3.0),
            //   blurRadius: 0.0,
            //   spreadRadius: 2.0,
            // ), //BoxShad
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: Icon(iconMenu, color: Colors.white),
          ),
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
