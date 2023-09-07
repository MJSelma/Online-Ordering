import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../provider/businessOutletProvider.dart';
import '../data_class/outlet_class.dart';
import '../data_class/region_class.dart';

class OutletsPage extends StatefulWidget {
  const OutletsPage({super.key});

  @override
  State<OutletsPage> createState() => _OutletsPageState();
}

class _OutletsPageState extends State<OutletsPage> {
  final collection = FirebaseFirestore.instance;
  CollectionReference regionCollection =
      FirebaseFirestore.instance.collection('region');
  CollectionReference cusineCollection =
      FirebaseFirestore.instance.collection('cuisine');
  List<DocumentSnapshot> documentsx = [];

  List<OutletClass> outletClass = [];
  List<RegionClass> regionClass = [];

  String outletId = '';
  String currentItem = 'Select Outlet';
  String currentOutletName = '';
  String currentRegion = 'Choose Region';
  String currentRegionId = '';
  String currentCusine = 'Choose Cuisine';
  String currentCusineId = '';

  OutletClass? dropDownValue;
  String businessName = '';
  bool isSelectedOutlet = false;
  int indexYesNo = 0;
  bool isSetDefaultWall = false;
  bool isAbsorb = true;
  String saveEditButton = 'EDIT';
  int addHeight = 100;

  TextEditingController txtSearchRegion = TextEditingController();
  String strSearchRegion = '';

  TextEditingController txtSearchCusine = TextEditingController();
  String strSearchCusine = '';

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

  List<DropdownMenuEntry<RegionClass>> _createListREgion() {
    return regionClass
        .map<DropdownMenuEntry<RegionClass>>(
          (e) => DropdownMenuEntry(value: e, label: e.name),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final businessProviderRead = context.read<BusinessOutletProvider>();

    final docId = context.select((BusinessOutletProvider p) => p.docId);
    final businessNamex =
        context.select((BusinessOutletProvider p) => p.businessName);
    final defaultOutletIdProvider =
        context.select((BusinessOutletProvider p) => p.defaultOutletId);

    final outletClassx =
        context.select((BusinessOutletProvider p) => p.outletClass);
    final regionClassx =
        context.select((BusinessOutletProvider p) => p.regionClass);
    final isSelected =
        context.select((BusinessOutletProvider p) => p.isBusinessSelected);

    outletClass = outletClassx;
    businessName = businessNamex;
    // regionClass = regionClassx;
    print(regionClass.length);
    print('${outletId}outlet id here');
    regionClass =
        regionClass.where((item) => item.outletId == outletId).toList();
    print(regionClass.length);
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
          outletId = value.id;
          txtLocation.text = strLocation;
          txtNumber.text = strNumber;
          txtEmail.text = strEmail;
          txtDescription.text = strDescription;
          txtCurrency.text = strCurrency;

          dropDownValue = value;
          isSelectedOutlet = true;
          print('$defaultOutletIdProvider + $outletId');
          defaultOutletIdProvider.toLowerCase() == outletId.toLowerCase()
              ? isSetDefaultWall = true
              : isSetDefaultWall = false;
          currentRegion = 'Choose Region';
          currentCusine = 'Choose Cuisine';
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

    void getDefaultOutlet() {
      // outletClass.where((item) =>
      //     item.id.toLowerCase() == defaultOutletIdProvider.toLowerCase());

      for (var data in outletClass) {
        if (data.id.toLowerCase() == defaultOutletIdProvider.toLowerCase()) {
          currentItem = data.name;
          currentOutletName = data.name;
          strLocation = data.location;
          indexYesNo = data.isLocatedAt == true ? 0 : 1;
          strNumber = data.contactNumber;
          strEmail = data.email;
          strDescription = data.description;
          strCurrency = data.currency;
          intStar = data.star;
          txtLocation.text = strLocation;
          txtNumber.text = strNumber;
          txtEmail.text = strEmail;
          txtDescription.text = strDescription;
          txtCurrency.text = strCurrency;
          outletId = defaultOutletIdProvider;
          // dropDownValue = outletClass;
          isSelectedOutlet = true;
          isSetDefaultWall = true;
        }
      }
    }

    return Expanded(
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            if (isSelectedOutlet == false) {
              getDefaultOutlet();
            }
          });
          //hover
        },
        onExit: (_) {
          setState(() {
            if (isSelectedOutlet == false) {
              getDefaultOutlet();
            }
          });
        },
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
                    SizedBox(width: 200, child: dropdown),
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
                            padding: const EdgeInsets.fromLTRB(
                                40.0, 40.0, 40.0, 10.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width / 2,
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Visibility(
                                            visible: saveEditButton == 'SAVE',
                                            child: const Text(
                                              'Edit schedule',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text(
                                                    strDescription,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                    ),
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

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.arrow_right),
                                              Text(
                                                currentRegion,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Visibility(
                                                  visible:
                                                      saveEditButton == 'SAVE',
                                                  child: TextButton(
                                                      onHover: (value) {},
                                                      onPressed: () =>
                                                          showRegionDialog(),
                                                      child: const Text(
                                                        'change',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // DropdownMenu<String>(
                                        //   // initialSelection: list.first,
                                        //   trailingIcon: saveEditButton == 'SAVE'
                                        //       ? InkWell(
                                        //           child: const Icon(Icons.add),
                                        //           onTap: () {
                                        //             setState(() {
                                        //               print('add region');
                                        //             });
                                        //           },
                                        //         )
                                        //       : null,
                                        //   width: 200,
                                        //   hintText: 'CHOOSE REGION',
                                        //   textStyle: const TextStyle(
                                        //     fontSize: 12,
                                        //     color: Colors.black,
                                        //   ),
                                        //   onSelected: (String? value) {
                                        //     // This is called when the user selects an item.
                                        //     setState(() {
                                        //       dropdownValueRegion = value!;
                                        //     });
                                        //   },
                                        //   dropdownMenuEntries: listRegion
                                        //       .map<DropdownMenuEntry<String>>(
                                        //           (String value) {
                                        //     return DropdownMenuEntry<String>(
                                        //         value: value, label: value);
                                        //   }).toList(),
                                        // ),

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.arrow_right),
                                              Text(
                                                currentCusine,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Visibility(
                                                  visible:
                                                      saveEditButton == 'SAVE',
                                                  child: TextButton(
                                                      onHover: (value) {},
                                                      onPressed: () =>
                                                          showCuisineDialog(),
                                                      child: const Text(
                                                        'change',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )))
                                            ],
                                          ),
                                        ),
                                        // DropdownMenu<String>(
                                        //   // initialSelection: list.first,
                                        //   trailingIcon: saveEditButton == 'SAVE'
                                        //       ? InkWell(
                                        //           child: const Icon(Icons.add),
                                        //           onTap: () {
                                        //             setState(() {
                                        //               print('add cuisine');
                                        //             });
                                        //           },
                                        //         )
                                        //       : null,
                                        //   width: 200,
                                        //   hintText: 'CHOOSE CUISINE',
                                        //   textStyle: const TextStyle(
                                        //     fontSize: 12,
                                        //     color: Colors.black,
                                        //   ),
                                        //   onSelected: (String? value) {
                                        //     // This is called when the user selects an item.
                                        //     setState(() {
                                        //       dropdownValueCuisine = value!;
                                        //     });
                                        //   },
                                        //   dropdownMenuEntries: listCuisine
                                        //       .map<DropdownMenuEntry<String>>(
                                        //           (String value) {
                                        //     return DropdownMenuEntry<String>(
                                        //         value: value, label: value);
                                        //   }).toList(),
                                        // ),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.arrow_right),
                                              const Text(
                                                'NIL',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Visibility(
                                                  visible:
                                                      saveEditButton == 'SAVE',
                                                  child: TextButton(
                                                      onHover: (value) {},
                                                      onPressed: null,
                                                      child: const Text(
                                                        'change',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )))
                                            ],
                                          ),
                                        ),
                                        // DropdownMenu<String>(
                                        //   // initialSelection: list.first,
                                        //   trailingIcon: saveEditButton == 'SAVE'
                                        //       ? InkWell(
                                        //           child: const Icon(Icons.add),
                                        //           onTap: () {
                                        //             setState(() {
                                        //               print(
                                        //                   'add cuisine style');
                                        //             });
                                        //           },
                                        //         )
                                        //       : null,
                                        //   width: 200,
                                        //   hintText: 'NIL',
                                        //   textStyle: const TextStyle(
                                        //     fontSize: 12,
                                        //     color: Colors.black54,
                                        //   ),
                                        //   onSelected: (String? value) {
                                        //     // This is called when the user selects an item.
                                        //     setState(() {
                                        //       dropdownValuex = value!;
                                        //     });
                                        //   },
                                        //   dropdownMenuEntries: list
                                        //       .map<DropdownMenuEntry<String>>(
                                        //           (String value) {
                                        //     return DropdownMenuEntry<String>(
                                        //         value: value, label: value);
                                        //   }).toList(),
                                        // ),
                                        const SizedBox(
                                          height: 30,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                    const Text('Set default?'),
                                    AbsorbPointer(
                                      absorbing: isAbsorb,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: isSetDefaultWall,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (isSetDefaultWall == true) {
                                              isSetDefaultWall = false;
                                            } else {
                                              isSetDefaultWall = true;
                                            }
                                            print(value);
                                            print(isSetDefaultWall);
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 100,
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(
                                    //   width: 20,
                                    // ),
                                    // Visibility(
                                    //   visible: saveEditButton == 'SAVE',
                                    //   child: Column(
                                    //     children: [
                                    //       Container(
                                    //         width: 260,
                                    //         height: 40,
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10.0),
                                    //           color: const Color(0xffef7700),
                                    //         ),
                                    //         child: Container(
                                    //           child: TextButton(
                                    //             onPressed: () {},
                                    //             child: const Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.center,
                                    //               crossAxisAlignment:
                                    //                   CrossAxisAlignment.center,
                                    //               children: [
                                    //                 Padding(
                                    //                   padding:
                                    //                       EdgeInsets.fromLTRB(
                                    //                           5, 0, 5, 0),
                                    //                   child: Icon(
                                    //                     Icons.save,
                                    //                     color: Colors.white,
                                    //                   ),
                                    //                 ),
                                    //                 Text(
                                    //                   'SAVE & SET DEFAULT',
                                    //                   style: TextStyle(
                                    //                     fontFamily: 'SFPro',
                                    //                     fontSize: 18,
                                    //                     color: Colors.white,
                                    //                     fontWeight:
                                    //                         FontWeight.w500,
                                    //                   ),
                                    //                   textAlign:
                                    //                       TextAlign.center,
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
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
      ),
    );
  }

  void saveRegion(
    String name,
  ) async {
    await regionCollection.add({
      'id': 'dlr005',
      'name': name,
      'outletId': outletId,
      'status': true,
      'defaultCuisineStyleId': '',
    });
  }

  void deleteRegion(String id) async {
    await regionCollection
        .where('id', isEqualTo: id)
        .get()
        .then((QuerySnapshot value) {
      for (var item in value.docs) {
        print(item.id);
        cusineCollection.doc(item.id).delete();
      }
    });
  }

  void saveCuisine(
    String name,
  ) async {
    await cusineCollection.add({
      'id': 'dlc006',
      'name': name,
      'regionId': currentRegionId,
      'status': true,
      // 'defaultCuisineStyleId': '',
    });
  }

  void deleCuisine(String id) async {
    await cusineCollection
        .where('id', isEqualTo: id)
        .get()
        .then((QuerySnapshot value) {
      for (var item in value.docs) {
        print(item.id);
        cusineCollection.doc(item.id).delete();
      }
    });
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

  showRegionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            TextEditingController txtaddRegion = TextEditingController();

            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: const Text(
                'Region',
                textAlign: TextAlign.center,
              ),
              children: [
                // SizedBox(
                //   height: 100,
                //   width: 300,
                //   child: IconButton(
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //       icon: const Icon(Icons.exit_to_app)),
                // ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          strSearchRegion = value;
                        });
                      },
                      controller: txtSearchRegion,
                      decoration: const InputDecoration(hintText: 'Search'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 400,
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: regionCollection
                        .where('outletId', isEqualTo: outletId)
                        // .where('outletId',
                        //     arrayContains: txtSearchRegion.text != ''
                        //         ? outletId
                        //         : txtSearchRegion.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        documentsx = snapshot.data!.docs;
                        print(strSearchRegion);
                        if (strSearchRegion.isNotEmpty) {
                          documentsx = documentsx.where((element) {
                            return element
                                .get('name')
                                .toString()
                                .toLowerCase()
                                .contains(strSearchRegion.toLowerCase());
                          }).toList();
                        }

                        return ListView.builder(
                          itemCount: documentsx.length,
                          itemBuilder: (context, index) {
                            // var doc = snapshot.data!.docs;
                            print(strSearchRegion);
                            // doc.contains(strSearchRegion);
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ListTile(
                                // leading: Image.asset(
                                //   'assets/chat.png',
                                //   color: Colors.redAccent[700],
                                //   height: 24,
                                // ),
                                trailing: Tooltip(
                                  message: 'delete',
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          deleteRegion(documentsx[index]['id']);
                                          print('delete region');
                                        });
                                      },
                                      icon: const Icon(Icons.delete)),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          documentsx[index]['name'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    currentRegionId = '';
                                    currentRegionId = documentsx[index]['id'];
                                    currentRegion = documentsx[index]['name'];
                                    currentCusine = 'Choose Cuisine';
                                    currentCusineId = '';

                                    // isEditRegion = true;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No data"));
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextField(
                      controller: txtaddRegion,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter region here...',
                          suffixIcon: Tooltip(
                            message: 'save',
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (txtaddRegion.text.isEmpty) return;
                                  saveRegion(txtaddRegion.text);
                                });
                              },
                              icon: const Icon(
                                Icons.save,
                                color: Color(0xffbef7700),
                              ),
                            ),
                          )),
                    ),
                  ),
                )
                // Row(
                //   children: [
                //     SizedBox(width: 100, child: const TextField()),
                //     Container(
                //       decoration: const BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(20)),
                //         color: Color(0xffbef7700),
                //       ),
                //       child: const TextButton(
                //           onPressed: null,
                //           child: Padding(
                //             padding: EdgeInsets.all(8.0),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Icon(
                //                   Icons.save,
                //                   color: Colors.white,
                //                 ),
                //                 SizedBox(
                //                   width: 10,
                //                 ),
                //                 Text(
                //                   'ADD',
                //                   style: TextStyle(color: Colors.white),
                //                 ),
                //               ],
                //             ),
                //           )),
                //     ),
                //   ],
                // )
              ],
            );
          },
        );
      },
    );
  }

  showCuisineDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            TextEditingController txtAddCuisine = TextEditingController();

            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: const Text(
                'Cuisine',
                textAlign: TextAlign.center,
              ),
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          strSearchCusine = value;
                        });
                      },
                      controller: txtSearchCusine,
                      decoration: const InputDecoration(hintText: 'Search'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 400,
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: cusineCollection
                        .where('regionId', isEqualTo: currentRegionId)
                        // .where('outletId',
                        //     arrayContains: txtSearchRegion.text != ''
                        //         ? outletId
                        //         : txtSearchRegion.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        documentsx = snapshot.data!.docs;
                        print(strSearchCusine);
                        if (strSearchCusine.isNotEmpty) {
                          documentsx = documentsx.where((element) {
                            return element
                                .get('name')
                                .toString()
                                .toLowerCase()
                                .contains(strSearchCusine.toLowerCase());
                          }).toList();
                        }

                        return ListView.builder(
                          itemCount: documentsx.length,
                          itemBuilder: (context, index) {
                            // var doc = snapshot.data!.docs;
                            print(strSearchCusine);
                            // doc.contains(strSearchRegion);
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ListTile(
                                // leading: Image.asset(
                                //   'assets/chat.png',
                                //   color: Colors.redAccent[700],
                                //   height: 24,
                                // ),
                                trailing: Tooltip(
                                  message: 'delete',
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          print(documentsx[index]['id']);
                                          deleCuisine(documentsx[index]['id']);
                                        });
                                      },
                                      icon: const Icon(Icons.delete)),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          documentsx[index]['name'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    currentCusineId = documentsx[index]['id'];
                                    currentCusine = documentsx[index]['name'];

                                    // isEditRegion = true;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No data"));
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextField(
                      controller: txtAddCuisine,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter cuisine here...',
                          suffixIcon: Tooltip(
                            message: 'save',
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (txtAddCuisine.text.isEmpty) return;
                                  saveCuisine(txtAddCuisine.text);
                                });
                              },
                              icon: const Icon(
                                Icons.save,
                                color: Color(0xffbef7700),
                              ),
                            ),
                          )),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
