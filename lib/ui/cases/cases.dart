import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as pathx;

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../provider/casesMessagesProvider.dart';
import '../controller/casesMessages_controller.dart';
import '../controller/cases_controller.dart';
import '../data_class/cases_class.dart';
import '../data_class/cases_messages_class.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';

import 'casesMessages.dart';

enum Options { forward, take }

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  final casesCollection = FirebaseFirestore.instance.collection('cases');

  int colorrow = 0;
  List<CasesClass> casesClass = [];
  List<CasesMessagesClass> casesMessagesClass = [];
  final TextEditingController _txtSendMesasge = TextEditingController();
  String downloadurl = '';
  bool isOpenMessages = false;
  String idx = '';
  String type = '';
  bool isRefresh = false;
  String cidx = '';
  String objectivex = '';

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

  getCasesMessages(String id) async {
    print(id);

    await casesCollection
        .doc(id)
        .collection('messages')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var item in snapshot.docs) {
        CasesMessagesClass temp = CasesMessagesClass(
            date: item['date'].toDate(),
            from: item['from'] ?? '',
            messages: item['message'] ?? '',
            receiver: item['receiver'] ?? '',
            sender: item['sender'] ?? '',
            status: item['status'] ?? '',
            type: item['type'] ?? '');

        casesMessagesClass.add(temp);
      }
    });
    casesMessagesClass = casesMessagesClass
      ..sort((a, b) => b.date.compareTo(a.date));

    print('-------------------casesMessagesClass');
    print(casesMessagesClass.length);
  }

  // getCasesMessages(String id) async {
  //   await casesCollection
  //       .doc(id)
  //       .collection('messages')
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     for (var item in snapshot.docs) {
  //       CasesMessagesClass temp = CasesMessagesClass(
  //           date: item['date'].toDate(),
  //           from: item['from'] ?? '',
  //           messages: item['message'] ?? '',
  //           receiver: item['receiver'] ?? '',
  //           sender: item['sender'] ?? '',
  //           status: item['status'] ?? '',
  //           type: item['type'] ?? '');

  //       casesMessagesClass.add(temp);
  //     }
  //   });
  // }

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

  _getProvider(BuildContext context) {
    final caseClasss = Provider.of<List<CasesClass>>(context);
    casesClass = caseClasss;
    // casesClass = caseClasss.where((item) => item.customerId == '01').toList();
    if (casesClass.isEmpty) {
      casesClass = [];
    }

    // for (var item in casesClass) {
    //   casesMessagesClass = item.casesMessagesClass;
    //   print(item.casesMessagesClass.length);
    // }
    // print('casesMessagesClass');

    // casesMessagesClass = [];
    // final caseMessagesClasss = Provider.of<List<CasesMessagesClass>>(context);
    // casesMessagesClass =
    //     caseMessagesClasss.where((item) => item.sender == 'dl1').toList();
    // if (casesMessagesClass.isEmpty) {
    //   casesMessagesClass = [];
    // }
  }

  _upload(String fileName, String types) async {
    print('ersult here');
    final url = await FirebaseStorage.instance
        .ref()
        .child('uploads/$fileName')
        .getDownloadURL();

    CasesController()
        .insertMessages(idx, 'agent', url, '01', 'dl01', 'unread', types);
    getCasesMessages(idx);
  }

  uploadImage() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles(); for android

    // for web
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

      // final url = await FirebaseStorage.instance
      //     .ref()
      //     .child('uploads/$fileName')
      //     .getDownloadURL();

      // print(url);
      // await CasesController()
      //     .insertMessages(idx, 'agent', url, '01', 'dl01', 'unread', types);
    }

    // FilePickerResult? result =
    //     await FilePickerWeb.platform.pickFiles(allowMultiple: true);

    // if (result != null) {
    //   List<File> files = result.paths.map((path) => File(path!)).toList();

    //   for (var item in files) {
    //     await FirebaseStorage.instance.ref('uploads/$item').putFile(item);
    //   }
    // } else {
    //   // User canceled the picker
    // }
  }

  @override
  Widget build(BuildContext context) {
    _getProvider(context);
    return Expanded(
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
                    child: Text('Agent number',
                        style: TextStyle(
                          color: Colors.white,
                          height: 3.0,
                          fontSize: 15.2,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  Expanded(
                      child: Center(
                    child: Text('Messages',
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
                                    // Container(
                                    //     width: 50,
                                    //     height: 50,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(113.0),
                                    //     ),
                                    //     child: PopupMenuButton(
                                    //       onSelected: (value) {
                                    //         _onMenuItemSelected(value as int);
                                    //       },
                                    //       tooltip: '',
                                    //       iconSize: 0.0,
                                    //       offset: const Offset(-50, -10),
                                    //       shape: const RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.only(
                                    //           bottomLeft:
                                    //               Radius.circular(8.0),
                                    //           bottomRight:
                                    //               Radius.circular(8.0),
                                    //           topLeft: Radius.circular(8.0),
                                    //           topRight: Radius.circular(8.0),
                                    //         ),
                                    //       ),
                                    //       itemBuilder: (ctx) => [
                                    //         _buildPopupMenuItem(
                                    //             'Forward',
                                    //             Icons.forward,
                                    //             Options.forward.index),
                                    //         // _buildPopupMenuItem('Take over',
                                    //         //     Icons.business, 3),
                                    //         // _buildPopupMenuItem('New Manager',
                                    //         //     Icons.manage_accounts, 4),
                                    //         // _buildPopupMenuItem('Settings',
                                    //         //     Icons.settings, 5),
                                    //         _buildPopupMenuItem(
                                    //             'Take over',
                                    //             Icons.get_app,
                                    //             Options.take.index),
                                    //       ],
                                    //       child: const FloatingActionButton
                                    //           .small(
                                    //         backgroundColor:
                                    //             Color(0xffef7700),
                                    //         tooltip: 'Settings',
                                    //         onPressed: null,
                                    //         child: Icon(
                                    //           Icons.settings,
                                    //           color: Colors.white,
                                    //           size: 14,
                                    //         ),
                                    //       ),
                                    //     )),
                                    FloatingActionButton.small(
                                      backgroundColor: const Color(0xffef7700),
                                      tooltip: 'View conversation',
                                      onPressed: () async {
                                        casesMessagesClass.clear();
                                        String id = casesClass[index].id;
                                        String cid = casesClass[index].caseId;
                                        String objective =
                                            casesClass[index].caseObjective;
                                        await getCasesMessages(id);
                                        setState(() {
                                          print('------------------id here 1');
                                          print(id);
                                          idx = id;
                                          cidx = cid;
                                          objectivex = objective;
                                          // _showCasesMessage();
                                          _showMessage();
                                        });
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const CasesMessages(),
                                        //     ));
                                      },
                                      child: const Icon(
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
    );
  }

  // _reloadMesasge(String cid) {
  //   print('sddsdsds');
  //   print(cid);
  //   if (casesMessagesClass.isEmpty) {
  //     casesMessagesClass = [];
  //   }

  //   casesMessagesClass.clear();
  //   casesClass = casesClass.where((item) => item.caseId == cid).toList();
  //   for (var i = 0; i < casesClass.length; i++) {
  //     for (var data in casesClass[i].casesMessagesClass) {
  //       CasesMessagesClass temp = CasesMessagesClass(
  //           date: data.date,
  //           from: data.from,
  //           messages: data.messages,
  //           receiver: data.receiver,
  //           sender: data.sender,
  //           status: data.status,
  //           type: data.type);

  //       casesMessagesClass.add(temp);
  //     }
  //   }
  //   print(casesMessagesClass.length);

  //   casesMessagesClass.sort((a, b) => b.date.compareTo(a.date));

  //   if (casesMessagesClass.isEmpty) {
  //     casesMessagesClass = [];
  //   }
  // }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildMessage(CasesMessagesClass message) {
    // final dateFormated = DateFormat('yMMMMd').format(message.date);
    final dateFormated = DateFormat('MMMM.dd hh:mm aaa').format(message.date);

    File file = File(message.messages);
    String basename = pathx.basename(file.path.split('/').last);
    String name = '';
    if (message.type == 'file') {
      var start = basename.lastIndexOf('/') + 11;
      var end = basename.indexOf('?');
      name = basename.substring(start, end);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: message.from == 'user'
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              message.from,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (message.type == 'file')
              Row(
                mainAxisAlignment: message.from == 'user'
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  (const Icon(
                    Icons.picture_as_pdf,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Tooltip(message: 'download', child: Text(name)),
                    onTap: () {
                      _launchInBrowser(Uri.parse(message.messages));
                    },
                  )
                ],
              )
            else if (message.type == 'image')
              GestureDetector(
                child: Tooltip(
                  message: 'view',
                  child: (Image.network(
                    message.messages,
                    height: 300,
                  )),
                ),
                onTap: () {
                  _launchInBrowser(Uri.parse(message.messages));
                },
              )
            else
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      (message.from == 'user' ? Colors.grey : Colors.blue[200]),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  message.messages,
                  style: const TextStyle(fontSize: 15),
                ),
              ),

            // else
            //   (Image.network(
            //     message.messages,
            //     // width: 40,
            //     height: 300,
            //     errorBuilder: (BuildContext context, Object exception,
            //         StackTrace? stackTrace) {
            //       return Text(message.messages);
            //     },
            //   )),

            Text(
              dateFormated,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
            ),
            // Image.network(
            //   message.messages,
            //   height: 120,
            // ),
          ],
        ),
      ),
    );
  }

  _showCasesMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width - 300,
            child: CasesMessages(
              idx: idx,
              caseId: cidx,
              objective: objectivex,
            ),
          ),
        );
      },
    );
  }

  _showMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int ind = 0;
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          // alignment: Alignment.center,
          child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width - 300,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffbef7700),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    // height: 65,

                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Case no. $cidx : Objective: $objectivex',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('cases')
                              .doc(idx)
                              .collection('messages')
                              .orderBy('date', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
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

                                    File file = File(doc['message']);
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
                                            Text(
                                              doc['from'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            if (doc['type'] == 'file')
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: (doc['from'] == 'user'
                                                      ? Colors.grey.shade200
                                                      : const Color(
                                                          0xffbef7700)),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: TextButton.icon(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      _launchInBrowser(
                                                          Uri.parse(
                                                              doc['message']));
                                                    },
                                                    icon: const Icon(
                                                      Icons.picture_as_pdf,
                                                      size: 22,
                                                    ),
                                                    label: Text(name)),
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
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: (doc['from'] == 'user'
                                                      ? Colors.grey.shade200
                                                      : const Color(
                                                          0xffbef7700)),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Text(
                                                  doc['message'],
                                                  style: TextStyle(
                                                      color:
                                                          doc['from'] == 'user'
                                                              ? Colors.black54
                                                              : Colors.white,
                                                      fontSize: 15),
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
                        )),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     child: ListView.builder(
                  //       reverse: true,
                  //       itemCount: casesMessagesClass.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return _buildMessage(casesMessagesClass[index]);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  const Divider(height: 25.0),
                  Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).cardColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Upload image',
                            icon: Icon(
                              Icons.upload,
                              color: Colors.redAccent[700],
                            ),
                            onPressed: () async {
                              print('select images');
                              uploadImage();

                              // if (uploadImage != '') {

                              // }
                            },
                            // onPressed: isLoaded ? null : onSendMessage,
                          ),
                          Expanded(
                            child: TextField(
                              // enabled: isLoaded == false ? true : false,
                              controller: _txtSendMesasge,
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
                              color: Colors.redAccent[700],
                            ),
                            onPressed: () async {
                              print('----------------------------id here');
                              print(idx);
                              await CasesController().insertMessages(
                                  idx,
                                  'agent',
                                  _txtSendMesasge.text,
                                  '01',
                                  'dl01',
                                  'unread',
                                  'text');
                              _txtSendMesasge.text = '';
                              casesMessagesClass.clear();
                              // _reloadMesasge(cid);
                              // _buildMessage(casesMessagesClass[ind]);
                            },

                            // onPressed: isLoaded ? null : onSendMessage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
