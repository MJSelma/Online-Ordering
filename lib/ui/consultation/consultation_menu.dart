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

import '../../provider/businessOutletProvider.dart';
import '../components/constant.dart';
import '../components/showDialog.dart';
import '../data_class/outlet_class.dart';

class ConsultationMenu extends StatefulWidget {
  const ConsultationMenu({super.key});

  @override
  State<ConsultationMenu> createState() => _ConsultationMenuState();
}

class _ConsultationMenuState extends State<ConsultationMenu> {
  PlatformFile? uploadimage; //variable for choosed file
  String fileName = '';
  // String fileNameUpdate = '';
  String fileType = '';
  String fileTypeUpdate = '';
  bool ismenuNamefiled = false;
  bool ismenuNamefiledUpdate = false;
  bool isImportMenuHasFile = false;
  bool isImportMenu = false;
  FilePickerResult? results;
  TextEditingController menuName = TextEditingController();

  TextEditingController menuNameUpdate = TextEditingController();
  String menuUpdateUrl = '';
  String menuUpdateUrlOld = '';
  String menuNameOld = '';
  String currentItem = 'Select Outlet';
  String outletImageUrl = '';
  String importFilenamex = '';
  String importImagex = '';
  String selectedOutletId = '';
  String importTypex = '';
  String importMenuNamex = '';

  List<OutletClass> outletClasss = [];

  Future<void> chooseImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = result!.files.first;
      print(result.files.first.name);
      fileName = result.files.first.name;
      // fileNameUpdate = result.files.first.name;
      results = result;
      fileType = fileName.split('.')[1];
      menuUpdateUrl =
          'http://192.168.8.108/uploads/uploads/${result.files.first.name}';
      context.read<MenuProvider>().setImageLoaded(true);
    });
  }

  Future<void> chooseImageUpdate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = result!.files.first;
      print(result.files.first.name);
      String fileNamex = result.files.first.name;
      // fileNameUpdate = result.files.first.name;
      results = result;
      fileTypeUpdate = fileNamex.split('.')[1];
      menuUpdateUrl =
          'http://192.168.8.108/uploads/uploads/${result.files.first.name}';
      context.read<MenuProvider>().setImageLoaded(true);
    });
  }

  Future<void> uploadImage(int menuCount) async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.8.108/uploads/image.php";
    // String uploadurl = "http://192.168.1.7/uploads/image.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try {
      List<int>? imageBytes = uploadimage!.bytes;
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
    fileName = '';
    menuName.text = '';
  }

  Future<void> uploadImageUpdate() async {
    //show your own loading or progressing code here

    String uploadurl = "http://192.168.8.108/uploads/image.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    try {
      List<int>? imageBytes = uploadimage!.bytes;
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
    fileName = '';
    menuName.text = '';
  }

  Future<void> createMenu(int menuCount) async {
    if (menuName.text != '' && fileName != '') {
      await FirebaseFirestore.instance
          .collection('merchant')
          .doc('X6odvQ5gqesAzwtJLaFl')
          .collection('consultationMenu')
          .add({
        'order': menuCount,
        'date': DateTime.now(),
        'fileName': fileName,
        'image': 'http://192.168.8.108/uploads/uploads/$fileName',
        'name': menuName.text,
        'status': true,
        'type': fileType,
        // 'outletId': 'dlo014'
        'outletId': selectedOutletId
      }).then((value) async {
        context.read<MenuProvider>().menuRefresh();
      });
    }
  }

  Future<void> createMenuImport(int menuCount) async {
    if (importImagex != '') {
      await FirebaseFirestore.instance
          .collection('merchant')
          .doc('X6odvQ5gqesAzwtJLaFl')
          .collection('consultationMenu')
          .add({
        'order': menuCount,
        'date': DateTime.now(),
        'fileName': importFilenamex,
        'image': 'http://192.168.8.108/uploads/uploads/$importFilenamex',
        'name': importMenuNamex,
        'status': true,
        'type': importTypex,
        // 'outletId': 'dlo015'
        'outletId': selectedOutletId
      }).then((value) async {
        context.read<MenuProvider>().menuRefresh();
        importImagex = '';
        isImportMenu = false;
      });
    } else {
      warningDialog(context, 'CHOOSE OUTLET', 'Please choose outlet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final outletClassx =
        context.select((BusinessOutletProvider p) => p.outletClass);
    outletClasss = outletClassx;

    // final outletIdprovider =
    //     context.select((BusinessOutletProvider p) => p.defaultOutletId);

    final outletId =
        context.select((BusinessOutletProvider p) => p.selectedOutletId);
    selectedOutletId = outletId;

    final country = context.select((BusinessOutletProvider p) => p.country);

    outletClasss = outletClasss
        .where((item) =>
            item.country.toLowerCase() == country.toLowerCase() &&
            item.id.toLowerCase() != selectedOutletId.toLowerCase())
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SizedBox(
        //   width: MediaQuery.sizeOf(context).width - 300,
        //   child: outletViewer(),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 8.0, 8.0, 8.0),
          child: Text(
            'CONSULTATION MENU',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'SFPro',
                fontSize: 20,
                color: defaultFileColorOrange),
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
                // color: Colors.grey.shade500,
                color: Colors.black87,
                height: MediaQuery.of(context).size.height - 200,
              ),
            ),
            outletWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 2,
                // color: Colors.grey.shade500,
                color: Colors.black87,
                height: MediaQuery.of(context).size.height - 200,
              ),
            ),
            menuWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 2,
                  // color: Colors.grey.shade500,
                  color: Colors.black87,
                  height: MediaQuery.of(context).size.height - 200),
            ),
            menuViewer(),
          ],
        )
      ],
    );
  }

  List<DropdownMenuEntry<OutletClass>> _createListOutlet() {
    return outletClasss.map<DropdownMenuEntry<OutletClass>>((e) {
      return DropdownMenuEntry(value: e, label: e.name);
    }).toList();
  }

  outletViewer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Main Wall',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffef7700)),
          ),
          SizedBox(
            width: 230,
            child: outletClasss.isEmpty
                ? Container()
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: DropdownMenu<OutletClass>(
                      enableSearch: true,
                      enableFilter: true,
                      inputDecorationTheme: const InputDecorationTheme(
                          border: InputBorder.none,
                          fillColor: Color(0xffef7700),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xffef7700))),
                      trailingIcon: const Icon(
                        Icons.search,
                        color: Color(0xffef7700),
                      ),
                      width: 200,
                      hintText: currentItem,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xffef7700)),
                      onSelected: (OutletClass? value) {},
                      dropdownMenuEntries: _createListOutlet(),
                    ),
                  ),
          ),
        ],
      ),
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
                        const CircularProgressIndicator(),
                    textStyle: const TextStyle(fontSize: 14),
                    webView: true,
                  ),
                )
              ],
            if (imageUrl != '')
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: defaultbuttonColorGrey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              fontFamily: 'SFPro',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              menuNameUpdate.text = menuName;
                              menuUpdateUrl = imageUrl;
                              menuUpdateUrlOld = imageUrl;
                              menuNameOld = menuName;
                            });

                            await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                context
                                    .read<MenuProvider>()
                                    .setImageLoaded(false);
                                return updateMenuDialog(context, menuID);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // child: IconButtonMenu(
                  //   text: 'Edit',
                  //   iconMenu: Icons.edit,
                  //   width: 100,
                  //   height: 30,
                  //   backColor: const defaultbuttonColorGrey,
                  // )),
                ),
              ),
            if (imageUrl != '')
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                      onTap: () async {
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
                        backColor: const Color.fromARGB(255, 210, 69, 69),
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
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 228, 228, 228),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffffffff),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff707070)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: menuName,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Menu Name'),
                      onChanged: (value) {
                        setState(() {
                          value != ''
                              ? ismenuNamefiled = true
                              : ismenuNamefiled = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Ex: Lunch, Dinner, Korian, Itallian',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                // uploadImage();
                // getUrl('waterdropmenu.png','');

                chooseImage();
              },
              child: IconButtonMenu(
                  text: 'CHOOSE FILE',
                  iconMenu: Icons.upload,
                  width: 200,
                  height: 30,
                  backColor: defaultFileColorOrange
                  // backColor: fileName != ''
                  //     ? const defaultFileColorOrange
                  //     : const defaultbuttonColorGrey,
                  )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Format available: pdf, png, jpg',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () async {
                if (menuName.text == '') {
                  warningDialog(
                      context, 'CREATE MENU', 'Please enter menu name.');
                  return;
                }

                if (fileName == '') {
                  warningDialog(context, 'CHOOSE FILE', 'Please select file.');
                  return;
                }

                uploadImage(menuCount);
              },
              child: IconButtonMenu(
                text: 'UPLOAD MENU',
                iconMenu: Icons.add,
                width: 200,
                height: 30,
                backColor: fileName != '' && menuName.text != ''
                    ? defaultUploadButtonColorGreen
                    : defaultbuttonColorGrey,
              )),
          const SizedBox(
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  shape: const CircleBorder(eccentricity: 1.0),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isImportMenu,
                  onChanged: (bool? value) {
                    setState(() {
                      isImportMenu == true
                          ? isImportMenu = false
                          : isImportMenu = true;
                    });
                  },
                ),
                Text(
                  'Import menu from existing outlets'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: defaultFileColorOrange,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Visibility(
              visible: isImportMenu,
              child: Column(
                children: [
                  GestureDetector(
                    child: IconButtonMenu(
                      text: 'Choose OUTLET'.toUpperCase(),
                      iconMenu: Icons.storefront_outlined,
                      width: 200,
                      height: 30,
                      backColor: importImagex != ''
                          ? defaultFileColorOrange
                          : defaultbuttonColorGrey,
                    ),
                    onTap: () {
                      setState(() {
                        context.read<MenuProvider>().setChoosenOutletMenId('');
                        context.read<MenuProvider>().setChooseOutletIndex(-1);
                        context
                            .read<MenuProvider>()
                            .setChooseOutletIndexSelected(-1);
                        context
                            .read<MenuProvider>()
                            .setImportImage('', '', '', '');
                      });

                      chooseOutlet();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () async {
                        createMenuImport(menuCount);
                      },
                      child: IconButtonMenu(
                        text: 'UPLOAD MENU',
                        iconMenu: Icons.add,
                        width: 200,
                        height: 30,
                        backColor: importImagex != ''
                            ? defaultUploadButtonColorGreen
                            : defaultbuttonColorGrey,
                      )),
                ],
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
              color: const Color.fromARGB(255, 228, 228, 228),
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
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            // controller: userController,
                            decoration:
                                InputDecoration.collapsed(hintText: 'Search'),
                          ),
                        ),
                      ),
                    ),
                    // const Spacer(),
                    // GestureDetector(
                    //   child: const Icon(Icons.filter_list_alt),
                    // )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            width: 400,
            child: const ConsultMenuPage(),
          ),
        ],
      ),
    );
  }

  Widget updateMenuDialog(BuildContext context, String mID) {
    return StatefulBuilder(
      builder: (context, setState) {
        final bool isImagedLoaded =
            context.select((MenuProvider p) => p.isImageLoaded);
        final String menuID = context.select((MenuProvider p) => p.menuID);
        final String menuName = context.select((MenuProvider p) => p.menuName);
        final String imageUrl = context.select((MenuProvider p) => p.imageUrl);
        final String type = context.select((MenuProvider p) => p.type);
        final String pdfData = context.select((MenuProvider p) => p.pdfData);

        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 4,
                color: defaultFileColorOrange,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          title: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: 500,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('UPDATE MENU',
                          style: TextStyle(
                              color: defaultFileColorOrange,
                              fontWeight: FontWeight.bold)),
                      Container(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Icon(
                            Icons.close,
                            size: 14,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Name',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: menuNameUpdate,
                                  onChanged: (value) {
                                    setState(() {
                                      value != ''
                                          ? ismenuNamefiledUpdate = true
                                          : ismenuNamefiledUpdate = false;
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      menuUpdateUrl,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              chooseImageUpdate();
                            },
                            child: IconButtonMenu(
                                text: 'CHOOSE FILE',
                                iconMenu: Icons.upload,
                                width: 200,
                                height: 35,
                                backColor: defaultFileColorOrange
                                // backColor: isImagedLoaded == true
                                //     ? const defaultFileColorOrange
                                //     : const defaultbuttonColorGrey,
                                )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 220,
                          height: 35,
                          decoration: BoxDecoration(
                            color: menuUpdateUrlOld != menuUpdateUrl &&
                                        menuNameUpdate.text != '' ||
                                    menuNameOld != menuNameUpdate.text
                                ? defaultbuttonColorGrey
                                : defaultUploadButtonColorGreen,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextButton(
                            child: const Text(
                              'APPLY CHANGES',
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () async {
                              if (menuNameUpdate.text == '') {
                                warningDialog(context, 'UPDATE MENU',
                                    'Please enter menu name.');
                                return;
                              }

                              // if (menuUpdateUrlOld == menuUpdateUrl) {
                              //   warningDialog(context, 'UPDATE MENU',
                              //       'Please select file.');
                              //   return;
                              // }

                              // if (fileNameUpdate.toLowerCase() ==
                              //     ''.toLowerCase()) {
                              //   warningDialog(context, 'CHOOSE FILE',
                              //       'Please select file.');
                              //   return;
                              // }

                              uploadImageUpdate();
                              FirebaseFirestore.instance
                                  .collection('merchant')
                                  .doc('X6odvQ5gqesAzwtJLaFl')
                                  .collection('consultationMenu')
                                  .doc(mID)
                                  .update({
                                'name': menuNameUpdate.text,
                                'image': menuUpdateUrl,
                                // 'image':
                                //     'http://192.168.8.108/uploads/uploads/$menuUpdateUrl',
                                'type': fileType
                              }).then((value) async {
                                context.read<MenuProvider>().menuRefresh();
                                context.read<MenuProvider>().selectedMenu(
                                    menuID,
                                    menuNameUpdate.text,
                                    menuUpdateUrl,
                                    type,
                                    pdfData);
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ),
                        // child: IconButtonMenu(
                        //   text: 'APPLY CHANGES',
                        //   iconMenu: Icons.add,
                        //   width: 220,
                        //   height: 35,
                        //   backColor: menuUpdateUrlOld != menuUpdateUrl &&
                        //           menuNameUpdate.text != ''
                        //       ? defaultUploadButtonColorGreen
                        //       : defaultbuttonColorGrey,
                        // )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget deleteMenuDialog(BuildContext context, String mID, menuName) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 4,
            color: defaultFileColorOrange,
          ),
          borderRadius: BorderRadius.circular(20.0)),
      title: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 400,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('DELETE MENU',
                      style: TextStyle(
                          color: defaultFileColorOrange,
                          fontWeight: FontWeight.bold)),
                  Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 14,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Are you sure you want to cancel menu $menuName ?',
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
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
                          context
                              .read<MenuProvider>()
                              .selectedMenu('', '', '', '', '');
                        });
                      },
                      child: IconButtonMenu(
                        text: 'Delete',
                        iconMenu: Icons.delete,
                        width: 150,
                        height: 35,
                        backColor: const Color.fromARGB(255, 210, 69, 69),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  chooseOutlet() {
    showDialog(
      context: context,
      builder: (context) {
        final String importFileName =
            context.select((MenuProvider p) => p.importFileName);
        final String importImage =
            context.select((MenuProvider p) => p.importImage);
        final String importType =
            context.select((MenuProvider p) => p.importType);
        final String importMenuName =
            context.select((MenuProvider p) => p.importMenuName);

        importFilenamex = importFileName;
        importImagex = importImage;
        importTypex = importType;
        importMenuNamex = importMenuName;

        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 4, color: Color(0xffef7700)),
              borderRadius: BorderRadius.circular(20.0)),
          title: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CHOOSE OUTLET',
                      style: TextStyle(
                          color: Color(0xffef7700),
                          fontWeight: FontWeight.bold)),
                  Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 14,
                      ),
                      onTap: () {
                        setState(() {
                          context
                              .read<MenuProvider>()
                              .setChoosenOutletMenId('');
                          context
                              .read<MenuProvider>()
                              .setImportImage('', '', '', '');
                          context.read<MenuProvider>().setChooseOutletIndex(-1);
                          context
                              .read<MenuProvider>()
                              .setChooseOutletIndexSelected(-1);
                        });

                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ]),
          ),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width - 300,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getOutletList(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 2,
                        color: Colors.grey.shade500,
                        height: MediaQuery.of(context).size.height - 200,
                      ),
                    ),
                    getOutletMenu(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 2,
                          color: Colors.grey.shade500,
                          height: MediaQuery.of(context).size.height - 200),
                    ),
                    getMenuView()
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          setState(() {
                            context.read<MenuProvider>().setImportImage(
                                importFileName,
                                importImage,
                                importType,
                                importMenuName);
                            Navigator.pop(context);
                          });
                        },
                        child: IconButtonMenu(
                          text: 'IMPORT',
                          iconMenu: Icons.import_export,
                          width: 150,
                          height: 35,
                          backColor: const Color.fromARGB(255, 210, 69, 69),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getOutletList() {
    return StatefulBuilder(
      builder: (context, setState) {
        final int indexOutletMenu =
            context.select((MenuProvider p) => p.chooseOutletIndex);
        final int indexOutletMenuSelected =
            context.select((MenuProvider p) => p.chooseOutletIndexSelected);

        int ind = 100;
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(children: [
            SizedBox(
              width: 300,
              height: MediaQuery.sizeOf(context).height - 200,
              child: ListView.builder(
                itemCount: outletClasss.length,
                itemBuilder: (context, index) {
                  print(index);
                  return MouseRegion(
                    onHover: (event) {
                      setState(() {
                        context
                            .read<MenuProvider>()
                            .setChooseOutletIndex(index);
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        context.read<MenuProvider>().setChooseOutletIndex(-1);
                      });
                    },
                    child: GestureDetector(
                      child: Container(
                        // margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        height: 70,
                        decoration: BoxDecoration(
                          color: indexOutletMenuSelected == index
                              ? const Color(0xffef7700)
                              : indexOutletMenu == index
                                  ? const Color(0xffef7700)
                                  : defaultbuttonColorGrey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                outletClasss[index].name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: Colors.white),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  outletClasss[index].location,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          print(outletClasss[index].id);
                          context
                              .read<MenuProvider>()
                              .setChooseOutletIndexSelected(index);
                          context
                              .read<MenuProvider>()
                              .setChoosenOutletMenId(outletClasss[index].id);

                          context
                              .read<MenuProvider>()
                              .setImportImage('', '', '', '');
                        });
                      },
                    ),
                  );
                },
              ),
            )
          ]),
        );
      },
    );
  }

  getOutletMenu() {
    return StatefulBuilder(
      builder: (context, setState) {
        final choosenOutletId =
            context.select((MenuProvider p) => p.ChoosenOutletMenId);

        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(children: [
            SizedBox(
              width: 300,
              height: MediaQuery.sizeOf(context).height - 200,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('merchant')
                    .doc('X6odvQ5gqesAzwtJLaFl')
                    .collection('consultationMenu')
                    .where('outletId', isEqualTo: choosenOutletId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              // childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.network(
                                  doc['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  outletImageUrl = doc['image'];
                                  print(outletImageUrl);
                                  context.read<MenuProvider>().setImportImage(
                                      doc['fileName'],
                                      doc['image'],
                                      doc['type'],
                                      doc['name']);
                                });
                              },
                            ),
                            Text(doc['name'])
                          ],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ]),
        );
      },
    );
  }

  getMenuView() {
    return StatefulBuilder(
      builder: (context, setState) {
        final url = context.select((MenuProvider p) => p.importImage);
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Visibility(
            visible: url != '',
            child: Center(
              child: Container(
                height: 500,
                width: 600,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
