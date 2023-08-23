import 'package:drinklinkmerchant/ui/merchant/merchant.dart';
import 'package:drinklinkmerchant/ui/messages/message.dart';
import 'package:drinklinkmerchant/ui/products/products.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../provider/casesMessagesProvider.dart';
import 'cases/cases.dart';
import 'cases/casesMessages.dart';
import 'cases/cases_menu.dart';

enum Options { cases, exit }

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int indexMenu = 0;
  bool showChat = false;

  var _popupMenuItemIndex = 0;
  Color _changeColorAccordingToMenuItem = Colors.red;
  var appBarHeight = AppBar().preferredSize.height;

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: const Color(0xffbef7700),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == Options.cases.index) {
      _changeColorAccordingToMenuItem = Colors.red;
      print('cases');
      setState(() {
        indexMenu = 6;
        // showChat = false;
      });
    } else {
      _changeColorAccordingToMenuItem = Colors.purple;
    }
  }

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
                      const Column(
                        children: [
                          Text(
                            'DRINKLINK',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Color(0xffbef7700),
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
                      const Spacer(),
                      const Column(
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
                            'Lucas',
                            style: TextStyle(
                                fontFamily: 'SFPro',
                                color: Color(0xF8737474),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(113.0),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/user_sample.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: PopupMenuButton(
                            onSelected: (value) {
                              _onMenuItemSelected(value as int);
                            },
                            tooltip: '',
                            iconSize: 0.0,
                            offset: Offset(0.0, appBarHeight),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            itemBuilder: (ctx) => [
                              _buildPopupMenuItem(
                                  'My Cases', Icons.chat, Options.cases.index),
                              _buildPopupMenuItem(
                                  'New Buiseness', Icons.business, 3),
                              _buildPopupMenuItem(
                                  'New Manager', Icons.manage_accounts, 4),
                              _buildPopupMenuItem(
                                  'Settings', Icons.settings, 5),
                              _buildPopupMenuItem('Exit', Icons.exit_to_app,
                                  Options.exit.index),
                            ],
                          ))
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
                                        : const Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                        : const Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                        : const Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                        : const Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                        : const Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
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
                                        : const Color.fromARGB(255, 66, 64, 64),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (indexMenu == 0) ...[
                        const widgetWall()
                      ] else if (indexMenu == 1) ...[
                        const MerchantPage()
                      ] else if (indexMenu == 2) ...[
                        const ProductsPage()
                      ] else if (indexMenu == 6) ...[
                        const CasesMenu()
                      ] else if (indexMenu == 6) ...[
                        // CasesMessages(id: index.toString())
                      ] else ...[
                        const widgetWall()
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
                    color: const Color.fromARGB(137, 106, 105, 105),
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
                                child: const Icon(Icons.close),
                              ),
                            )
                          ],
                        ),
                        const MessagePage(
                          caseId: '01',
                          customerID: '01',
                        )
                      ]),
                    ),
                  )),
          ],
        ),
        floatingActionButton: Visibility(
          visible: !showChat,
          child: FloatingActionButton.small(
            onPressed: () {
              setState(() {
                showChat = true;
              });
            },
            backgroundColor: const Color(0xffef7700),
            child: const Icon(
              Icons.message,
            ),
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
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              'Order Your Best \nFood Anytime / Ads will show here also',
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 30,
                color: Color(0xff5b5957),
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const SizedBox(
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
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x29000000),
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
                const Row(
                  children: [],
                )
              ],
            ),
            const SizedBox(
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
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x29000000),
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
                const Row(
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
