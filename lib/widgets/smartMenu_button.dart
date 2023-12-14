import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/business_outlet_provider.dart';
import '../provider/menu_provider.dart';

class SmartMenuButton extends StatefulWidget {
  String text;
  int val;
  IconData iconMenu;
  double height;
  double paddingLeft;
  SmartMenuButton(
      {super.key,
      required this.text,
      required this.val,
      required this.iconMenu,
      required this.height,
      required this.paddingLeft});

  @override
  State<SmartMenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<SmartMenuButton> {
  int indexMenuHover = 100;

  @override
  Widget build(BuildContext context) {
    int indexMenu = context.select((MenuProvider p) => p.indexMenu);
    bool isMenuOpen = context.select((MenuProvider p) => p.isMenuOpen);
    String outletId =
        context.select((BusinessOutletProvider p) => p.selectedOutletId);
    return Padding(
      padding: EdgeInsets.fromLTRB(widget.paddingLeft, 0, 0, 0),
      child: Container(
        width: isMenuOpen ? 200 : 50,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade200,
          // color: smartMenuIndex == widget.val
          //     ? const Color(0xffef7700)
          //     : Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
              child: Icon(
                widget.iconMenu,
                color: const Color.fromARGB(255, 66, 64, 64),
                // color: smartMenuIndex == val
                //     ? Colors.white
                //     : const Color.fromARGB(255, 66, 64, 64),
              ),
            ),
            Visibility(
              visible: isMenuOpen,
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontFamily: 'SFPro',
                  fontSize: 18,
                  color: Color.fromARGB(255, 66, 64, 64),
                  // color: smartMenuIndex == val
                  //     ? Colors.white
                  //     : const Color.fromARGB(255, 66, 64, 64),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
