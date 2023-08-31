import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../data_class/outlet_class.dart';

class OutletsPage extends StatefulWidget {
  const OutletsPage({super.key});

  @override
  State<OutletsPage> createState() => _OutletsPageState();
}

class _OutletsPageState extends State<OutletsPage> {
  List<OutletClass> outletClass = [];
  String currentItem = 'Select Outlet';
  OutletClass? dropDownValue;

  List<DropdownMenuItem<OutletClass>> _createList() {
    return outletClass
        .map<DropdownMenuItem<OutletClass>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Center(
              child: Text(
                e.name,
                style: const TextStyle(
                  color: Color(0xffbef7700),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  Future<void> _getOutlet(String docId) async {
    await FirebaseFirestore.instance
        .collection('businesses')
        .doc(docId)
        .collection('outlets')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var item in snapshot.docs) {
        DateTime date = (item['date'] as Timestamp).toDate();

        OutletClass outletClassx = OutletClass(
            docId: item.id,
            id: item['id'],
            name: item['name'],
            description: item['description'],
            image: item['image'],
            date: date,
            country: item['country']);
        outletClass.add(outletClassx);
        print(outletClass[0].name);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getOutlet('tZajIXre4OqWnhWg5RsV');
    });
  }

  @override
  Widget build(BuildContext context) {
    // const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    // String dropdownValuex = list.first;

    final dropdown = DropdownButton<OutletClass>(
      items: _createList(),
      underline: const SizedBox(),
      iconSize: 0,
      isExpanded: false,
      borderRadius: BorderRadius.circular(20),
      hint: Container(
        width: 200,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xffef7700)),
        alignment: Alignment.center,
        child: Text(
          currentItem,
          style: const TextStyle(
            fontFamily: 'SFPro',
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onChanged: (OutletClass? value) {
        setState(() {
          currentItem = value!.name;
          dropDownValue = value;
        });
      },
    );

    return Expanded(
      child: Column(
        children: [
          // DropdownMenu<String>(
          //   initialSelection: list.first,
          //   onSelected: (String? value) {
          //     // This is called when the user selects an item.
          //     setState(() {
          //       dropdownValuex = value!;
          //     });
          //   },
          //   dropdownMenuEntries:
          //       list.map<DropdownMenuEntry<String>>((String value) {
          //     return DropdownMenuEntry<String>(value: value, label: value);
          //   }).toList(),
          // )
          // FloatingActionButton(
          //   child: const Text('Refresh'),
          //   onPressed: () {
          //     setState(() {
          //       // _getOutlet('tZajIXre4OqWnhWg5RsV');
          //     });
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Main Wall',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  child: Container(child: dropdown),
                  onTap: () {
                    setState(() {});
                  },
                ),
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
            // child: const Row(
            //   children: [Text('Businesses')],
            // ),
          )
        ],
      ),
    );
  }
}
