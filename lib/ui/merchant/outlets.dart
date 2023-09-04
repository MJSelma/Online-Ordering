import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../provider/businessOutletProvider.dart';
import '../data_class/outlet_class.dart';

class OutletsPage extends StatefulWidget {
  const OutletsPage({super.key});

  @override
  State<OutletsPage> createState() => _OutletsPageState();
}

class _OutletsPageState extends State<OutletsPage> {
  List<OutletClass> outletClass = [];
  String currentItem = 'Select Outlet';
  String currentOutletName = '';
  OutletClass? dropDownValue;
  String businessName = '';
  bool isSelectedOutlet = false;
  int indexYesNo = 0;
  bool isAbsorb = true;
  String saveEditButton = 'EDIT';
  int addHeight = 100;

  TextEditingController txtLocation = TextEditingController();
  String strLocation = '';
  // String strLocation = 'Queen Elizabeth Ave. 12, 20-233 Angel Town';

  TextEditingController txtNumber = TextEditingController();
  String strNumber = '';
  // String strNumber = '+343 59 456 3452';

  TextEditingController txtEmail = TextEditingController();
  String strEmail = '';
  // String strEmail = 'xxxww@coffeebean.com';

  TextEditingController txtDescription = TextEditingController();
  String strDescription = '';
  // String strDescription = 'Cafetteria, Bar';

  TextEditingController txtCurrency = TextEditingController();
  String strCurrency = '';
  // String strCurrency = 'USD';

  int intStar = 0;

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

  @override
  Widget build(BuildContext context) {
    final businessProviderRead = context.read<BusinessOutletProvider>();

    final docId = context.select((BusinessOutletProvider p) => p.docId);
    final businessNamex =
        context.select((BusinessOutletProvider p) => p.businessName);
    final outletClassx =
        context.select((BusinessOutletProvider p) => p.outletClass);
    final isSelected =
        context.select((BusinessOutletProvider p) => p.isBusinessSelected);

    outletClass = outletClassx;
    businessName = businessNamex;
    if (isSelected == true) {
      currentItem = 'Select Outlet';

      currentOutletName = '';
      businessProviderRead.setIsBusinessSelected(false);
    }
    if (currentItem == 'Select Outlet') {
      isSelectedOutlet = false;
    }

    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    String dropdownValuex = list.first;

    const List<String> listRegion = <String>[
      'Central African cuisine',
      'East African cuisine',
      'North African cuisine',
      'Southern African cuisine'
    ];
    String dropdownValueRegion = listRegion.first;

    const List<String> listCuisine = <String>[
      'Angolan cuisine',
      'Cameroonian cuisine',
      'Chadian cuisine',
      'Gabonese cuisine'
    ];
    String dropdownValueCuisine = listCuisine.first;

    final dropdown = DropdownButton<OutletClass>(
      items: _createList(),
      underline: const SizedBox(),
      iconSize: 0,
      isExpanded: false,
      borderRadius: BorderRadius.circular(20),
      hint: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isSelectedOutlet == true
              ? const Color(0xffef7700)
              : Colors.grey.shade200,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business,
              color: isSelectedOutlet == true
                  ? Colors.white
                  : const Color.fromARGB(255, 66, 64, 64),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              currentItem,
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 18,
                color: isSelectedOutlet == true
                    ? Colors.white
                    : const Color.fromARGB(255, 66, 64, 64),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onChanged: (OutletClass? value) {
        setState(() {
          currentItem = value!.name;
          currentOutletName = value.name;
          strLocation = value.location;
          indexYesNo = value.isLocatedAt == true ? 0 : 1;
          strNumber = value.contactNumber;
          strEmail = value.email;
          strDescription = value.description;
          strCurrency = value.currency;
          intStar = value.star;

          txtLocation.text = strLocation;
          txtNumber.text = strNumber;
          txtEmail.text = strEmail;
          txtDescription.text = strDescription;
          txtCurrency.text = strCurrency;

          dropDownValue = value;
          isSelectedOutlet = true;
        });
      },
    );

    void save() async {
      saveEditButton = 'EDIT';
      isAbsorb = true;
      strLocation = txtLocation.text;
      strNumber = txtNumber.text;
      strEmail = txtEmail.text;
      strDescription = txtDescription.text;
      strCurrency = txtCurrency.text;
      addHeight = 100;
    }

    void update() async {
      saveEditButton = 'SAVE';
      isAbsorb = false;
      txtLocation.text = strLocation;
      txtNumber.text = strNumber;
      txtEmail.text = strEmail;
      txtDescription.text = strDescription;
      txtCurrency.text = strCurrency;
      addHeight = 0;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0.0, 40.0, 0.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Main Wall',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffef7700)),
                  ),
                  InkWell(
                    child: SizedBox(width: 200, child: dropdown),
                    onHover: (value) {
                      setState(() {
                        outletClass = outletClassx;
                      });
                    },
                    onTap: () {
                      setState(() {
                        outletClass = outletClassx;
                      });
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height - addHeight,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 10.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      child: Text(
                                    '$businessName $currentOutletName',
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ))
                                ],
                              ),
                              const Spacer(),
                              Visibility(
                                visible: currentOutletName != '',
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RatingBarIndicator(
                                          rating: 1,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 1,
                                          itemSize: 50.0,
                                          direction: Axis.horizontal,
                                        ),
                                        Container(
                                          child: Text(
                                            '$intStar Star-Points',
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black54,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: currentOutletName != '',
                          child: AbsorbPointer(
                            absorbing: isAbsorb,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'location',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Text(
                                          'Is your store inside any Airport/Mall/Hotel/Theme Park',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: indexYesNo == 0
                                                  ? true
                                                  : false,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  indexYesNo = 0;
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                            Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: indexYesNo == 1
                                                  ? true
                                                  : false,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  indexYesNo = 1;
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                            child: saveEditButton == 'SAVE'
                                                ? SizedBox(
                                                    width: 600,
                                                    child: TextField(
                                                      controller: txtLocation,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  )
                                                : Text(
                                                    strLocation,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                    ),
                                                  )),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          'Contacts',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Container(
                                          child: saveEditButton == 'SAVE'
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 600,
                                                      child: TextField(
                                                        controller: txtNumber,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 600,
                                                      child: TextField(
                                                        controller: txtEmail,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      strNumber,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    Text(
                                                      strEmail,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          'Schedule',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Text(
                                          'Mon-Fri',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Text(
                                          '09:00-21:30',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Text(
                                          'Sat-Sun',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Text(
                                          '07:30-22:30',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Category',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Container(
                                        child: saveEditButton == 'SAVE'
                                            ? SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  controller: txtDescription,
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            : Text(
                                                strDescription,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                      ),
                                      // const Text(
                                      //   'Bar',
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.black54,
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'CUISINE',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      DropdownMenu<String>(
                                        // initialSelection: list.first,
                                        width: 200,
                                        hintText: 'CHOOSE REGION',
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValueRegion = value!;
                                          });
                                        },
                                        dropdownMenuEntries: listRegion
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      DropdownMenu<String>(
                                        // initialSelection: list.first,
                                        width: 200,
                                        hintText: 'CHOOSE CUISINE',
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValueCuisine = value!;
                                          });
                                        },
                                        dropdownMenuEntries: listCuisine
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'CUISINE STYLE',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      DropdownMenu<String>(
                                        // initialSelection: list.first,
                                        width: 200,
                                        hintText: 'NIL',
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValuex = value!;
                                          });
                                        },
                                        dropdownMenuEntries: list
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Currency',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Container(
                                        child: saveEditButton == 'SAVE'
                                            ? SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  controller: txtCurrency,
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            : Text(
                                                strCurrency,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: currentOutletName != '',
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SEASONAL BREAK',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'CLOSE LOCATION',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: const Color(0xffef7700),
                                        ),
                                        child: Container(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                if (isAbsorb == false) {
                                                  save();
                                                } else {
                                                  update();

                                                  // txtLocation.text =
                                                  //     'Queen Elizabeth Ave. 12, 20-233 Angel Town';
                                                }
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 5, 0),
                                                  child: Icon(
                                                    isAbsorb == true
                                                        ? Icons.edit
                                                        : Icons.save,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  saveEditButton,
                                                  style: const TextStyle(
                                                    fontFamily: 'SFPro',
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
    return const Color(0xffef7700);
  }
}
