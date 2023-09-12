import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/ui/data_class/region_class.dart';
import 'package:flutter/material.dart';

import '../ui/data_class/outlet_class.dart';

class BusinessOutletProvider with ChangeNotifier {
  final List<OutletClass> _outletClass = [];
  final List<RegionClass> _regionClass = [];

  String _docId = '';
  String _businessName = '';
  bool _isBusinessSelected = false;
  String _defaultOutletId = '';

  String get docId => _docId;
  List<OutletClass> get outletClass => _outletClass;
  List<RegionClass> get regionClass => _regionClass;

  bool get isBusinessSelected => _isBusinessSelected;
  String get businessName => _businessName;
  String get defaultOutletId => _defaultOutletId;

  void setDocId(String id) {
    clear();
    _docId = id;
    _getOutlet();
    // _getRegion();
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
          regionId: item['regionId'],
          regionName: item['regionName'],
          cuisineId: item['cuisineId'],
          cuisineName: item['cuisineName'],
          cuisineStyleId: item['cuisineStyleId'],
          cuisineStyleName: item['cuisineStyleName'],
          scheduleId: item['scheduleId'],
          category: item['category'],
        );
        _outletClass.add(outletClassx);
        print(_outletClass[0].name);
      }
    });
  }

  void setIsBusinessSelected(bool isSelected) {
    _isBusinessSelected = isSelected;
    notifyListeners();
  }

  void setBusinessName(String name) {
    _businessName = name;
    notifyListeners();
  }

  void setDefaultOutletId(String str) {
    _defaultOutletId = str;
    notifyListeners();
  }
}
