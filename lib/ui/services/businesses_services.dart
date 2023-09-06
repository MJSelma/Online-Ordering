import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/ui/data_class/businesses_class.dart';

class BusinessesServices {
  final CollectionReference businessesCollection =
      FirebaseFirestore.instance.collection('businesses');

  List<BusinessesClass> getBusinessesInfo(QuerySnapshot snapshot) {
    return snapshot.docs.map((data) {
      return BusinessesClass(
        docId: data.id,
        merchantId: data['merchantId'],
        id: data['id'],
        name: data['name'],
        description: data['description'],
        image: data['image'],
        date: data['date'].toDate(),
        defaultOutletId: data['defaultOutletId'],
      );
    }).toList();
  }

  Stream<List<BusinessesClass>> get businessesList {
    return businessesCollection.snapshots().map(getBusinessesInfo);
  }
}
