import 'package:flutter/material.dart';

import '../ui/constant/theme_color.dart';

warningDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 3, color: systemDefaultColorOrange, strokeAlign: 1),
            borderRadius: BorderRadius.circular(20.0)),
        title: DecoratedBox(
          decoration: BoxDecoration(
            color: showDialogBackgrounddColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 400,
            height: 180,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: systemDefaultColorOrange,
                            fontWeight: FontWeight.bold)),
                    Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: const Icon(
                          Icons.close,
                          size: 14,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      message.toUpperCase(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 25,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       width: 150,
                //       height: 35,
                //       decoration: BoxDecoration(
                //         color: const Color.fromARGB(255, 210, 69, 69),
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       child: TextButton(
                //         child: const Text(
                //           'Okay',
                //           style: TextStyle(
                //             fontFamily: 'SFPro',
                //             fontSize: 18,
                //             color: sys_color_white,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return systemDefaultColorOrange;
}
