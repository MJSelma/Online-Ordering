import 'package:flutter/material.dart';

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
            width: 300,
            height: 170,
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 12,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Color(0xffef7700),
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                          Text(
                            message,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
