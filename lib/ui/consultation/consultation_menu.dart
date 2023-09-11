import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:drinklinkmerchant/ui/consultation/menu_list.dart';
import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ConsultationMenu extends StatefulWidget {
  ConsultationMenu({super.key});

  @override
  State<ConsultationMenu> createState() => _ConsultationMenuState();
}

class _ConsultationMenuState extends State<ConsultationMenu> {
  PlatformFile? uploadimage; //variable for choosed file
  String fileName = '';
  String fileType = '';
  FilePickerResult? results;
  TextEditingController menuName = TextEditingController();

  TextEditingController menuNameUpdate = TextEditingController();
  String menuUpdateUrl = '';

  Future<void> chooseImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = result!.files.first;
      print(result.files.first.name);
      fileName = result.files.first.name;
      results = result;
      fileType = fileName.split('.')[1];
      menuUpdateUrl = result.files.first.name;
    });
  }

  Future<void> uploadImage(int menuCount) async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.1.7/uploads/image.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try {
      List<int>? imageBytes = await uploadimage!.bytes;
      String baseimage = base64Encode(imageBytes!);
      print(baseimage.length);
      //convert file image to Base64 encoding
      var response = await http.post(Uri.parse(uploadurl), body: {
        'file_name': fileName,
        'base64_data': baseimage,
      });

      print(response.toString());

      if (response.statusCode == 200) {
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print(e.toString());
      //there is error during converting file image to base64 encoding.
    }

    createMenu(menuCount);
  }

  Future<void> uploadImageUpdate() async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.1.7/uploads/image.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try {
      List<int>? imageBytes = await uploadimage!.bytes;
      String baseimage = base64Encode(imageBytes!);
      print(baseimage.length);
      //convert file image to Base64 encoding
      var response = await http.post(Uri.parse(uploadurl), body: {
        'file_name': fileName,
        'base64_data': baseimage,
      });

      print(response.toString());

      if (response.statusCode == 200) {
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print(e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  Future<void> createMenu(int menuCount) async {
    if (menuName.text != '' && fileName != '') {
      FirebaseFirestore.instance
          .collection('merchant')
          .doc('X6odvQ5gqesAzwtJLaFl')
          .collection('consultationMenu')
          .add({
        'order': menuCount,
        'date': DateTime.now(),
        'fileName': fileName,
        'image': 'http://192.168.1.7/uploads/uploads/$fileName',
        'name': menuName.text,
        'status': true,
        'type': fileType,
      }).then((value) async {
        context.read<MenuProvider>().menuRefresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Consultation Menu',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontFamily: 'SFPro', fontSize: 20),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 2,
                color: Colors.black87,
                height: MediaQuery.of(context).size.height - 200,
              ),
            ),
            outletWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 2,
                color: Colors.black87,
                height: MediaQuery.of(context).size.height - 200,
              ),
            ),
            menuWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 2,
                  color: Colors.black87,
                  height: MediaQuery.of(context).size.height - 200),
            ),
            menuViewer(),
          ],
        )
      ],
    );
  }

  menuViewer() {
    final String menuID = context.select((MenuProvider p) => p.menuID);
    final String menuName = context.select((MenuProvider p) => p.menuName);
    final String imageUrl = context.select((MenuProvider p) => p.imageUrl);
    final String type = context.select((MenuProvider p) => p.type);
    final String pdfData = context.select((MenuProvider p) => p.pdfData);

    return SizedBox(
      width: 450,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Stack(
          children: [
            if (imageUrl != '')
              if (type != 'pdf') ...[
                SizedBox(
                    width: 500,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    )),
              ] else ...[
                SizedBox(
                  width: 500,
                  child: HtmlWidget(
                    pdfData,
                    // customStylesBuilder: (element) {
                    //   if (element.classes.contains('foo')) {
                    //     return {'color': 'red'};
                    //   }
                    //   return null;
                    // },
                    onErrorBuilder: (context, element, error) =>
                        Text('$element error: $error'),
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        CircularProgressIndicator(),
                    textStyle: TextStyle(fontSize: 14),
                    webView: true,
                  ),
                )
              ],
            if (imageUrl != '')
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          menuNameUpdate.text = menuName;
                          menuUpdateUrl = imageUrl;
                        });
                        await showDialog<bool>(
                          context: context,
                          builder: (context) =>
                              updateMenuDialog(context, menuID),
                        );
                      },
                      child: IconButtonMenu(
                        text: 'Edit',
                        iconMenu: Icons.edit,
                        width: 100,
                        height: 30,
                        backColor: Color.fromARGB(255, 186, 186, 186),
                      )),
                ),
              ),
            if (imageUrl != '')
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                      onTap: ()async {
                         await showDialog<bool>(
                          context: context,
                          builder: (context) =>
                              deleteMenuDialog(context, menuID, menuName),
                        );
                      },
                      child: IconButtonMenu(
                        text: 'Delete',
                        iconMenu: Icons.delete,
                        width: 100,
                        height: 30,
                        backColor: Color.fromARGB(255, 210, 69, 69),
                      )),
                ),
              )
          ],
        ),
      ),
    );
  }

  outletWidget() {
    final int menuCount = context.select((MenuProvider p) => p.menuCount);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: menuName,
                  decoration: InputDecoration.collapsed(hintText: 'Menu name'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Ex: Lunch, Dinner, Korian, Itallian',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                // uploadImage();
                // getUrl('waterdropmenu.png','');
                chooseImage();
              },
              child: IconButtonMenu(
                text: 'Upload Menu',
                iconMenu: Icons.upload,
                width: 200,
                height: 30,
                backColor: Color.fromARGB(255, 186, 186, 186),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Format available: pdf, png, jpg',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () {
                uploadImage(menuCount);
              },
              child: IconButtonMenu(
                text: 'ADD',
                iconMenu: Icons.add,
                width: 200,
                height: 30,
                backColor: const Color(0xffef7700),
              )),
          SizedBox(
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Import menu from existing outlet',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xffef7700),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
              child: IconButtonMenu(
            text: 'Choose Location',
            iconMenu: Icons.storefront_outlined,
            width: 200,
            height: 30,
            backColor: const Color(0xffef7700),
          )),
        ],
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null || result.files.isEmpty) {
      throw Exception('No files picked or file picker was canceled');
    }
  }

  // uploadImage() async {
  //   FilePickerResult? result = await FilePickerWeb.platform.pickFiles();
  //   String types = '';
  //   if (result != null) {
  //     Uint8List? fileBytes = result.files.first.bytes;
  //     String fileName = result.files.first.name;
  //     double progress = 0;
  //     if (fileName.contains('.png')) {
  //       types = 'image';
  //     } else if (fileName.contains('.jpeg')) {
  //       types = 'image';
  //     } else if (fileName.contains('.jpg')) {
  //       types = 'image';
  //     } else if (fileName.contains('.pdf')) {
  //       types = 'file';
  //     }

  //     // Upload file
  //     FirebaseStorage.instance
  //         .ref('uploads/$fileName')
  //         .putData(fileBytes!)
  //         .snapshotEvents
  //         .listen((event) {
  //       switch (event.state) {
  //         case TaskState.running:
  //           progress = 100.0 * (event.bytesTransferred / event.totalBytes);
  //           if (progress == 100) {
  //             Future.delayed(Duration(seconds: 2), () {
  //               getUrl(fileName, types);
  //             });
  //           }
  //           print("Upload is $progress% complete.");
  //           break;
  //         case TaskState.paused:
  //           print("Upload is paused.");
  //           break;
  //         case TaskState.canceled:
  //           print("Upload was canceled");
  //           break;
  //         case TaskState.error:
  //           // Handle unsuccessful uploads
  //           break;
  //         case TaskState.success:
  //           // Handle successful uploads on complete
  //           // ...
  //           break;
  //       }
  //     });
  //   }
  // }

  // getUrl(String fileName, String types) async {
  //   print('ersult here');
  //   final url = await FirebaseStorage.instance
  //       .ref()
  //       .child('uploads/$fileName')
  //       .getDownloadURL();

  //   print(url);
  // }

  menuWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color.fromARGB(255, 228, 228, 228),
            ),
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            // controller: userController,
                            decoration:
                                InputDecoration.collapsed(hintText: 'Search'),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Icon(Icons.filter_list_alt),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            width: 400,
            child: ConsultMenuPage(),
          ),
        ],
      ),
    );
  }

  Widget updateMenuDialog(BuildContext context, String mID) {
    return AlertDialog(
      title: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 400,
          height: 330,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Menu',
              ),
              const SizedBox(height: 15),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Name',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLines: 1,
                              controller: menuNameUpdate,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                menuUpdateUrl,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    chooseImage();
                  },
                  child: IconButtonMenu(
                    text: 'Upload new menu',
                    iconMenu: Icons.upload,
                    width: 200,
                    height: 30,
                    backColor: Color.fromARGB(255, 120, 120, 120),
                  )),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: IconButtonMenu(
                            text: 'Cancel',
                            iconMenu: Icons.close,
                            width: 200,
                            height: 35,
                            backColor: Color.fromARGB(255, 120, 120, 120),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: () async {
                            uploadImageUpdate();
                            FirebaseFirestore.instance
                                .collection('merchant')
                                .doc('X6odvQ5gqesAzwtJLaFl')
                                .collection('consultationMenu')
                                .doc(mID)
                                .update({
                              'name': menuNameUpdate.text,
                              'image':
                                  'http://192.168.1.7/uploads/uploads/$menuUpdateUrl',
                              'type': fileType
                            }).then((value) async {
                              context.read<MenuProvider>().menuRefresh();
                              Navigator.of(context).pop();
                            });
                          },
                          child: IconButtonMenu(
                            text: 'Update',
                            iconMenu: Icons.edit,
                            width: 200,
                            height: 35,
                            backColor: const Color(0xffef7700),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget deleteMenuDialog(BuildContext context, String mID, menuName) {
    return AlertDialog(
      title: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 300,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delete Menu',
              ),
              const SizedBox(height: 15),
              Text(
                'Are you sure you want to delete this menu $menuName ?',
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: IconButtonMenu(
                            text: 'Cancel',
                            iconMenu: Icons.close,
                            width: 200,
                            height: 35,
                            backColor: Color.fromARGB(255, 120, 120, 120),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: () async {
                            uploadImageUpdate();
                            FirebaseFirestore.instance
                                .collection('merchant')
                                .doc('X6odvQ5gqesAzwtJLaFl')
                                .collection('consultationMenu')
                                .doc(mID)
                                .delete()
                                .then((value) async {
                              context.read<MenuProvider>().menuRefresh();
                              Navigator.of(context).pop();
                            });
                          },
                          child: IconButtonMenu(
                            text: 'Delete',
                            iconMenu: Icons.delete,
                            width: 200,
                            height: 35,
                            backColor:  Color.fromARGB(255, 210, 69, 69),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
