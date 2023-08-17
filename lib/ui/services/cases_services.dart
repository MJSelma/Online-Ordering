import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_class/cases_class.dart';

class CasesServices {
  final CollectionReference caseCollection =
      FirebaseFirestore.instance.collection('cases');

  // StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<CasesClass>>
  //     _transformer() {
  //   return StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
  //       List<CasesClass>>.fromHandlers(
  //     handleData: (QuerySnapshot<Map<String, dynamic>> snapshot,
  //         EventSink<List<CasesClass>> sink) async {
  //       List<CasesClass> casesInfoList = [];
  //       for (var doc in snapshot.docs) {
  //         var casesData = await _createCasesDataFromDocument(doc);
  //         casesInfoList.add(casesData);
  //       }
  //       sink.add(casesInfoList);
  //     },
  //   );
  // }

  // Future<CasesClass> _createCasesDataFromDocument(
  //     DocumentSnapshot<Object?> snapshot) async {
  //   var data = snapshot.data() as Map<String, dynamic>;
  //   var subcollectionNames = ['messages'];
  //   List<CasesMessagesClass> casesMessagesClass = [];

  //   // for (var subcollectionName in subcollectionNames) {
  //   var subcollection = snapshot.reference.collection('messages');
  //   print(subcollection.doc());

  //   subcollection.get().then((subcollectionSnapshot) {
  //     for (var subdoc in subcollectionSnapshot.docs) {
  //       CasesMessagesClass temp = CasesMessagesClass(
  //           date: subdoc['date'].toDate(),
  //           from: subdoc['from'] ?? '',
  //           messages: subdoc['message'] ?? '',
  //           receiver: subdoc['receiver'] ?? '',
  //           sender: subdoc['sender'] ?? '',
  //           status: subdoc['status'] ?? '',
  //           type: subdoc['type'] ?? '');
  //       casesMessagesClass.add(temp);
  //     }
  //   });
  //   // }
  //   // print(casesMessagesClass.length);
  //   return CasesClass(
  //       id: snapshot.id,
  //       caseId: snapshot['caseId'] ?? '',
  //       deteStart: snapshot['dateStart'].toDate(),
  //       dateEnd: snapshot['dateEnd'].toDate(),
  //       customerName: snapshot['customerName'] ?? '',
  //       customerUser: snapshot['customerUser'] ?? '',
  //       customerContact: snapshot['customerContact'] ?? '',
  //       caseType: snapshot['caseType'] ?? '',
  //       caseObjective: snapshot['caseObjective'] ?? '',
  //       caseDescription: snapshot['caseDescription'] ?? '',
  //       agentName: snapshot['agentName'] ?? '',
  //       status: snapshot['status'] ?? '',
  //       note: snapshot['Note'] ?? '',
  //       customerId: snapshot['customerId'] ?? '',
  //       customerImage: snapshot['customerImage'] ?? '',
  //       merchantId: snapshot['merchantId'] ?? '',
  //       branchId: snapshot['branchId'] ?? '',
  //       agentId: snapshot['agentId'] ?? '',
  //       agentImage: snapshot['agentImage'] ?? '',
  //       casesMessagesClass: casesMessagesClass);
  // }

  // Stream<List<CasesClass>> get getCasesList {
  //   CollectionReference casesCollection =
  //       FirebaseFirestore.instance.collection('cases');
  //   return casesCollection.snapshots().transform(_transformer());
  // }

  List<CasesClass> _getCasesInfo(QuerySnapshot snapshot) {
    return snapshot.docs.map((data) {
      // print('--------------------------------------------');
      // print(data.data());
      return CasesClass(
          id: data.id,
          caseId: data['caseId'] ?? '',
          deteStart: data['dateStart'].toDate(),
          dateEnd: data['dateEnd'].toDate(),
          customerName: data['customerName'] ?? '',
          customerUser: data['customerUser'] ?? '',
          customerContact: data['customerContact'] ?? '',
          caseType: data['caseType'] ?? '',
          caseObjective: data['caseObjective'] ?? '',
          caseDescription: data['caseDescription'] ?? '',
          agentName: data['agentName'] ?? '',
          status: data['status'] ?? '',
          note: data['Note'] ?? '',
          customerId: data['customerId'] ?? '',
          customerImage: data['customerImage'] ?? '',
          merchantId: data['merchantId'] ?? '',
          branchId: data['branchId'] ?? '',
          agentId: data['agentId'] ?? '',
          agentImage: data['agentImage'] ?? '');
    }).toList();
  }

  Stream<List<CasesClass>> get getCasesList {
    return caseCollection.snapshots().map(_getCasesInfo);
  }
}
