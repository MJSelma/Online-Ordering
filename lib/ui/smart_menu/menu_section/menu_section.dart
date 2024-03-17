import 'dart:typed_data';

import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:drinklinkmerchant/ui/constant/theme_data.dart';
import 'package:drinklinkmerchant/widgets/button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MenuSectionItems extends StatefulWidget {
  const MenuSectionItems({super.key});

  @override
  State<MenuSectionItems> createState() => _MenuSectionItemsState();
}

class _MenuSectionItemsState extends State<MenuSectionItems> {
  int? ChooseFood;
  bool isPrepare = false;
  bool isCookLevel = false;
  bool isMeat = false;
  bool isEgg = false;
  bool isDescription = false;
  bool isIngridient = false;
  bool isAllergens = false;
  bool isSteak = false;
  bool isAddons = false;
  bool isOption = false;
  bool addons = false;
  bool sideDish = false;
  bool suace = false;
  bool adonsDes = false;
  bool adonsInd = false;
  bool adonsAler = false;
  bool adonsNoPrice = false;
  bool isUploadPic = false;
  bool isCalCogs = false;
  List<Item> itemList = [];
  List<PortionModel> pList = [];
  TextEditingController portionController = TextEditingController(text: '');
  TextEditingController portionPriceController =
      TextEditingController(text: '');
  TextEditingController txtItemName = TextEditingController(text: '');
  TextEditingController txtItemPrice = TextEditingController(text: '');

  //Ingredient var
  TextEditingController inName = TextEditingController(text: '');
  TextEditingController inQuant = TextEditingController(text: '');
  TextEditingController inUnit = TextEditingController(text: '');
  TextEditingController inIdk = TextEditingController(text: '');

  TextEditingController inCost = TextEditingController(text: '');
  TextEditingController inExtraCost = TextEditingController(text: '');
  TextEditingController inTotCost = TextEditingController(text: '');

  TextEditingController adDesText = TextEditingController(text: '');
  TextEditingController adIngText = TextEditingController(text: '');
  TextEditingController adAlText = TextEditingController(text: '');

  String? uploadimage;
  Uint8List? webImage;
  int sendAllWst = 0;
  String workingStaion = 'wst';
  int drinkItem = 0;

  bool drinkSold1 = false;
  bool drinkSold2 = false;
  bool drinkSold3 = false;
  bool drinkSold4 = false;

  int drinkSoldOption = 0;
  int drinkSoldOption1 = 0;
  bool isDoubleShot = false;
  bool isMixDoubleShot = false;
  bool isMixDiff = false;
  String totalCost = '0';
  String earnings = '100';

  List<AddOns> adList = [];
  List<AddOns> optList = [];
  List<Ingredients> ingredientsList = [];
  TextEditingController adOnsName = TextEditingController(text: '');
  TextEditingController adonsPrice = TextEditingController(text: '');
  TextEditingController optName = TextEditingController(text: '');
  TextEditingController optPrice = TextEditingController(text: '');

  int pageItemAdd = 0;
  List<String> adsUnitList = ['Volume', 'Unit', 'Weight'];
  List<String> adWeight = ['kl', 'g', 'pounds'];
  List<String> adVolume = ['l', 'ml', 'gal'];
  List<String> adUnit = ['pack', 'pcs', 'box'];

  String selectedVolumeUnit = 'Unit';
  String selectedWeight = 'kl';
  String selectedVolume = 'l';
  String selectedUnit = 'pcs';
  bool isAdd = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageItemAdd = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffef7700),
            style: BorderStyle.solid,
            width: 1.8,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('WST'),
                  const Spacer(),
                  Visibility(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isAdd = true;
                        });
                        await showDialog<bool>(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return addMenuItemSection(context);
                          },
                        );
                        setState(() {
                          pageItemAdd = 0;
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffef7700)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'ADD MENU ITEM',
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: 14,
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
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text('ITEMS LIST'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 500,
                width: MediaQuery.of(context).size.width - 400,
                child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        itemList[index].name,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      itemList[index].price,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      ' (${itemList[index].percentage}%)',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isAdd = false;
                                        });
                                        await showDialog<bool>(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return addMenuItemSection(context);
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.info,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String actString = '';
                                        if (itemList[index].status == true) {
                                          actString = 'deactivate';
                                        } else {
                                          actString = 'activate';
                                        }
                                        await showDialog<bool>(
                                          context: context,
                                          builder: (context) {
                                            return DeActItem(
                                                context,
                                                index,
                                                actString,
                                                itemList[index].status);
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color:
                                                itemList[index].status == true
                                                    ? iconButtonTextColorPurple
                                                    : btnColorGreyDark1),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              itemList[index].status != true
                                                  ? 'ACT'
                                                  : 'DE-ACT',
                                              style: TextStyle(
                                                fontFamily: 'SFPro',
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xffef7700),
                                          style: BorderStyle.solid,
                                          width: 1.8,
                                        ),
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'WST',
                                            style: TextStyle(
                                              fontFamily: 'SFPro',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'EDIT LANGUAGE',
                                            style: TextStyle(
                                              fontFamily: 'SFPro',
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  Widget DeActItem(BuildContext context, int index, String textAct, bool stat) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: systemDefaultColorOrange,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          title: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: 400,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Are you sure you want to $textAct the item',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 113, 112, 112),
                                  style: BorderStyle.solid,
                                  width: 1.8,
                                ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontFamily: 'SFPro',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (stat) {
                                  itemList[index].status = false;
                                } else {
                                  itemList[index].status = true;
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffef7700),
                                  style: BorderStyle.solid,
                                  width: 1.8,
                                ),
                                color: const Color(0xffef7700),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontFamily: 'SFPro',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
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
          ),
        );
      },
    );
  }

  Widget addMenuItemSection(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: systemDefaultColorOrange,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          title: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: 1000,
                height: 700,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      if (pageItemAdd == 0) ...[
                        MenuItemSetupPage(context, setStateDialog),
                      ] else if (pageItemAdd == 1) ...[
                        if (ChooseFood == 1) ...[
                          ItemName(context, setStateDialog),
                        ] else if (ChooseFood == 2) ...[
                          ItemNameDrinks(context, setStateDialog),
                        ] else if (ChooseFood == 3) ...[
                          ItemNameMixology(context, setStateDialog),
                        ] else ...[
                          ItemName(context, setStateDialog),
                        ]
                      ] else if (pageItemAdd == 2) ...[
                        DIAPage(context, setStateDialog),
                      ] else if (pageItemAdd == 3) ...[
                        AddOnsPage(context, setStateDialog),
                      ] else if (pageItemAdd == 4) ...[
                        PictureWst(context, setStateDialog),
                      ] else if (pageItemAdd == 5) ...[
                        CogsEarnings(context, setStateDialog),
                      ] else
                        ...[]
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox MenuItemSetupPage(BuildContext context, StateSetter setStateDialog) {
    return SizedBox(
      width: 1000,
      height: 600,
      child: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 900,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('MENU ITEM SET UP PAGE',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                        // const Spacer(),
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   child: InkWell(
                        //     child: const Icon(
                        //       Icons.close,
                        //       size: 14,
                        //     ),
                        //     onTap: () {
                        //       Navigator.pop(context);
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //MENU info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setStateDialog(() {
                                    ChooseFood = 1;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: ChooseFood == 1,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            ChooseFood = 1;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'FOOD ITEM',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '(Ex. Pasta, Meat, Fish, Dessert)',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: ChooseFood == 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 20, 0, 0),
                                  child: Row(
                                    children: [
                                      const Column(
                                        children: [
                                          Text(
                                            'COOKING LEVEL REQUIRED',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              'This creates a window in the Drinklink app asking the cooking level of the meat. Ideal for Steaks',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Switch(
                                        value: isCookLevel,
                                        activeColor: const Color(0xffef7700),
                                        onChanged: (bool value) {
                                          setStateDialog(() {
                                            isCookLevel = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isCookLevel,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 40, 0, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Column(
                                            children: [
                                              Text(
                                                'Meat',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Switch(
                                            value: isMeat,
                                            activeColor:
                                                const Color(0xffef7700),
                                            onChanged: (bool value) {
                                              setStateDialog(() {
                                                isMeat = value;
                                                if (isMeat == true) {
                                                  isEgg = false;
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          const Column(
                                            children: [
                                              Text(
                                                'Egg',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Switch(
                                            value: isEgg,
                                            activeColor:
                                                const Color(0xffef7700),
                                            onChanged: (bool value) {
                                              setStateDialog(() {
                                                isEgg = value;
                                                if (isEgg == true) {
                                                  isMeat = false;
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateDialog(() {
                                    ChooseFood = 2;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: ChooseFood == 2,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            ChooseFood = 2;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'DRINK ITEM',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '(Ex. Beer, Coca Cola, Water)',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: ChooseFood == 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              drinkItem = 1;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: drinkItem == 1,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      drinkItem = 1;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'SOFT DRINKS',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              drinkItem = 2;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: drinkItem == 2,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      drinkItem = 2;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'BEER',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              drinkItem = 3;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: drinkItem == 3,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      drinkItem = 3;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'WINE',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              drinkItem = 4;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: drinkItem == 4,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      drinkItem = 4;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'SPIRIT',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateDialog(() {
                                    ChooseFood = 3;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: ChooseFood == 3,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            ChooseFood = 3;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'MIXOLOGY ITEM',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '(Ex. Mojito, Negroni, Gin-Tonic)',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //DateTime info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setStateDialog(() {
                                    ChooseFood = 4;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: ChooseFood == 4,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            ChooseFood = 4;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'MEAL PACKAGE',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateDialog(() {
                                    ChooseFood = 5;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: ChooseFood == 5,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            ChooseFood = 5;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'PROMOTION',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateDialog(() {
                                    ChooseFood = 6;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: ChooseFood == 6,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            ChooseFood = 6;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'FOOD PRODUCT',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Ex. Chocolate bar etc',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateDialog(() {
                                    ChooseFood = 7;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: ChooseFood == 7,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            ChooseFood = 7;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'PRODUCT ITEM',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Ex. Gadgets',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'NEXT',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setState(() {
                        setStateDialog(() {
                          pageItemAdd = 1;
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  indicatorCirlcePage(StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Tooltip(
            message: 'Menu Item Setup Page',
            child: GestureDetector(
              onTap: () {
                if (isAdd == false)
                  setter(() {
                    pageItemAdd = 0;
                  });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color:
                      pageItemAdd == 0 ? Colors.amber[800] : Colors.amber[100],
                ),
              ),
            ),
          ),
          Tooltip(
            message: 'Menu Item Name & Price',
            child: GestureDetector(
              onTap: () {
                if (isAdd == false)
                  setter(() {
                    pageItemAdd = 1;
                  });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color:
                      pageItemAdd == 1 ? Colors.amber[800] : Colors.amber[100],
                ),
              ),
            ),
          ),
          Tooltip(
            message: 'D.I.A',
            child: GestureDetector(
              onTap: () {
                if (isAdd == false)
                  setter(() {
                    pageItemAdd = 2;
                  });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color:
                      pageItemAdd == 2 ? Colors.amber[800] : Colors.amber[100],
                ),
              ),
            ),
          ),
          Tooltip(
            message: 'ADD-ONS',
            child: GestureDetector(
              onTap: () {
                if (isAdd == false)
                  setter(() {
                    pageItemAdd = 3;
                  });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color:
                      pageItemAdd == 3 ? Colors.amber[800] : Colors.amber[100],
                ),
              ),
            ),
          ),
          Tooltip(
            message: 'Picture & WST',
            child: GestureDetector(
              onTap: () {
                if (isAdd == false)
                  setter(() {
                    pageItemAdd = 4;
                  });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color:
                      pageItemAdd == 4 ? Colors.amber[800] : Colors.amber[100],
                ),
              ),
            ),
          ),
          Tooltip(
            message: 'COGS & Earnings',
            child: GestureDetector(
              onTap: () {
                if (isAdd == false)
                  setter(() {
                    pageItemAdd = 5;
                  });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.circle,
                  color:
                      pageItemAdd == 5 ? Colors.amber[800] : Colors.amber[100],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox ItemNameMixology(BuildContext context, StateSetter setStateDialog) {
    return SizedBox(
      width: 1000,
      height: 700,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 900,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('MENU ITEM SET UP PAGE',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                        // const Spacer(),
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   child: InkWell(
                        //     child: const Icon(
                        //       Icons.close,
                        //       size: 14,
                        //     ),
                        //     onTap: () {
                        //       Navigator.pop(context);
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //MENU info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text(
                                  'ENTER ITEM NAME',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: txtItemName,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        //ADDPRICE HERE
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        'ENTER PRICE',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller: txtItemPrice,
                                                ),
                                              )),
                                          const Text(
                                            'USD',
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'DOUBLE SHOT',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Switch(
                                        value: isMixDoubleShot,
                                        activeColor: const Color(0xffef7700),
                                        onChanged: (bool value) {
                                          setStateDialog(() {
                                            isMixDoubleShot = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    //asdasdasd
                                    visible: isMixDoubleShot,
                                    child: Row(
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                const Text(
                                                  'PRICE',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextField(
                                                        controller:
                                                            portionPriceController,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'USD',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 20, 0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  setStateDialog(() {
                                                    String id =
                                                        (pList.length + 1)
                                                            .toString();
                                                    PortionModel po =
                                                        PortionModel(
                                                            id,
                                                            portionController
                                                                .text,
                                                            portionPriceController
                                                                .text,
                                                            false);
                                                    pList.add(po);
                                                  });
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: const Color(
                                                          0xffef7700)),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'ADD',
                                                        style: TextStyle(
                                                          fontFamily: 'SFPro',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'DIFFERENT OPTION',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Switch(
                                        value: isMixDiff,
                                        activeColor: const Color(0xffef7700),
                                        onChanged: (bool value) {
                                          setStateDialog(() {
                                            isMixDiff = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    //asdasdasd
                                    visible: isMixDiff,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                const Text(
                                                  'ENTER NAME',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextField(
                                                        controller:
                                                            portionController,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const Text(
                                                      'PRICE',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            controller:
                                                                portionPriceController,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'USD',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      setStateDialog(() {
                                                        String id =
                                                            (pList.length + 1)
                                                                .toString();
                                                        PortionModel po =
                                                            PortionModel(
                                                                id,
                                                                portionController
                                                                    .text,
                                                                portionPriceController
                                                                    .text,
                                                                false);
                                                        pList.add(po);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          color: const Color(
                                                              0xffef7700)),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'ADD',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'SFPro',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //DateTime info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //PRICE RESULT HERE

                        //Show portionList

                        const SizedBox(
                          width: 400,
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'PORTION SIZE',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'PRICE',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text('  '),
                              ]),
                        ),
                        SizedBox(
                          height: 200,
                          width: 400,
                          child: ListView.builder(
                              itemCount: pList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: 400,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                pList[index].name,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                pList[index].price,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Checkbox(
                                                  value: pList[index].status,
                                                  onChanged: null)
                                            ]),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'NEXT',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setState(() {
                        setStateDialog(() {
                          pageItemAdd = 2;
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox ItemNameDrinks(BuildContext context, StateSetter setStateDialog) {
    return SizedBox(
      width: 1000,
      height: 700,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                width: 900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('MENU ITEM SET UP PAGE',
                        style: TextStyle(
                            color: systemDefaultColorOrange,
                            fontWeight: FontWeight.bold)),
                    // const Spacer(),
                    // Container(
                    //   alignment: Alignment.topRight,
                    //   child: InkWell(
                    //     child: const Icon(
                    //       Icons.close,
                    //       size: 14,
                    //     ),
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //MENU info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text(
                                  'ENTER ITEM NAME',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: txtItemName,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ITEM SOLD DIFFERENT SIZE',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Ex. Almond Milk, Coconut Milk etc etc',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Switch(
                                    value: drinkSold1,
                                    activeColor: const Color(0xffef7700),
                                    onChanged: (bool value) {
                                      setStateDialog(() {
                                        drinkSold1 = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: drinkSold1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setStateDialog(() {
                                                  drinkSoldOption1 = 1;
                                                  portionController.text =
                                                      'SMALL';
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Checkbox(
                                                      value:
                                                          drinkSoldOption1 == 1,
                                                      onChanged: (value) {
                                                        setStateDialog(() {
                                                          drinkSoldOption1 = 1;
                                                          portionController
                                                              .text = 'SMALL';
                                                        });
                                                      }),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    'SMALL',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setStateDialog(() {
                                                  drinkSoldOption1 = 2;
                                                  portionController.text =
                                                      'MEDIUM';
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Checkbox(
                                                      value:
                                                          drinkSoldOption1 == 2,
                                                      onChanged: (value) {
                                                        setStateDialog(() {
                                                          drinkSoldOption1 = 2;
                                                          portionController
                                                              .text = 'MEDIUM';
                                                        });
                                                      }),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    'MEDIUM',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setStateDialog(() {
                                                  drinkSoldOption1 = 3;
                                                  portionController.text =
                                                      'LARGE';
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Checkbox(
                                                      value:
                                                          drinkSoldOption1 == 3,
                                                      onChanged: (value) {
                                                        setStateDialog(() {
                                                          drinkSoldOption1 = 3;
                                                          portionController
                                                              .text = 'LARGE';
                                                        });
                                                      }),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    'LARGE',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setStateDialog(() {
                                                  drinkSoldOption1 = 4;
                                                  portionController.text =
                                                      'EXTRA LARGE';
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Checkbox(
                                                      value:
                                                          drinkSoldOption1 == 4,
                                                      onChanged: (value) {
                                                        setStateDialog(() {
                                                          drinkSoldOption1 = 4;
                                                          portionController
                                                                  .text =
                                                              'EXTRA LARGE';
                                                        });
                                                      }),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    'EXTRA LARGE',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const Text(
                                                      'CUSTOMIZED NAME',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            onChanged: (value) {
                                                              if (value
                                                                  .isNotEmpty) {
                                                                setStateDialog(
                                                                    () {
                                                                  drinkSoldOption1 =
                                                                      0;
                                                                });
                                                              }
                                                            },
                                                            controller:
                                                                portionController,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          'PRICE',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    portionPriceController,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'USD',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setStateDialog(() {
                                                String id = (pList.length + 1)
                                                    .toString();
                                                PortionModel po = PortionModel(
                                                    id,
                                                    portionController.text,
                                                    portionPriceController.text,
                                                    false);
                                                pList.add(po);
                                              });
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffef7700)),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                      fontFamily: 'SFPro',
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'MULTIPLE OPTIONS AVAILABLE',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Ex. Almond Milk, Coconut Milk etc etc',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Switch(
                                    value: drinkSold2,
                                    activeColor: const Color(0xffef7700),
                                    onChanged: (bool value) {
                                      setStateDialog(() {
                                        drinkSold2 = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: drinkSold2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const Text(
                                                      'CUSTOMIZED NAME',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            onChanged: (value) {
                                                              if (value
                                                                  .isNotEmpty) {
                                                                setStateDialog(
                                                                    () {
                                                                  drinkSoldOption1 =
                                                                      0;
                                                                });
                                                              }
                                                            },
                                                            controller:
                                                                portionController,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          'PRICE',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    txtItemPrice,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'USD',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setStateDialog(() {
                                                String id = (pList.length + 1)
                                                    .toString();
                                                PortionModel po = PortionModel(
                                                    id,
                                                    portionController.text,
                                                    portionPriceController.text,
                                                    false);
                                                pList.add(po);
                                              });
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffef7700)),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                      fontFamily: 'SFPro',
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ITEM SOLD BY BOTTLE',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Ex. Water, wine, beer',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Switch(
                                    value: drinkSold3,
                                    activeColor: const Color(0xffef7700),
                                    onChanged: (bool value) {
                                      setStateDialog(() {
                                        drinkSold3 = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: drinkSold3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const Text(
                                                      'CUSTOMIZED NAME',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            onChanged: (value) {
                                                              if (value
                                                                  .isNotEmpty) {
                                                                setStateDialog(
                                                                    () {
                                                                  drinkSoldOption1 =
                                                                      0;
                                                                });
                                                              }
                                                            },
                                                            controller:
                                                                portionController,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          'PRICE',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    portionPriceController,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'USD',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setStateDialog(() {
                                                String id = (pList.length + 1)
                                                    .toString();
                                                PortionModel po = PortionModel(
                                                    id,
                                                    portionController.text,
                                                    portionPriceController.text,
                                                    false);
                                                pList.add(po);
                                              });
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffef7700)),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                      fontFamily: 'SFPro',
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ITEM SOLD BY GLASS',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Ex. Wine Glass, Beer Pint',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Switch(
                                    value: drinkSold4,
                                    activeColor: const Color(0xffef7700),
                                    onChanged: (bool value) {
                                      setStateDialog(() {
                                        drinkSold4 = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: drinkSold4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const Text(
                                                      'CUSTOMIZED NAME',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            onChanged: (value) {
                                                              if (value
                                                                  .isNotEmpty) {
                                                                setStateDialog(
                                                                    () {
                                                                  drinkSoldOption1 =
                                                                      0;
                                                                });
                                                              }
                                                            },
                                                            controller:
                                                                portionController,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        const Text(
                                                          'PRICE',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    portionPriceController,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'USD',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setStateDialog(() {
                                                String id = (pList.length + 1)
                                                    .toString();
                                                PortionModel po = PortionModel(
                                                    id,
                                                    portionController.text,
                                                    portionPriceController.text,
                                                    false);
                                                pList.add(po);
                                              });
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffef7700)),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                      fontFamily: 'SFPro',
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //DateTime info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Visibility(
                                visible: drinkSold4 == false &&
                                    drinkSold3 == false &&
                                    drinkSold2 == false &&
                                    drinkSold1 == false,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'ENTER PRICE',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextField(
                                                      // controller: txtmenusectionName,
                                                      ),
                                                )),
                                            const Text(
                                              'USD',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Column(
                                        children: [
                                          Text(
                                            'DOUBLE SHOT',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Switch(
                                        value: isDoubleShot,
                                        activeColor: const Color(0xffef7700),
                                        onChanged: (bool value) {
                                          setStateDialog(() {
                                            isDoubleShot = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Column(
                                        children: [
                                          Text(
                                            'NO-ICE OPTION',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Switch(
                                        value: isDoubleShot,
                                        activeColor: const Color(0xffef7700),
                                        onChanged: (bool value) {
                                          setStateDialog(() {
                                            isDoubleShot = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Text(
                                            'ENTER PRICE',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextField(
                                                      controller: txtItemPrice,
                                                    ),
                                                  )),
                                              const Text(
                                                'USD',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Visibility(
                                visible: isSteak,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          setStateDialog(() {
                                            String id =
                                                (pList.length + 1).toString();
                                            PortionModel po = PortionModel(
                                                id,
                                                portionController.text,
                                                portionPriceController.text,
                                                false);
                                            pList.add(po);
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: const Color(0xffef7700)),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'ADD',
                                                style: TextStyle(
                                                  fontFamily: 'SFPro',
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //PRICE RESULT HERE

                        //Show portionList
                        Visibility(
                          visible: isSteak,
                          child: const Text(
                            'PORTIONS LISTED',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Visibility(
                          visible: isSteak,
                          child: const SizedBox(
                            width: 400,
                            height: 50,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PORTION SIZE',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'PRICE',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text('  '),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: 400,
                          child: ListView.builder(
                              itemCount: pList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: 400,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                pList[index].name,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                pList[index].price,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Checkbox(
                                                  value: pList[index].status,
                                                  onChanged: null)
                                            ]),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'NEXT',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setState(() {
                        setStateDialog(() {
                          pageItemAdd = 2;
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox ItemName(BuildContext context, StateSetter setStateDialog) {
    return SizedBox(
      width: 1000,
      height: 700,
      child: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 900,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('MENU ITEM SET UP PAGE',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                        // const Spacer(),
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   child: InkWell(
                        //     child: const Icon(
                        //       Icons.close,
                        //       size: 14,
                        //     ),
                        //     onTap: () {
                        //       Navigator.pop(context);
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //MENU info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text(
                                  'ENTER ITEM NAME',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: txtItemName,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        //ADDPRICE HERE
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Visibility(
                                visible: !isSteak,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'ENTER PRICE',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    enabled: !isSteak,
                                                    controller: txtItemPrice,
                                                  ),
                                                )),
                                            const Text(
                                              'USD',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Column(
                                    children: [
                                      Text(
                                        'SET PRICES FOR MULTIPLE PORTIONS',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Ideal for Steaks orders',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Switch(
                                    value: isSteak,
                                    activeColor: const Color(0xffef7700),
                                    onChanged: (bool value) {
                                      setStateDialog(() {
                                        isSteak = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Visibility(
                                visible: isSteak,
                                child: const Text(
                                  'DISHES',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Visibility(
                                visible: isSteak,
                                child: Row(
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            const Text(
                                              'ENTER PORTION',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller:
                                                        portionController,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Visibility(
                                      visible: isSteak,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const Text(
                                                'ENTER PRICE',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextField(
                                                          controller:
                                                              portionPriceController,
                                                        ),
                                                      )),
                                                  const Text(
                                                    'USD',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Visibility(
                                visible: isSteak,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          setStateDialog(() {
                                            String id =
                                                (pList.length + 1).toString();
                                            PortionModel po = PortionModel(
                                                id,
                                                portionController.text,
                                                portionPriceController.text,
                                                false);
                                            pList.add(po);
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: const Color(0xffef7700)),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'ADD',
                                                style: TextStyle(
                                                  fontFamily: 'SFPro',
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //DateTime info
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //PRICE RESULT HERE

                        //Show portionList
                        Visibility(
                          visible: isSteak,
                          child: const Text(
                            'PORTIONS LISTED',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Visibility(
                          visible: isSteak,
                          child: const SizedBox(
                            width: 400,
                            height: 50,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PORTION SIZE',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'PRICE',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text('  '),
                                ]),
                          ),
                        ),
                        Visibility(
                          visible: isSteak,
                          child: SizedBox(
                            height: 200,
                            width: 400,
                            child: ListView.builder(
                                itemCount: pList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: SizedBox(
                                          width: 400,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  pList[index].name,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  pList[index].price,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                Checkbox(
                                                    value: pList[index].status,
                                                    onChanged: null)
                                              ]),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'NEXT',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setState(() {
                        setStateDialog(() {
                          pageItemAdd = 2;
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox DIAPage(BuildContext context, StateSetter setStateDialog) {
    return SizedBox(
      width: 1000,
      height: 600,
      child: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('D, I, A, PRICES',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                        // const Spacer(),
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   child: InkWell(
                        //     child: const Icon(
                        //       Icons.close,
                        //       size: 14,
                        //     ),
                        //     onTap: () {
                        //       Navigator.pop(context);
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //MENU info
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Row(
                          children: [
                            const Text(
                              'ENTER DESCRIPTION',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Switch(
                              value: isDescription,
                              activeColor: const Color(0xffef7700),
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  isDescription = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: isDescription,
                          child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  maxLines: 3,
                                  // controller: txtmenusectionName,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Row(
                          children: [
                            const Text(
                              'ENTER INGRIDIENTS',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Switch(
                              value: isIngridient,
                              activeColor: const Color(0xffef7700),
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  isIngridient = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: isIngridient,
                          child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  maxLines: 3,
                                  // controller: txtmenusectionName,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Row(
                          children: [
                            const Text(
                              'ENTER ALLERGENS',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Switch(
                              value: isAllergens,
                              activeColor: const Color(0xffef7700),
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  isAllergens = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: isAllergens,
                          child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  // controller: txtmenusectionName,
                                  maxLines: 3,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  //DateTime info
                ],
              ),
            ],
          ),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'NEXT',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setStateDialog(() {
                        pageItemAdd = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox AddOnsPage(BuildContext context, StateSetter setStateDialog) {
    return SizedBox(
      width: 1000,
      height: 600,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('ADD-ONS/OPTION',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //MENU info
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'CREATE ADD-ONS',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Switch(
                                      value: isAddons,
                                      activeColor: const Color(0xffef7700),
                                      onChanged: (bool value) {
                                        setStateDialog(() {
                                          isAddons = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Ex. Creamy Spinach, Wedge Potatoes, French Fries',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Visibility(
                                    visible: isAddons,
                                    child: Column(
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                const Text(
                                                  'ENTER NAME',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextField(
                                                        controller: adOnsName,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'ENTER DESCRIPTION',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const Spacer(),
                                                      Switch(
                                                        value: adonsDes,
                                                        activeColor:
                                                            const Color(
                                                                0xffef7700),
                                                        onChanged:
                                                            (bool value) {
                                                          setStateDialog(() {
                                                            adonsDes = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: adonsDes,
                                                  child: Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextField(
                                                          controller: adDesText,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'ENTER INGRIDIENTS',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const Spacer(),
                                                      Switch(
                                                        value: adonsInd,
                                                        activeColor:
                                                            const Color(
                                                                0xffef7700),
                                                        onChanged:
                                                            (bool value) {
                                                          setStateDialog(() {
                                                            adonsInd = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: adonsInd,
                                                  child: Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextField(
                                                          controller: adIngText,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'ENTER ALLERGENS',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const Spacer(),
                                                      Switch(
                                                        value: adonsAler,
                                                        activeColor:
                                                            const Color(
                                                                0xffef7700),
                                                        onChanged:
                                                            (bool value) {
                                                          setStateDialog(() {
                                                            adonsAler = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: adonsAler,
                                                  child: Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextField(
                                                          controller: adAlText,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Visibility(
                            visible: isAddons,
                            child: Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const SizedBox(
                                                      width: 150,
                                                      height: 50,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'ENTER PRICE',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    adonsPrice,
                                                              ),
                                                            )),
                                                        const Text(
                                                          'USD',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: adonsNoPrice,
                                                            onChanged: (value) {
                                                              setStateDialog(
                                                                  () {
                                                                adonsNoPrice =
                                                                    value!;
                                                              });
                                                            }),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        const Text(
                                                          'NO PRICE REQUIRED',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setStateDialog(() {
                                                              String id =
                                                                  (adList.length +
                                                                          1)
                                                                      .toString();
                                                              String inf = '';
                                                              if (adonsDes) {
                                                                inf = '${inf}D';
                                                              }
                                                              if (adonsInd) {
                                                                inf = '$inf,I';
                                                              }
                                                              if (adonsAler) {
                                                                inf = '$inf,A';
                                                              }
                                                              AddOns tmp =
                                                                  AddOns(
                                                                      id,
                                                                      adOnsName
                                                                          .text,
                                                                      adonsPrice
                                                                          .text,
                                                                      inf,
                                                                      false,
                                                                      '100',
                                                                      []);
                                                              adList.add(tmp);
                                                              adOnsName.text =
                                                                  '';
                                                              adDesText.text =
                                                                  '';
                                                              adIngText.text =
                                                                  '';
                                                              adAlText.text =
                                                                  '';
                                                              adonsPrice.text =
                                                                  '';
                                                              adonsDes = false;
                                                              adonsAler = false;
                                                              adonsInd = false;
                                                              adonsNoPrice =
                                                                  false;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                color: const Color(
                                                                    0xffef7700)),
                                                            child: const Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'SAVE',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'SFPro',
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Visibility(
                                                      visible: isAddons,
                                                      child: SizedBox(
                                                        height: 200,
                                                        width: 150,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //LIST of adons
                                                            SizedBox(
                                                              height: 200,
                                                              width: 150,
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          adList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Row(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {},
                                                                              child: SizedBox(
                                                                                width: 150,
                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                  Text(
                                                                                    adList[index].name,
                                                                                    style: const TextStyle(fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    adList[index].price,
                                                                                    style: const TextStyle(fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    adList[index].info,
                                                                                    style: const TextStyle(fontSize: 12),
                                                                                  ),
                                                                                  Checkbox(value: adList[index].status, onChanged: null)
                                                                                ]),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //MENU info
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'CREATE OPTION',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Switch(
                                      value: isOption,
                                      activeColor: const Color(0xffef7700),
                                      onChanged: (bool value) {
                                        setStateDialog(() {
                                          isOption = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Ex. Creamy Spinach, Wedge Potatoes, French Fries',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Visibility(
                                    visible: isOption,
                                    child: Column(
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                const Text(
                                                  'ENTER NAME',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextField(
                                                        controller: optName,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'ENTER DESCRIPTION',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const Spacer(),
                                                      Switch(
                                                        value: adonsDes,
                                                        activeColor:
                                                            const Color(
                                                                0xffef7700),
                                                        onChanged:
                                                            (bool value) {
                                                          setStateDialog(() {
                                                            adonsDes = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: adonsDes,
                                                  child: Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextField(
                                                          controller: adDesText,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'ENTER INGRIDIENTS',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const Spacer(),
                                                      Switch(
                                                        value: adonsInd,
                                                        activeColor:
                                                            const Color(
                                                                0xffef7700),
                                                        onChanged:
                                                            (bool value) {
                                                          setStateDialog(() {
                                                            adonsInd = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: adonsInd,
                                                  child: Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextField(
                                                          controller: adIngText,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'ENTER ALLERGENS',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const Spacer(),
                                                      Switch(
                                                        value: adonsAler,
                                                        activeColor:
                                                            const Color(
                                                                0xffef7700),
                                                        onChanged:
                                                            (bool value) {
                                                          setStateDialog(() {
                                                            adonsAler = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Visibility(
                                                  visible: adonsAler,
                                                  child: Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: TextField(
                                                          controller: adAlText,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Visibility(
                            visible: isOption,
                            child: Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const SizedBox(
                                                      width: 150,
                                                      height: 50,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'ENTER PRICE',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    optPrice,
                                                              ),
                                                            )),
                                                        const Text(
                                                          'USD',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            value: adonsNoPrice,
                                                            onChanged: (value) {
                                                              setStateDialog(
                                                                  () {
                                                                adonsNoPrice =
                                                                    value!;
                                                              });
                                                            }),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        const Text(
                                                          'NO PRICE REQUIRED',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setStateDialog(() {
                                                              String id =
                                                                  (optList.length +
                                                                          1)
                                                                      .toString();
                                                              String inf = '';
                                                              if (adonsDes) {
                                                                inf = '${inf}D';
                                                              }
                                                              if (adonsInd) {
                                                                inf = '$inf,I';
                                                              }
                                                              if (adonsAler) {
                                                                inf = '$inf,A';
                                                              }
                                                              AddOns tmp =
                                                                  AddOns(
                                                                      id,
                                                                      optName
                                                                          .text,
                                                                      optPrice
                                                                          .text,
                                                                      inf,
                                                                      false,
                                                                      '100',
                                                                      []);
                                                              optList.add(tmp);
                                                              optName.text = '';
                                                              adDesText.text =
                                                                  '';
                                                              adIngText.text =
                                                                  '';
                                                              adAlText.text =
                                                                  '';
                                                              optPrice.text =
                                                                  '';
                                                              adonsDes = false;
                                                              adonsAler = false;
                                                              adonsInd = false;
                                                              adonsNoPrice =
                                                                  false;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                color: const Color(
                                                                    0xffef7700)),
                                                            child: const Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'SAVE',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'SFPro',
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Visibility(
                                                      visible: isAddons,
                                                      child: SizedBox(
                                                        height: 200,
                                                        width: 150,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //LIST of adons
                                                            SizedBox(
                                                              height: 200,
                                                              width: 150,
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          optList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Row(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {},
                                                                              child: SizedBox(
                                                                                width: 150,
                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                  Text(
                                                                                    optList[index].name,
                                                                                    style: const TextStyle(fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    optList[index].price,
                                                                                    style: const TextStyle(fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    optList[index].info,
                                                                                    style: const TextStyle(fontSize: 12),
                                                                                  ),
                                                                                  Checkbox(value: optList[index].status, onChanged: null)
                                                                                ]),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'NEXT',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setStateDialog(() {
                        pageItemAdd = 4;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> chooseImage(StateSetter setStateDialog) async {
    final result = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    uploadimage = result!.path;
    print(uploadimage);
    var f = await result.readAsBytes();
    setStateDialog(() {
      webImage = f;
    });
  }

  SizedBox PictureWst(BuildContext context, StateSetter setStateDialog) {
    List<String> work = context.select((MenuProvider p) => p.workStation) ?? [];
    return SizedBox(
      width: 1000,
      height: 600,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('PICTURE & WST',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //MENU info
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'UPLOAD PICTURE',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Switch(
                                value: isUploadPic,
                                activeColor: const Color(0xffef7700),
                                onChanged: (bool value) {
                                  setStateDialog(() {
                                    isUploadPic = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Visibility(
                            visible: isUploadPic,
                            child: GestureDetector(
                              onTap: () async {
                                chooseImage(setStateDialog);
                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: const Color(0xffef7700)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CHOOSE FILE',
                                      style: TextStyle(
                                        fontFamily: 'SFPro',
                                        fontSize: 14,
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
                          Visibility(
                              visible: webImage != null,
                              child: webImage != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Image.memory(webImage!)),
                                    )
                                  : Container())
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // GestureDetector(
                                //   onTap: () {
                                //     setStateDialog(() {
                                //       sendAllWst = 1;
                                //     });
                                //   },
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: [
                                //       Checkbox(
                                //           value: sendAllWst == 1,
                                //           onChanged: (value) {
                                //             setStateDialog(() {
                                //               sendAllWst = 1;
                                //             });
                                //           }),
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //       const Text(
                                //         'SEND ALL MENU SECTION TO SPECIFIC WST',
                                //         style: TextStyle(
                                //             fontSize: 12, color: Color(0xffef7700)),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // Visibility(
                                //   visible: sendAllWst == 1,
                                //   child: Center(
                                //     child: DropdownButtonHideUnderline(
                                //       child: DropdownButton2<String>(
                                //         isExpanded: true,
                                //         hint: Text(
                                //           workingStaion,
                                //           style: TextStyle(
                                //             fontSize: 14,
                                //             color: Theme.of(context).hintColor,
                                //           ),
                                //         ),
                                //         items: work
                                //             .map((String item) =>
                                //                 DropdownMenuItem<String>(
                                //                   value: item,
                                //                   child: Text(
                                //                     item,
                                //                     style: const TextStyle(
                                //                       fontSize: 14,
                                //                     ),
                                //                   ),
                                //                 ))
                                //             .toList(),
                                //         // value: selectedValue,
                                //         value: workingStaion ?? 'wst',
                                //         onChanged: (String? value) {
                                //           setStateDialog(() {
                                //             workingStaion = value!;
                                //           });
                                //         },
                                //         buttonStyleData: const ButtonStyleData(
                                //           padding:
                                //               EdgeInsets.symmetric(horizontal: 16),
                                //           height: 40,
                                //           width: 140,
                                //         ),
                                //         menuItemStyleData: const MenuItemStyleData(
                                //           height: 40,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    setStateDialog(() {
                                      sendAllWst = 2;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                          value: sendAllWst == 2,
                                          onChanged: (value) {
                                            setStateDialog(() {
                                              sendAllWst = 1;
                                            });
                                          }),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'SEND EACH MENU ITEM TO A WST',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffef7700)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'NEXT',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setStateDialog(() {
                        pageItemAdd = 5;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox CogsEarnings(BuildContext context, StateSetter setStateDialog) {
    List<String> work = context.select((MenuProvider p) => p.workStation) ?? [];
    return SizedBox(
      width: 1000,
      height: 700,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('COGS & EARNINGS',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //MENU info
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'CALCULATE COGS',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Switch(
                                value: isCalCogs,
                                activeColor: const Color(0xffef7700),
                                onChanged: (bool value) {
                                  setStateDialog(() {
                                    isCalCogs = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                              visible: isCalCogs,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'MAIN ITEM',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'COGS',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'EARNINGS',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            )
                                          ]),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  txtItemName.text,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  totalCost,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '$earnings %',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                    onTap: () async {
                                                      await showDialog<bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          return addIngredients(
                                                              context,
                                                              setStateDialog);
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      'View',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ))
                                              ],
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                              visible: isCalCogs,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'ADD-ONS',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 400,
                                      width: 800,
                                      child: ListView.builder(
                                          itemCount: adList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  adList[index].name,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  adList[index].cogs,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  '${adList[index].earnings} %',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                Column(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () async {
                                                          await showDialog<
                                                              bool>(
                                                            context: context,
                                                            builder: (context) {
                                                              return AddOnsIngredients(
                                                                  context,
                                                                  setStateDialog,
                                                                  adList[index]
                                                                      .name,
                                                                  index,
                                                                  adList[index]
                                                                      .price);
                                                            },
                                                          );
                                                        },
                                                        child: Text(
                                                          'View',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: indicatorCirlcePage(setStateDialog),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: ButtonMenu(
                      text: 'PUBLISH',
                      width: 200,
                      height: 45,
                      backColor: [btnColorGreenLight, btnColorGreenDark],
                      textColor: iconButtonTextColor,
                    ),
                    onTap: () {
                      setState(() {
                        String itemID = (itemList.length + 1).toString();
                        Item tmp = Item(itemID, txtItemName.text,
                            txtItemPrice.text, earnings, true);
                        itemList.add(tmp);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addIngredients(BuildContext context, StateSetter setStateDialogMain) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: systemDefaultColorOrange,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          title: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: 800,
                height: 600,
                child: SingleChildScrollView(
                    child: SizedBox(
                  width: 1000,
                  height: 700,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 800,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(''),
                                const Spacer(),
                                Text(txtItemName.text,
                                    style: TextStyle(
                                        color: systemDefaultColorOrange,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
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
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Enter ingridients and related costs for each sold item in order to have the COGS and EARNINGS',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'ENTER INGRIDIENT',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inName,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'ENTER QTY',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextField(
                                                      controller: inQuant,
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DropdownButton<
                                                          String>(
                                                        value:
                                                            selectedVolumeUnit,
                                                        icon: const Icon(Icons
                                                            .arrow_downward),
                                                        elevation: 16,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .deepPurple),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors
                                                              .deepPurpleAccent,
                                                        ),
                                                        onChanged:
                                                            (String? value) {
                                                          // This is called when the user selects an item.
                                                          setStateDialog(() {
                                                            selectedVolumeUnit =
                                                                value!;
                                                          });
                                                        },
                                                        items: adsUnitList.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ))),
                                              //asdasdasd

                                              SizedBox(
                                                width: 8,
                                              ),

                                              if (selectedVolumeUnit ==
                                                  'Volume') ...[
                                                Container(
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: selectedVolume,
                                                          icon: const Icon(Icons
                                                              .arrow_downward),
                                                          elevation: 16,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          underline: Container(
                                                            height: 2,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            // This is called when the user selects an item.
                                                            setStateDialog(() {
                                                              selectedVolume =
                                                                  value!;
                                                            });
                                                          },
                                                          items: adVolume.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ))),
                                              ] else if (selectedVolumeUnit ==
                                                  'Unit') ...[
                                                Container(
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: selectedUnit,
                                                          icon: const Icon(Icons
                                                              .arrow_downward),
                                                          elevation: 16,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          underline: Container(
                                                            height: 2,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            // This is called when the user selects an item.
                                                            setStateDialog(() {
                                                              selectedUnit =
                                                                  value!;
                                                            });
                                                          },
                                                          items: adUnit.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ))),
                                              ] else if (selectedVolumeUnit ==
                                                  'Weight') ...[
                                                Container(
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: selectedWeight,
                                                          icon: const Icon(Icons
                                                              .arrow_downward),
                                                          elevation: 16,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          underline: Container(
                                                            height: 2,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            // This is called when the user selects an item.
                                                            setStateDialog(() {
                                                              selectedWeight =
                                                                  value!;
                                                            });
                                                          },
                                                          items: adWeight.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ))),
                                              ] else ...[
                                                Container()
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'FOOD COST',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inCost,
                                                onChanged: (val) {
                                                  inTotCost
                                                      .text = (double.parse(
                                                              inCost.text) +
                                                          double.parse(
                                                              inExtraCost.text))
                                                      .toString();
                                                },
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'EXTRA COST',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inExtraCost,
                                                onChanged: (val) {
                                                  inTotCost
                                                      .text = (double.parse(
                                                              inCost.text) +
                                                          double.parse(
                                                              inExtraCost.text))
                                                      .toString();
                                                },
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'TOTAL COST',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inTotCost,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        child: ButtonMenu(
                                          text: 'SAVE',
                                          width: 200,
                                          height: 45,
                                          backColor: [
                                            btnColorRedLight,
                                            btnColorGreenDark
                                          ],
                                          textColor: iconButtonTextColor,
                                        ),
                                        onTap: () {
                                          setStateDialog(() {
                                            int id = ingredientsList.length + 1;
                                            String quat =
                                                inUnit.text + ' ' + inIdk.text;
                                            Ingredients ing = Ingredients(
                                                id.toString(),
                                                inName.text,
                                                quat,
                                                inQuant.text,
                                                inTotCost.text,
                                                false);
                                            ingredientsList.add(ing);
                                            inCost.text = '';
                                            inName.text = '';
                                            inCost.text = '';
                                            inExtraCost.text = '';
                                            inTotCost.text = '';
                                            inUnit.text = '';
                                            inUnit.text = '';
                                            inIdk.text = '';
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'INGRIDIENT',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'QTY',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'TOT COST',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        )
                                      ]),
                                  SizedBox(
                                    height: 200,
                                    width: 400,
                                    child: ListView.builder(
                                        itemCount: ingredientsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: SizedBox(
                                                  width: 400,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          ingredientsList[index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          ingredientsList[index]
                                                                  .quantity +
                                                              ' ' +
                                                              ingredientsList[
                                                                      index]
                                                                  .unit,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          ingredientsList[index]
                                                              .price,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        Checkbox(
                                                            value:
                                                                ingredientsList[
                                                                        index]
                                                                    .status,
                                                            onChanged: null)
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: ButtonMenu(
                                text: 'SAVE',
                                width: 200,
                                height: 45,
                                backColor: [
                                  btnColorGreenLight,
                                  btnColorGreenDark
                                ],
                                textColor: iconButtonTextColor,
                              ),
                              onTap: () {
                                setStateDialogMain(() {
                                  for (var i = 0;
                                      i < ingredientsList.length;
                                      i++) {
                                    totalCost = (double.parse(totalCost) +
                                            double.parse(
                                                ingredientsList[i].price))
                                        .toString();
                                  }
                                  print(totalCost);
                                  double tmp = double.parse(txtItemPrice.text) -
                                      double.parse(totalCost);
                                  print(tmp);
                                  earnings =
                                      ((tmp / double.parse(txtItemPrice.text)) *
                                              100)
                                          .toStringAsFixed(2);
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget AddOnsIngredients(BuildContext context, StateSetter setStateDialogMain,
      String name, int index, String tot) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: systemDefaultColorOrange,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          title: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: 800,
                height: 600,
                child: SingleChildScrollView(
                    child: SizedBox(
                  width: 1000,
                  height: 700,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 800,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(''),
                                const Spacer(),
                                Text(name,
                                    style: TextStyle(
                                        color: systemDefaultColorOrange,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
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
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Enter ingridients and related costs for each sold item in order to have the COGS and EARNINGS',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'ENTER INGRIDIENT',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inName,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'ENTER QTY',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextField(
                                                      controller: inQuant,
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DropdownButton<
                                                          String>(
                                                        value:
                                                            selectedVolumeUnit,
                                                        icon: const Icon(Icons
                                                            .arrow_downward),
                                                        elevation: 16,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .deepPurple),
                                                        underline: Container(
                                                          height: 2,
                                                          color: Colors
                                                              .deepPurpleAccent,
                                                        ),
                                                        onChanged:
                                                            (String? value) {
                                                          // This is called when the user selects an item.
                                                          setStateDialog(() {
                                                            selectedVolumeUnit =
                                                                value!;
                                                          });
                                                        },
                                                        items: adsUnitList.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ))),
                                              //asdasdasd

                                              SizedBox(
                                                width: 8,
                                              ),

                                              if (selectedVolumeUnit ==
                                                  'Volume') ...[
                                                Container(
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: selectedVolume,
                                                          icon: const Icon(Icons
                                                              .arrow_downward),
                                                          elevation: 16,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          underline: Container(
                                                            height: 2,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            // This is called when the user selects an item.
                                                            setStateDialog(() {
                                                              selectedVolume =
                                                                  value!;
                                                            });
                                                          },
                                                          items: adVolume.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ))),
                                              ] else if (selectedVolumeUnit ==
                                                  'Unit') ...[
                                                Container(
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: selectedUnit,
                                                          icon: const Icon(Icons
                                                              .arrow_downward),
                                                          elevation: 16,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          underline: Container(
                                                            height: 2,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            // This is called when the user selects an item.
                                                            setStateDialog(() {
                                                              selectedUnit =
                                                                  value!;
                                                            });
                                                          },
                                                          items: adUnit.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ))),
                                              ] else if (selectedVolumeUnit ==
                                                  'Weight') ...[
                                                Container(
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: selectedWeight,
                                                          icon: const Icon(Icons
                                                              .arrow_downward),
                                                          elevation: 16,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          underline: Container(
                                                            height: 2,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            // This is called when the user selects an item.
                                                            setStateDialog(() {
                                                              selectedWeight =
                                                                  value!;
                                                            });
                                                          },
                                                          items: adWeight.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ))),
                                              ] else ...[
                                                Container()
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'FOOD COST',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inCost,
                                                onChanged: (val) {
                                                  inTotCost
                                                      .text = (double.parse(
                                                              inCost.text) +
                                                          double.parse(
                                                              inExtraCost.text))
                                                      .toString();
                                                },
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'EXTRA COST',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inExtraCost,
                                                onChanged: (val) {
                                                  inTotCost
                                                      .text = (double.parse(
                                                              inCost.text) +
                                                          double.parse(
                                                              inExtraCost.text))
                                                      .toString();
                                                },
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'TOTAL COST',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: inTotCost,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        child: ButtonMenu(
                                          text: 'SAVE',
                                          width: 200,
                                          height: 45,
                                          backColor: [
                                            btnColorRedLight,
                                            btnColorGreenDark
                                          ],
                                          textColor: iconButtonTextColor,
                                        ),
                                        onTap: () {
                                          setStateDialog(() {
                                            int id = ingredientsList.length + 1;
                                            String quat =
                                                inUnit.text + ' ' + inIdk.text;
                                            AddsIngredients ing =
                                                AddsIngredients(
                                                    id.toString(),
                                                    inName.text,
                                                    quat,
                                                    inQuant.text,
                                                    inTotCost.text,
                                                    false);
                                            adList[index].inAds.add(ing);
                                            inCost.text = '';
                                            inName.text = '';
                                            inCost.text = '';
                                            inExtraCost.text = '';
                                            inTotCost.text = '';
                                            inUnit.text = '';
                                            inUnit.text = '';
                                            inIdk.text = '';
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'INGRIDIENT',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'QTY',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'TOT COST',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        )
                                      ]),
                                  SizedBox(
                                    height: 200,
                                    width: 400,
                                    child: ListView.builder(
                                        itemCount: adList[index].inAds.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: SizedBox(
                                                  width: 400,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          adList[index]
                                                              .inAds[index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          adList[index]
                                                                  .inAds[index]
                                                                  .quantity +
                                                              ' ' +
                                                              adList[index]
                                                                  .inAds[index]
                                                                  .unit,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          adList[index]
                                                              .inAds[index]
                                                              .price,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        Checkbox(
                                                            value: adList[index]
                                                                .inAds[index]
                                                                .status,
                                                            onChanged: null)
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: ButtonMenu(
                                text: 'SAVE',
                                width: 200,
                                height: 45,
                                backColor: [
                                  btnColorGreenLight,
                                  btnColorGreenDark
                                ],
                                textColor: iconButtonTextColor,
                              ),
                              onTap: () {
                                setStateDialogMain(() {
                                  String totalCost = '0';
                                  for (var i = 0;
                                      i < adList[index].inAds.length;
                                      i++) {
                                    totalCost = (double.parse(totalCost) +
                                            double.parse(
                                                adList[index].inAds[i].price))
                                        .toString();
                                  }
                                  print(totalCost);
                                  double tmp = double.parse(tot) -
                                      double.parse(totalCost);
                                  print(tmp);

                                  adList[index].earnings =
                                      ((tmp / double.parse(tot)) * 100)
                                          .toStringAsFixed(2);
                                  adList[index].cogs = totalCost;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PortionModel {
  final String id;
  String name;
  String price;
  bool status;

  PortionModel(this.id, this.name, this.price, this.status);
}

class AddOns {
  final String id;
  String name;
  String price;
  String info;
  bool status;
  String earnings;
  List<AddsIngredients> inAds;
  String cogs = '';

  AddOns(this.id, this.name, this.price, this.info, this.status, this.earnings,
      this.inAds);
}

class AddsIngredients {
  final String id;
  String name;
  String unit;
  String quantity;
  String price;
  bool status;

  AddsIngredients(
      this.id, this.name, this.unit, this.quantity, this.price, this.status);
}

class Ingredients {
  final String id;
  String name;
  String unit;
  String quantity;
  String price;
  bool status;

  Ingredients(
      this.id, this.name, this.unit, this.quantity, this.price, this.status);
}

class Item {
  final String id;
  String name;
  String price;
  String percentage;
  bool status;

  Item(this.id, this.name, this.price, this.percentage, this.status);
}
