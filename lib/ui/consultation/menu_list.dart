import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/%20model/consultation_menu_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';

class ConsultMenuPage extends HookWidget {
  const ConsultMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    final menuList = useState<List<ConsultationMenuModel>>([]);

    useEffect(() {
      Future.microtask(() async {
        await getMenu(menuList);
      });
    }, [refresh.value]);

    return Expanded(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuList(context, menuList),
              ],
            )));
  }

  getMenu(ValueNotifier menuList) async {
    List<ConsultationMenuModel> ulist = [];

    await FirebaseFirestore.instance
        .collection('merchant')
        .doc('X6odvQ5gqesAzwtJLaFl')
        .collection('consultationMenu')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                debugPrint(doc.id);
                ConsultationMenuModel obj = ConsultationMenuModel(
                    doc.id,
                    doc['name'],
                    doc['fileName'],
                    doc['image'],
                    doc['date'].toString(),
                    doc['status'].toString(),
                    doc['type']);

                ulist.add(obj);
              })
            });
    debugPrint(ulist[0].name);
    menuList.value = ulist;
  }

  getImage(String path) async {
    Uint8List? imageBytes;
    await FirebaseStorage.instance
        .ref()
        .child('uploads/$path')
        .getData(10000000)
        .then((data) {
      imageBytes = data;
    });
    var img = imageBytes != null
        ? Image.memory(
            imageBytes!,
            fit: BoxFit.cover,
          )
        : const Text("Loading...");
    return img;
  }

  Future<File?> getImageFile(String path) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = path.split('/').last;
    final file = File('${tempDir.path}/$fileName');

    // If the file do not exists try to download
    if (!file.existsSync()) {
      try {
        file.create(recursive: true);
        await FirebaseStorage.instance.ref(path).writeToFile(file);
      } catch (e) {
        // If there is an error delete the created file
        await file.delete(recursive: true);
        return null;
      }
    }
    return file;
  }

  Widget _buildMenuList(BuildContext context,
      ValueNotifier<List<ConsultationMenuModel>> menuList) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: menuList.value.length,
          itemBuilder: (context, index) {
            
            return GestureDetector(
              onTap: () {
                // setState(() {
                //   urlImage =
                //       'https://images.sample.net/wp-content/uploads/2023/01/Blank-Restaurant-Menu-Template.jpg';
                // });
              },
              child: Container(
                width: 140,
                height: 200,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade100,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(menuList.value[index].name),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }


}
