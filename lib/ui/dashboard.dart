import 'package:drinklinkmerchant/ui/merchant/merchant.dart';
import 'package:drinklinkmerchant/ui/messages/message.dart';
import 'package:drinklinkmerchant/ui/products/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int indexMenu = 0;
  bool showChat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'DRINKLINK',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Color(0xFFBEF7700),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'marketing words here',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Color.fromRGBO(115, 115, 114, 0.976),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Color(0xF8737474),
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            'John Custom',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Color(0xF8737474),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(113.0),
                          image: DecorationImage(
                            image: const AssetImage(
                                'assets/images/user_sample.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                indexMenu = 0;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: indexMenu == 0
                                    ? const Color(0xffef7700)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Your wall',
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18,
                                    color: indexMenu == 0
                                        ? Colors.white
                                        : Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                indexMenu = 1;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: indexMenu == 1
                                    ? const Color(0xffef7700)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Merchant',
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18,
                                    color: indexMenu == 1
                                        ? Colors.white
                                        : Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                indexMenu = 2;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: indexMenu == 2
                                    ? const Color(0xffef7700)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Products',
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18,
                                    color: indexMenu == 2
                                        ? Colors.white
                                        : Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                indexMenu = 3;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: indexMenu == 3
                                    ? const Color(0xffef7700)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Inventory',
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18,
                                    color: indexMenu == 3
                                        ? Colors.white
                                        : Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                indexMenu = 4;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: indexMenu == 4
                                    ? const Color(0xffef7700)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Reports',
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18,
                                    color: indexMenu == 4
                                        ? Colors.white
                                        : Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                indexMenu = 5;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: indexMenu == 5
                                    ? const Color(0xffef7700)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18,
                                    color: indexMenu == 5
                                        ? Colors.white
                                        : Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      if (indexMenu == 0) ...[
                        widgetWall()
                      ] else if (indexMenu == 1) ...[
                        MerchantPage()
                      ] else if (indexMenu == 2) ...[
                        ProductsPage()
                      ] else ...[
                        widgetWall()
                      ]
                    ],
                  ),
                )
              ],
            ),
            if (showChat)
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 400,
                    height: 500,
                    color: Color.fromARGB(137, 106, 105, 105),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: Column(children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showChat = false;
                                  });
                                },
                                child: Icon(Icons.close),
                              ),
                            )
                          ],
                        ),
                        MessagePage(caseId: '01',customerID: '01',)
                      ]),
                    ),
                  )),
          ],
        ),
        floatingActionButton: Visibility(
          visible: !showChat,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                showChat = true;
              });
            },
            backgroundColor: const Color(0xffef7700),
            child: const Icon(Icons.message),
          ),
        ));
  }
}

class widgetWall extends StatelessWidget {
  const widgetWall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 280,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color(0xffe9f9fc),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              'Order Your Best \nFood Anytime / Ads will show here also',
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 30,
                color: const Color(0xff5b5957),
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 700,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55.0),
                    color: const Color(0xfffafafa),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/wall_sample.png',
                    width: 600,
                    height: 450,
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  children: [],
                )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55.0),
                    color: const Color(0xfffafafa),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/ads_sample.png',
                    width: 600,
                    height: 450,
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  children: [],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
