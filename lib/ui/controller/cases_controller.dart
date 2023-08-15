import 'package:cloud_firestore/cloud_firestore.dart';

class CasesController {
  final casesCollection = FirebaseFirestore.instance.collection('cases');

  insertMessages(String parentid, String from, String message, String receiver,
      String sender, String status, String type) async {
    DateTime now = DateTime.now();
    Map<String, dynamic> data = {
      'date': now,
      'from': from,
      'message': message,
      'receiver': receiver,
      'sender': sender,
      'status': status,
      'type': type,
    };

    await casesCollection.doc(parentid).collection('messages').add(data);

    DateTime dateUpdate = DateTime.now();

    await casesCollection.doc(parentid).update({'dateEnd': dateUpdate});
  }
}
