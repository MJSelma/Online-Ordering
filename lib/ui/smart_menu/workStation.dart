import 'dart:convert';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/button.dart';
import '../../widgets/show_dialog.dart';
import '../constant/theme_data.dart';

class WorkStation extends StatefulWidget {
  const WorkStation({super.key});

  @override
  State<WorkStation> createState() => _WorkStationState();
}

class _WorkStationState extends State<WorkStation> {
  bool isPaid = true;
  int orderingMenu = 0;
  int stationMenu = 0;
  bool showOrderingMenu = true;
  bool showStationMenu = true;
  bool isActiveWst = false;
  bool isPayOrder = false;
  bool isOrderOnly = false;
  bool isSelfCollection = false;
  bool isOrderAndPay = false;
  bool isServeCollection = false;
  TextEditingController prepTime = TextEditingController(text: '');
  TextEditingController stationController = TextEditingController(text: '');
  TextEditingController collectionInstruction = TextEditingController(text: '');
  String strcollectionInstruction = '';
  //Serve
  PlatformFile? uploadimage; //variable for choosed file
  String fileName = '';
  String fileType = '';
  FilePickerResult? results;
  TextEditingController menuName = TextEditingController();

  TextEditingController menuNameUpdate = TextEditingController();
  String menuUpdateUrl = '';
  bool showGraph = false;
  int stationMulMenu = 3;
  List<String> stations = [];

  init() {
    // showOrderingMenu = true;
    showStationMenu = true;
    isActiveWst = false;
    isPayOrder = false;
    isOrderOnly = false;
    isOrderAndPay = false;
    isSelfCollection = false;
    isServeCollection = false;
    stations = [];
    collectionInstruction.clear();
    strcollectionInstruction = '';
    prepTime.clear();
    stationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'Smart Menu > Work Station',
            //     style: TextStyle(
            //         fontWeight: FontWeight.w400,
            //         fontFamily: 'SFPro',
            //         fontSize: 20),
            //   ),
            // ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 2,
                  color: Colors.grey.shade500,
                  height: MediaQuery.of(context).size.height - 150,
                ),
                Visibility(
                  visible: !showOrderingMenu,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showOrderingMenu = true;
                            });
                          },
                          child: Image.asset(
                              'assets/images/single-right-arrow.png',
                              height: 20,
                              color: Colors.grey.shade500))),
                ),
                Visibility(
                  visible: showOrderingMenu,
                  child: SizedBox(
                    width: 260,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const SizedBox(
                          //   height: 24,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'CHOOSE ONE',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: defaultFontFamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showOrderingMenu = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/images/single-left-arrow.png',
                                      height: 20,
                                      color: Colors.grey.shade500))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        orderingMenu = 1;
                                      });
                                    },
                                    child: ButtonMenu(
                                      text: 'SELF ORDERING MENU',
                                      width: 200,
                                      height: 30,
                                      backColor: orderingMenu == 1
                                          ? [
                                              btnColorOrangeLight,
                                              btnColorOrangeDark
                                            ]
                                          : [
                                              btnColorBlueLight,
                                              btnColorBlueDark
                                            ],
                                      textColor: orderingMenu == 1
                                          ? btnColorPurpleDark
                                          : iconButtonTextColor,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showGraph = true;
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/images/question.png',
                                    color: Colors.grey.shade500,
                                    height: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Row(
                          //   children: [
                          //     GestureDetector(
                          //         onTap: () {
                          //           setState(() {
                          //             orderingMenu = 1;
                          //           });
                          //         },
                          //         child: ButtonMenu(
                          //           text: 'Self Ordering Menu',
                          //           width: 200,
                          //           height: 30,
                          //           backColor: orderingMenu == 1
                          //               ? [
                          //                   btnColorOrang       btnColorOrangeDark
                          //            eLight,
                          //                 ]
                          //               : [btnColorBlueLight, btnColorBlueDark],
                          //           textColor: iconButtonTextColor,
                          //         )),
                          //     const IconButton(
                          //         onPressed: null,
                          //         icon: Icon(Icons.question_mark_outlined))
                          //   ],
                          // ),
                          // child: myButton1('Self Ordering Menu', 1,
                          //     Icons.payment, 50, 12, false)),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Your Dguest will be able to order and/or pay from their smarthphones. Ideal fro clubs, Caffeteria, or small business',
                              style: TextStyle(
                                  fontSize: defaulDescriptiontFontSize,
                                  fontFamily: defaultFontFamily,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        orderingMenu = 2;
                                      });
                                    },
                                    child: ButtonMenu(
                                      text: 'SERVED ORDERING MENU',
                                      width: 200,
                                      height: 30,
                                      backColor: orderingMenu == 2
                                          ? [
                                              btnColorOrangeLight,
                                              btnColorOrangeDark
                                            ]
                                          : [
                                              btnColorBlueLight,
                                              btnColorBlueDark
                                            ],
                                      textColor: orderingMenu == 2
                                          ? btnColorPurpleDark
                                          : iconButtonTextColor,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/images/question.png',
                                  color: Colors.grey.shade500,
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                          // child: myButton1('Serve Ordering Menu', 2,
                          //     Icons.payment, 50, 12, false)),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Your waiters will be able to place order from their smarthphones',
                              style: TextStyle(
                                  fontSize: defaulDescriptiontFontSize,
                                  fontFamily: defaultFontFamily,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.grey.shade500,
                  height: MediaQuery.of(context).size.height - 150,
                ),
                Visibility(
                    visible: !showStationMenu,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showStationMenu = true;
                              });
                            },
                            child: Image.asset(
                                'assets/images/single-right-arrow.png',
                                height: 20,
                                color: Colors.grey.shade500)))),
                Visibility(
                  visible: orderingMenu == 1,
                  child: Visibility(
                    visible: showStationMenu,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          height: MediaQuery.sizeOf(context).height < 800
                              ? 550
                              : MediaQuery.sizeOf(context).height,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // const SizedBox(
                                  //   height: 24,
                                  // ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Text(
                                          'CHOOSE ONE',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: defaultFontFamily),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showStationMenu = false;
                                            });
                                          },
                                          child: Image.asset(
                                              'assets/images/single-left-arrow.png',
                                              height: 20,
                                              color: Colors.grey.shade500))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          stationMenu = 1;
                                          init();
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'ONE WST REQUIRED',
                                        width: 200,
                                        height: 30,
                                        backColor: stationMenu == 1
                                            ? [
                                                btnColorOrangeLight,
                                                btnColorOrangeDark
                                              ]
                                            : [
                                                btnColorBlueLight,
                                                btnColorBlueDark
                                              ],
                                        textColor: stationMenu == 1
                                            ? btnColorPurpleDark
                                            : iconButtonTextColor,
                                      )),
                                  // child: stationButton('One Station Required',
                                  //     1, Icons.payment, 50, 12, false)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Your Dguest will be able to order and/or pay from their smarthphones. Ideal fro clubs, Caffeteria, or small business',
                                      style: TextStyle(
                                          fontSize: defaulDescriptiontFontSize,
                                          fontFamily: defaultFontFamily,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          stationMenu = 2;
                                          init();
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'MULTIPLE WST REQUIRED',
                                        width: 200,
                                        height: 30,
                                        backColor: stationMenu == 2
                                            ? [
                                                btnColorOrangeLight,
                                                btnColorOrangeDark
                                              ]
                                            : [
                                                btnColorBlueLight,
                                                btnColorBlueDark
                                              ],
                                        textColor: stationMenu == 2
                                            ? btnColorPurpleDark
                                            : iconButtonTextColor,
                                      )),
                                  // child: stationButton(
                                  //     'Multiple Working Station',
                                  //     2,
                                  //     Icons.payment,
                                  //     50,
                                  //     12,
                                  //     false)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Your waiters will be able to place order from their smarthphones',
                                      style: TextStyle(
                                          fontSize: defaulDescriptiontFontSize,
                                          fontFamily: defaultFontFamily,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),

                                  //Multiple working
                                  const Divider(),
                                  Visibility(
                                      visible: stationMenu == 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showGraph = true;
                                                  });
                                                },
                                                child: Image.asset(
                                                  'assets/images/question.png',
                                                  color: Colors.grey.shade500,
                                                  height: 25,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      stationMulMenu = 1;
                                                      init();
                                                    });
                                                  },
                                                  child: ButtonMenu(
                                                    text: 'MASTER WST SETUP',
                                                    width: 200,
                                                    height: 30,
                                                    backColor:
                                                        stationMulMenu == 1
                                                            ? [
                                                                btnColorOrangeLight,
                                                                btnColorOrangeDark
                                                              ]
                                                            : [
                                                                btnColorBlueLight,
                                                                btnColorBlueDark
                                                              ],
                                                    textColor: stationMulMenu ==
                                                            1
                                                        ? btnColorPurpleDark
                                                        : iconButtonTextColor,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          // child: stationMultipleButton(
                                          //     'Create Master Station',
                                          //     1,
                                          //     Icons.payment,
                                          //     50,
                                          //     12,
                                          //     false)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Having a Master Station will let your DGUESTS to order different menu categories Ex. Food & Drinks, which will be handled by different Working Stations. Ideal for Food-Courts, Restaurants, Bars, Caffetterias, Beach Clubs',
                                              style: TextStyle(
                                                  fontSize:
                                                      defaulDescriptiontFontSize,
                                                  fontFamily: defaultFontFamily,
                                                  fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showGraph = true;
                                                  });
                                                },
                                                child: Image.asset(
                                                  'assets/images/question.png',
                                                  color: Colors.grey.shade500,
                                                  height: 25,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      stationMulMenu = 2;
                                                      init();
                                                    });
                                                  },
                                                  child: ButtonMenu(
                                                    text: 'SINGLE WSTs SETUP',
                                                    width: 200,
                                                    height: 30,
                                                    backColor:
                                                        stationMulMenu == 2
                                                            ? [
                                                                btnColorOrangeLight,
                                                                btnColorOrangeDark
                                                              ]
                                                            : [
                                                                btnColorBlueLight,
                                                                btnColorBlueDark
                                                              ],
                                                    textColor: stationMulMenu ==
                                                            2
                                                        ? btnColorPurpleDark
                                                        : iconButtonTextColor,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          // child: stationMultipleButton(
                                          //     'Create Single Station',
                                          //     2,
                                          //     Icons.payment,
                                          //     50,
                                          //     12,
                                          //     false)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Your Dguests will be able to choose and select which station will prepare their orders. Ideal for Bar, Pubs, Caffeterias, Clubs',
                                              style: TextStyle(
                                                  fontSize:
                                                      defaulDescriptiontFontSize,
                                                  fontFamily: defaultFontFamily,
                                                  fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ))
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: orderingMenu == 2,
                    child: Container(
                      child: serveWidget(),
                    )),
                Visibility(
                  visible: orderingMenu == 1 || orderingMenu == 2,
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade500,
                    height: MediaQuery.of(context).size.height - 150,
                  ),
                ),
                if (orderingMenu == 1) ...[
                  if (stationMenu == 1) ...[
                    widgetOneStation()
                  ] else ...[
                    if (stationMulMenu == 1 || stationMulMenu == 2) ...[
                      widgetMultipleStation()
                    ]
                  ]
                ] else ...[
                  Visibility(visible: orderingMenu == 2, child: itemServeMenu())
                ]
              ],
            ),
          ],
        ),
        Visibility(
          visible: showGraph,
          child: Container(
            color: Colors.grey.withOpacity(.8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 300,
              height: MediaQuery.of(context).size.height - 100,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  width: 400,
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showGraph = false;
                                      });
                                    },
                                    child: const Icon(Icons.close_rounded))
                              ],
                            ),
                          ),
                          SizedBox(
                              width: 400,
                              child: SizedBox(
                                width: 380,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/graph1.jpeg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isPaid,
          child: Container(
            color: Colors.grey.withOpacity(.8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 300,
              height: MediaQuery.of(context).size.height - 100,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 3,
                        strokeAlign: 1,
                        color: systemDefaultColorOrange),
                    color: Colors.white,
                  ),
                  width: 400,
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'To use this feature you must pay \nthe premium account',
                            style: TextStyle(
                                fontSize: 20, fontFamily: defaultFontFamily),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPaid = false;
                                  });
                                },
                                child: ButtonMenu(
                                  text: 'PAY NOW',
                                  width: 200,
                                  height: 35,
                                  backColor: [
                                    btnColorOrangeLight,
                                    btnColorOrangeDark
                                  ],
                                  textColor: iconButtonTextColor,
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget stationMultipleButton(String text, int val, IconData iconMenu,
      double height, double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: stationMulMenu == val
              ? const Color(0xffef7700)
              : Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: showIcon,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                child: Icon(
                  iconMenu,
                  color: stationMenu == val
                      ? Colors.white
                      : const Color.fromARGB(255, 66, 64, 64),
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 18,
                color: stationMulMenu == val
                    ? Colors.white
                    : const Color.fromARGB(255, 66, 64, 64),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget stationButton(String text, int val, IconData iconMenu, double height,
      double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: stationMenu == val
              ? const Color(0xffef7700)
              : Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: showIcon,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                child: Icon(
                  iconMenu,
                  color: stationMenu == val
                      ? Colors.white
                      : const Color.fromARGB(255, 66, 64, 64),
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 18,
                color: stationMenu == val
                    ? Colors.white
                    : const Color.fromARGB(255, 66, 64, 64),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Widget myButton1(String text, int val, IconData iconMenu, double height,
  //     double paddingLeft, bool showIcon) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
  //     child: Container(
  //       width: 200,
  //       height: height,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         color: orderingMenu == val
  //             ? const Color(0xffef7700)
  //             : Colors.grey.shade200,
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Visibility(
  //             visible: showIcon,
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
  //               child: Icon(
  //                 iconMenu,
  //                 color: orderingMenu == val
  //                     ? Colors.white
  //                     : const Color.fromARGB(255, 66, 64, 64),
  //               ),
  //             ),
  //           ),
  //           Text(
  //             text,
  //             style: TextStyle(
  //               fontFamily: 'SFPro',
  //               fontSize: 18,
  //               color: orderingMenu == val
  //                   ? Colors.white
  //                   : const Color.fromARGB(255, 66, 64, 64),
  //               fontWeight: FontWeight.w500,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget myButton(String text, int val, IconData iconMenu, double height,
      double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xffef7700),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: showIcon,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                child: Icon(iconMenu, color: Colors.white),
              ),
            ),
            Text(
              text,
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
    );
  }

  Widget widgetOneStation() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height < 800
            ? 550
            : MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: showStationMenu == false && showOrderingMenu == true
                    ? 800
                    : showOrderingMenu == false && showStationMenu == false
                        ? 1000
                        : 600,
                child: Row(
                  children: [
                    Text(
                      'Your Dguests will be able to order and/or pay from their smartphones. \nIdeal for Clubs, Caffeteria or small Businesses',
                      style: TextStyle(
                          fontSize: defaulDescriptiontFontSize,
                          fontFamily: defaultFontFamily,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showGraph = true;
                        });
                      },
                      child: SizedBox(
                          width: showStationMenu == false &&
                                      showOrderingMenu == true ||
                                  showStationMenu == true &&
                                      showOrderingMenu == false
                              ? 120
                              : showOrderingMenu == false &&
                                      showStationMenu == false
                                  ? 150
                                  : 100,
                          child: Image.asset(
                            'assets/images/graph1.jpeg',
                            fit: BoxFit.fitWidth,
                          )),
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/step1.png',
                        height: 25,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isActiveWst = !isActiveWst;
                          });
                        },
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: const Border.fromBorderSide(BorderSide(
                                strokeAlign: 1,
                                color: Colors.white,
                              )),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: isActiveWst
                                      ? [
                                          btnColorOrangeLight,
                                          btnColorOrangeDark
                                        ]
                                      : [btnColorGreyLight, btnColorGreyDark]),
                              boxShadow: [
                                BoxShadow(
                                  color: btnColorGreyDark2,
                                  // blurStyle: BlurStyle.normal,
                                  offset: const Offset(
                                    1.0,
                                    3.0,
                                  ),
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                ),
                              ]
                              // color: isActiveWst
                              //     ? const Color(0xffef7700)
                              //     : Colors.grey.shade500,
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                !isActiveWst ? 'ACTIVATE WST' : 'WST ACTIVATED',
                                style: TextStyle(
                                  fontFamily: defaultFontFamily,
                                  // fontSize: 18,
                                  color: !isActiveWst
                                      ? iconButtonTextColor
                                      : btnColorPurpleDark,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/step2.png',
                              height: 25,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'ENTER AVERAGE PREPARATION TIME(mins)',
                              style: TextStyle(
                                fontSize: defaulDescriptiontFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0,
                              // color: const Color(0xff707070)
                              color: systemDefaultColorOrange),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: prepTime,
                              decoration: const InputDecoration.collapsed(
                                  hintText: '5'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'SERVICE OPTIONS (CHOOSE ONE OR MORE)',
                  style: TextStyle(
                      fontSize: defaulDescriptiontFontSize,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: showStationMenu == false && showOrderingMenu == true
                        ? 850
                        : showOrderingMenu == false && showStationMenu == false
                            ? 1000
                            : 650,
                    color: Colors.grey.shade500,
                    height: 1),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/step3.png',
                        height: 25,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Your Dguests will collect the order from \n dedicated collection points',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: defaultFontFamily,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelfCollection = !isSelfCollection;
                                      });
                                    },
                                    child: ButtonMenu(
                                      text: 'SELF COLLECTION',
                                      width: 200,
                                      height: 35,
                                      backColor: isSelfCollection
                                          ? [
                                              btnColorOrangeLight,
                                              btnColorOrangeDark
                                            ]
                                          : [
                                              btnColorBlueLight,
                                              btnColorBlueDark
                                            ],
                                      textColor: isSelfCollection
                                          ? btnColorPurpleDark
                                          : iconButtonTextColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Visibility(
                                    visible: isSelfCollection,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isOrderAndPay = !isOrderAndPay;
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'ORDER AND PAY',
                                        width: 200,
                                        height: 35,
                                        backColor: isOrderAndPay
                                            ? [
                                                btnColorOrangeLight,
                                                btnColorOrangeDark
                                              ]
                                            : [
                                                btnColorBlueLight,
                                                btnColorBlueDark
                                              ],
                                        textColor: isOrderAndPay
                                            ? btnColorPurpleDark
                                            : iconButtonTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //ADD here
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: isSelfCollection || isServeCollection ? 10 : 150,
                  ),
                  Visibility(
                    visible: isSelfCollection || isServeCollection,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'COLLECTION INSTRUCTION',
                              style: TextStyle(
                                  fontSize: defaulDescriptiontFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 200,
                              width: showStationMenu == false &&
                                          showOrderingMenu == true ||
                                      showStationMenu == true &&
                                          showOrderingMenu == false
                                  ? 400
                                  : showOrderingMenu == false &&
                                          showStationMenu == false
                                      ? 600
                                      : 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffef7700))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: collectionInstruction,
                                  expands: true,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 11,
                                          fontFamily: defaultFontFamily,
                                          fontStyle: FontStyle.italic),
                                      border: InputBorder.none,
                                      hintText:
                                          'Example: Please proceed to Drinklink Cube situated next to the cashier'),
                                  onChanged: (value) {
                                    setState(() {
                                      strcollectionInstruction =
                                          collectionInstruction.text;
                                    });
                                  },
                                ),
                                // child: Text(
                                //   'Example: Please proceed to Drinklink Cube situated next to the cashier',
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 1,
                              color: Colors.grey.shade500,
                              // height: MediaQuery.sizeOf(context).height),
                              height: 250),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       width: 1,
                  //       color: Colors.grey.shade500,
                  //       height: MediaQuery.sizeOf(context).height),
                  // ),
                  Column(
                    children: [
                      Visibility(
                        // visible: isSelfCollection,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/step4.png',
                              height: 25,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Your Dguests will served by your waiters to their tables',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: defaultFontFamily,
                                            fontStyle: FontStyle.italic),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isServeCollection =
                                              !isServeCollection;
                                          if (isServeCollection == false) {
                                            isPayOrder = false;
                                            isOrderOnly = false;
                                          }
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'SERVED',
                                        width: 200,
                                        height: 35,
                                        backColor: isServeCollection
                                            ? [
                                                btnColorOrangeLight,
                                                btnColorOrangeDark
                                              ]
                                            : [
                                                btnColorBlueLight,
                                                btnColorBlueDark
                                              ],
                                        textColor: isServeCollection
                                            ? btnColorPurpleDark
                                            : iconButtonTextColor,
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     setState(() {
                                    //       isServeCollection = !isServeCollection;
                                    //     });
                                    //   },
                                    //   child: Container(
                                    //     width: 200,
                                    //     height: 50,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(10.0),
                                    //       color: isServeCollection
                                    //           ? const Color(0xffef7700)
                                    //           : Colors.grey.shade500,
                                    //     ),
                                    //     child: const Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.center,
                                    //       children: [
                                    //         Text(
                                    //           'Serve',
                                    //           style: TextStyle(
                                    //             fontFamily: 'SFPro',
                                    //             fontSize: 18,
                                    //             color: Colors.white,
                                    //             fontWeight: FontWeight.w500,
                                    //           ),
                                    //           textAlign: TextAlign.center,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Visibility(
                                      visible: isServeCollection,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'CHOOSE ONE',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      defaultFontFamily),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isPayOrder == false) {
                                                  isPayOrder = true;
                                                  isOrderOnly = false;
                                                }
                                              });
                                            },
                                            child: ButtonMenu(
                                              text: 'ORDER AND PAY',
                                              width: 200,
                                              height: 35,
                                              backColor: isPayOrder
                                                  ? [
                                                      btnColorOrangeLight,
                                                      btnColorOrangeDark
                                                    ]
                                                  : [
                                                      btnColorBlueLight,
                                                      btnColorBlueDark
                                                    ],
                                              textColor: isPayOrder
                                                  ? btnColorPurpleDark
                                                  : iconButtonTextColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isOrderOnly == false) {
                                                  isOrderOnly = true;
                                                  isPayOrder = false;
                                                }
                                              });
                                            },
                                            child: ButtonMenu(
                                              text: 'ORDER ONLY',
                                              width: 200,
                                              height: 35,
                                              backColor: isOrderOnly
                                                  ? [
                                                      btnColorOrangeLight,
                                                      btnColorOrangeDark
                                                    ]
                                                  : [
                                                      btnColorBlueLight,
                                                      btnColorBlueDark
                                                    ],
                                              textColor: isOrderOnly
                                                  ? btnColorPurpleDark
                                                  : iconButtonTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isActiveWst == true &&
                                            prepTime.text != '' &&
                                            isOrderAndPay == true) {
                                          context
                                              .read<MenuProvider>()
                                              .updateMenuCount(1);
                                        }
                                      });
                                    },
                                    child: ButtonMenu(
                                      text: 'SET UP WTPs',
                                      width: 200,
                                      height: 35,
                                      backColor: isActiveWst == true &&
                                              prepTime.text != '' &&
                                              strcollectionInstruction != '' &&
                                              isOrderAndPay == true
                                          ? [
                                              btnColorGreenLight,
                                              btnColorGreenDark
                                            ]
                                          : [
                                              btnColorGreyLight,
                                              btnColorGreyDark
                                            ],
                                      textColor: iconButtonTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetMultipleStation() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height < 850
            ? 550
            : MediaQuery.sizeOf(context).height - 230,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: showStationMenu == false && showOrderingMenu == true
                      ? 800
                      : showOrderingMenu == false && showStationMenu == false
                          ? 1000
                          : 600,
                  child: Row(
                    children: [
                      Text(
                        'Your Dguests will be able to order and/or pay from their smartphones. \nIdeal for Clubs, Caffeteria or small Businesses',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: defaultFontFamily,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showGraph = true;
                          });
                        },
                        child: SizedBox(
                            width: 100,
                            child: Image.asset(
                              'assets/images/graph1.jpeg',
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: stationMulMenu == 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/step1.png',
                            height: 25,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isActiveWst = !isActiveWst;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border:
                                      const Border.fromBorderSide(BorderSide(
                                    strokeAlign: 1,
                                    color: Colors.white,
                                  )),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: isActiveWst
                                          ? [
                                              btnColorOrangeLight,
                                              btnColorOrangeDark
                                            ]
                                          : [
                                              btnColorGreyLight,
                                              btnColorGreyDark
                                            ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: btnColorGreyDark2,
                                      // blurStyle: BlurStyle.normal,
                                      offset: const Offset(
                                        1.0,
                                        3.0,
                                      ),
                                      blurRadius: 3.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ]
                                  // color: isActiveWst
                                  //     ? const Color(0xffef7700)
                                  //     : Colors.grey.shade500,
                                  ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    !isActiveWst
                                        ? 'ACTIVATE WST'
                                        : 'WST ACTIVATED',
                                    style: TextStyle(
                                      fontFamily: defaultFontFamily,
                                      // fontSize: 18,
                                      color: !isActiveWst
                                          ? iconButtonTextColor
                                          : btnColorPurpleDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 150,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/step2.png',
                                  height: 25,
                                  color: Colors.grey.shade500,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'ENTER AVERAGE PREPARATION TIME(mins)',
                                  style: TextStyle(
                                    fontSize: defaulDescriptiontFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xffffffff),
                              border: Border.all(
                                  width: 1.0, color: systemDefaultColorOrange),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: prepTime,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: '5'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            stationMulMenu == 1
                                ? 'CREATE SUB STATION'
                                : 'CREATE STATION',
                            style: TextStyle(
                              fontSize: defaulDescriptiontFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: systemDefaultColorOrange),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: stationController,
                                decoration: InputDecoration.collapsed(
                                    hintStyle: TextStyle(
                                        fontSize: 11,
                                        fontFamily: defaultFontFamily,
                                        fontStyle: FontStyle.italic),
                                    border: InputBorder.none,
                                    hintText: 'Station Name'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'EX. Kitchen, Bar, Lounge',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: defaultFontFamily,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 150,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          stationMulMenu == 1
                              ? 'assets/images/step3.png'
                              : 'assets/images/step1.png',
                          height: 25,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (stationController.text == '') {
                                warningDialog(context, 'CREATE SUB STATION',
                                    'Please enter station name');
                                return;
                              }

                              stations.add(stationController.text);
                              context
                                  .read<MenuProvider>()
                                  .setWorkStation(stations);
                              stationController.text = '';
                            });
                          },
                          child: ButtonMenu(
                            text: 'ADD',
                            width: 200,
                            height: 35,
                            backColor: [
                              btnColorOrangeLight,
                              btnColorOrangeDark
                            ],
                            textColor: iconButtonTextColor,
                          ),
                        ),
                      ],
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       stations.add(stationController.text);
                    //       context.read<MenuProvider>().setWorkStation(stations);
                    //       stationController.text = '';
                    //     });
                    //   },
                    //   child: Container(
                    //     width: 100,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       color: const Color(0xffef7700),
                    //     ),
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           'ADD',
                    //           style: TextStyle(
                    //             fontFamily: 'SFPro',
                    //             fontSize: 18,
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                const SizedBox(
                  width: 20,
                ),
                //List of station
                Visibility(
                    visible: stations.isNotEmpty, child: ListOfStation(300)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'SERVICE OPTIONS (CHOOSE ONE OR MORE)',
                    style: TextStyle(
                        fontSize: defaulDescriptiontFontSize,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width:
                          showStationMenu == false && showOrderingMenu == true
                              ? 850
                              : showOrderingMenu == false &&
                                      showStationMenu == false
                                  ? 1000
                                  : 650,
                      color: Colors.grey.shade500,
                      height: 1),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          stationMulMenu == 2
                              ? 'assets/images/step2.png'
                              : 'assets/images/step4.png',
                          height: 25,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Your Dguests will collect the order from \n dedicated collection points',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: defaultFontFamily,
                                            fontStyle: FontStyle.italic),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSelfCollection = !isSelfCollection;
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'SELF COLLECTION',
                                        width: 200,
                                        height: 35,
                                        backColor: isSelfCollection
                                            ? [
                                                btnColorOrangeLight,
                                                btnColorOrangeDark
                                              ]
                                            : [
                                                btnColorBlueLight,
                                                btnColorBlueDark
                                              ],
                                        textColor: isSelfCollection
                                            ? btnColorPurpleDark
                                            : iconButtonTextColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Visibility(
                                      visible: isSelfCollection,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOrderAndPay = !isOrderAndPay;
                                          });
                                        },
                                        child: ButtonMenu(
                                          text: 'ORDER AND PAY',
                                          width: 200,
                                          height: 35,
                                          backColor: isOrderAndPay
                                              ? [
                                                  btnColorOrangeLight,
                                                  btnColorOrangeDark
                                                ]
                                              : [
                                                  btnColorBlueLight,
                                                  btnColorBlueDark
                                                ],
                                          textColor: isOrderAndPay
                                              ? btnColorPurpleDark
                                              : iconButtonTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //ADD here
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: isSelfCollection || isServeCollection ? 10 : 150,
                    ),
                    Visibility(
                      visible: isSelfCollection || isServeCollection,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'COLLECTION INSTRUCTION',
                                style: TextStyle(
                                    fontSize: defaulDescriptiontFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 200,
                                width: showStationMenu == false &&
                                            showOrderingMenu == true ||
                                        showStationMenu == true &&
                                            showOrderingMenu == false
                                    ? 400
                                    : showOrderingMenu == false &&
                                            showStationMenu == false
                                        ? 600
                                        : 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color(0xffef7700))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: collectionInstruction,
                                    expands: true,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 11,
                                            fontFamily: defaultFontFamily,
                                            fontStyle: FontStyle.italic),
                                        border: InputBorder.none,
                                        hintText:
                                            'Example: Please proceed to Drinklink Cube situated next to the cashier'),
                                    onChanged: (value) {
                                      setState(() {
                                        strcollectionInstruction =
                                            collectionInstruction.text;
                                      });
                                    },
                                  ),
                                  // child: Text(
                                  //   'Example: Please proceed to Drinklink Cube situated next to the cashier',
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 1,
                                color: Colors.grey.shade500,
                                // height: MediaQuery.sizeOf(context).height),
                                height: 250),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //       width: 1,
                    //       color: Colors.grey.shade500,
                    //       height: MediaQuery.sizeOf(context).height),
                    // ),
                    Column(
                      children: [
                        Visibility(
                          // visible: isSelfCollection,
                          child: Column(
                            children: [
                              Image.asset(
                                stationMulMenu == 2
                                    ? 'assets/images/step3.png'
                                    : 'assets/images/step5.png',
                                height: 25,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Your Dguests will served by your waiters to their tables',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: defaultFontFamily,
                                              fontStyle: FontStyle.italic),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isServeCollection =
                                                !isServeCollection;
                                            if (isServeCollection == false) {
                                              isPayOrder = false;
                                              isOrderOnly = false;
                                            }
                                          });
                                        },
                                        child: ButtonMenu(
                                          text: 'SERVED',
                                          width: 200,
                                          height: 35,
                                          backColor: isServeCollection
                                              ? [
                                                  btnColorOrangeLight,
                                                  btnColorOrangeDark
                                                ]
                                              : [
                                                  btnColorBlueLight,
                                                  btnColorBlueDark
                                                ],
                                          textColor: isServeCollection
                                              ? btnColorPurpleDark
                                              : iconButtonTextColor,
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     setState(() {
                                      //       isServeCollection = !isServeCollection;
                                      //     });
                                      //   },
                                      //   child: Container(
                                      //     width: 200,
                                      //     height: 50,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(10.0),
                                      //       color: isServeCollection
                                      //           ? const Color(0xffef7700)
                                      //           : Colors.grey.shade500,
                                      //     ),
                                      //     child: const Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.center,
                                      //       children: [
                                      //         Text(
                                      //           'Serve',
                                      //           style: TextStyle(
                                      //             fontFamily: 'SFPro',
                                      //             fontSize: 18,
                                      //             color: Colors.white,
                                      //             fontWeight: FontWeight.w500,
                                      //           ),
                                      //           textAlign: TextAlign.center,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                        visible: isServeCollection,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'CHOOSE ONE',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        defaultFontFamily),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (isPayOrder == false) {
                                                    isPayOrder = true;
                                                    isOrderOnly = false;
                                                  }
                                                });
                                              },
                                              child: ButtonMenu(
                                                text: 'ORDER AND PAY',
                                                width: 200,
                                                height: 35,
                                                backColor: isPayOrder
                                                    ? [
                                                        btnColorOrangeLight,
                                                        btnColorOrangeDark
                                                      ]
                                                    : [
                                                        btnColorBlueLight,
                                                        btnColorBlueDark
                                                      ],
                                                textColor: isPayOrder
                                                    ? btnColorPurpleDark
                                                    : iconButtonTextColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (isOrderOnly == false) {
                                                    isOrderOnly = true;
                                                    isPayOrder = false;
                                                  }
                                                });
                                              },
                                              child: ButtonMenu(
                                                text: 'ORDER ONLY',
                                                width: 200,
                                                height: 35,
                                                backColor: isOrderOnly
                                                    ? [
                                                        btnColorOrangeLight,
                                                        btnColorOrangeDark
                                                      ]
                                                    : [
                                                        btnColorBlueLight,
                                                        btnColorBlueDark
                                                      ],
                                                textColor: isOrderOnly
                                                    ? btnColorPurpleDark
                                                    : iconButtonTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (stationMulMenu == 1 &&
                                                  isActiveWst == true &&
                                                  prepTime.text != '' &&
                                                  strcollectionInstruction !=
                                                      '' &&
                                                  stations.isNotEmpty &&
                                                  isOrderAndPay == true ||
                                              stationMulMenu == 2 &&
                                                  strcollectionInstruction !=
                                                      '' &&
                                                  stations.isNotEmpty &&
                                                  isOrderAndPay == true) {
                                            context
                                                .read<MenuProvider>()
                                                .updateMenuCount(1);
                                          }
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'SET UP WTPs',
                                        width: 200,
                                        height: 35,
                                        backColor: stationMulMenu == 1 &&
                                                    isActiveWst == true &&
                                                    prepTime.text != '' &&
                                                    strcollectionInstruction !=
                                                        '' &&
                                                    stations.isNotEmpty &&
                                                    isOrderAndPay == true ||
                                                stationMulMenu == 2 &&
                                                    strcollectionInstruction !=
                                                        '' &&
                                                    stations.isNotEmpty &&
                                                    isOrderAndPay == true
                                            ? [
                                                btnColorGreenLight,
                                                btnColorGreenDark
                                              ]
                                            : [
                                                btnColorGreyLight,
                                                btnColorGreyDark
                                              ],
                                        textColor: iconButtonTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ListOfStation(double width) {
    return SizedBox(
      width: width,
      height: 150,
      child: ListView.builder(
          itemCount: stations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(stations[index]),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          stations.removeAt(index);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        color: Color(0xffef7700),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  serveWidget() {
    return SizedBox(
      width: 200,
      child: Column(children: [
        Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xffffffff),
            border: Border.all(width: 1.0, color: const Color(0xff707070)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: menuName,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Menu name'),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Ex: Lunch, Dinner, Korian, Itallian',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
            onTap: () {
              chooseImage();
            },
            child: ButtonMenu(
              text: 'Upload Menu',

              width: 200,
              height: 30,
              backColor: [btnColorOrangeLight, btnColorOrangeDark],
              textColor: iconButtonTextColor,

              // backColor: fileName != ''
              //     ? const sys_color_defaultorange
              //     : const button_color_grey,
            )),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Format available: pdf, png, jpg',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
            onTap: () {
              //need to change the count
              uploadImage(10);
            },
            child: ButtonMenu(
              text: 'SAVE',

              width: 200,
              height: 30,
              backColor: [btnColorOrangeLight, btnColorOrangeDark],
              textColor: iconButtonTextColor,

              // backColor: fileName != ''
              //     ? const sys_color_defaultorange
              //     : const button_color_grey,
            )),
        const SizedBox(
          height: 50,
        ),
        Column(
          children: [
            Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: systemDefaultColorOrange),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: stationController,
                    decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                            fontSize: 11,
                            fontFamily: defaultFontFamily,
                            fontStyle: FontStyle.italic),
                        border: InputBorder.none,
                        hintText: 'Station Name'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'EX. Kitchen, Bar, Lounge',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: defaultFontFamily,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              stations.add(stationController.text);
              context.read<MenuProvider>().setWorkStation(stations);
              stationController.text = '';
            });
          },
          child: Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffef7700),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ADD',
                  style: TextStyle(
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
        const SizedBox(
          height: 30,
        ),
        ListOfStation(200),
      ]),
    );
  }

  Future<void> chooseImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = result!.files.first;
      print(result.files.first.name);
      fileName = result.files.first.name;
      results = result;
      fileType = fileName.split('.')[1];
      menuUpdateUrl = result.files.first.name;
    });
  }

  Future<void> uploadImage(int menuCount) async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.1.7/uploads/image.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try {
      List<int>? imageBytes = uploadimage!.bytes;
      String baseimage = base64Encode(imageBytes!);
      print(baseimage.length);
      //convert file image to Base64 encoding
      var response = await http.post(Uri.parse(uploadurl), body: {
        'file_name': fileName,
        'base64_data': baseimage,
      });

      print(response.toString());

      if (response.statusCode == 200) {
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print(e.toString());
      //there is error during converting file image to base64 encoding.
    }

    createMenu(menuCount);
  }

  Future<void> uploadImageUpdate() async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.1.7/uploads/image.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try {
      List<int>? imageBytes = uploadimage!.bytes;
      String baseimage = base64Encode(imageBytes!);
      print(baseimage.length);
      //convert file image to Base64 encoding
      var response = await http.post(Uri.parse(uploadurl), body: {
        'file_name': fileName,
        'base64_data': baseimage,
      });

      print(response.toString());

      if (response.statusCode == 200) {
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print(e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  Future<void> createMenu(int menuCount) async {
    if (menuName.text != '' && fileName != '') {
      FirebaseFirestore.instance
          .collection('merchant')
          .doc('X6odvQ5gqesAzwtJLaFl')
          .collection('consultationMenu')
          .add({
        'order': menuCount,
        'date': DateTime.now(),
        'fileName': fileName,
        'image': 'http://192.168.1.7/uploads/uploads/$fileName',
        'name': menuName.text,
        'status': true,
        'type': fileType,
      }).then((value) async {
        context.read<MenuProvider>().menuRefresh();
      });
    }
  }

  itemServeMenu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 228, 228, 228),
                ),
                child: SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xff707070)),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                // controller: userController,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Search'),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: const Icon(Icons.filter_list_alt),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height - 200,
              //   width: 400,
              //   child: const ConsultMenuPage(),
              // ),
            ],
          ),
          menuViewer()
        ],
      ),
    );
  }

  Widget updateMenuDialog(BuildContext context, String mID) {
    return AlertDialog(
      title: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 400,
          height: 330,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update Menu',
              ),
              const SizedBox(height: 15),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Name',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLines: 1,
                              controller: menuNameUpdate,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                menuUpdateUrl,
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    chooseImage();
                  },
                  child: ButtonMenu(
                    text: 'UPLOAD NEW MENU',

                    width: 200,
                    height: 30,
                    backColor: [btnColorOrangeLight, btnColorOrangeDark],
                    textColor: iconButtonTextColor,

                    // backColor: fileName != ''
                    //     ? const sys_color_defaultorange
                    //     : const button_color_grey,
                  )),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: ButtonMenu(
                            text: 'CANCEL',

                            width: 200,
                            height: 30,
                            backColor: [
                              btnColorOrangeLight,
                              btnColorOrangeDark
                            ],
                            textColor: iconButtonTextColor,

                            // backColor: fileName != ''
                            //     ? const sys_color_defaultorange
                            //     : const button_color_grey,
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: () async {
                            uploadImageUpdate();
                            FirebaseFirestore.instance
                                .collection('merchant')
                                .doc('X6odvQ5gqesAzwtJLaFl')
                                .collection('consultationMenu')
                                .doc(mID)
                                .update({
                              'name': menuNameUpdate.text,
                              'image':
                                  'http://192.168.1.7/uploads/uploads/$menuUpdateUrl',
                              'type': fileType
                            }).then((value) async {
                              context.read<MenuProvider>().menuRefresh();
                              Navigator.of(context).pop();
                            });
                          },
                          child: ButtonMenu(
                            text: 'UPDATE',

                            width: 200,
                            height: 30,
                            backColor: [
                              btnColorOrangeLight,
                              btnColorOrangeDark
                            ],
                            textColor: iconButtonTextColor,

                            // backColor: fileName != ''
                            //     ? const sys_color_defaultorange
                            //     : const button_color_grey,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  menuViewer() {
    final String menuID = context.select((MenuProvider p) => p.menuID);
    final String menuName = context.select((MenuProvider p) => p.menuName);
    final String imageUrl = context.select((MenuProvider p) => p.imageUrl);
    final String type = context.select((MenuProvider p) => p.type);
    final String pdfData = context.select((MenuProvider p) => p.pdfData);

    return SizedBox(
      width: 450,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Stack(
          children: [
            if (imageUrl != '')
              if (type != 'pdf') ...[
                SizedBox(
                    width: 500,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    )),
              ] else ...[
                SizedBox(
                  width: 500,
                  child: HtmlWidget(
                    pdfData,
                    // customStylesBuilder: (element) {
                    //   if (element.classes.contains('foo')) {
                    //     return {'color': 'red'};
                    //   }
                    //   return null;
                    // },
                    onErrorBuilder: (context, element, error) =>
                        Text('$element error: $error'),
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        const CircularProgressIndicator(),
                    textStyle: const TextStyle(fontSize: 14),
                    webView: true,
                  ),
                )
              ],
            if (imageUrl != '')
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          menuNameUpdate.text = menuName;
                          menuUpdateUrl = imageUrl;
                        });
                        await showDialog<bool>(
                          context: context,
                          builder: (context) =>
                              updateMenuDialog(context, menuID),
                        );
                      },
                      child: ButtonMenu(
                        text: 'EDIT',

                        width: 200,
                        height: 30,
                        backColor: [btnColorOrangeLight, btnColorOrangeDark],
                        textColor: iconButtonTextColor,

                        // backColor: fileName != ''
                        //     ? const sys_color_defaultorange
                        //     : const button_color_grey,
                      )),
                ),
              ),
            if (imageUrl != '')
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                      onTap: () async {
                        await showDialog<bool>(
                          context: context,
                          builder: (context) =>
                              deleteMenuDialog(context, menuID, menuName),
                        );
                      },
                      child: ButtonMenu(
                        text: 'DELETE',

                        width: 200,
                        height: 30,
                        backColor: [btnColorOrangeLight, btnColorOrangeDark],
                        textColor: iconButtonTextColor,

                        // backColor: fileName != ''
                        //     ? const sys_color_defaultorange
                        //     : const button_color_grey,
                      )),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget deleteMenuDialog(BuildContext context, String mID, menuName) {
    return AlertDialog(
      title: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 300,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delete Menu',
              ),
              const SizedBox(height: 15),
              Text(
                'Are you sure you want to delete this menu $menuName ?',
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: ButtonMenu(
                            text: 'CANCEL',

                            width: 200,
                            height: 30,
                            backColor: [
                              btnColorOrangeLight,
                              btnColorOrangeDark
                            ],
                            textColor: iconButtonTextColor,

                            // backColor: fileName != ''
                            //     ? const sys_color_defaultorange
                            //     : const button_color_grey,
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: () async {
                            uploadImageUpdate();
                            FirebaseFirestore.instance
                                .collection('merchant')
                                .doc('X6odvQ5gqesAzwtJLaFl')
                                .collection('consultationMenu')
                                .doc(mID)
                                .delete()
                                .then((value) async {
                              context.read<MenuProvider>().menuRefresh();
                              Navigator.of(context).pop();
                            });
                          },
                          child: ButtonMenu(
                            text: 'DELETE',

                            width: 200,
                            height: 30,
                            backColor: [
                              btnColorOrangeLight,
                              btnColorOrangeDark
                            ],
                            textColor: iconButtonTextColor,

                            // backColor: fileName != ''
                            //     ? const sys_color_defaultorange
                            //     : const button_color_grey,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
