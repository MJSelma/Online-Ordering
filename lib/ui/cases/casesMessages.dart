import 'package:flutter/material.dart';

class CasesMessages extends StatefulWidget {
  String id;
  CasesMessages({super.key, required this.id});

  @override
  State<CasesMessages> createState() => _CasesMessagesState();
}

class _CasesMessagesState extends State<CasesMessages> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Column(
      children: [Text('Messages')],
    ));
  }
}
