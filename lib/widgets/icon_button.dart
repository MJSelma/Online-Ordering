import 'package:flutter/material.dart';

class IconButtonMenu extends StatelessWidget {
  String text;
  IconData iconMenu;
  double height;
  double width;
  Color backColor;
  IconButtonMenu({
    required this.text,
    required this.iconMenu,
    required this.height,
    required this.width,
    required this.backColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: Icon(
              iconMenu,
              color: Colors.white
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'SFPro',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
