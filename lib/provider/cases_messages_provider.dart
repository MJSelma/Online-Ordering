import 'package:flutter/material.dart';

class CasesMessageProvider with ChangeNotifier {
  int _index = 0;
  String _docId = '';

  int get indx => _index;

  void setIndex(int id) {
    _index = id;
    notifyListeners();
  }

  String get docId => _docId;

  void setDocId(String docId) {
    _docId = docId;
    notifyListeners();
  }
}
