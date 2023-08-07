import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data_class/cases_class.dart';

class CasesServices {
  final CollectionReference caseCollection =
      FirebaseFirestore.instance.collection('cases');

  List<CasesClass> _getCasesInfo(QuerySnapshot snapshot) {
    return snapshot.docs.map((data) {
      print('--------------------------------------------');
      print(data.data());
      return CasesClass(
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
