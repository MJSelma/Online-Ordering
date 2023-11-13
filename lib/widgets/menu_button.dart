import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/business_outlet_provider.dart';
import '../provider/menu_provider.dart';
import '../ui/constant/theme_data.dart';

class MenuButton extends StatefulWidget {
  String text;
  int val;
  IconData iconMenu;
  double height;
  double paddingLeft;
  MenuButton(
      {super.key,
      required this.text,
      required this.val,
      required this.iconMenu,
      required this.height,
      required this.paddingLeft});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  int indexMenuHover = 100;

  @override
  Widget build(BuildContext context) {
    int indexMenu = context.select((MenuProvider p) => p.indexMenu);
    bool isMenuOpen = context.select((MenuProvider p) => p.isMenuOpen);
    String outletId =
        context.select((BusinessOutletProvider p) => p.selectedOutletId);
    print(outletId);
    return Padding(
      padding: EdgeInsets.fromLTRB(widget.paddingLeft, 0, 0, 0),
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            indexMenuHover = widget.val;
          });
        },
        onExit: (event) {
          setState(() {
            indexMenuHover = 100;
          });
        },
        child: Container(
          width: isMenuOpen ? menuButtonWidthOpen : menuButtonWidthClose,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: widget.val == 0
                ? btnColorPurpleLight
                : indexMenu == widget.val &&
                        indexMenuHover == 100 &&
                        outletId != ''
                    ? systemDefaultColorOrange
                    : indexMenu == widget.val && indexMenuHover == widget.val
                        ? systemDefaultColorOrange
                        : indexMenuHover == widget.val
                            ? Colors.grey.shade200
                            : iconButtonTextColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                child: Icon(
                  size: 20,
                  widget.iconMenu,
                  color: widget.val == 0
                      ? iconButtonTextColor
                      : indexMenu == widget.val
                          ? iconButtonTextColor
                          : indexMenuHover == widget.val
                              ? systemDefaultColorOrange
                              : systemDefaultColorOrange,
                ),
              ),
              Visibility(
                visible: isMenuOpen,
                child: Flexible(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        // fontFamily: 'SFPro',
                        fontFamily: defaultFontFamily,
                        fontSize: defaultMenuButtonFontSize,
                        color: widget.val == 0
                            ? iconButtonTextColor
                            : indexMenu == widget.val
                                ? iconButtonTextColor
                                : indexMenuHover == widget.val
                                    ? systemDefaultColorOrange
                                    : systemDefaultColorOrange,
                        fontWeight: indexMenu == widget.val ||
                                indexMenuHover == widget.val
                            ? FontWeight.w900
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MenuButton extends StatefulWidget {
//   String text;
//   int val;
//   IconData iconMenu;
//   double height;
//   double paddingLeft;
//   MenuButton(
//       {super.key,
//       required this.text,
//       required this.val,
//       required this.iconMenu,
//       required this.height,
//       required this.paddingLeft});

//   @override
//   State<MenuButton> createState() => _MenuButtonState();
// }

// class _MenuButtonState extends State<MenuButton> {
//   int indexMenuHover = 100;

//   @override
//   Widget build(BuildContext context) {
//     int indexMenu = context.select((MenuProvider p) => p.indexMenu);
//     bool isMenuOpen = context.select((MenuProvider p) => p.isMenuOpen);
//     String outletId =
//         context.select((BusinessOutletProvider p) => p.selectedOutletId);
//     return Padding(
//       padding: EdgeInsets.fromLTRB(widget.paddingLeft, 0, 0, 0),
//       child: MouseRegion(
//         onHover: (event) {
//           setState(() {
//             indexMenuHover = widget.val;
//           });
//         },
//         onExit: (event) {
//           setState(() {
//             indexMenuHover = 100;
//           });
//         },
//         child: Container(
//           width: isMenuOpen ? menuButtonWidthOpen : menuButtonWidthClose,
//           height: widget.height,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             border: const Border.fromBorderSide(BorderSide(
//               strokeAlign: 1,
//               color: Colors.white,
//             )),
//             boxShadow: [
//               BoxShadow(
//                 color: btnColorGreyLight0,
//                 // blurStyle: BlurStyle.normal,
//                 offset: const Offset(
//                   1.0,
//                   3.0,
//                 ),
//                 blurRadius: 3.0,
//                 spreadRadius: 1.0,
//               ), //BoxShadow
//               // BoxShadow(
//               //   color: Colors.white,
//               //   offset: Offset(0.0, 0.0),
//               //   blurRadius: 0.0,
//               //   spreadRadius: 0.0,
//               // ), //BoxShad
//             ],

//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: indexMenu == widget.val &&
//                         indexMenuHover == 100 &&
//                         outletId != ''
//                     // ? [btnColorPurpleLight, btnColorPurpleDark]
//                     ? [btnColorOrangeLight, btnColorOrangeDark]
//                     : indexMenuHover == widget.val
//                         // ? [btnColorPurpleLight, btnColorPurpleDark]
//                         ? [btnColorGreyLight0, btnColorGreyLight0]
//                         : [Colors.grey.shade200, Colors.grey.shade300]),

//             // color: indexMenu == 0 && indexMenuHover == 100
//             //     ? sys_color_purpleLight
//             //     : indexMenu > 0 && indexMenu == widget.val
//             //         ? sys_color_defaultorange
//             //         : indexMenuHover == widget.val
//             //             ? sys_color_defaultorange
//             //             : button_color_grey
//             // : Colors.grey.shade200,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
//                 child: Icon(
//                   size: 20,
//                   widget.iconMenu,
//                   color: indexMenu == widget.val
//                       ? btnColorGreyDark1
//                       : indexMenuHover == widget.val
//                           ? btnColorGreyDark1
//                           : btnColorGreyDark1,
//                 ),
//               ),
//               Visibility(
//                 visible: isMenuOpen,
//                 child: Flexible(
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Text(
//                       widget.text,
//                       style: TextStyle(
//                         // fontFamily: 'SFPro',
//                         fontFamily: defaultFontFamily,
//                         fontSize: defaultMenuButtonFontSize,
//                         color: indexMenu == widget.val
//                             ? btnColorGreyDark1
//                             : indexMenuHover == widget.val
//                                 ? btnColorGreyDark1
//                                 : btnColorGreyDark1,
//                         fontWeight: indexMenu == widget.val ||
//                                 indexMenuHover == widget.val
//                             ? FontWeight.w900
//                             : FontWeight.normal,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
