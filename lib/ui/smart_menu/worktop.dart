import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class WorkTop extends StatefulWidget {
  const WorkTop({super.key});

  @override
  State<WorkTop> createState() => _WorkTopState();
}

class _WorkTopState extends State<WorkTop> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Smart Menu > Worktop',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontFamily: 'SFPro', fontSize: 20),
          ),
        ),
      
      ],
    );
  }

}
