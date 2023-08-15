import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/ui/data_class/cases_messages_class.dart';

class CasesMessagesController {
  final casesCollection = FirebaseFirestore.instance.collection('cases');

  getCasesMessages(String id) async {
    List<CasesMessagesClass> casesMessagesClass = [];

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
  }
}
