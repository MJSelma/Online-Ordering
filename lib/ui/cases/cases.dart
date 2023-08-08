import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data_class/cases_class.dart';

enum Options { forward, take }

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  int colorrow = 0;
  List<CasesClass> casesClass = [];

  final _popupMenuItemIndex = 0;
  final Color _changeColorAccordingToMenuItem = Colors.red;
  // var appBarHeight = AppBar().preferredSize.height;

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
    // setState(() {
    //   _popupMenuItemIndex = value;
    // });

    // if (value == Options.forward.index) {
    //   _changeColorAccordingToMenuItem = Colors.red;
    //   print('cases');
    //   setState(() {
    // indexMenu = 6;
    // showChat = false;
    //   });
    // } else {
    //   _changeColorAccordingToMenuItem = Colors.purple;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final caseClasss = Provider.of<List<CasesClass>>(context);
    casesClass = caseClasss;
    // casesClass = caseClasss.where((item) => item.customerId == '01').toList();
    if (casesClass.isEmpty) {
      casesClass = [];
    }
    print('aaaaaaaaaaaaaa');
    print(casesClass.length);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 1.5,
          // width: MediaQuery.sizeOf(context).width / 1.2,
          child: Column(
            children: [
              Container(
                color: const Color(0xffef7700),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Center(
                      child: Text('Case number',
                          style: TextStyle(
                            color: Colors.white,
                            height: 3.0,
                            fontSize: 15.2,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                    Expanded(
                        child: Center(
                      child: Text('Date start',
                          style: TextStyle(
                            color: Colors.white,
                            height: 3.0,
                            fontSize: 15.2,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                    // Expanded(
                    //     child: Center(
                    //   child: Text('Date End',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         height: 3.0,
                    //         fontSize: 15.2,
                    //         fontWeight: FontWeight.bold,
                    //       )),
                    // )),
                    // Expanded(
                    //     child: Center(
                    //   child: Text('Name',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         height: 3.0,
                    //         fontSize: 15.2,
                    //         fontWeight: FontWeight.bold,
                    //       )),
                    // )),
                    // Expanded(
                    //     child: Center(
                    //   child: Text('Contact no.',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         height: 3.0,
                    //         fontSize: 15.2,
                    //         fontWeight: FontWeight.bold,
                    //       )),
                    // )),
                    Expanded(
                        child: Center(
                      child: Text('Type',
                          style: TextStyle(
                            color: Colors.white,
                            height: 3.0,
                            fontSize: 15.2,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                    Expanded(
                        child: Center(
                      child: Text('Objective',
                          style: TextStyle(
                            color: Colors.white,
                            height: 3.0,
                            fontSize: 15.2,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                    // Expanded(
                    //     child: Center(
                    //   child: Text('Description',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         height: 3.0,
                    //         fontSize: 15.2,
                    //         fontWeight: FontWeight.bold,
                    //       )),
                    // )),
                    Expanded(
                        child: Center(
                      child: Text('Status',
                          style: TextStyle(
                            color: Colors.white,
                            height: 3.0,
                            fontSize: 15.2,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                    Expanded(
                        child: Center(
                      child: Text('Agent',
                          style: TextStyle(
                            color: Colors.white,
                            height: 3.0,
                            fontSize: 15.2,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                    Expanded(
                        child: Center(
                      child: Text('Action',
                          style: TextStyle(
                            color: Colors.white,
                            height: 3.0,
                            fontSize: 15.2,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: casesClass.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (colorrow == 0) {
                      colorrow = 1;
                    } else {
                      colorrow = 0;
                    }
                    final startDateConverted = DateFormat('yMMMMd')
                        .format(casesClass[index].deteStart);
                    final endDateConverted =
                        DateFormat('yMMMMd').format(casesClass[index].dateEnd);
                    return Container(
                      color: colorrow == 0 ? Colors.grey : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Center(
                                      child: Text(
                                casesClass[index].caseId,
                                style: const TextStyle(fontSize: 12),
                              ))),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    startDateConverted.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //     child: Center(
                              //         child: Text(
                              //   (endDateConverted.toString()),
                              //   style: const TextStyle(fontSize: 12),
                              // ))),
                              // Expanded(
                              //     child: Center(
                              //         child: Text(
                              //   casesClass[index].customerName,
                              //   style: const TextStyle(fontSize: 12),
                              // ))),
                              // Expanded(
                              //     child: Center(
                              //         child: Text(
                              //   casesClass[index].customerContact,
                              //   style: const TextStyle(fontSize: 12),
                              // ))),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                casesClass[index].caseType,
                                style: const TextStyle(fontSize: 12),
                              ))),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                casesClass[index].caseObjective,
                                style: const TextStyle(fontSize: 12),
                              ))),
                              // Expanded(
                              //     child: Center(
                              //         child: Text(
                              //   casesClass[index].caseDescription,
                              //   style: const TextStyle(fontSize: 12),
                              // ))),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                casesClass[index].status,
                                style: const TextStyle(fontSize: 12),
                              ))),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                casesClass[index].agentId,
                                style: const TextStyle(fontSize: 12),
                              ))),
                              Expanded(
                                child: SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(113.0),
                                          ),
                                          child: PopupMenuButton(
                                            onSelected: (value) {
                                              _onMenuItemSelected(value as int);
                                            },
                                            tooltip: '',
                                            iconSize: 0.0,
                                            offset: const Offset(-50, -10),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0),
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                              ),
                                            ),
                                            itemBuilder: (ctx) => [
                                              _buildPopupMenuItem(
                                                  'Forward',
                                                  Icons.forward,
                                                  Options.forward.index),
                                              // _buildPopupMenuItem('Take over',
                                              //     Icons.business, 3),
                                              // _buildPopupMenuItem('New Manager',
                                              //     Icons.manage_accounts, 4),
                                              // _buildPopupMenuItem('Settings',
                                              //     Icons.settings, 5),
                                              _buildPopupMenuItem(
                                                  'Take over',
                                                  Icons.get_app,
                                                  Options.take.index),
                                            ],
                                            child: const FloatingActionButton
                                                .small(
                                              backgroundColor:
                                                  Color(0xffef7700),
                                              tooltip: 'Settings',
                                              onPressed: null,
                                              child: Icon(
                                                Icons.settings,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                          )),
                                      const FloatingActionButton.small(
                                        backgroundColor: Color(0xffef7700),
                                        tooltip: 'View conversation',
                                        onPressed: null,
                                        child: Icon(
                                          Icons.message,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }, //itemBuilder
                ),
              ),
              // Expanded(
              //     child: Container(
              //   // color: Colors.amberAccent,
              //   alignment: Alignment.topRight,
              //   child: const Padding(
              //       padding: EdgeInsets.only(right: 40),
              //       child: Expanded(
              //         child: FloatingActionButton.small(
              //           backgroundColor: Color(0xffef7700),
              //           tooltip: 'create new case',
              //           onPressed: null,
              //           child: Icon(
              //             Icons.add,
              //             color: Colors.white,
              //             size: 14,
              //           ),
              //         ),
              //       )),
              // ))
            ],
          ),
        ),
      ),
    );
  }
}
