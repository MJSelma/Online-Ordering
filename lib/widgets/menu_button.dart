import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/menu_provider.dart';
import '../ui/constant/theme_color.dart';

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
          width: isMenuOpen ? 200 : 50,
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: const Border.fromBorderSide(BorderSide(
                strokeAlign: 1,
                color: Colors.white,
              )),
              gradient: indexMenu == widget.val
                  ? null
                  : indexMenuHover == widget.val
                      ? null
                      : LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // stops: const [
                          //   0.1,
                          //   0.4,
                          //   0.6,
                          //   0.9,
                          // ],
                          colors: [button_color_grey, Colors.grey.shade200]),
              // boxShadow: [
              //   BoxShadow(
              //     color: button_color_grey,
              //     offset: const Offset(
              //       0.0,
              //       2.0,
              //     ),
              //     blurRadius: 4.0,
              //     spreadRadius: 2.0,
              //   ),
              // ],
              color: indexMenu == 0 && indexMenuHover == 100
                  ? sys_color_purpleLight
                  : indexMenu > 0 && indexMenu == widget.val
                      ? sys_color_defaultorange
                      : indexMenuHover == widget.val
                          ? sys_color_defaultorange
                          : button_color_grey
              // : Colors.grey.shade200,
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                child: Icon(
                  widget.iconMenu,
                  color: indexMenu == widget.val
                      ? Colors.white
                      : indexMenuHover == widget.val
                          ? Colors.white
                          : sys_color_purple,
                ),
              ),
              Visibility(
                visible: isMenuOpen,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 14,
                    color: indexMenu == widget.val
                        ? Colors.white
                        : indexMenuHover == widget.val
                            ? Colors.white
                            : sys_color_purple,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
