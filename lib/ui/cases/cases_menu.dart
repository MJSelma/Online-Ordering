import 'dart:html';
import 'dart:io';
import 'dart:io' as filex;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/cases_controller.dart';
import '../data_class/cases_class.dart';
import '../data_class/cases_messages_class.dart';
import 'package:path/path.dart' as pathx;

class CasesMenu extends StatefulWidget {
  const CasesMenu({super.key});

  @override
  State<CasesMenu> createState() => _CasesMenuState();
}

class _CasesMenuState extends State<CasesMenu> {
  String idx = ' ';
  String customerName = '';
  String agentName = '';
  String query = '';
  String imageUrl = '';
  String pageName = '';

  bool isClose = false;
  bool isSelected = false;
  int selectedIndex = -0;
  int tabindex = 1;
  int pageIndex = 1;

  var statuscolor = Colors.red;

  final _defaultColor = const Color(0xffbef7700);

  final TextEditingController txtSendMesasge = TextEditingController();

  final TextEditingController txtsearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final casesCollection = FirebaseFirestore.instance.collection('cases');

    List<CasesClass> casesClass = [];
    List<CasesMessagesClass> casesMessagesClass = [];

    var txtStyle = const TextStyle(fontSize: 12);

    _getProvider(BuildContext context) {
      final caseClasss = Provider.of<List<CasesClass>>(context);
      if (query.isNotEmpty) {
        casesClass = caseClasss
            .where((item) =>
                item.caseId.contains(query) ||
                item.customerName.contains(query) ||
                item.caseObjective.contains(query))
            .toList();
      } else {
        casesClass = caseClasss;
      }

      if (casesClass.isEmpty) {
        casesClass = [];
      }
      casesClass = casesClass..sort((a, b) => a.status.compareTo(b.status));
    }

    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    _upload(String fileName, String types) async {
      print('ersult here');
      final url = await FirebaseStorage.instance
          .ref()
          .child('uploads/$fileName')
          .getDownloadURL();

      CasesController()
          .insertMessages(idx, 'agent', url, '01', 'dl01', 'unread', types);
    }

    uploadImage() async {
      FilePickerResult? result = await FilePickerWeb.platform.pickFiles();
      String types = '';
      if (result != null) {
        Uint8List? fileBytes = result.files.first.bytes;
        String fileName = result.files.first.name;
        double progress = 0;
        if (fileName.contains('.png')) {
          types = 'image';
        } else if (fileName.contains('.jpeg')) {
          types = 'image';
        } else if (fileName.contains('.jpg')) {
          types = 'image';
        } else if (fileName.contains('.pdf')) {
          types = 'file';
        }

        // Upload file
        FirebaseStorage.instance
            .ref('uploads/$fileName')
            .putData(fileBytes!)
            .snapshotEvents
            .listen((event) {
          switch (event.state) {
            case TaskState.running:
              progress = 100.0 * (event.bytesTransferred / event.totalBytes);
              if (progress == 100) {
                _upload(fileName, types);
              }
              print("Upload is $progress% complete.");
              break;
            case TaskState.paused:
              print("Upload is paused.");
              break;
            case TaskState.canceled:
              print("Upload was canceled");
              break;
            case TaskState.error:
              // Handle unsuccessful uploads
              break;
            case TaskState.success:
              // Handle successful uploads on complete
              // ...
              break;
          }
        });
      }
    }

    _getProvider(context);

    return Expanded(
      child: Column(
        children: [
          Visibility(
            visible: true,
            child: TextField(
              decoration: InputDecoration(
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: _defaultColor),
                // ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _defaultColor),
                ),
                // border: UnderlineInputBorder(
                //   borderSide: BorderSide(color: _defaultColor),
                // ),
                hintText: 'Search',
              ),
              controller: txtsearch,
              onChanged: (value) {
                setState(() {
                  query = value;
                  idx = ' ';
                  isSelected = false;
                  selectedIndex = -0;
                  tabindex = -0;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: pageIndex == 2,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_left),
                    onTap: () {
                      setState(() {
                        pageIndex = -0;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Text(pageName),
                  onTap: () {
                    setState(() {
                      pageIndex = -0;
                    });
                  },
                )
              ],
            ),
          ),
          if (pageIndex == 1)
            (Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    print('inside the onNotification');
                    if (scrollNotification.metrics.axisDirection ==
                        AxisDirection.down) {
                      setState(() {
                        print('scrolled down');
                      });

                      //the setState function
                    } else {
                      if (scrollNotification.metrics.axisDirection ==
                          AxisDirection.up) {}
                      setState(() {
                        print('scrolled up');
                      });
                      //setState function
                    }
                    return true;
                  },
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height - 250,
                    width: 350,
                    child: ListView.builder(
                      itemCount: casesClass.length,
                      itemBuilder: (context, index) {
                        var statuscolorx = Colors.red;
                        if (casesClass[index].status.toLowerCase() ==
                            'active') {
                          statuscolorx = Colors.green;
                        } else if (casesClass[index].status.toLowerCase() ==
                            'in-active') {
                          statuscolorx = Colors.grey;
                        } else {
                          statuscolorx = statuscolorx;
                        }

                        DateTime date = casesClass[index].deteStart;

                        final dateFormated =
                            DateFormat('MMMM.dd hh:mm aaa').format(date);

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 30, 15),
                          child: GestureDetector(
                            child: Card(
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                //<-- SEE HERE
                                side: BorderSide(
                                  color: isSelected == true &&
                                          selectedIndex == index
                                      ? _defaultColor
                                      : Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              // shape: Borderr(
                              //     vertical: BorderSide(
                              //         width: 1,
                              //         color: isSelected == true &&
                              //                 selectedIndex == index
                              //             ? _defaultColor
                              //             : Colors.transparent)),
                              color: Colors.grey.shade50,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: statuscolorx),
                                              borderRadius:
                                                  BorderRadius.circular(113.0),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    casesClass[index]
                                                        .customerImage),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(casesClass[index].status),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            alignment: Alignment.topRight,
                                            child: Icon(Icons.circle,
                                                size: 16, color: statuscolorx),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Text(
                                        casesClass[index].customerName,
                                        style: txtStyle,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      child: Text(
                                        'Case no.: ${casesClass[index].caseId}',
                                        style: txtStyle,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      child: Text(
                                        'Date submitted: $dateFormated',
                                        style: txtStyle,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      child: Text(
                                        'Objective: ${casesClass[index].caseObjective}',
                                        style: txtStyle,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Container(
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Tooltip(
                                          //     message: 'Previous Agent',
                                          //     child: GestureDetector(
                                          //       child: Icon(Icons.support_agent,
                                          //           color: _defaultColor),
                                          //       onTap: () {
                                          //         print('Previous Agent');
                                          //       },
                                          //     ),
                                          //   ),
                                          // ),
                                          // const Spacer(),
                                          Container(
                                            child: TextButton.icon(
                                                onPressed: () {
                                                  print('Forward');
                                                },
                                                icon: Icon(Icons.forward,
                                                    size: 16,
                                                    color: _defaultColor),
                                                label: Text(
                                                  'Forward',
                                                  style: TextStyle(
                                                      color: _defaultColor,
                                                      fontSize: 12),
                                                )),
                                          ),
                                          Container(
                                            child: TextButton.icon(
                                                onPressed: () {
                                                  print('Cloase case');
                                                },
                                                icon: Icon(Icons.close,
                                                    size: 16,
                                                    color: _defaultColor),
                                                label: Text(
                                                  'Close case',
                                                  style: TextStyle(
                                                      color: _defaultColor,
                                                      fontSize: 12),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () async {
                              String id = casesClass[index].id;
                              String customerNamex =
                                  casesClass[index].customerName;
                              String agentNamex = casesClass[index].agentName;
                              String statusx = casesClass[index].status;
                              String image = casesClass[index].customerImage;

                              setState(() {
                                tabindex = 1;
                                selectedIndex = index;
                                isSelected = true;
                                idx = id;
                                customerName = customerNamex;
                                agentName = agentNamex;
                                imageUrl = image;
                                if (statusx.toLowerCase() == 'close') {
                                  isClose = false;
                                } else {
                                  isClose = true;
                                }

                                if (casesClass[index].status.toLowerCase() ==
                                    'active') {
                                  statuscolor = Colors.green;
                                } else if (casesClass[index]
                                        .status
                                        .toLowerCase() ==
                                    'in-active') {
                                  statuscolor = Colors.grey;
                                } else {
                                  statuscolor = statuscolorx;
                                }

                                print('${idx}888888888888888');
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (tabindex == 1)
                  (Visibility(
                    visible: idx == ' ' ? false : true,
                    child: Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.grey.shade50,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height - 330,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('cases')
                                    .doc(idx)
                                    // .doc('GWbs43UG9oiZx60999Z5')
                                    .collection('messages')
                                    .orderBy('date', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  print(
                                      '${idx}99999999999999999999999999999999');
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        reverse: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot doc =
                                              snapshot.data!.docs[index];
                                          print(doc['date']);
                                          DateTime date =
                                              (doc['date'] as Timestamp)
                                                  .toDate();

                                          final dateFormated =
                                              DateFormat('MMMM.dd hh:mm aaa')
                                                  .format(date);

                                          filex.File file =
                                              filex.File(doc['message']);
                                          String basename = pathx.basename(
                                              file.path.split('/').last);
                                          String name = '';
                                          if (doc['type'] == 'file') {
                                            var start =
                                                basename.lastIndexOf('/') + 11;
                                            var end = basename.indexOf('?');
                                            name =
                                                basename.substring(start, end);
                                          }

                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    doc['from'] == 'user'
                                                        ? CrossAxisAlignment
                                                            .start
                                                        : CrossAxisAlignment
                                                            .end,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        doc['from'] == 'user'
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                    children: [
                                                      Visibility(
                                                        visible: doc['from']
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'user',
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 40),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                width: 3,
                                                                color:
                                                                    statuscolor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          113.0),
                                                              image:
                                                                  const DecorationImage(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                image: AssetImage(
                                                                    'assets/images/sample_logo.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      if (doc['type'] == 'file')
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // border: Border.all(
                                                            //     color: Colors.red,
                                                            //     width: 0.1),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                            color: (doc['from'] ==
                                                                    'user'
                                                                ? Colors.grey
                                                                    .shade200
                                                                : Colors
                                                                    .green[50]),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Column(
                                                            crossAxisAlignment: doc[
                                                                        'from'] ==
                                                                    'user'
                                                                ? CrossAxisAlignment
                                                                    .start
                                                                : CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              // Text(
                                                              //   doc['from'] ==
                                                              //           'user'
                                                              //       ? customerName
                                                              //       : agentName,
                                                              //   style: const TextStyle(
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .bold,
                                                              //       color: Colors
                                                              //           .blue),
                                                              // ),
                                                              // const SizedBox(
                                                              //   height: 10,
                                                              // ),
                                                              TextButton.icon(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .black87,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    _launchInBrowser(
                                                                        Uri.parse(
                                                                            doc['message']));
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .picture_as_pdf,
                                                                    size: 22,
                                                                  ),
                                                                  label: Text(
                                                                      name)),
                                                              Text(
                                                                dateFormated,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: doc['from'] ==
                                                                            'user'
                                                                        ? Colors
                                                                            .black54
                                                                        : Colors
                                                                            .black87,
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      else if (doc['type'] ==
                                                          'image')
                                                        GestureDetector(
                                                          child: Tooltip(
                                                            message: 'view',
                                                            child:
                                                                (Image.network(
                                                              doc['message'],
                                                              height: 500,
                                                            )),
                                                          ),
                                                          onTap: () {
                                                            _launchInBrowser(
                                                                Uri.parse(doc[
                                                                    'message']));
                                                          },
                                                        )
                                                      else
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // border: Border.all(
                                                            //     color: Colors.red,
                                                            //     width: 0.1),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                            color: (doc['from'] ==
                                                                    'user'
                                                                ? Colors.grey
                                                                    .shade200
                                                                : Colors
                                                                    .green[50]),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Column(
                                                            crossAxisAlignment: doc[
                                                                        'from'] ==
                                                                    'user'
                                                                ? CrossAxisAlignment
                                                                    .start
                                                                : CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              // Text(
                                                              //   doc['from'] ==
                                                              //           'user'
                                                              //       ? customerName
                                                              //       : agentName,
                                                              //   style: const TextStyle(
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .bold,
                                                              //       color: Colors
                                                              //           .blue),
                                                              // ),
                                                              // const SizedBox(
                                                              //   height: 10,
                                                              // ),
                                                              Text(
                                                                doc['message'],
                                                                style: TextStyle(
                                                                    color: doc['from'] ==
                                                                            'user'
                                                                        ? Colors
                                                                            .black54
                                                                        : Colors
                                                                            .black87,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                dateFormated,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: doc['from'] ==
                                                                            'user'
                                                                        ? Colors
                                                                            .black54
                                                                        : Colors
                                                                            .black87,
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return const Text("No data");
                                  }
                                },
                              ),
                            ),
                            Visibility(
                                visible: isClose,
                                child: const Divider(height: 25.0)),
                            Visibility(
                              visible: isClose,
                              child: Container(
                                // decoration:
                                //     BoxDecoration(
                                //       color: Theme.of(context).),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        tooltip: 'Upload image',
                                        icon: Icon(
                                          Icons.folder_rounded,
                                          color: _defaultColor,
                                        ),
                                        onPressed: () async {
                                          print('select images');
                                          uploadImage();
                                        },
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: txtSendMesasge,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.all(10.0),
                                            hintText: 'Type a message...',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Send',
                                        icon: Icon(
                                          Icons.send,
                                          color: _defaultColor,
                                        ),
                                        onPressed: () async {
                                          print(
                                              '----------------------------id here');
                                          print(idx);
                                          await CasesController()
                                              .insertMessages(
                                                  idx,
                                                  'agent',
                                                  txtSendMesasge.text,
                                                  '01',
                                                  'dl01',
                                                  'unread',
                                                  'text');
                                          txtSendMesasge.text = '';
                                          casesMessagesClass.clear();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              ],
            ))
          else
            Row(
              children: [
                (Expanded(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    // width: MediaQuery.sizeOf(context).width / 1.2,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffef7700),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Center(
                                child: Text('Image',
                                    style: TextStyle(
                                      color: Colors.white,
                                      height: 3.0,
                                      fontSize: 15.2,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )),
                              Expanded(
                                  child: Center(
                                child: Text('Merchants',
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
                                child: Text('Country',
                                    style: TextStyle(
                                      color: Colors.white,
                                      height: 3.0,
                                      fontSize: 15.2,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )),
                              // Expanded(
                              //     child: Center(
                              //   child: Text('Case number',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         height: 3.0,
                              //         fontSize: 15.2,
                              //         fontWeight: FontWeight.bold,
                              //       )),
                              // )),
                              // Expanded(
                              //     child: Center(
                              //   child: Text('Date start',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         height: 3.0,
                              //         fontSize: 15.2,
                              //         fontWeight: FontWeight.bold,
                              //       )),
                              // )),
                              // Expanded(
                              //     child: Center(
                              //   child: Text('Type',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         height: 3.0,
                              //         fontSize: 15.2,
                              //         fontWeight: FontWeight.bold,
                              //       )),
                              // )),
                              // Expanded(
                              //     child: Center(
                              //   child: Text('Objective',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         height: 3.0,
                              //         fontSize: 15.2,
                              //         fontWeight: FontWeight.bold,
                              //       )),
                              // )),
                              // Expanded(
                              //     child: Center(
                              //   child: Text('Status',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         height: 3.0,
                              //         fontSize: 15.2,
                              //         fontWeight: FontWeight.bold,
                              //       )),
                              // )),
                              // Expanded(
                              //     child: Center(
                              //   child: Text('Agent number',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         height: 3.0,
                              //         fontSize: 15.2,
                              //         fontWeight: FontWeight.bold,
                              //       )),
                              // )),
                              Expanded(
                                  child: Center(
                                child: Text('',
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
                            // itemCount: casesClass.length,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              final startDateConverted = DateFormat('yMMMMd')
                                  .format(casesClass[index].deteStart);
                              final endDateConverted = DateFormat('yMMMMd')
                                  .format(casesClass[index].dateEnd);
                              return Container(
                                // color: colorrow == 0 ? Colors.grey : Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Center(
                                          child: Image.asset(
                                            'assets/images/sample_logo.png',
                                            height: 54,
                                          ),
                                        )),
                                        const Expanded(
                                          child: Center(
                                            child: Text(
                                              'Coffe Project Corporation',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Center(
                                            child: Text(
                                              'Coffe Shop',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Center(
                                            child: Text(
                                              'Philippines',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        // Expanded(
                                        //     child: Center(
                                        //         child: Text(
                                        //   casesClass[index].caseId,
                                        //   style: const TextStyle(fontSize: 12),
                                        // ))),
                                        // Expanded(
                                        //   child: Center(
                                        //     child: Text(
                                        //       startDateConverted.toString(),
                                        //       style:
                                        //           const TextStyle(fontSize: 12),
                                        //     ),
                                        //   ),
                                        // ),

                                        // Expanded(
                                        //     child: Center(
                                        //         child: Text(
                                        //   casesClass[index].caseType,
                                        //   style: const TextStyle(fontSize: 12),
                                        // ))),
                                        // Expanded(
                                        //     child: Center(
                                        //         child: Text(
                                        //   casesClass[index].caseObjective,
                                        //   style: const TextStyle(fontSize: 12),
                                        // ))),

                                        // Expanded(
                                        //     child: Center(
                                        //         child: Text(
                                        //   casesClass[index].status,
                                        //   style: const TextStyle(fontSize: 12),
                                        // ))),
                                        // Expanded(
                                        //     child: Center(
                                        //         child: Text(
                                        //   casesClass[index].agentId,
                                        //   style: const TextStyle(fontSize: 12),
                                        // ))),
                                        Expanded(
                                          child: SizedBox(
                                            height: 30,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xffef7700),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          pageIndex = 1;
                                                          pageName =
                                                              'Coffe Project Corporation';
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Open',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                )

                                                // FloatingActionButton.small(
                                                //   backgroundColor:
                                                //       const Color(0xffef7700),
                                                //   tooltip: 'Open',
                                                //   onPressed: () async {
                                                //     casesMessagesClass.clear();
                                                //     String id =
                                                //         casesClass[index].id;
                                                //     String cid =
                                                //         casesClass[index]
                                                //             .caseId;
                                                //     String objective =
                                                //         casesClass[index]
                                                //             .caseObjective;

                                                //     setState(() {});
                                                //     // Navigator.pushReplacement(
                                                //     //     context,
                                                //     //     MaterialPageRoute(
                                                //     //       builder: (context) =>
                                                //     //           const CasesMessages(),
                                                //     //     ));
                                                //   },
                                                //   child: const Icon(
                                                //     Icons.open_with,
                                                //     color: Colors.white,
                                                //     size: 14,
                                                //   ),
                                                // ),
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
                        //   child: ListView.builder(
                        //     itemCount: casesMessagesClass.length,
                        //     itemBuilder: (context, index) {
                        //       print('cases MEssages Listt');
                        //       print(casesMessagesClass.length);
                        //       return Expanded(
                        //         child: Column(
                        //           crossAxisAlignment:
                        //               casesMessagesClass[index].from == 'user'
                        //                   ? CrossAxisAlignment.start
                        //                   : CrossAxisAlignment.end,
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 Expanded(
                        //                     child:
                        //                         Text(casesMessagesClass[index].messages)),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
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
                )),
              ],
            )
        ],
      ),
    );
  }
}
