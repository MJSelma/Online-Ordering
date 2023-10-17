import 'package:cloud_firestore/cloud_firestore.dart';

import '../../provider/menu_provider.dart';

Future<void> saveBusinessOutlet(
    bool isSetDefaultWall,
    String businessId,
    String outletId,
    String email,
    String number,
    String lcoation,
    int isLocatedAt,
    String currency,
    String regionId,
    String regionName,
    String cuisineId,
    String cuisineName,
    String cuisineStyleId,
    String cuisineStyleName,
    String scheduleId,
    List<String> category,
    context) async {
  Map<String, dynamic> data = {
    'email': email,
    'contactNumber': number,
    'location': lcoation,
    'isLocatedAt': isLocatedAt == 0 ? true : false,
    'currency': currency,
    'regionId': regionId,
    'regionName': regionName,
    'cuisineId': cuisineId,
    'cuisineName': cuisineName,
    'cuisineStyleId': cuisineStyleId,
    'cuisineStyleName': cuisineStyleName,
    'scheduleId': scheduleId,
    'category': category
  };

  Map<String, dynamic> defaultOutletId = {
    'defaultOutletId': outletId,
  };

  final collectionBusiness =
      FirebaseFirestore.instance.collection('businesses').doc(businessId);

  if (isSetDefaultWall == true) {
    await collectionBusiness.update(defaultOutletId);
  }

  await collectionBusiness
      .collection('outlets')
      .where('id', isEqualTo: outletId)
      .get()
      .then((QuerySnapshot value) {
    for (var item in value.docs) {
      collectionBusiness.collection('outlets').doc(item.id).update(data);
    }
  });
  context.read<MenuProvider>().menuRefresh();
}

Future<void> saveRegion(
  String Id,
  String outletId,
  String name,
) async {
  await FirebaseFirestore.instance.collection('region').add({
    'id': Id,
    'name': name,
    'outletId': outletId,
    'status': true,
    'defaultCuisineStyleId': '',
  });
}

Future<void> deleteRegion(String id) async {
  CollectionReference regCol = FirebaseFirestore.instance.collection('region');

  await regCol.where('id', isEqualTo: id).get().then((QuerySnapshot value) {
    for (var item in value.docs) {
      regCol.doc(item.id).delete();
    }
  });
}

Future<void> saveCuisine(
  String id,
  String currentRegionId,
  String name,
) async {
  await FirebaseFirestore.instance.collection('cuisine').add({
    'id': id,
    'name': name,
    'regionId': currentRegionId,
    'status': true,
    // 'defaultCuisineStyleId': '',
  });
}

Future<void> deleCuisine(String id) async {
  CollectionReference cusineCol =
      FirebaseFirestore.instance.collection('cuisine');

  await cusineCol.where('id', isEqualTo: id).get().then((QuerySnapshot value) {
    for (var item in value.docs) {
      print(item.id);
      cusineCol.doc(item.id).delete();
    }
  });
}

Future<void> saveCuisineStyle(
  String id,
  String outletId,
  String name,
) async {
  await FirebaseFirestore.instance.collection('cuisineStyle').add({
    'id': id,
    'outletId': outletId,
    'name': name,
    'refId': '',
    'status': true,
  });
}

Future<void> deleCuisineStyle(String id) async {
  CollectionReference cuisineStyleCol =
      FirebaseFirestore.instance.collection('cuisineStyle');

  await cuisineStyleCol
      .where('id', isEqualTo: id)
      .get()
      .then((QuerySnapshot value) {
    for (var item in value.docs) {
      print(item.id);
      cuisineStyleCol.doc(item.id).delete();
    }
  });
}
