import 'package:flutter/material.dart';
import '../ui/constant/theme_data.dart';

class ButtonMenu extends StatelessWidget {
  String text;
  double height;
  double width;
  List<Color> backColor;
  Color textColor;
  Color? borderColor;

  ButtonMenu(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      required this.backColor,
      required this.textColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage(sys_color_defaultorange == backColor
          //         ? 'assets/images/sys_orange.png'
          //         : ''),
          //     fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.fromBorderSide(BorderSide(
            width: borderColor != null ? 4 : 0,
            strokeAlign: 1,
            color: borderColor != null ? btnColorPurpleLight : Colors.white,
          )),
          // color: backColor,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: backColor),
          boxShadow: [
            BoxShadow(
              color: btnColorGreyDark2,
              // blurStyle: BlurStyle.normal,
              offset: const Offset(
                1.0,
                3.0,
              ),
              blurRadius: 3.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            // const BoxShadow(
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
              fontFamily: defaultFontFamily,
              fontSize: defaultMenuButtonFontSize,
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
