import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data_class/cases_class.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  int colorrow = 0;
  List<CasesClass> casesClass = [];

  @override
  Widget build(BuildContext context) {
    final caseClasss = Provider.of<List<CasesClass>>(context);
    casesClass = caseClasss.where((item) => item.customerId == '01').toList();
    if (casesClass.isEmpty) {
      casesClass = [];
    }
    print('aaaaaaaaaaaaaa');
    print(casesClass.length);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 1.5,
        width: MediaQuery.sizeOf(context).width / 1.3,
        child: Column(
          children: [
            Container(
              color: const Color(0xffef7700),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Center(
                    child: Text('Date Start',
                        style: TextStyle(
                          color: Colors.white,
                          height: 3.0,
                          fontSize: 15.2,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  Expanded(
                      child: Center(
                    child: Text('Date End',
                        style: TextStyle(
                          color: Colors.white,
                          height: 3.0,
                          fontSize: 15.2,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  Expanded(
                      child: Center(
                    child: Text('Name',
                        style: TextStyle(
                          color: Colors.white,
                          height: 3.0,
                          fontSize: 15.2,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  Expanded(
                      child: Center(
                    child: Text('Contact Number',
                        style: TextStyle(
                          color: Colors.white,
                          height: 3.0,
                          fontSize: 15.2,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
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
                  Expanded(
                      child: Center(
                    child: Text('Description',
                        style: TextStyle(
                          color: Colors.white,
                          height: 3.0,
                          fontSize: 15.2,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
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
                    child: Text('Conversation',
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
                  final startDateConverted =
                      DateFormat('yMMMMd').format(casesClass[index].deteStart);
                  final endDateConverted =
                      DateFormat('yMMMMd').format(casesClass[index].dateEnd);
                  return Container(
                    color: colorrow == 0 ? Colors.white : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  startDateConverted.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Center(
                                    child: Text(
                              (endDateConverted.toString()),
                              style: const TextStyle(fontSize: 12),
                            ))),
                            Expanded(
                                child: Center(
                                    child: Text(
                              casesClass[index].customerName,
                              style: const TextStyle(fontSize: 12),
                            ))),
                            Expanded(
                                child: Center(
                                    child: Text(
                              casesClass[index].customerContact,
                              style: const TextStyle(fontSize: 12),
                            ))),
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
                            Expanded(
                                child: Center(
                                    child: Text(
                              casesClass[index].caseDescription,
                              style: const TextStyle(fontSize: 12),
                            ))),
                            Expanded(
                                child: Center(
                                    child: Text(
                              casesClass[index].status,
                              style: const TextStyle(fontSize: 12),
                            ))),
                            Expanded(
                                child: Center(
                                    child: Text(
                              casesClass[index].agentName,
                              style: const TextStyle(fontSize: 12),
                            ))),
                            const Expanded(
                              child: FloatingActionButton.small(
                                backgroundColor: Color(0xffef7700),
                                tooltip: 'View conversation',
                                onPressed: null,
                                child: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                  size: 14,
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
    );
  }
}
