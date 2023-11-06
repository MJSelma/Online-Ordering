import 'package:drinklinkmerchant/ui/consultation/consultation_menu.dart';
import 'package:drinklinkmerchant/ui/merchant/merchant.dart';
import 'package:drinklinkmerchant/ui/messages/message.dart';
import 'package:drinklinkmerchant/ui/products/products.dart';
import 'package:drinklinkmerchant/ui/smart_menu/smart_menu.dart';
import 'package:drinklinkmerchant/ui/smart_menu/smart_menu_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../provider/business_outlet_provider.dart';
import '../provider/cases_messages_provider.dart';
import '../provider/menu_provider.dart';
import '../widgets/menu_button.dart';
import 'cases/cases.dart';
import 'cases/cases_messages.dart';
import 'cases/cases_menu.dart';

import 'constant/theme_data.dart';
import 'data_class/businesses_class.dart';
import 'merchant/ouletMenu.dart';
import 'merchant/outlets.dart';
import 'merchant/sample.dart';

enum Options { cases, exit }

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool showChat = false;
  int indexMenu = 100;
  String currentItem = 'SELECT BUSINESS';
  String businessDocId = '';
  int smartMenuIndex = 0;

  BusinessesClass? dropDownValue;

  List<BusinessesClass> businessesClass = [];

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

  _getProvider(context) {
    final businessesData = Provider.of<List<BusinessesClass>>(context);
    businessesClass = businessesData;
  }

  List<DropdownMenuItem<BusinessesClass>> _createList() {
    return businessesClass
        .map<DropdownMenuItem<BusinessesClass>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Container(
              // color: Colors.grey[900],
              child: Center(
                child: Text(
                  e.name,
                  style: const TextStyle(
                    color: Color(0xffbef7700),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _getProvider(context);

    final businessProvider = context.read<BusinessOutletProvider>();
    bool isMenuOpen = context.select((MenuProvider p) => p.isMenuOpen);
    context.read<MenuProvider>().setIndexMenu(indexMenu);
    // int indexMenux = context.select((MenuProvider p) => p.indexMenu);
    // indexMenu = indexMenux;
    // int indexMenuHover = context.select((MenuProvider p) => p.indexMenuHover);
    // final businessProvider = Provider.of<BusinessOutletProvider>(context);

    final dropdown = DropdownButton<BusinessesClass>(
      items: _createList(),
      underline: const SizedBox(),
      iconSize: 0,
      isExpanded: false,
      borderRadius: BorderRadius.circular(20),
      hint: Center(
        child: MenuButton(
            text: currentItem,
            val: 0,
            iconMenu: Icons.business,
            height: 50,
            paddingLeft: 0),
      ),
      onChanged: (BusinessesClass? value) {
        setState(() {
          indexMenu = 0;

          businessDocId = value!.docId;
          currentItem = value.name;
          dropDownValue = value;
          businessProvider.setDocId(businessDocId);
          print(currentItem);
          businessProvider.setBusinessName(currentItem);
          businessProvider.setDefaultOutletId(value.defaultOutletId);
        });
      },
    );

    return Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/header.jpg'),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'DRINKLINK',
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  color: Color(0xffbef7700),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'MORE TIMES FOR FUN',
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  color: btnColorPurpleDark,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const Text(
                              'Welcome',
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  color: Color(0xF8737474),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              'GOODFUN HOSPITALITY ',
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  color: btnColorPurpleDark,
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
                                image: AssetImage('assets/images/Goodfun.jpg'),
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
                                _buildPopupMenuItem('My Cases', Icons.chat,
                                    Options.cases.index),
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height - 120,
                        child: RawScrollbar(
                          padding: const EdgeInsets.symmetric(vertical: 50.0),
                          // mainAxisMargin: 200.0,
                          thumbColor: btnColorPurpleLight,
                          // trackVisibility: true,
                          // trackColor: sys_color_white,
                          // trackBorderColor: btn_color_purplelight,
                          notificationPredicate: (notification) =>
                              notification.depth == 0,

                          interactive: true,

                          trackRadius: const Radius.circular(20.0),

                          thumbVisibility: true, //always show scrollbar
                          thickness: 10, //width of scrollbar
                          radius: const Radius.circular(
                              20), //corner radius of scrollbar
                          scrollbarOrientation: ScrollbarOrientation.right,

                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 40.0, 0.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexMenu = 0;
                                      });
                                    },
                                    child: isMenuOpen
                                        ? dropdown
                                        : MenuButton(
                                            text: currentItem,
                                            val: 0,
                                            iconMenu: Icons.business,
                                            height: 50,
                                            paddingLeft: 0),
                                  ),
                                  Visibility(
                                    visible: businessDocId != '',
                                    // visible: true,
                                    child: Column(
                                      children: [
                                        // const SizedBox(
                                        //   height: 12,
                                        // ),

                                        // const SizedBox(
                                        //   height: 4,
                                        // ),
                                        // Divider(thickness: 2, color: Colors.black, ),
                                        // const SizedBox(
                                        //   height: 4,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 8),
                                          child: Container(
                                            height: 2,
                                            color: Colors.black45,
                                            width: isMenuOpen ? 200 : 50,
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 4, 0, 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Choose one',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'SFPro',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 2;
                                              setIndexMenuNameProvider(
                                                  'CONSULTATION MENU');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'CONSULTATION MENU',
                                              val: 2,
                                              iconMenu: Icons.picture_as_pdf,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 3;
                                              setIndexMenuNameProvider(
                                                  'SMART MENU');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'SMART MENU',
                                              val: 3,
                                              iconMenu: Icons.menu_book_rounded,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (isMenuOpen)
                                          Visibility(
                                            visible: indexMenu == 3,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
                                                  border: Border.fromBorderSide(
                                                      BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              systemDefaultColorOrange))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                MenuProvider>()
                                                            .updateMenuCount(0);
                                                        smartMenuIndex = 0;
                                                        indexMenu = 13;
                                                      });
                                                    },
                                                    child: Text(
                                                      'WORKING STATIONS',
                                                      style: TextStyle(
                                                          color:
                                                              iconButtonTextColorPurple),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                MenuProvider>()
                                                            .updateMenuCount(1);
                                                        smartMenuIndex = 1;
                                                        indexMenu = 14;
                                                      });
                                                    },
                                                    child: Text(
                                                      'WORKTOPS',
                                                      style: TextStyle(
                                                          color:
                                                              iconButtonTextColorPurple),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                MenuProvider>()
                                                            .updateMenuCount(2);
                                                        smartMenuIndex = 2;
                                                        indexMenu = 15;
                                                      });
                                                    },
                                                    child: Text(
                                                      'SMART MENU',
                                                      style: TextStyle(
                                                          color:
                                                              iconButtonTextColorPurple),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 8),
                                          child: Container(
                                            height: 2,
                                            color: Colors.black45,
                                            width: isMenuOpen ? 200 : 50,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              setIndexMenuNameProvider('');
                                              context
                                                  .read<MenuProvider>()
                                                  .menuRefresh();
                                              indexMenu = 1;
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'TABLE BOOKINGS',
                                              val: 1,
                                              iconMenu: Icons.book,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 4;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'EXPLORE VENUE',
                                              val: 4,
                                              iconMenu: Icons.explore,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 5;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'EVENTS/WEEKLY \nPROGRAMS',
                                              val: 5,
                                              iconMenu: Icons.calendar_month,
                                              height: 50,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 6;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'MEDIA CONTENT',
                                              val: 6,
                                              iconMenu: Icons.image,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 7;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'EXPERIENCE',
                                              val: 7,
                                              iconMenu: Icons.history,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 8;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'YOUR ADS',
                                              val: 8,
                                              iconMenu:
                                                  Icons.branding_watermark,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 9;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'YOUR STAFF',
                                              val: 9,
                                              iconMenu: Icons.person_add,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 10;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'REPORT',
                                              val: 10,
                                              iconMenu:
                                                  Icons.bar_chart_outlined,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 11;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'PAYMENT',
                                              val: 11,
                                              iconMenu: Icons.payment,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              indexMenu = 12;
                                              setIndexMenuNameProvider('');
                                            });
                                          },
                                          child: MenuButton(
                                              text: 'BUSINESS CONTACT',
                                              val: 12,
                                              iconMenu:
                                                  Icons.contact_mail_rounded,
                                              height: 35,
                                              paddingLeft: 0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isMenuOpen = !isMenuOpen;
                                  context
                                      .read<MenuProvider>()
                                      .setIsMenuOpen(isMenuOpen);
                                });
                              },
                              child: Icon(
                                isMenuOpen
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_forward_ios,
                                color: const Color(0xffbef7700),
                              ),
                            ),
                          )
                        ],
                      ),
                      if (indexMenu == 0) ...[
                        const OutletsPage()
                      ] else ...[
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width - 300,
                                    child: const OutletMenu(),
                                  ),
                                ],
                              ),
                              if (indexMenu == 0) ...[
                                const OutletsPage()
                              ] else if (indexMenu == 1) ...[
                                const SamplePage()
                                // const MerchantPage()
                              ] else if (indexMenu == 2) ...[
                                const ConsultationMenu(),
                              ] else if (indexMenu == 3) ...[
                                SmartMenuPage()
                              ] else if (indexMenu == 13) ...[
                                SmartMenuPage()
                              ] else if (indexMenu == 14) ...[
                                SmartMenuPage()
                              ] else if (indexMenu == 15) ...[
                                SmartMenuPage()
                              ] else if (indexMenu == 6) ...[
                                const CasesMenu()
                              ] else ...[
                                // const widgetWall()
                              ],
                            ],
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ]),
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
                  ))
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

  setIndexMenuNameProvider(String name) {
    context.read<BusinessOutletProvider>().setIndexPageName(name);
  }
}

//   Widget MenuButton(String text, int val, IconData iconMenu, double height,
//       double paddingLeft) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
//       child: MouseRegion(
//         onHover: (event) {
//           setState(() {
//             indexMenuHover = val;
//           });
//         },
//         onExit: (event) {
//           indexMenuHover = 100;
//         },
//         child: Container(
//           width: isMenuOpen ? 200 : 50,
//           height: height,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: indexMenu == val
//                 ? const Color(0xffef7700)
//                 : indexMenuHover == val
//                     ? const Color(0xffef7700)
//                     : Colors.grey.shade200,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
//                 child: Icon(
//                   iconMenu,
//                   color: indexMenu == val
//                       ? Colors.white
//                       : indexMenuHover == val
//                           ? Colors.white
//                           : const Color.fromARGB(255, 66, 64, 64),
//                 ),
//               ),
//               Visibility(
//                 visible: isMenuOpen,
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     fontFamily: 'SFPro',
//                     fontSize: 18,
//                     color: indexMenu == val
//                         ? Colors.white
//                         : indexMenuHover == val
//                             ? Colors.white
//                             : const Color.fromARGB(255, 66, 64, 64),
//                     fontWeight: FontWeight.w500,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class widgetWall extends StatelessWidget {
//   const widgetWall({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width - 280,
//           height: 150,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30.0),
//             color: const Color(0xffe9f9fc),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0x29000000),
//                 offset: Offset(0, 3),
//                 blurRadius: 6,
//               ),
//             ],
//           ),
//           child: const Padding(
//             padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
//             child: Text(
//               'Order Your Best \nFood Anytime / Ads will show here also',
//               style: TextStyle(
//                 fontFamily: 'SF Pro',
//                 fontSize: 30,
//                 color: Color(0xff5b5957),
//                 fontWeight: FontWeight.w700,
//                 shadows: [
//                   Shadow(
//                     color: Color(0x29000000),
//                     offset: Offset(0, 3),
//                     blurRadius: 6,
//                   )
//                 ],
//               ),
//               textAlign: TextAlign.left,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 700,
//                   height: 500,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(55.0),
//                     color: const Color(0xfffafafa),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color(0x29000000),
//                         offset: Offset(0, 3),
//                         blurRadius: 6,
//                       ),
//                     ],
//                   ),
//                   child: Image.asset(
//                     'assets/images/wall_sample.png',
//                     width: 600,
//                     height: 450,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 const Row(
//                   children: [],
//                 )
//               ],
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 400,
//                   height: 400,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(55.0),
//                     color: const Color(0xfffafafa),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color(0x29000000),
//                         offset: Offset(0, 3),
//                         blurRadius: 6,
//                       ),
//                     ],
//                   ),
//                   child: Image.asset(
//                     'assets/images/ads_sample.png',
//                     width: 600,
//                     height: 450,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 const Row(
//                   children: [],
//                 )
//               ],
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
