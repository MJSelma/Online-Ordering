import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  bool refresh = false;
  bool _isImageLoaded = false;
  String _menuName = '';
  String _imageUrl = '';
  String _menuID = '';
  String _type = '';
  String _pdfData = '';
  int _menuCount = 0;
  String _choosenOutletMenId = '';
  String _importFileName = '';
  String _importImage = '';
  String _importType = '';
  String _importMenuName = '';

  bool get isImageLoaded => _isImageLoaded;
  String get menuName => _menuName;
  String get imageUrl => _imageUrl;
  String get menuID => _menuID;
  String get type => _type;
  String get pdfData => _pdfData;
  int get menuCount => _menuCount;
  String get ChoosenOutletMenId => _choosenOutletMenId;
  String get importFileName => _importFileName;
  String get importImage => _importImage;
  String get importType => _importType;
  String get importMenuName => _importMenuName;

  void selectedMenu(String id, name, image, type, pdfData) {
    _menuID = id;
    _menuName = name;
    _imageUrl = image;
    _type = type;
    _pdfData = pdfData;
    notifyListeners();
  }

  void updateMenuCount(int count) {
    _menuCount = count;
    notifyListeners();
  }

  bool get isRefresh => refresh;

  void menuRefresh() {
    refresh = !refresh;
    notifyListeners();
  }

  void setImageLoaded(bool isloaded) {
    _isImageLoaded = isloaded;
    notifyListeners();
  }

  void setChoosenOutletMenId(String Id) {
    _choosenOutletMenId = Id;
    notifyListeners();
  }

  void setImportImage(String str1, str2, str3, str4) {
    _importFileName = str1;
    _importImage = str2;
    _importType = str2;
    _importMenuName = str4;
    notifyListeners();
  }
}
