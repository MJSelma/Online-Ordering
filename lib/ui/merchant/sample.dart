import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../provider/businessOutletProvider.dart';
import '../../provider/menu_provider.dart';
import '../controller/outletController.dart';
import '../data_class/businesses_class.dart';
import '../data_class/outlet_class.dart';
import '../data_class/region_class.dart';
import '../data_class/schedule_class.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  CollectionReference regionCollection =
      FirebaseFirestore.instance.collection('region');
  CollectionReference cusineCollection =
      FirebaseFirestore.instance.collection('cuisine');
  CollectionReference cusineStyleCollection =
      FirebaseFirestore.instance.collection('cuisineStyle');

  List<DocumentSnapshot> documentsx = [];
  List<BusinessesClass> businessesClass = [];
  List<OutletClass> outletClass = [];
  List<RegionClass> regionClass = [];
  List<DateTimeClass> scheduleDateTime = [];

  String outletId = '';
  String outletIdProvider = '';
  String currentItem = 'Select Outlet';
  String currentOutletName = '';
  String currentRegion = '';
  String currentRegionId = '';
  String currentCusine = '';
  String currentCusineId = '';
  String currentCusineStyle = '';
  String currentCusineStylId = '';

  OutletClass? dropDownValue;
  String businessName = '';
  String businessId = '';
  bool isSelectedOutlet = false;
  int indexYesNo = 0;
  int indexYesNoCategory = 0;
  int indexYesNoCategoryCount = 0;
  List<int> indexSchedule = [];
  List<int> indexScheduleAdded = [];
  bool isSetDefaultWall = false;
  bool isAbsorb = true;
  String saveEditButton = 'EDIT';
  int addHeight = 100;
  bool isPostbackLoad = false;

  TextEditingController txtSearchRegion = TextEditingController();
  String strSearchRegion = '';

  TextEditingController txtSearchCusine = TextEditingController();
  String strSearchCusine = '';

  TextEditingController txtSearchCusineStyle = TextEditingController();
  String strSearchCusineStyle = '';

  TextEditingController txtLocation = TextEditingController();
  String strLocation = '';
  // String strLocation = 'Queen Elizabeth Ave. 12, 20-233 Angel Town';

  TextEditingController txtNumber = TextEditingController();
  String strNumber = '';
  // String strNumber = '+343 59 456 3452';

  TextEditingController txtEmail = TextEditingController();
  String strEmail = '';
  // String strEmail = 'xxxww@coffeebean.com';

  TextEditingController txtDescription = TextEditingController();
  String strDescription = '';
  // String strDescription = 'Cafetteria, Bar';

  TextEditingController txtCurrency = TextEditingController();
  String strCurrency = '';
  // String strCurrency = 'USD';

  TextEditingController txtMondayStart = TextEditingController();
  String strMondayStart = '';

  TextEditingController txtMondayEnd = TextEditingController();
  String strMondayEnd = '';

  TextEditingController txtTuesdayStart = TextEditingController();
  String strTuesdayStart = '';

  TextEditingController txtTuesdayEnd = TextEditingController();
  String strTuesdayEnd = '';

  TextEditingController txtWednesdayStart = TextEditingController();
  String strWednesdayStart = '';

  TextEditingController txtWednesdayEnd = TextEditingController();
  String strWednesdayEnd = '';

  TextEditingController txtThursdaytart = TextEditingController();
  String stThursdayStart = '';

  TextEditingController txtThursdayEnd = TextEditingController();
  String strThursdayEnd = '';

  TextEditingController txtFridayStart = TextEditingController();
  String strFridayStart = '';

  TextEditingController txtFridayEnd = TextEditingController();
  String strFridayEnd = '';

  TextEditingController txtSaturdayStart = TextEditingController();
  String strSaturdayStart = '';

  TextEditingController txtSaturdayEnd = TextEditingController();
  String strSaturdayEnd = '';

  TextEditingController txtSundayStart = TextEditingController();
  String strSundayStart = '';

  TextEditingController txtSundayEnd = TextEditingController();
  String strSundayEnd = '';

  int intStar = 0;

  List<String> categoryList = <String>[
    'Cafetteria',
    'Bar',
    'Restaurant',
    'Bar2',
    'Cafetteria3',
    'Bar3',
    'Cafetteria4',
    'Bar4',
    'Cafetteria5',
    'Bar5',
    'Cafetteria6',
    'Bar6',
    'Cafetteria7',
    'Bar7'
  ];

  List<String> scheduleList = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  List<String> categoryListAdded = [];
  List<String> scheduleListAdded = [];

  @override
  Widget build(BuildContext context) {
    final bool isRefresh = context.select((MenuProvider p) => p.isRefresh);
    // final defaultOutletIdProvider =
    //     context.select((BusinessOutletProvider p) => p.defaultOutletId);
    final outletIdprovider =
        context.select((BusinessOutletProvider p) => p.selectedOutletId);
    final businessProviderRead = context.read<BusinessOutletProvider>();

    final docId = context.select((BusinessOutletProvider p) => p.docId);

    final businessNamex =
        context.select((BusinessOutletProvider p) => p.businessName);
    // final defaultOutletIdProviderx =
    //     context.select((BusinessOutletProvider p) => p.defaultOutletId);

    final outletClassx =
        context.select((BusinessOutletProvider p) => p.outletClass);
    final regionClassx =
        context.select((BusinessOutletProvider p) => p.regionClass);
    final isSelected =
        context.select((BusinessOutletProvider p) => p.isBusinessSelected);
    final scheduleDateTimex =
        context.select((BusinessOutletProvider p) => p.dateTimeClass);

    final businessesData = Provider.of<List<BusinessesClass>>(context);
    businessesClass = businessesData
        .where((item) =>
            item.defaultOutletId.toLowerCase() == outletId.toLowerCase())
        .toList();

    outletClass = outletClassx;
    businessName = businessNamex;
    businessId = docId;
    outletIdProvider = outletIdprovider;
    scheduleDateTime = scheduleDateTimex;

    // regionClass = regionClassx;
    print(regionClass.length);
    print('${outletId}outlet id here');
    regionClass =
        regionClass.where((item) => item.outletId == outletId).toList();
    print(regionClass.length);
    if (isSelected == true) {
      currentItem = 'Select Outlet';

      currentOutletName = '';
      businessProviderRead.setIsBusinessSelected(false);
    }
    if (currentItem == 'Select Outlet') {
      isSelectedOutlet = false;
    }

    void save() async {
      // List<String> category = [];

      print('saveOutlet');
      saveEditButton = 'EDIT';
      isAbsorb = true;
      strLocation = txtLocation.text;
      strNumber = txtNumber.text;
      strEmail = txtEmail.text;
      strDescription = txtDescription.text;
      strCurrency = txtCurrency.text;
      addHeight = 100;
      if (isSetDefaultWall == true) {
        context.read<BusinessOutletProvider>().setDefaultOutletId(outletId);
      }

      await saveBusinessOutlet(
          isSetDefaultWall,
          businessId,
          outletId,
          txtEmail.text,
          txtNumber.text,
          txtLocation.text,
          indexYesNo,
          txtCurrency.text,
          currentRegionId,
          currentRegion,
          currentCusineId,
          currentCusine,
          currentCusineStylId,
          currentCusineStyle,
          '',
          categoryListAdded,
          context);
      // businessProviderRead.setDocId(docId);
    }

    void update() async {
      saveEditButton = 'SAVE';
      isAbsorb = false;
      txtLocation.text = strLocation;
      txtNumber.text = strNumber;
      txtEmail.text = strEmail;
      txtDescription.text = strDescription;
      txtCurrency.text = strCurrency;
      addHeight = 0;
    }

    void getDefaultOutlet() {
      print('11111111111111111111');
      categoryListAdded.clear();
      for (var data in outletClass) {
        if (data.id.toLowerCase() == outletIdProvider.toLowerCase()) {
          currentItem = data.name;
          currentOutletName = data.name;
          strLocation = data.location;
          indexYesNo = data.isLocatedAt == true ? 0 : 1;
          strNumber = data.contactNumber;
          strEmail = data.email;
          strDescription = data.description;
          strCurrency = data.currency;
          intStar = data.star;
          txtLocation.text = strLocation;
          txtNumber.text = strNumber;
          txtEmail.text = strEmail;
          txtDescription.text = strDescription;
          txtCurrency.text = strCurrency;
          outletId = outletIdProvider;

          currentRegionId = data.regionId;
          currentRegion = data.regionName;
          currentCusineId = data.cuisineId;
          currentCusine = data.cuisineName;
          currentCusineStylId = data.cuisineStyleId;
          currentCusineStyle = data.cuisineStyleName;
          for (var data in data.category) {
            print(data);
            categoryListAdded.add(data);
          }
          context.read<BusinessOutletProvider>().setSelectedOutletId(outletId);
          context
              .read<BusinessOutletProvider>()
              .setCountry(data.country, data.location);
          // dropDownValue = outletClass;
          isSelectedOutlet = true;
          // isSetDefaultWall = true;
          for (var item in businessesClass) {
            item.defaultOutletId.toLowerCase() == outletId.toLowerCase()
                ? isSetDefaultWall = true
                : isSetDefaultWall = false;
          }
          isPostbackLoad = true;
        }
      }
      context.read<MenuProvider>().menuRefresh();
    }

    isRefresh == true
        ? WidgetsBinding.instance
            .addPostFrameCallback((_) => setState(getDefaultOutlet))
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Expanded(
        child: Container(
          // height: MediaQuery.sizeOf(context).height - addHeight,
          width: MediaQuery.sizeOf(context).width - 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            // color: const Color(0xffe9f9fc),
            color: Colors.grey.shade100,
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 10.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                              child: Text(
                            '$businessName $currentOutletName',
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ))
                        ],
                      ),
                      const Spacer(),
                      Visibility(
                        visible: currentOutletName != '',
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RatingBarIndicator(
                                  rating: 1,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 1,
                                  itemSize: 50.0,
                                  direction: Axis.horizontal,
                                ),
                                Container(
                                  child: Text(
                                    '$intStar Star-Points',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black54,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: currentOutletName != '',
                  child: AbsorbPointer(
                    absorbing: isAbsorb,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'location',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                Container(
                                    child: saveEditButton == 'SAVE'
                                        ? SizedBox(
                                            width: 600,
                                            child: TextField(
                                              controller: txtLocation,
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        : Text(
                                            strLocation,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          )),
                                Row(
                                  children: [
                                    const Text(
                                      'Is your store inside any Airport/Mall/Hotel/Theme Park',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Tooltip(
                                        message: strLocation,
                                        child: const Icon(Icons.location_pin))
                                  ],
                                ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                Row(
                                  children: [
                                    Checkbox(
                                      shape:
                                          const CircleBorder(eccentricity: 1.0),
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      value: indexYesNo == 0 ? true : false,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          indexYesNo = 0;
                                        });
                                      },
                                    ),
                                    const Text('Yes'),
                                    Checkbox(
                                      shape:
                                          const CircleBorder(eccentricity: 1.0),
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      value: indexYesNo == 1 ? true : false,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          indexYesNo = 1;
                                        });
                                      },
                                    ),
                                    const Text('No'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'Contacts',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                Container(
                                  child: saveEditButton == 'SAVE'
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 600,
                                              child: TextField(
                                                controller: txtNumber,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 600,
                                              child: TextField(
                                                controller: txtEmail,
                                                textAlign: TextAlign.start,
                                              ),
                                            )
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              strNumber,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              strEmail,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                const Text(
                                  'Schedule',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: scheduleDateTime.length,
                                    itemBuilder: (context, index) {
                                      // for (var item
                                      //     in scheduleClass[index]
                                      //         .schedule) {
                                      //   scheduleListAdded.add(item);
                                      // }
                                      // print(scheduleClass[index]
                                      //     .schedule);
                                      return Card(
                                        // color: const Color(
                                        //     0xffef7700),
                                        color: Colors.redAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_today,
                                                    size: 12,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      scheduleDateTime[index]
                                                          .date,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              ),
                                              Text(
                                                  '${scheduleDateTime[index].start} - ${scheduleDateTime[index].end}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: saveEditButton == 'SAVE',
                                  child: TextButton(
                                      onHover: (value) {},
                                      onPressed: () => showScheduleDialog(),
                                      child: const Text(
                                        'Edit schedule',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.red),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: SizedBox(
                                  // color: Colors.amberAccent,
                                  width: 300,
                                  height: 100,

                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: saveEditButton == 'SAVE'
                                        ? categoryList.length
                                        : categoryListAdded.length,
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              saveEditButton == 'SAVE'
                                                  ? Checkbox(
                                                      shape: const CircleBorder(
                                                          eccentricity: 1.0),
                                                      checkColor: Colors.white,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith(
                                                                  getColor),
                                                      value: categoryListAdded
                                                              .contains(
                                                                  categoryList[
                                                                      index])
                                                          ? true
                                                          : false,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          if (value == true) {
                                                            categoryListAdded
                                                                .add(
                                                                    categoryList[
                                                                        index]);
                                                          } else {
                                                            categoryListAdded
                                                                .removeWhere((item) =>
                                                                    item ==
                                                                    categoryList[
                                                                        index]);
                                                          }
                                                        });
                                                      },
                                                    )
                                                  : const Icon(
                                                      Icons.arrow_right),
                                              Text(saveEditButton == 'SAVE'
                                                  ? categoryList[index]
                                                  : categoryListAdded[index]),
                                            ],
                                          ),
                                        ),
                                      ));
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'CUISINE',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text(
                                      currentRegion == ''
                                          ? 'Choose Region'
                                          : currentRegion,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Visibility(
                                        visible: saveEditButton == 'SAVE',
                                        child: TextButton(
                                            onHover: (value) {},
                                            onPressed: () => showRegionDialog(),
                                            child: const Text(
                                              'change',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text(
                                      currentCusine == ''
                                          ? 'Choose Cuisine'
                                          : currentCusine,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Visibility(
                                        visible: saveEditButton == 'SAVE',
                                        child: TextButton(
                                            onHover: (value) {},
                                            onPressed: () =>
                                                showCuisineDialog(),
                                            child: const Text(
                                              'change',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'CUISINE STYLE',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text(
                                      currentCusineStyle == ''
                                          ? 'Choose Cuisine Style'
                                          : currentCusineStyle,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Visibility(
                                        visible: saveEditButton == 'SAVE',
                                        child: TextButton(
                                            onHover: (value) {},
                                            onPressed: () =>
                                                showCuisineStyleDialog(),
                                            child: const Text(
                                              'change',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Currency',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Container(
                                child: saveEditButton == 'SAVE'
                                    ? SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: txtCurrency,
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                    : Text(
                                        strCurrency,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Visibility(
                  visible: currentOutletName != '',
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SEASONAL BREAK',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'CLOSE LOCATION',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Text('Set default?'),
                          AbsorbPointer(
                            absorbing: isAbsorb,
                            child: Checkbox(
                              shape: const CircleBorder(eccentricity: 1.0),
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isSetDefaultWall,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (isSetDefaultWall == true) {
                                    isSetDefaultWall = false;
                                  } else {
                                    isSetDefaultWall = true;
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: const Color(0xffef7700),
                                ),
                                child: Container(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (isAbsorb == false) {
                                          save();
                                        } else {
                                          update();
                                        }
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 5, 0),
                                          child: Icon(
                                            isAbsorb == true
                                                ? Icons.edit
                                                : Icons.save,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                        Text(
                                          saveEditButton,
                                          style: const TextStyle(
                                            fontFamily: 'SFPro',
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showRegionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            TextEditingController txtaddRegion = TextEditingController();

            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: const Text(
                'Region',
                textAlign: TextAlign.center,
              ),
              children: [
                // SizedBox(
                //   height: 100,
                //   width: 300,
                //   child: IconButton(
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //       icon: const Icon(Icons.exit_to_app)),
                // ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          strSearchRegion = value;
                        });
                      },
                      controller: txtSearchRegion,
                      decoration: const InputDecoration(hintText: 'Search'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 400,
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: regionCollection
                        // .where('outletId', isEqualTo: outletId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        documentsx = snapshot.data!.docs;
                        print(strSearchRegion);
                        if (strSearchRegion.isNotEmpty) {
                          documentsx = documentsx.where((element) {
                            return element
                                .get('name')
                                .toString()
                                .toLowerCase()
                                .contains(strSearchRegion.toLowerCase());
                          }).toList();
                        }

                        return ListView.builder(
                          itemCount: documentsx.length,
                          itemBuilder: (context, index) {
                            print(strSearchRegion);
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          documentsx[index]['name'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    currentRegionId = documentsx[index]['id'];
                                    currentRegion = documentsx[index]['name'];
                                    currentCusine = '';
                                    currentCusineId = '';
                                    print(currentRegion);
                                    // isEditRegion = true;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No data"));
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextField(
                        controller: txtaddRegion,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter region here...',
                            suffixIcon: Tooltip(
                              message: 'save',
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (txtaddRegion.text.isEmpty) return;
                                    saveRegion(
                                        'dlr005', outletId, txtaddRegion.text);
                                  });
                                },
                                icon: const Icon(
                                  Icons.save,
                                  color: Color(0xffbef7700),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(
                                  0.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              // BoxShadow(
                              //   color: Colors.white,
                              //   offset: Offset(0.0, 0.0),
                              //   blurRadius: 0.0,
                              //   spreadRadius: 0.0,
                              // ), //BoxShadow
                            ],
                            color: const Color(0xffbef7700),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  showCuisineDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            TextEditingController txtAddCuisine = TextEditingController();

            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: const Text(
                'Cuisine',
                textAlign: TextAlign.center,
              ),
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          strSearchCusine = value;
                        });
                      },
                      controller: txtSearchCusine,
                      decoration: const InputDecoration(hintText: 'Search'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 400,
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: cusineCollection
                        .where('regionId', isEqualTo: currentRegionId)
                        // .where('outletId',
                        //     arrayContains: txtSearchRegion.text != ''
                        //         ? outletId
                        //         : txtSearchRegion.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        documentsx = snapshot.data!.docs;
                        print(strSearchCusine);
                        if (strSearchCusine.isNotEmpty) {
                          documentsx = documentsx.where((element) {
                            return element
                                .get('name')
                                .toString()
                                .toLowerCase()
                                .contains(strSearchCusine.toLowerCase());
                          }).toList();
                        }

                        return ListView.builder(
                          itemCount: documentsx.length,
                          itemBuilder: (context, index) {
                            // var doc = snapshot.data!.docs;
                            print(strSearchCusine);
                            // doc.contains(strSearchRegion);
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ListTile(
                                // leading: Image.asset(
                                //   'assets/chat.png',
                                //   color: Colors.redAccent[700],
                                //   height: 24,
                                // ),
                                // trailing: Tooltip(
                                //   message: 'delete',
                                //   child: IconButton(
                                //       onPressed: () {
                                //         setState(() {
                                //           print(documentsx[index]['id']);
                                //           deleCuisine(documentsx[index]['id']);
                                //         });
                                //       },
                                //       icon: const Icon(Icons.delete)),
                                // ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          documentsx[index]['name'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    currentCusineId = documentsx[index]['id'];
                                    currentCusine = documentsx[index]['name'];

                                    // isEditRegion = true;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No data"));
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(
                                  0.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              // BoxShadow(
                              //   color: Colors.white,
                              //   offset: Offset(0.0, 0.0),
                              //   blurRadius: 0.0,
                              //   spreadRadius: 0.0,
                              // ), //BoxShadow
                            ],
                            color: const Color(0xffbef7700),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextField(
                        controller: txtAddCuisine,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter cuisine here...',
                            suffixIcon: Tooltip(
                              message: 'save',
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (txtAddCuisine.text.isEmpty) return;
                                    saveCuisine('dlc006', currentRegionId,
                                        txtAddCuisine.text);
                                  });
                                },
                                icon: const Icon(
                                  Icons.save,
                                  color: Color(0xffbef7700),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  showCuisineStyleDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            TextEditingController txtAddCuisineStyle = TextEditingController();

            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: const Text(
                'Cuisine Style',
                textAlign: TextAlign.center,
              ),
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          strSearchCusineStyle = value;
                        });
                      },
                      controller: txtSearchCusineStyle,
                      decoration: const InputDecoration(hintText: 'Search'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 400,
                  width: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: cusineStyleCollection
                        // .where('outletId', isEqualTo: outletId)
                        // .where('outletId',
                        //     arrayContains: txtSearchRegion.text != ''
                        //         ? outletId
                        //         : txtSearchRegion.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        documentsx = snapshot.data!.docs;
                        print(strSearchCusineStyle);
                        if (strSearchCusineStyle.isNotEmpty) {
                          documentsx = documentsx.where((element) {
                            return element
                                .get('name')
                                .toString()
                                .toLowerCase()
                                .contains(strSearchCusineStyle.toLowerCase());
                          }).toList();
                        }

                        return ListView.builder(
                          itemCount: documentsx.length,
                          itemBuilder: (context, index) {
                            // var doc = snapshot.data!.docs;
                            print(strSearchCusineStyle);
                            // doc.contains(strSearchRegion);
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ListTile(
                                // leading: Image.asset(
                                //   'assets/chat.png',
                                //   color: Colors.redAccent[700],
                                //   height: 24,
                                // ),
                                // trailing: Tooltip(
                                //   message: 'delete',
                                //   child: IconButton(
                                //       onPressed: () {
                                //         setState(() {
                                //           print(documentsx[index]['id']);
                                //           deleCuisineStyle(
                                //               documentsx[index]['id']);
                                //         });
                                //       },
                                //       icon: const Icon(Icons.delete)),
                                // ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          documentsx[index]['name'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    currentCusineStylId =
                                        documentsx[index]['id'];
                                    currentCusineStyle =
                                        documentsx[index]['name'];

                                    // isEditRegion = true;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No data"));
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(
                                  0.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              // BoxShadow(
                              //   color: Colors.white,
                              //   offset: Offset(0.0, 0.0),
                              //   blurRadius: 0.0,
                              //   spreadRadius: 0.0,
                              // ), //BoxShadow
                            ],
                            color: const Color(0xffbef7700),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextField(
                        controller: txtAddCuisineStyle,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter cuisine here...',
                            suffixIcon: Tooltip(
                              message: 'save',
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (txtAddCuisineStyle.text.isEmpty) {
                                      return;
                                    }
                                    saveCuisineStyle('dlcs006', outletId,
                                        txtAddCuisineStyle.text);
                                  });
                                },
                                icon: const Icon(
                                  Icons.save,
                                  color: Color(0xffbef7700),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  showScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 400.0),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.exit_to_app)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                      child: Center(
                        child: Text('Schedule', style: TextStyle(fontSize: 26)),
                      ),
                    ),
                    SizedBox(
                      height: 530,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          // scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    'Monday',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Start',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtMondayStart,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            if (txtMondayStart.text != '') {
                                              indexScheduleAdded.add(0);
                                            }

                                            txtMondayStart.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('To'),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'End',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtMondayEnd,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(0);
                                            txtMondayEnd.text = '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    'Tuesday',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Start',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtTuesdayStart,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(1);
                                            txtTuesdayStart.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('To'),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'End',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtTuesdayEnd,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(1);
                                            txtTuesdayEnd.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    'Wednesday',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Start',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtWednesdayStart,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(2);
                                            txtWednesdayStart.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('To'),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'End',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtWednesdayEnd,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(2);
                                            txtWednesdayEnd.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    'Thursday',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Start',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtThursdaytart,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(3);
                                            txtThursdaytart.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('To'),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'End',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtThursdayEnd,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(3);
                                            txtThursdayEnd.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    'Friday',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Start',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtFridayStart,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(4);
                                            txtFridayStart.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('To'),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'End',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtFridayEnd,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(4);
                                            txtFridayEnd.text = '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    'Saturday',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Start',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtSaturdayStart,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(5);
                                            txtSaturdayStart.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('To'),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'End',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtSaturdayEnd,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(5);
                                            txtSaturdayEnd.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    'Sunday',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Start',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtSundayStart,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(6);
                                            txtSundayStart.text =
                                                '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('To'),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'End',
                                            hintTextDirection:
                                                TextDirection.ltr),
                                        controller: txtSundayEnd,
                                        onTap: () async {
                                          final TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 7, minute: 15),
                                          );
                                          var hour = newTime!.hour;
                                          var minute = newTime.minute;

                                          setState(() {
                                            indexScheduleAdded.add(6);
                                            txtSundayEnd.text = '$hour:$minute';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(
                                      0.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  // BoxShadow(
                                  //   color: Colors.white,
                                  //   offset: Offset(0.0, 0.0),
                                  //   blurRadius: 0.0,
                                  //   spreadRadius: 0.0,
                                  // ), //BoxShadow
                                ],
                                color: const Color(0xffbef7700),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.save,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              for (var data in indexScheduleAdded) {
                                indexSchedule.add(data);
                              }
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return const Color(0xffef7700);
}
