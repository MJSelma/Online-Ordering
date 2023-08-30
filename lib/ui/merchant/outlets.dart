import 'package:flutter/material.dart';

class OutletsPage extends StatefulWidget {
  const OutletsPage({super.key});

  @override
  State<OutletsPage> createState() => _OutletsPageState();
}

class _OutletsPageState extends State<OutletsPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Main Wall',
                  style: TextStyle(fontSize: 16),
                ),
                Text('Outlet'),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(0xffe9f9fc),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: const Row(
              children: [Text('Businesses')],
            ),
          )
        ],
      ),
    );
  }
}
