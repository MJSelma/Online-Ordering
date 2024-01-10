import 'dart:convert';
import 'dart:ui';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/business_outlet_provider.dart';
import '../../widgets/button.dart';
import '../../widgets/show_dialog.dart';
import '../constant/theme_data.dart';
import '../consultation/ipaddress.dart';
import '../data_class/outlet_class.dart';
import '../data_class/subStation_class.dart';

class WorkStation extends StatefulWidget {
  const WorkStation({super.key});

  @override
  State<WorkStation> createState() => _WorkStationState();
}

class _WorkStationState extends State<WorkStation> {
  bool isPaid = true;
  int orderingMenu = 0;
  int servedOrderingMenu = 0;
  int stationMenu = 0;
  bool showSetupMenu = true;
  bool showOrderingMenu = true;
  bool showStationMenu = true;
  bool isActiveWst = false;
  bool isPayOrder = false;
  bool isOrderOnly = false;
  bool isSelfCollection = false;
  bool isOrderAndPay = false;
  bool isServeCollection = false;
  bool isAverageTimeOpen1 = false;
  bool isAverageTimeOpen2 = false;
  bool isServiceOptionOpen1 = false;
  bool isServiceOptionOpen2 = false;
  bool isServiceOptionOpen3 = false;
  bool isListSubstationOpen = false;
  TextEditingController prepTime = TextEditingController(text: '');
  TextEditingController stationController = TextEditingController(text: '');
  TextEditingController collectionInstruction = TextEditingController(text: '');
  String strcollectionInstruction = '';
  String strprepTime = '';
  String graphSrc = '';
  String selectedOutletId = '';
  String docId = '';
  String stationId = '';
  bool isImportMenu = false;
  String importFilenamex = '';
  String importImagex = '';
  String importTypex = '';
  String importMenuNamex = '';
  List<OutletClass> outletClasss = [];

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

  List<dynamic> indexListSubStation = [];
  int indexListSubStationDelete = 0;
  bool isSubStationSelected = false;
  bool isSubStationDiactivated = false;
  List<SubStationClass> listSubStation = [];

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
    final outletId =
        context.select((BusinessOutletProvider p) => p.selectedOutletId);
    selectedOutletId = outletId;
    final outletClassx =
        context.select((BusinessOutletProvider p) => p.outletClass);
    outletClasss = outletClassx;

    final country = context.select((BusinessOutletProvider p) => p.country);
    outletClasss = outletClasss
        .where((item) =>
            item.country.toLowerCase() == country.toLowerCase() &&
            item.id.toLowerCase() != selectedOutletId.toLowerCase())
        .toList();

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
                                        servedOrderingMenu = 0;
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
                                      borderColor: null,
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
                              'Your Dguests will be able to order and/or pay from their smartphones. Ideal for Clubs, Caffeteria or small Businesses ',
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
                                      borderColor: null,
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
                              'Your waiters will be able to place ordes from their smartphones',
                              style: TextStyle(
                                  fontSize: defaulDescriptiontFontSize,
                                  fontFamily: defaultFontFamily,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Visibility(
                            visible: orderingMenu == 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // orderingMenu = 2;
                                          servedOrderingMenu = 1;
                                          showSetupMenu = false;
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'MENU SET UP',
                                        width: 150,
                                        height: 30,
                                        backColor: servedOrderingMenu == 1
                                            ? [
                                                btnColorOrangeLight,
                                                btnColorOrangeDark
                                              ]
                                            : [
                                                btnColorBlueLight,
                                                btnColorBlueDark
                                              ],
                                        textColor: servedOrderingMenu == 1
                                            ? btnColorPurpleDark
                                            : iconButtonTextColor,
                                        borderColor: null,
                                      )),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // orderingMenu = 2;
                                          servedOrderingMenu = 2;
                                        });
                                      },
                                      child: ButtonMenu(
                                        text: 'WST SET UP',
                                        width: 150,
                                        height: 30,
                                        backColor: servedOrderingMenu == 2
                                            ? [
                                                btnColorOrangeLight,
                                                btnColorOrangeDark
                                              ]
                                            : [
                                                btnColorBlueLight,
                                                btnColorBlueDark
                                              ],
                                        textColor: servedOrderingMenu == 2
                                            ? btnColorPurpleDark
                                            : iconButtonTextColor,
                                        borderColor: null,
                                      )),
                                ],
                              ),
                            ),
                          )
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
                                          graphSrc = 'graph1.jpeg';
                                          init();
                                          strprepTime = '';
                                          isAverageTimeOpen1 = false;
                                          isServiceOptionOpen1 = false;
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
                                        borderColor: null,
                                      )),
                                  // child: stationButton('One Station Required',
                                  //     1, Icons.payment, 50, 12, false)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Your Dguest will be able to order and pay from their smartphone. Ideal for Clubs, Caffeteria or small Businesses',
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
                                          isListSubstationOpen = false;
                                          isServiceOptionOpen2 = false;
                                          isServiceOptionOpen3 = false;
                                          listSubStation.clear();
                                          strprepTime = '';
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
                                        borderColor: null,
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
                                      'Your Dguest will be able to order and pay from their smartphone. Ideal for Clubs, Pubs, Caffeteria, Restaurants',
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
                                                      stationId = '1';
                                                      graphSrc = 'graph2.jpeg';
                                                      init();

                                                      isListSubstationOpen =
                                                          false;
                                                      isServiceOptionOpen2 =
                                                          false;
                                                      isServiceOptionOpen3 =
                                                          false;
                                                      listSubStation.clear();
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
                                                    borderColor: null,
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
                                              'Having a Master Station will let your DGUESTS to order different menu categories Ex. Food&Drinks, which will be preparedby different Working Stations. Ideal for Food-Courts, Restaurants, Bars, Caffetterias, Beach Clubs, Pubs',
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
                                                      listSubStation.clear();
                                                      stationMulMenu = 2;
                                                      stationId = '2';
                                                      graphSrc = 'graph3.jpeg';
                                                      init();
                                                      isAverageTimeOpen2 =
                                                          false;
                                                      isListSubstationOpen =
                                                          false;
                                                      isServiceOptionOpen3 =
                                                          false;
                                                      listSubStation.clear();
                                                      int idexno =
                                                          listSubStation.length;
                                                      SubStationClass
                                                          subStationx =
                                                          SubStationClass(
                                                              index: idexno,
                                                              stationName:
                                                                  stationController
                                                                      .text,
                                                              status: true);
                                                      listSubStation
                                                          .add(subStationx);
                                                    });
                                                  },
                                                  child: ButtonMenu(
                                                    text:
                                                        'INDIVIDUAL WSTs SET UP',
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
                                                    borderColor: null,
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
                // Visibility(
                //   visible: !showSetupMenu,
                //   child: Padding(
                //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                //       child: GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               showSetupMenu = false;
                //             });
                //           },
                //           child: Image.asset(
                //               'assets/images/single-right-arrow.png',
                //               height: 20,
                //               color: Colors.grey.shade500))),
                // ),
                Visibility(
                    visible: servedOrderingMenu == 1 ||
                        servedOrderingMenu == 2 ||
                        !showSetupMenu,
                    child: serveWidget()),
                Visibility(
                  visible: orderingMenu == 1 ||
                      servedOrderingMenu == 1 ||
                      servedOrderingMenu == 2,
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
                  Visibility(
                      visible:
                          servedOrderingMenu == 1 || servedOrderingMenu == 2,
                      child: getOutletMenu())
                ],
                Visibility(
                  visible: servedOrderingMenu == 1,
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade500,
                    height: MediaQuery.of(context).size.height - 150,
                  ),
                ),
                Visibility(
                  visible: true,
                  // visible: servedOrderingMenu == 1 || servedOrderingMenu == 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                          visible: servedOrderingMenu == 1 ||
                              servedOrderingMenu == 2,
                          child: getMenuView()),
                      Visibility(
                        visible:
                            servedOrderingMenu == 1 || servedOrderingMenu == 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 50.0, 20.0, 0.0),
                              alignment: Alignment.bottomRight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (singleStationVal()) {
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
                                      backColor: singleStationVal()
                                          ? [
                                              btnColorGreenLight,
                                              btnColorGreenDark
                                            ]
                                          : [
                                              btnColorGreyLight,
                                              btnColorGreyDark
                                            ],
                                      textColor: iconButtonTextColor,
                                      borderColor: null,
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
                )
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
                  height: 400,
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
                          Expanded(
                              child: Center(
                            child: Image.asset(
                              'assets/images/$graphSrc',
                              fit: BoxFit.fitWidth,
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
                                  borderColor: null,
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
        ),
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
                            isAverageTimeOpen1 = !isAverageTimeOpen1;
                            isServiceOptionOpen1 = !isServiceOptionOpen1;
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
                  Visibility(
                    visible: isAverageTimeOpen1,
                    child: Column(
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
                                'ENTER AVERAGE PREPARATION TIME',
                                style: TextStyle(
                                  fontSize: defaulDescriptiontFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
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
                                    onChanged: (value) {
                                      setState(() {
                                        strprepTime = prepTime.text;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'MINUTES',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: defaulDescriptiontFontSize,
                                  fontFamily: defaultFontFamily,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isServiceOptionOpen1 && strprepTime.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                          width: showStationMenu == false &&
                                      showOrderingMenu == true ||
                                  showStationMenu == true &&
                                      showOrderingMenu == false
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              isSelfCollection =
                                                  !isSelfCollection;
                                              collectionInstruction.text = '';
                                              strcollectionInstruction = '';
                                              if (isOrderAndPay == true) {
                                                isOrderAndPay = false;
                                              }
                                            });
                                          },
                                          child: ButtonMenu(
                                            text: 'SELF SERVICE',
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
                                            borderColor: null,
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
                                              borderColor: null,
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
                          width: isSelfCollection ? 10 : 150,
                        ),
                        Visibility(
                          visible: isSelfCollection,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                // if (isServeCollection == false) {
                                                //   isPayOrder = false;
                                                //   isOrderOnly = false;
                                                // }

                                                // if (isSelfCollection == true &&
                                                //     isOrderAndPay == false) {
                                                //   warningDialog(
                                                //       context,
                                                //       'SELF SERVICE',
                                                //       'Please select Service Option');
                                                //   isServeCollection = false;
                                                //   return;
                                                // }

                                                // if (isSelfCollection == true &&
                                                //     strcollectionInstruction == '') {
                                                //   warningDialog(
                                                //       context,
                                                //       'SELF SERVICE',
                                                //       'Please enter Collection Instruction');
                                                //   isServeCollection = false;
                                                //   return;
                                                // }
                                              });
                                            },
                                            child: ButtonMenu(
                                              text: 'SERVED SERVICE',
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
                                              borderColor: null,
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
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            defaultFontFamily),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      // if (isPayOrder == false) {
                                                      //   isPayOrder = true;
                                                      //   isOrderOnly = false;
                                                      // }
                                                      isPayOrder = !isPayOrder;
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
                                                    borderColor: null,
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   height: 20,
                                                // ),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     setState(() {
                                                //       if (isOrderOnly == false) {
                                                //         isOrderOnly = true;
                                                //         isPayOrder = false;
                                                //       }
                                                //     });
                                                //   },
                                                //   child: ButtonMenu(
                                                //     text: 'ORDER ONLY',
                                                //     width: 200,
                                                //     height: 35,
                                                //     backColor: isOrderOnly
                                                //         ? [
                                                //             btnColorOrangeLight,
                                                //             btnColorOrangeDark
                                                //           ]
                                                //         : [
                                                //             btnColorBlueLight,
                                                //             btnColorBlueDark
                                                //           ],
                                                //     textColor: isOrderOnly
                                                //         ? btnColorPurpleDark
                                                //         : iconButtonTextColor,
                                                //     borderColor: null,
                                                //   ),
                                                // ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (singleStationVal()) {
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
                                            backColor: singleStationVal()
                                                ? [
                                                    btnColorGreenLight,
                                                    btnColorGreenDark
                                                  ]
                                                : [
                                                    btnColorGreyLight,
                                                    btnColorGreyDark
                                                  ],
                                            textColor: iconButtonTextColor,
                                            borderColor: null,
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
            ],
          ),
        ),
      ),
    );
  }

  bool singleStationVal() {
    bool a = false;
    bool b = false;
    bool c = false;
    if (isActiveWst == true && strprepTime != '' && isPayOrder == true ||
        isActiveWst == true && strprepTime != '' && isOrderOnly == true) {
      a = true;
    }
    if (isActiveWst == true &&
        strprepTime != '' &&
        isOrderAndPay == true &&
        strcollectionInstruction != '') {
      b = true;
    }
    if (isSelfCollection == true) {
      c = b;
    }
    if (isServeCollection == true) {
      c = a;
    }
    if (isSelfCollection == true && isServeCollection == true) {
      if (a == true && b == true) {
        c = true;
      } else {
        c = false;
      }
    }

    return c;
  }

  bool multipleStationVal() {
    bool a = false;
    bool b = false;
    bool c = false;
    if (isActiveWst == true &&
            listSubStation.isNotEmpty &&
            isPayOrder == true ||
        isActiveWst == true &&
            listSubStation.isNotEmpty &&
            isOrderOnly == true) {
      a = true;
    }
    if (isActiveWst == true &&
        listSubStation.isNotEmpty &&
        isOrderAndPay == true &&
        strcollectionInstruction != '') {
      b = true;
    }
    if (isSelfCollection == true) {
      c = b;
    }
    if (isServeCollection == true) {
      c = a;
    }
    if (isSelfCollection == true && isServeCollection == true) {
      if (a == true && b == true) {
        c = true;
      } else {
        c = false;
      }
    }

    return c;
  }

  bool multipleStationIndividualVal() {
    bool a = false;
    bool b = false;
    bool c = false;
    if (listSubStation.isNotEmpty &&
            strprepTime.isNotEmpty &&
            isPayOrder == true ||
        isActiveWst == true &&
            listSubStation.isNotEmpty &&
            isOrderOnly == true) {
      a = true;
    }
    if (listSubStation.isNotEmpty &&
        strprepTime.isNotEmpty &&
        isOrderAndPay == true &&
        strcollectionInstruction != '') {
      b = true;
    }
    if (isSelfCollection == true) {
      c = b;
    }
    if (isServeCollection == true) {
      c = a;
    }
    if (isSelfCollection == true && isServeCollection == true) {
      if (a == true && b == true) {
        c = true;
      } else {
        c = false;
      }
    }

    return c;
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
                              'assets/images/$graphSrc',
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: stationMulMenu == 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                isListSubstationOpen = !isListSubstationOpen;
                                listSubStation.clear();
                                isServiceOptionOpen2 = !isServiceOptionOpen2;
                                int idexno = listSubStation.length;
                                SubStationClass subStationx = SubStationClass(
                                    index: idexno,
                                    stationName: stationController.text,
                                    status: true);
                                listSubStation.add(subStationx);
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
                                        ? 'ACTIVATE MASTER'
                                        : 'MASTER WST ACTIVATED',
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
                        width: 100,
                      ),
                      Visibility(
                        visible: isListSubstationOpen,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              stationMulMenu == 1
                                  ? 'assets/images/step2.png'
                                  : 'assets/images/step1.png',
                              height: 25,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'CREATE STATION',
                                        style: TextStyle(
                                          fontSize: defaulDescriptiontFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xffffffff),
                                        border: Border.all(
                                            width: 1.0,
                                            color: systemDefaultColorOrange),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: stationController,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontFamily:
                                                            defaultFontFamily,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                    border: InputBorder.none,
                                                    hintText: 'Station Name'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'EX. Kitchen, Bar, Lounge',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: defaultFontFamily,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(width: 50),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (stationController.text ==
                                                    '') {
                                                  warningDialog(
                                                      context,
                                                      'CREATE SUB STATION',
                                                      'Please enter station name');
                                                  return;
                                                }

                                                FirebaseFirestore.instance
                                                    .collection('subStation')
                                                    .add({
                                                  'stationId': '1',
                                                  'stationName':
                                                      stationController.text,
                                                  'status': true,
                                                });
                                                // stations
                                                //     .add(stationController.text);

                                                int idexno =
                                                    listSubStation.length;
                                                SubStationClass subStationx =
                                                    SubStationClass(
                                                        index: idexno,
                                                        stationName:
                                                            stationController
                                                                .text,
                                                        status: true);
                                                listSubStation.add(subStationx);
                                                context
                                                    .read<MenuProvider>()
                                                    .setWorkStation(stations);
                                                stationController.text = '';
                                                isServiceOptionOpen2 =
                                                    !isServiceOptionOpen2;
                                              });
                                            },
                                            child: ButtonMenu(
                                              text: 'ADD',
                                              width: 100,
                                              height: 35,
                                              backColor: [
                                                btnColorPurpleLight,
                                                btnColorPurpleDark
                                              ],
                                              textColor: iconButtonTextColor,
                                              borderColor: null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                //List of station
                                Visibility(
                                    visible: listSubStation.isNotEmpty,
                                    child: ListOfStation(300)),
                                Visibility(
                                  visible: listSubStation.isNotEmpty,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 200.0),
                                        child: GestureDetector(
                                          child: ButtonMenu(
                                            text: 'DELETE',
                                            width: 100,
                                            height: 35,
                                            backColor: [
                                              btnColorRedLight,
                                              btnColorRedDark
                                            ],
                                            textColor: iconButtonTextColor,
                                            borderColor: null,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              for (var i = 0;
                                                  i <
                                                      indexListSubStation
                                                          .length;
                                                  i++) {
                                                print(indexListSubStation[i]);
                                                listSubStation.removeWhere(
                                                    (item) =>
                                                        item.stationName ==
                                                        indexListSubStation[i]);
                                                indexListSubStation.removeWhere(
                                                    (item) =>
                                                        item ==
                                                        indexListSubStation[i]
                                                            .toString());
                                                isSubStationSelected = false;
                                              }

                                              FirebaseFirestore.instance
                                                  .collection('subStation')
                                                  .doc(docId)
                                                  .delete();
                                              //     .then((value) async {
                                              //   context
                                              //       .read<MenuProvider>()
                                              //       .menuRefresh();
                                              //   Navigator.of(context).pop();
                                              //   context
                                              //       .read<MenuProvider>()
                                              //       .selectedMenu(
                                              //           '', '', '', '', '');
                                              // });

                                              // for (var itemx
                                              //     in indexListSubStation) {
                                              //   print(itemx);
                                              //   stations.removeWhere((item) =>
                                              //       item == itemx.toString());
                                              //   indexListSubStation.removeWhere(
                                              //       (item) =>
                                              //           item == itemx.toString());
                                              // }
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Visibility(
                    visible: stationMulMenu == 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          stationMulMenu == 1
                              ? 'assets/images/step2.png'
                              : 'assets/images/step1.png',
                          height: 25,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'ENTER NAME OF WSTs',
                                    style: TextStyle(
                                      fontSize: defaulDescriptiontFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xffffffff),
                                    border: Border.all(
                                        width: 1.0,
                                        color: systemDefaultColorOrange),
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'EX. Kitchen, Bar, Lounge',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: defaultFontFamily,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      const SizedBox(width: 50),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (stationController.text == '') {
                                              warningDialog(
                                                  context,
                                                  'CREATE SUB STATION',
                                                  'Please enter station name');
                                              return;
                                            }
                                            FirebaseFirestore.instance
                                                .collection('subStation')
                                                .add({
                                              'stationId': '2',
                                              'stationName':
                                                  stationController.text,
                                              'status': true,
                                            });
                                            // stations
                                            //     .add(stationController.text);

                                            int idexno = listSubStation.length;
                                            SubStationClass subStationx =
                                                SubStationClass(
                                                    index: idexno,
                                                    stationName:
                                                        stationController.text,
                                                    status: true);
                                            listSubStation.add(subStationx);
                                            context
                                                .read<MenuProvider>()
                                                .setWorkStation(stations);
                                            stationController.text = '';
                                          });
                                        },
                                        child: ButtonMenu(
                                          text: 'ADD',
                                          width: 100,
                                          height: 35,
                                          backColor: [
                                            btnColorPurpleLight,
                                            btnColorPurpleDark
                                          ],
                                          textColor: iconButtonTextColor,
                                          borderColor: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            //List of station
                            Visibility(
                                visible: listSubStation.isNotEmpty,
                                child: ListOfStation(300)),
                            Visibility(
                              visible: listSubStation.isNotEmpty,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        200.0, 0.0, 0.0, 20.0),
                                    child: GestureDetector(
                                      child: ButtonMenu(
                                        text: 'DELETE',
                                        width: 100,
                                        height: 35,
                                        backColor: [
                                          btnColorRedLight,
                                          btnColorRedDark
                                        ],
                                        textColor: iconButtonTextColor,
                                        borderColor: null,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          for (var i = 0;
                                              i < indexListSubStation.length;
                                              i++) {
                                            print(indexListSubStation[i]);
                                            listSubStation.removeWhere((item) =>
                                                item.stationName ==
                                                indexListSubStation[i]);
                                            indexListSubStation.removeWhere(
                                                (item) =>
                                                    item ==
                                                    indexListSubStation[i]
                                                        .toString());
                                            isSubStationSelected = false;
                                          }

                                          FirebaseFirestore.instance
                                              .collection('subStation')
                                              .doc(docId)
                                              .delete();

                                          // for (var itemx
                                          //     in indexListSubStation) {
                                          //   print(itemx);
                                          //   stations.removeWhere((item) =>
                                          //   0    item == itemx.toString());
                                          //   indexListSubStation.removeWhere(
                                          //       (item) =>
                                          //           item == itemx.toString());
                                          // }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: listSubStation.isNotEmpty,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/step2.png',
                                height: 25,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'ENTER AVERAGE PREPARATION TIME',
                                      style: TextStyle(
                                        fontSize: defaulDescriptiontFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                              decoration: const InputDecoration
                                                  .collapsed(hintText: '5'),
                                              onChanged: (value) {
                                                setState(() {
                                                  strprepTime = prepTime.text;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'MINUTES',
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize:
                                                defaulDescriptiontFontSize,
                                            fontFamily: defaultFontFamily,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: stationMulMenu == 2
                      ? listSubStation.isNotEmpty && strprepTime.isNotEmpty
                      : listSubStation.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                            width: showStationMenu == false &&
                                        showOrderingMenu == true ||
                                    showStationMenu == true &&
                                        showOrderingMenu == false
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
                                    ? 'assets/images/step3.png'
                                    : 'assets/images/step3.png',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                isSelfCollection =
                                                    !isSelfCollection;
                                              });
                                            },
                                            child: ButtonMenu(
                                              text: 'SELF SERVICE',
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
                                              borderColor: null,
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
                                                  isOrderAndPay =
                                                      !isOrderAndPay;
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
                                                borderColor: null,
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
                            width: isSelfCollection || isServeCollection
                                ? 10
                                : 150,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          ? 'assets/images/step4.png'
                                          : 'assets/images/step4.png',
                                      height: 25,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Your Dguests will served by your waiters to their tables',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily:
                                                        defaultFontFamily,
                                                    fontStyle:
                                                        FontStyle.italic),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isServeCollection =
                                                      !isServeCollection;
                                                  if (stationMulMenu == 1) {
                                                    isPayOrder = false;
                                                    isOrderOnly = false;
                                                  }

                                                  // isPayOrder = !isPayOrder;
                                                  // if (isServeCollection == false) {
                                                  //   isPayOrder = false;
                                                  //   isOrderOnly = false;
                                                  // }
                                                });
                                              },
                                              child: ButtonMenu(
                                                text: 'SERVED SERVICE',
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
                                                borderColor: null,
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'CHOOSE ONE',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              defaultFontFamily),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (stationMulMenu ==
                                                            1) {
                                                          if (isPayOrder ==
                                                              false) {
                                                            isPayOrder = true;
                                                            isOrderOnly = false;
                                                          }
                                                        } else {
                                                          isPayOrder =
                                                              !isPayOrder;
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
                                                      borderColor: null,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        stationMulMenu == 1,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (isOrderOnly ==
                                                              false) {
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
                                                        borderColor: null,
                                                      ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (stationMulMenu == 1) {
                                                    if (multipleStationVal()) {
                                                      context
                                                          .read<MenuProvider>()
                                                          .updateMenuCount(1);
                                                    }
                                                  } else {
                                                    if (multipleStationIndividualVal()) {
                                                      context
                                                          .read<MenuProvider>()
                                                          .updateMenuCount(2);
                                                    }
                                                  }
                                                });
                                              },
                                              child: stationMulMenu == 1
                                                  ? ButtonMenu(
                                                      text: 'SET UP WTPs',
                                                      width: 200,
                                                      height: 35,
                                                      backColor:
                                                          multipleStationVal()
                                                              ? [
                                                                  btnColorGreenLight,
                                                                  btnColorGreenDark
                                                                ]
                                                              : [
                                                                  btnColorGreyLight,
                                                                  btnColorGreyDark
                                                                ],
                                                      textColor:
                                                          iconButtonTextColor,
                                                      borderColor: null,
                                                    )
                                                  : ButtonMenu(
                                                      text: 'SET UP WTPs',
                                                      width: 200,
                                                      height: 35,
                                                      backColor:
                                                          multipleStationIndividualVal()
                                                              ? [
                                                                  btnColorGreenLight,
                                                                  btnColorGreenDark
                                                                ]
                                                              : [
                                                                  btnColorGreyLight,
                                                                  btnColorGreyDark
                                                                ],
                                                      textColor:
                                                          iconButtonTextColor,
                                                      borderColor: null,
                                                    )),
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
      height: 250,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('subStation')
            .where('stationId', isEqualTo: stationId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  print('1111111111111111111111111111111111');
                  print(doc['stationName']);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(stations[index]),
                        GestureDetector(
                          onTap: doc['status'] == false
                              ? null
                              : () {
                                  setState(() {
                                    docId = doc.id;
                                    print(docId);
                                    indexListSubStationDelete = index;

                                    isSubStationSelected = false;
                                    isSubStationSelected = true;
                                    indexListSubStation.clear();
                                    indexListSubStation.add(doc['stationName']);

                                    // for (var i = 0; i < indexListSubStation.length; i++) {
                                    //   print(indexListSubStation[i]);
                                    // }
                                  });
                                },
                          child: Opacity(
                            opacity: doc['status'] == false ? 0.25 : 1.0,
                            child: ButtonMenu(
                              text: doc['stationName'],
                              width: 200,
                              height: 35,
                              backColor: [
                                btnColorOrangeLight,
                                btnColorOrangeDark
                              ],
                              textColor: iconButtonTextColor,
                              borderColor: indexListSubStationDelete == index &&
                                      isSubStationSelected
                                  ? btnColorPurpleLight
                                  : null,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              print(doc.id);
                              if (indexListSubStationDelete == index &&
                                  doc['status'] == false) {
                                FirebaseFirestore.instance
                                    .collection('subStation')
                                    .doc(doc.id)
                                    .update({'status': true});
                              } else {
                                FirebaseFirestore.instance
                                    .collection('subStation')
                                    .doc(doc.id)
                                    .update({'status': false});
                              }
                              // stations.removeAt(index);
                              isSubStationSelected = false;
                              // indexListSubStationDelete == index &&
                              //         isSubStationSelected
                              //     ? isSubStationSelected = false
                              //     : isSubStationSelected = true;
                              indexListSubStationDelete = index;
                              // isSubStationDiactivated = !isSubStationDiactivated;
                              isSubStationDiactivated = false;
                              isSubStationDiactivated = true;
                            });
                          },
                          child: ButtonMenu(
                            text: doc['status'] == false ? 'D-ACT' : 'ACT',
                            width: 50,
                            height: 35,
                            backColor: doc['status'] == false
                                ? [btnColorGreyLight, btnColorGreyDark]
                                : [btnColorPurpleLight, btnColorPurpleDark],
                            textColor: doc['status'] == false
                                ? btnColorRedDark
                                : iconButtonTextColor,
                            borderColor: null,
                          ),
                          // child: const Icon(
                          //   Icons.close,
                          //   color: Color(0xffef7700),
                          // ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return Container();
          }
        },
      ),
      // child: ListView.builder(
      //     itemCount: listSubStation.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             // Text(stations[index]),
      //             GestureDetector(
      //               child: ButtonMenu(
      //                 text: listSubStation[index].stationName,
      //                 width: 200,
      //                 height: 35,
      //                 backColor: [btnColorOrangeLight, btnColorOrangeDark],
      //                 textColor: iconButtonTextColor,
      //                 borderColor: indexListSubStationDelete == index &&
      //                         isSubStationSelected
      //                     ? btnColorPurpleLight
      //                     : null,
      //               ),
      //               onTap: () {
      //                 setState(() {
      //                   indexListSubStationDelete = index;

      //                   isSubStationSelected = false;
      //                   isSubStationSelected = true;
      //                   indexListSubStation.clear();
      //                   indexListSubStation
      //                       .add(listSubStation[index].stationName);

      //                   // for (var i = 0; i < indexListSubStation.length; i++) {
      //                   //   print(indexListSubStation[i]);
      //                   // }
      //                 });
      //               },
      //             ),
      //             GestureDetector(
      //               onTap: () {
      //                 setState(() {
      //                   indexListSubStationDelete == index &&
      //                           isSubStationDiactivated == false
      //                       ? isSubStationSelected = true
      //                       : isSubStationSelected = false;
      //                   // stations.removeAt(index);
      //                   isSubStationSelected = false;
      //                   // indexListSubStationDelete == index &&
      //                   //         isSubStationSelected
      //                   //     ? isSubStationSelected = false
      //                   //     : isSubStationSelected = true;
      //                   indexListSubStationDelete = index;
      //                   // isSubStationDiactivated = !isSubStationDiactivated;
      //                   isSubStationDiactivated = false;
      //                   isSubStationDiactivated = true;
      //                 });
      //               },
      //               child: ButtonMenu(
      //                 text: indexListSubStationDelete == index &&
      //                         isSubStationDiactivated
      //                     ? 'D-ACT'
      //                     : 'ACT',
      //                 width: 50,
      //                 height: 35,
      //                 backColor: indexListSubStationDelete == index &&
      //                         isSubStationDiactivated
      //                     ? [btnColorGreyLight, btnColorGreyDark]
      //                     : [btnColorPurpleLight, btnColorPurpleDark],
      //                 textColor: indexListSubStationDelete == index &&
      //                         isSubStationDiactivated
      //                     ? btnColorRedDark
      //                     : iconButtonTextColor,
      //                 borderColor: null,
      //               ),
      //               // child: const Icon(
      //               //   Icons.close,
      //               //   color: Color(0xffef7700),
      //               // ),
      //             )
      //           ],
      //         ),
      //       );
      //     }),
    );
  }

  serveWidget() {
    final int menuCount = context.select((MenuProvider p) => p.menuCount);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: Column(children: [
          Visibility(
            visible: servedOrderingMenu == 1,
            child: Visibility(
              visible: !showSetupMenu,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Enter Menu Name',
                        style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              showSetupMenu = true;
                            });
                          },
                          child: Image.asset(
                              'assets/images/single-left-arrow.png',
                              height: 20,
                              color: Colors.grey.shade500)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                          controller: menuName,
                          decoration: null,
                          style: const TextStyle(fontSize: 12.0),
                          onChanged: (value) {
                            setState(() {});
                          },
                          // const InputDecoration.collapsed(hintText: 'Menu name'),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Ex: Lunch, Dinner, Korian, Itallian',
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
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
                        text: 'CHOOSE FILE',

                        width: 200,
                        height: 30,
                        backColor: [btnColorOrangeLight, btnColorOrangeDark],
                        textColor: fileName.isNotEmpty
                            ? btnColorPurpleDark
                            : iconButtonTextColor,
                        borderColor: null,

                        // backColor: fileName != ''
                        //     ? const sys_color_defaultorange
                        //     : const button_color_grey,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Format available: pdf, png, jpg',
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (menuName.text == '') {
                          warningDialog(
                              context, 'MENU NAME', 'Please enter menu name.');
                          return;
                        }

                        if (fileName == '') {
                          warningDialog(
                              context, 'CHOOSE FILE', 'Please select file.');
                          return;
                        }

                        //need to change the count
                        uploadImage(menuCount);

                        // uploadImage(1);
                      },
                      child: ButtonMenu(
                        text: 'UPLOAD FILE',

                        width: 200,
                        height: 30,
                        backColor: fileName != '' && menuName.text != ''
                            ? [btnColorGreenLight, btnColorGreenDark]
                            : [btnColorGreyLight, btnColorGreyDark],
                        textColor: iconButtonTextColor,
                        borderColor: null,
                        // backColor: fileName != ''
                        //     ? const sys_color_defaultorange
                        //     : const button_color_grey,
                      )),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        children: [
                          Checkbox(
                            shape: const CircleBorder(eccentricity: 1.0),
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: isImportMenu,
                            onChanged: (bool? value) {
                              setState(() {
                                isImportMenu == true
                                    ? isImportMenu = false
                                    : isImportMenu = true;
                                importImagex = '';
                              });
                            },
                          ),
                          Text(
                            'Import menu from existing outlets'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: systemDefaultColorOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Visibility(
                      visible: isImportMenu,
                      child: Column(
                        children: [
                          GestureDetector(
                            child: ButtonMenu(
                              text: 'Choose OUTLET'.toUpperCase(),
                              width: 200,
                              height: 30,
                              backColor: [
                                btnColorOrangeLight,
                                btnColorOrangeDark
                              ],
                              textColor: iconButtonTextColor,
                              borderColor: null,
                            ),
                            onTap: () {
                              setState(() {
                                context
                                    .read<MenuProvider>()
                                    .setChoosenOutletMenId('');
                                context
                                    .read<MenuProvider>()
                                    .setChooseOutletIndex(-1);
                                context
                                    .read<MenuProvider>()
                                    .setChooseOutletIndexSelected(-1);
                                context
                                    .read<MenuProvider>()
                                    .setImportImage('', '', '', '');
                              });

                              chooseOutlet();
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                              onTap: () async {
                                createMenuImport(menuCount);
                              },
                              child: ButtonMenu(
                                text: 'UPLOAD MENU',
                                width: 200,
                                height: 30,
                                backColor: importImagex != ''
                                    ? [btnColorGreenLight, btnColorGreenDark]
                                    : [btnColorGreyLight, btnColorGreyDark],
                                textColor: iconButtonTextColor,
                                borderColor: null,
                              )),
                        ],
                      )),
                ],
              ),
            ),
          ),
          // const SizedBox(
          //   height: 50,
          // ),
          Visibility(
            visible: servedOrderingMenu == 2,
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 1.0, color: systemDefaultColorOrange),
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
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // stations.add(stationController.text);
                      int idexno = listSubStation.length;
                      SubStationClass subStationx = SubStationClass(
                          index: idexno,
                          stationName: stationController.text,
                          status: true);
                      listSubStation.add(subStationx);
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
              ],
            ),
          ),
        ]),
      ),
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
    String uploadurl = "$ipAddress/uploads/image.php";

    // String uploadurl = "http://192.168.1.7/uploads/image.php";
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
    setState(() {
      fileName = '';
      menuName.text = '';
    });
  }

  Future<void> createMenuImport(int menuCount) async {
    if (importImagex != '') {
      await FirebaseFirestore.instance
          .collection('merchant')
          .doc('X6odvQ5gqesAzwtJLaFl')
          .collection('smartMenu')
          .add({
        'order': menuCount,
        'date': DateTime.now(),
        'fileName': importFilenamex,
        'image': '$ipAddress/uploads/uploads/$importFilenamex',
        'name': importMenuNamex,
        'status': true,
        'type': importTypex,
        // 'outletId': 'dlo015'
        'outletId': selectedOutletId
      }).then((value) async {
        context.read<MenuProvider>().menuRefresh();
        setState(() {
          importImagex = '';
          isImportMenu = false;
        });
      });
    } else {
      warningDialog(context, 'CHOOSE OUTLET', 'Please choose outlet.');
    }
  }

  Future<void> uploadImageUpdate() async {
    //show your own loading or progressing code here

    String uploadurl = "$ipAddress/uploads/image.php";
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
          .collection('smartMenu')
          .add({
        'order': menuCount,
        'date': DateTime.now(),
        'fileName': fileName,
        'image': '$ipAddress/uploads/uploads/$fileName',
        'name': menuName.text,
        'status': true,
        'type': fileType,
        'outletId': selectedOutletId
      }).then((value) async {
        context.read<MenuProvider>().menuRefresh();
      });
    }
  }

  getOutletMenu() {
    return StatefulBuilder(
      builder: (context, setState) {
        String outletIdxx = '';
        final choosenOutletId =
            context.select((MenuProvider p) => p.ChoosenOutletMenId);

        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Column(children: [
              SizedBox(
                width: 240,
                height: MediaQuery.sizeOf(context).height - 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('merchant')
                      .doc('X6odvQ5gqesAzwtJLaFl')
                      .collection('smartMenu')
                      .where('outletId', isEqualTo: selectedOutletId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // maxCrossAxisExtent: 300,
                                // childAspectRatio: 1,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Image.network(
                                    doc['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    // outletImageUrl = doc['image'];
                                    // print(outletImageUrl);
                                    context.read<MenuProvider>().setImportImage(
                                        doc['fileName'],
                                        doc['image'],
                                        doc['type'],
                                        doc['name']);
                                  });
                                },
                              ),
                              Text(doc['name'])
                            ],
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  getOutletMenu2() {
    return StatefulBuilder(
      builder: (context, setState) {
        String outletIdxx = '';
        final choosenOutletId =
            context.select((MenuProvider p) => p.ChoosenOutletMenId);

        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Column(children: [
              SizedBox(
                width: 240,
                height: MediaQuery.sizeOf(context).height - 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('merchant')
                      .doc('X6odvQ5gqesAzwtJLaFl')
                      .collection('smartMenu')
                      .where('outletId', isEqualTo: choosenOutletId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // maxCrossAxisExtent: 300,
                                // childAspectRatio: 1,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Image.network(
                                    doc['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    // outletImageUrl = doc['image'];
                                    // print(outletImageUrl);
                                    context.read<MenuProvider>().setImportImage(
                                        doc['fileName'],
                                        doc['image'],
                                        doc['type'],
                                        doc['name']);
                                  });
                                },
                              ),
                              Text(doc['name'])
                            ],
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  getMenuView() {
    return StatefulBuilder(
      builder: (context, setState) {
        final url = context.select((MenuProvider p) => p.importImage);
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: url.isEmpty
              ? const SizedBox(height: 500)
              : Center(
                  child: Container(
                    height: 500,
                    width: 500,
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        );
      },
    );
  }

  getMenuView2() {
    return StatefulBuilder(
      builder: (context, setState) {
        final url = context.select((MenuProvider p) => p.importImage);
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Visibility(
            visible: url != '',
            child: Center(
              child: Container(
                height: 500,
                width: 500,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
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
          // menuViewer()
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
                    borderColor: null,
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
                            borderColor: null,
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
                                .collection('smartMenu')
                                .doc(mID)
                                .update({
                              'name': menuNameUpdate.text,
                              'image':
                                  '$ipAddress/uploads/uploads/$menuUpdateUrl',
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
                            borderColor: null,
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
                        borderColor: null,
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
                        borderColor: null,
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
                            borderColor: null,
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
                                .collection('smartMenu')
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
                            borderColor: null,
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

  chooseOutlet() {
    showDialog(
      context: context,
      builder: (context) {
        final String importFileName =
            context.select((MenuProvider p) => p.importFileName);
        final String importImage =
            context.select((MenuProvider p) => p.importImage);
        final String importType =
            context.select((MenuProvider p) => p.importType);
        final String importMenuName =
            context.select((MenuProvider p) => p.importMenuName);

        importFilenamex = importFileName;
        importImagex = importImage;
        importTypex = importType;
        importMenuNamex = importMenuName;

        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Color(0xffef7700)),
              borderRadius: BorderRadius.circular(20.0)),
          title: DecoratedBox(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CHOOSE OUTLET',
                      style: TextStyle(
                          color: Color(0xffef7700),
                          fontWeight: FontWeight.bold)),
                  Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 14,
                      ),
                      onTap: () {
                        setState(() {
                          context
                              .read<MenuProvider>()
                              .setChoosenOutletMenId('');
                          context
                              .read<MenuProvider>()
                              .setImportImage('', '', '', '');
                          context.read<MenuProvider>().setChooseOutletIndex(-1);
                          context
                              .read<MenuProvider>()
                              .setChooseOutletIndexSelected(-1);
                        });

                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ]),
          ),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width - 300,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getOutletList(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 2,
                        color: Colors.grey.shade500,
                        height: MediaQuery.of(context).size.height - 200,
                      ),
                    ),
                    getOutletMenu2(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 2,
                          color: Colors.grey.shade500,
                          height: MediaQuery.of(context).size.height - 200),
                    ),
                    getMenuView2()
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          setState(() {
                            context.read<MenuProvider>().setImportImage(
                                importFileName,
                                importImage,
                                importType,
                                importMenuName);
                            Navigator.pop(context);
                          });
                        },
                        child: ButtonMenu(
                          text: 'IMPORT',

                          width: 150,
                          height: 35,
                          // backColor: const Color.fromARGB(255, 210, 69, 69),
                          backColor: importFilenamex != ''
                              ? [btnColorGreenLight, btnColorGreenDark]
                              : [btnColorGreyLight, btnColorGreyDark],
                          textColor: iconButtonTextColor,
                          borderColor: null,
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getOutletList() {
    return StatefulBuilder(
      builder: (context, setState) {
        final int indexOutletMenu =
            context.select((MenuProvider p) => p.chooseOutletIndex);
        final int indexOutletMenuSelected =
            context.select((MenuProvider p) => p.chooseOutletIndexSelected);

        int ind = 100;
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(children: [
            SizedBox(
              width: 300,
              height: MediaQuery.sizeOf(context).height - 200,
              child: ListView.builder(
                itemCount: outletClasss.length,
                itemBuilder: (context, index) {
                  print(index);
                  return MouseRegion(
                    onHover: (event) {
                      setState(() {
                        context
                            .read<MenuProvider>()
                            .setChooseOutletIndex(index);
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        context.read<MenuProvider>().setChooseOutletIndex(-1);
                      });
                    },
                    child: GestureDetector(
                      child: Container(
                        // margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: indexOutletMenuSelected == index
                                  ? [btnColorPurpleLight, btnColorPurpleDark]
                                  : indexOutletMenu == index
                                      ? [
                                          btnColorPurpleLight,
                                          btnColorPurpleDark
                                        ]
                                      : [btnColorGreyLight, btnColorGreyDark]),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                outletClasss[index].name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: Colors.white),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  outletClasss[index].location,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          print(outletClasss[index].id);
                          context
                              .read<MenuProvider>()
                              .setChooseOutletIndexSelected(index);
                          context
                              .read<MenuProvider>()
                              .setChoosenOutletMenId(outletClasss[index].id);

                          context
                              .read<MenuProvider>()
                              .setImportImage('', '', '', '');
                        });
                      },
                    ),
                  );
                },
              ),
            )
          ]),
        );
      },
    );
  }
}
