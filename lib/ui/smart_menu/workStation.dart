import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:flutter/material.dart';

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
  bool showGraph = false;
  int stationMulMenu = 3;
  List<String> stations = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Smart Menu > Work Station',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SFPro',
                    fontSize: 20),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                          child: Icon(Icons.arrow_forward_ios)),
                    )),
                Visibility(
                  visible: showOrderingMenu,
                  child: SizedBox(
                    width: 250,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text('Choose one'),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showOrderingMenu = false;
                                    });
                                  },
                                  child: Icon(Icons.arrow_back_ios))
                            ],
                          ),
                          SizedBox(
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
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: const Text(
                                'Your Dguest will be able to order and/or pay from their smarthphones. Ideal fro clubs, Caffeteria, or small business'),
                          ),
                          SizedBox(
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
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: const Text(
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
                          child: Icon(Icons.arrow_forward_ios)),
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
                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    Text('Choose one'),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showStationMenu = false;
                                          });
                                        },
                                        child: Icon(Icons.arrow_back_ios))
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        stationMenu = 1;
                                      });
                                    },
                                    child: stationButton('One Station Required',
                                        1, Icons.payment, 50, 12, false)),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: const Text(
                                      'Your Dguest will be able to order and/or pay from their smarthphones. Ideal fro clubs, Caffeteria, or small business'),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        stationMenu = 2;
                                      });
                                    },
                                    child: stationButton(
                                        'Multiple Working Station',
                                        2,
                                        Icons.payment,
                                        50,
                                        12,
                                        false)),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: const Text(
                                      'Your waiters will be able to place order from their smarthphones'),
                                ),

                                //Multiple working
                                Divider(),
                                Visibility(
                                    visible: stationMenu == 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                stationMulMenu = 1;
                                              });
                                            },
                                            child: stationMultipleButton(
                                                'Create Master Station',
                                                1,
                                                Icons.payment,
                                                50,
                                                12,
                                                false)),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: const Text(
                                              'Having a Master Station will let your DGUESTS to order different menu categories Ex. Food & Drinks, which will be handled by different Working Stations. Ideal for Food-Courts, Restaurants, Bars, Caffetterias, Beach Clubs'),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                stationMulMenu = 2;
                                              });
                                            },
                                            child: stationMultipleButton(
                                                'Create Single Station',
                                                2,
                                                Icons.payment,
                                                50,
                                                12,
                                                false)),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: const Text(
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
                  visible: orderingMenu == 1,
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
                ] else
                  ...[]
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
                                    child: Icon(Icons.close_rounded))
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
                          Text(
                            'To use this feature you must pay \nthe premium account',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
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
                Text(
                    'Your Dguests will be able to order and/or pay from their smartphones. \nIdeal for Clubs, Caffeteria or small Businesses'),
                Spacer(),
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
              SizedBox(
                width: 150,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
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
                          decoration: InputDecoration.collapsed(hintText: '5'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Choose Service Option'),
                  ),
                  Container(
                    width: isSelfCollection || isServeCollection ? 380 : 250,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                  child: Row(
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
                              SizedBox(
                                height: 20,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Visibility(
                            visible: isSelfCollection || isServeCollection,
                            child: Column(
                              children: [
                                Text('Collection Instruction'),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffef7700))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Example: Please proceed to Drinklink Cube situated next to the cashier',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: isSelfCollection || isServeCollection ? 10 : 150,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Choose Payment Option'),
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
                                borderRadius: BorderRadius.circular(10.0),
                                color: !isOrderOnly
                                    ? const Color(0xffef7700)
                                    : Colors.grey.shade500,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                          SizedBox(
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
                                borderRadius: BorderRadius.circular(10.0),
                                color: isOrderOnly
                                    ? const Color(0xffef7700)
                                    : Colors.grey.shade500,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Pay Only',
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
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              SizedBox(
                width: 400,
              ),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: isActiveWst && isServeCollection == true ||
                          isSelfCollection == true
                      ? Colors.green[600]
                      : Colors.grey.withOpacity(.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Save',
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
                Text(
                    'Your Dguests will be able to order and/or pay from their smartphones. \nIdeal for Clubs, Caffeteria or small Businesses'),
                Spacer(),
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
              SizedBox(
                width: 150,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
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
                          decoration: InputDecoration.collapsed(hintText: '5'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
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
                        ? 'Create slave station'
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
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
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
                          decoration: InputDecoration.collapsed(
                              hintText: 'Station name'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
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
                  child: Row(
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

          SizedBox(
            width: 20,
          ),
          //List of station
          ListOfStation(),
          SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Choose Service Option'),
                  ),
                  Container(
                    width: isSelfCollection || isServeCollection ? 380 : 250,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                  child: Row(
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
                              SizedBox(
                                height: 20,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Visibility(
                            visible: isSelfCollection || isServeCollection,
                            child: Column(
                              children: [
                                Text('Collection Instruction'),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffef7700))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Example: Please proceed to Drinklink Cube situated next to the cashier',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: isSelfCollection || isServeCollection ? 10 : 150,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Choose Payment Option'),
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
                                borderRadius: BorderRadius.circular(10.0),
                                color: !isOrderOnly
                                    ? const Color(0xffef7700)
                                    : Colors.grey.shade500,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                          SizedBox(
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
                                borderRadius: BorderRadius.circular(10.0),
                                color: isOrderOnly
                                    ? const Color(0xffef7700)
                                    : Colors.grey.shade500,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Pay Only',
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
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              SizedBox(
                width: 400,
              ),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: isActiveWst && isServeCollection == true ||
                          isSelfCollection == true
                      ? Colors.green[600]
                      : Colors.grey.withOpacity(.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Save',
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
            ],
          )
        ],
      ),
    );
  }

  Widget ListOfStation() {
    return SizedBox(
      width: 300,
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
                      onTap: (){
                        setState(() {
                          stations.removeAt(index);
                        });
                      },child: Icon(Icons.close, color: const Color(0xffef7700),),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
