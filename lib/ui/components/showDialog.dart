import 'package:flutter/material.dart';

import '../../widgets/icon_button.dart';

warningDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0xffef7700),
            ),
            borderRadius: BorderRadius.circular(20.0)),
        title: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 400,
            height: 200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Color(0xffef7700),
                            fontWeight: FontWeight.bold)),
                    // Container(
                    //   alignment: Alignment.topRight,
                    //   child: InkWell(
                    //     child: const Icon(
                    //       Icons.close,
                    //       size: 14,
                    //     ),
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // )
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
                      message,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: IconButtonMenu(
                          text: 'Close',
                          iconMenu: Icons.close,
                          width: 150,
                          height: 35,
                          backColor: const Color.fromARGB(255, 210, 69, 69),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
