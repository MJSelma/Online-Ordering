import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drinklinkmerchant/ui/consultation/menu_list.dart';
import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ConsultationMenu extends StatefulWidget {
  ConsultationMenu({super.key});

  @override
  State<ConsultationMenu> createState() => _ConsultationMenuState();
}

class _ConsultationMenuState extends State<ConsultationMenu> {
  String urlImage =
      'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/129614613/original/f212f9ae0b155df29408578b685bae83727e0f89/design-modern-restaurant-menu.jpg';

  PlatformFile? uploadimage; //variable for choosed file
  String fileName = '';
  FilePickerResult? results;


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
    });
  }

  Future<void> uploadImage() async {
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

      // if (response.statusCode == 200) {
      //   var jsondata = json.decode(response.body); //decode json data
      //   if (jsondata["error"]) {
      //     //check error sent from server
      //     print(jsondata["msg"]);
      //     //if error return from server, show message from server
      //   } else {
      //     print("Upload successful");
      //   }
      // } else {
      //   print("Error during connection to server");
      //   //there is error during connecting to server,
      //   //status code might be 404 = url not found
      // }
    } catch (e) {
      print(e.toString());
      //there is error during converting file image to base64 encoding.
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
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Stack(
          children: [
            SizedBox(
                width: 500,
                child: Image.network(
                  urlImage,
                  fit: BoxFit.fitWidth,
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                    child: IconButtonMenu(
                  text: 'Edit',
                  iconMenu: Icons.edit,
                  width: 100,
                  height: 30,
                  backColor: Color.fromARGB(255, 186, 186, 186),
                )),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
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
                  // controller: userController,
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
                uploadImage();
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
}
