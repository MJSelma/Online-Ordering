import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../ui/data_class/outlet_class.dart';

class BusinessOutletProvider with ChangeNotifier {
  final List<OutletClass> _outletClass = [];

  String _docId = '';
  String _businessName = '';
  bool _isBusinessSelected = false;

  String get docId => _docId;

  void setDocId(String id) {
    clear();
    _docId = id;
    _getOutlet();
    setIsBusinessSelected(true);
    notifyListeners();
  }

  void clear() {
    _isBusinessSelected = false;
    _docId = '';
    _outletClass.clear();
  }

  Future<void> _getOutlet() async {
    await FirebaseFirestore.instance
        .collection('businesses')
        .doc(docId)
        .collection('outlets')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var item in snapshot.docs) {
        DateTime date = (item['date'] as Timestamp).toDate();
        OutletClass outletClassx = OutletClass(
          docId: item.id,
          id: item['id'],
          name: item['name'],
          description: item['description'],
          image: item['image'],
          date: date,
          country: item['country'],
          location: item['location'],
          isLocatedAt: item['isLocatedAt'],
          contactNumber: item['contactNumber'],
          email: item['email'],
          currency: item['currency'],
          star: item['star'],
        );
        _outletClass.add(outletClassx);
        print(_outletClass[0].name);
      }
    });
  }

  List<OutletClass> get outletClass => _outletClass;

  bool get isBusinessSelected => _isBusinessSelected;

  void setIsBusinessSelected(bool isSelected) {
    _isBusinessSelected = isSelected;
    notifyListeners();
  }

  //Businesses
  String get businessName => _businessName;
  void setBusinessName(String name) {
    _businessName = name;
    notifyListeners();
  }
}
