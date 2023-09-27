import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/ui/data_class/region_class.dart';
import 'package:flutter/material.dart';

import '../ui/data_class/outlet_class.dart';
import '../ui/data_class/schedule_class.dart';

class BusinessOutletProvider with ChangeNotifier {
  final List<OutletClass> _outletClass = [];
  final List<RegionClass> _regionClass = [];
  final List<ScheduleClass> _scheduleClass = [];
  final List<DateTimeClass> _dateTimeClass = [];

  String _docId = '';
  String _businessName = '';
  bool _isBusinessSelected = false;
  String _defaultOutletId = '';
  String _selectedOutletId = '';
  String _country = '';
  String _location = '';
  String _indexPageName = '';

  String get docId => _docId;
  List<OutletClass> get outletClass => _outletClass;
  List<RegionClass> get regionClass => _regionClass;
  List<ScheduleClass> get scheduleClass => _scheduleClass;
  List<DateTimeClass> get dateTimeClass => _dateTimeClass;

  bool get isBusinessSelected => _isBusinessSelected;
  String get businessName => _businessName;
  String get defaultOutletId => _defaultOutletId;
  String get selectedOutletId => _selectedOutletId;
  String get country => _country;
  String get location => _location;
  String get indexPageName => _indexPageName;

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
      }
    });
  }

  Future<void> _getSchedule() async {
    await FirebaseFirestore.instance
        .collection('schedule')
        .where('outletId', isEqualTo: _selectedOutletId)
        // .where('outletId', isEqualTo: 'dlo010')
        .get()
        .then((QuerySnapshot snapshot) {
      _scheduleClass.clear();
      for (var item in snapshot.docs) {
        print(item['outletId']);
        ScheduleClass scheduleClass = ScheduleClass(
          scheduleDocId: item.id,
          outletId: item['outletId'],
          schedule: item['schedule'],
        );
        _scheduleClass.add(scheduleClass);
      }
      if (_scheduleClass.isNotEmpty) {
        _dateTimeClass.clear();
        List<dynamic> map = _scheduleClass[0].schedule;
        print(_scheduleClass[0].schedule);

        DateTimeClass dateTimeClassx =
            DateTimeClass(date: '', start: 0, end: 0);

        for (var item in map) {
          Map<String, dynamic> map2 = item;

          map2.forEach((key, value) {
            Map<String, dynamic> map3 = value;
            DateTimeClass dateTimeClassx = DateTimeClass(
                date: key, start: map3['start'], end: map3['end']);
            _dateTimeClass.add(dateTimeClassx);
          });
        }

        for (var element in _dateTimeClass) {
          print(element.date);
        }
      } else {
        _dateTimeClass.clear();
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

  void setSelectedOutletId(String outletID) {
    _selectedOutletId = outletID;
    // _getSchedule(outletID);
    // _getSchedule();
    notifyListeners();
  }

  void setCountry(String country, String loc) {
    _country = country;
    _location = loc;
    notifyListeners();
  }

  void setIndexPageName(String name) {
    _indexPageName = name;
    notifyListeners();
  }
}
