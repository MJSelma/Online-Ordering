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

  bool isClose = false;
  bool isSelected = false;
  int selectedIndex = -0;

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

      casesClass = casesClass..sort((a, b) => a.status.compareTo(b.status));
      if (casesClass.isEmpty) {
        casesClass = [];
      }
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
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
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
                  height: MediaQuery.sizeOf(context).height - 200,
                  width: 350,
                  child: ListView.builder(
                    itemCount: casesClass.length,
                    itemBuilder: (context, index) {
                      var statuscolor = Colors.red;
                      if (casesClass[index].status.toLowerCase() == 'active') {
                        statuscolor = Colors.green;
                      } else if (casesClass[index].status.toLowerCase() ==
                          'in-active') {
                        statuscolor = Colors.grey;
                      } else {
                        statuscolor = statuscolor;
                      }

                      DateTime date = casesClass[index].deteStart;

                      final dateFormated =
                          DateFormat('MMMM.dd hh:mm aaa').format(date);

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 15),
                        child: GestureDetector(
                          child: Card(
                            shape: Border.symmetric(
                                vertical: BorderSide(
                                    width: 1,
                                    color: isSelected == true &&
                                            selectedIndex == index
                                        ? _defaultColor
                                        : Colors.transparent)),
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
                                                width: 3, color: statuscolor),
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
                                              size: 16, color: statuscolor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    child: Text(
                                      'Submitted by: ${casesClass[index].customerName}',
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
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

                              print('${idx}888888888888888');
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: idx == ' ' ? false : true,
                child: Expanded(
                  child: Card(
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
                              print('${idx}99999999999999999999999999999999');
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    reverse: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot doc =
                                          snapshot.data!.docs[index];
                                      print(doc['date']);
                                      DateTime date =
                                          (doc['date'] as Timestamp).toDate();

                                      final dateFormated =
                                          DateFormat('MMMM.dd hh:mm aaa')
                                              .format(date);

                                      filex.File file =
                                          filex.File(doc['message']);
                                      String basename = pathx
                                          .basename(file.path.split('/').last);
                                      String name = '';
                                      if (doc['type'] == 'file') {
                                        var start =
                                            basename.lastIndexOf('/') + 11;
                                        var end = basename.indexOf('?');
                                        name = basename.substring(start, end);
                                      }

                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                doc['from'] == 'user'
                                                    ? CrossAxisAlignment.start
                                                    : CrossAxisAlignment.end,
                                            children: <Widget>[
                                              if (doc['type'] == 'file')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.red,
                                                        width: 0.1),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: (doc['from'] ==
                                                            'user'
                                                        ? Colors.grey.shade200
                                                        : const Color(
                                                            0xffbef7700)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        doc['from'] == 'user'
                                                            ? CrossAxisAlignment
                                                                .start
                                                            : CrossAxisAlignment
                                                                .end,
                                                    children: [
                                                      Text(
                                                        doc['from'] == 'user'
                                                            ? customerName
                                                            : agentName,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextButton.icon(
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            _launchInBrowser(
                                                                Uri.parse(doc[
                                                                    'message']));
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .picture_as_pdf,
                                                            size: 22,
                                                          ),
                                                          label: Text(name)),
                                                    ],
                                                  ),
                                                )
                                              else if (doc['type'] == 'image')
                                                GestureDetector(
                                                  child: Tooltip(
                                                    message: 'view',
                                                    child: (Image.network(
                                                      doc['message'],
                                                      height: 500,
                                                    )),
                                                  ),
                                                  onTap: () {
                                                    _launchInBrowser(Uri.parse(
                                                        doc['message']));
                                                  },
                                                )
                                              else
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.red,
                                                        width: 0.1),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: (doc['from'] ==
                                                            'user'
                                                        ? Colors.grey.shade200
                                                        : const Color(
                                                            0xffbef7700)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        doc['from'] == 'user'
                                                            ? CrossAxisAlignment
                                                                .start
                                                            : CrossAxisAlignment
                                                                .end,
                                                    children: [
                                                      Text(
                                                        doc['from'] == 'user'
                                                            ? customerName
                                                            : agentName,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        doc['message'],
                                                        style: TextStyle(
                                                            color:
                                                                doc['from'] ==
                                                                        'user'
                                                                    ? Colors
                                                                        .black54
                                                                    : Colors
                                                                        .white,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              Text(
                                                dateFormated,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                        contentPadding: EdgeInsets.all(10.0),
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
                                      await CasesController().insertMessages(
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
