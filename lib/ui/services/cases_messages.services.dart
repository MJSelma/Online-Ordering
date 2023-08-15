import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_class/cases_messages_class.dart';

class CasesMessagesServices {
  var casesMessagesCollection = FirebaseFirestore.instance.collection('cases');

  List<CasesMessagesClass> _getcasesMessagesInfo(QuerySnapshot snapshot) {
    print('bbbbbbbbbbbbbbbbbbbbbbbbbb');
    return snapshot.docs.map((data) {
      print('--------------------------------------------');
      print(data.data());
      return CasesMessagesClass(
          date: data['date'].toDate(),
          from: data['from'] ?? '',
          messages: data['message'] ?? '',
          receiver: data['receiver'] ?? '',
          sender: data['sender'] ?? '',
          status: data['status'] ?? '',
          type: data['type'] ?? '');
    }).toList();
  }

  Stream<List<CasesMessagesClass>> get getCasesMessagesList {
    casesMessagesCollection = FirebaseFirestore.instance
        .collection('cases')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var item in snapshot.docs) {
        return casesMessagesCollection.doc(item.id).collection('messages');
      }
    }) as CollectionReference<Map<String, dynamic>>;

    return casesMessagesCollection.snapshots().map(_getcasesMessagesInfo);
  }

  // StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
  //     List<CasesMessagesClass>> _transformer() {
  //   return StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
  //       List<CasesMessagesClass>>.fromHandlers(
  //     handleData: (QuerySnapshot<Map<String, dynamic>> snapshot,
  //         EventSink<List<CasesMessagesClass>> sink) async {
  //       List<CasesMessagesClass> msginfolist = [];
  //       for (var doc in snapshot.docs) {
  //         var classesData = await _setData(doc);
  //         msginfolist.add(classesData);
  //       }
  //       sink.add(msginfolist);
  //     },
  //   );
  // }

  // final List<CasesMessagesClass> _getinfo = [];
  // Future<CasesMessagesClass> _setData(DocumentSnapshot snapshot) async {
  //   FirebaseFirestore.instance
  //       .collection('chat')
  //       .doc()
  //       .get()
  //       .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //     var data = snapshot.data() as Map<String, dynamic>;
  //     print(data);

  //     CasesMessagesClass msginfo = CasesMessagesClass(
  //         date: data['date'].toDate(),
  //         from: data['from'] ?? '',
  //         messages: data['message'] ?? '',
  //         receiver: data['receiver'] ?? '',
  //         sender: data['sender'] ?? '',
  //         status: data['status'] ?? '',
  //         type: data['type'] ?? '');
  //     _getinfo.add(msginfo);
  //   });

  //   return CasesMessagesClass(
  //       date: snapshot['date'].toDate(),
  //       from: snapshot['from'] ?? '',
  //       messages: snapshot['message'] ?? '',
  //       receiver: snapshot['receiver'] ?? '',
  //       sender: snapshot['sender'] ?? '',
  //       status: snapshot['status'] ?? '',
  //       type: snapshot['type'] ?? '');
  // }

  // Stream<List<CasesMessagesClass>> get getCasesMessagesList {
  //   CollectionReference casesMessageCollection =
  //       FirebaseFirestore.instance.collection('cases');
  //   return casesMessageCollection.snapshots().transform(_transformer());
  // }
}
