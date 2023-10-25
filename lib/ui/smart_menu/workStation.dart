import 'dart:convert';
import 'package:drinklinkmerchant/ui/consultation/menu_list.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/button.dart';
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
  bool isServeCollection = false;
  TextEditingController prepTime = TextEditingController(text: '');
  TextEditingController stationController = TextEditingController(text: '');

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
    isSelfCollection = false;
    isServeCollection = false;
    stations = [];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                  color: Colors.black87,
                  height: MediaQuery.of(context).size.height - 200,
                ),
                Visibility(
                    visible: !showOrderingMenu,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showOrderingMenu = true;
                            });
                          },
                          child: const Icon(Icons.arrow_forward_ios)),
                    )),
                Visibility(
                  visible: showOrderingMenu,
                  child: SizedBox(
                    width: 250,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              const Text('Choose one'),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showOrderingMenu = false;
                                    });
                                  },
                                  child: const Icon(Icons.arrow_back_ios))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  orderingMenu = 1;
                                });
                              },
                              child: myButton1('Self Ordering Menu', 1,
                                  Icons.payment, 50, 12, false)),
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                                'Your Dguest will be able to order and/or pay from their smarthphones. Ideal fro clubs, Caffeteria, or small business'),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  orderingMenu = 2;
                                });
                              },
                              child: myButton1('Serve Ordering Menu', 2,
                                  Icons.payment, 50, 12, false)),
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                                'Your waiters will be able to place order from their smarthphones'),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 2,
                    color: Colors.black87,
                    height: MediaQuery.of(context).size.height - 200,
                  ),
                ),
                Visibility(
                    visible: !showStationMenu,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showStationMenu = true;
                            });
                          },
                          child: const Icon(Icons.arrow_forward_ios)),
                    )),
                Visibility(
                  visible: orderingMenu == 1,
                  child: Visibility(
                    visible: showStationMenu,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    const Text('Choose one'),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showStationMenu = false;
                                          });
                                        },
                                        child: const Icon(Icons.arrow_back_ios))
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
                                    child: stationButton('One Station Required',
                                        1, Icons.payment, 50, 12, false)),
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                      'Your Dguest will be able to order and/or pay from their smarthphones. Ideal fro clubs, Caffeteria, or small business'),
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
                                    child: stationButton(
                                        'Multiple Working Station',
                                        2,
                                        Icons.payment,
                                        50,
                                        12,
                                        false)),
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                      'Your waiters will be able to place order from their smarthphones'),
                                ),

                                //Multiple working
                                const Divider(),
                                Visibility(
                                    visible: stationMenu == 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                stationMulMenu = 1;
                                                init();
                                              });
                                            },
                                            child: stationMultipleButton(
                                                'Create Master Station',
                                                1,
                                                Icons.payment,
                                                50,
                                                12,
                                                false)),
                                        const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                              'Having a Master Station will let your DGUESTS to order different menu categories Ex. Food & Drinks, which will be handled by different Working Stations. Ideal for Food-Courts, Restaurants, Bars, Caffetterias, Beach Clubs'),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                stationMulMenu = 2;
                                                init();
                                              });
                                            },
                                            child: stationMultipleButton(
                                                'Create Single Station',
                                                2,
                                                Icons.payment,
                                                50,
                                                12,
                                                false)),
                                        const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                              'Your Dguests will be able to choose and select which station will prepare their orders. Ideal for Bar, Pubs, Caffeterias, Clubs'),
                                        ),
                                      ],
                                    ))
                              ]),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 2,
                      color: Colors.black87,
                      height: MediaQuery.of(context).size.height - 200,
                    ),
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
              width: MediaQuery.of(context).size.width - 280,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
              width: MediaQuery.of(context).size.width - 280,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'To use this feature you must pay \nthe premium account',
                            style: TextStyle(fontSize: 20),
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
                                  child: myButton('Pay Now', 1, Icons.payment,
                                      50, 12, true))
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

  Widget myButton1(String text, int val, IconData iconMenu, double height,
      double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: orderingMenu == val
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
                  color: orderingMenu == val
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
                color: orderingMenu == val
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 600,
            child: Row(
              children: [
                const Text(
                    'Your Dguests will be able to order and/or pay from their smartphones. \nIdeal for Clubs, Caffeteria or small Businesses'),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isActiveWst = !isActiveWst;
                  });
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: isActiveWst
                        ? const Color(0xffef7700)
                        : Colors.grey.shade500,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        !isActiveWst ? 'Activate WST' : 'WST Activated',
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
              const SizedBox(
                width: 150,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Enter Average Preparation Time(mins)'),
                  ),
                  Container(
                    width: 80,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
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
                          decoration:
                              const InputDecoration.collapsed(hintText: '5'),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Choose Service Option'),
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Choose one or both'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelfCollection = !isSelfCollection;
                                  });
                                },
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: isSelfCollection
                                        ? const Color(0xffef7700)
                                        : Colors.grey.shade500,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Self Collection',
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
                                height: 20,
                              ),
                              Visibility(
                                visible: isSelfCollection,
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xffef7700),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Order and Pay',
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
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),

                          //ADD here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: isSelfCollection || isServeCollection ? 10 : 120,
              ),
              Visibility(
                visible: isSelfCollection || isServeCollection,
                child: Column(
                  children: [
                    const Text('Collection Instruction'),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffef7700))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Example: Please proceed to Drinklink Cube situated next to the cashier',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Visibility(
                    // visible: isSelfCollection,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 28,
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
                                const SizedBox(
                                  height: 26,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isServeCollection = !isServeCollection;
                                    });
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: isServeCollection
                                          ? const Color(0xffef7700)
                                          : Colors.grey.shade500,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Serve',
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
                                  height: 20,
                                ),
                                Visibility(
                                  visible: isServeCollection,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Choose one'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOrderOnly = !isOrderOnly;
                                            if (isOrderOnly) {
                                              isPayOrder = false;
                                            } else {
                                              isPayOrder = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: !isOrderOnly
                                                ? const Color(0xffef7700)
                                                : Colors.grey.shade500,
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Order and Pay',
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
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOrderOnly = !isOrderOnly;
                                            if (isOrderOnly) {
                                              isPayOrder = false;
                                            } else {
                                              isPayOrder = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: isOrderOnly
                                                ? const Color(0xffef7700)
                                                : Colors.grey.shade500,
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Order Only',
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
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            children: [
              const SizedBox(
                width: 400,
              ),
              GestureDetector(
                onTap: () {
                  if (isActiveWst && isServeCollection == true ||
                      isSelfCollection == true) {
                    context.read<MenuProvider>().updateMenuCount(1);
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: isActiveWst && isServeCollection == true ||
                            isSelfCollection == true
                        ? Colors.green[600]
                        : Colors.grey.withOpacity(.8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Go to Worktop',
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
            ],
          )
        ],
      ),
    );
  }

  Widget widgetMultipleStation() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 600,
            child: Row(
              children: [
                const Text(
                    'Your Dguests will be able to order and/or pay from their smartphones. \nIdeal for Clubs, Caffeteria or small Businesses'),
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isActiveWst = !isActiveWst;
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: isActiveWst
                          ? const Color(0xffef7700)
                          : Colors.grey.shade500,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          !isActiveWst ? 'Activate WST' : 'WST Activated',
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
                const SizedBox(
                  width: 150,
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Enter Average Preparation Time(mins)'),
                    ),
                    Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
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
                            decoration:
                                const InputDecoration.collapsed(hintText: '5'),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(stationMulMenu == 1
                        ? 'Create sub station'
                        : 'Create station'),
                  ),
                  Container(
                    width: 200,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
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
                          controller: stationController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Station name'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 150,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    stations.add(stationController.text);
                    stationController.text = '';
                  });
                },
                child: Container(
                  width: 100,
                  height: 50,
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
            ],
          ),

          const SizedBox(
            width: 20,
          ),
          //List of station
          ListOfStation(300),
          const SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Choose Service Option'),
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Choose one or both'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelfCollection = !isSelfCollection;
                                  });
                                },
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: isSelfCollection
                                        ? const Color(0xffef7700)
                                        : Colors.grey.shade500,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Self Collection',
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
                                height: 20,
                              ),
                              Visibility(
                                visible: isSelfCollection,
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xffef7700),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Order and Pay',
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
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),

                          //ADD here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: isSelfCollection || isServeCollection ? 10 : 120,
              ),
              Visibility(
                visible: isSelfCollection || isServeCollection,
                child: Column(
                  children: [
                    const Text('Collection Instruction'),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffef7700))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Example: Please proceed to Drinklink Cube situated next to the cashier',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Visibility(
                    // visible: isSelfCollection,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 28,
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
                                const SizedBox(
                                  height: 26,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isServeCollection = !isServeCollection;
                                    });
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: isServeCollection
                                          ? const Color(0xffef7700)
                                          : Colors.grey.shade500,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Serve',
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
                                  height: 20,
                                ),
                                Visibility(
                                  visible: isServeCollection,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Choose one'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOrderOnly = !isOrderOnly;
                                            if (isOrderOnly) {
                                              isPayOrder = false;
                                            } else {
                                              isPayOrder = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: !isOrderOnly
                                                ? const Color(0xffef7700)
                                                : Colors.grey.shade500,
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Order and Pay',
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
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOrderOnly = !isOrderOnly;
                                            if (isOrderOnly) {
                                              isPayOrder = false;
                                            } else {
                                              isPayOrder = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: isOrderOnly
                                                ? const Color(0xffef7700)
                                                : Colors.grey.shade500,
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Order Only',
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
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              const SizedBox(
                width: 400,
              ),
              GestureDetector(
                onTap: () {
                  if (isActiveWst && isServeCollection == true ||
                      isSelfCollection == true) {
                    context.read<MenuProvider>().updateMenuCount(1);
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: stations.isNotEmpty &&
                            isActiveWst &&
                            isServeCollection == true &&
                            isSelfCollection == true
                        ? Colors.green[600]
                        : Colors.grey.withOpacity(.8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Go to Worktop',
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
            ],
          )
        ],
      ),
    );
  }

  Widget ListOfStation(double width) {
    return SizedBox(
      width: width,
      height: 100,
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
                controller: stationController,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Station Name'),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              stations.add(stationController.text);
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
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                width: 400,
                child: const ConsultMenuPage(),
              ),
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
