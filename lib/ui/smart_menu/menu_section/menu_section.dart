import 'package:drinklinkmerchant/ui/constant/theme_data.dart';
import 'package:drinklinkmerchant/widgets/button.dart';
import 'package:flutter/material.dart';

class MenuSectionItems extends StatefulWidget {
  const MenuSectionItems({super.key});

  @override
  State<MenuSectionItems> createState() => _MenuSectionItemsState();
}

class _MenuSectionItemsState extends State<MenuSectionItems> {
  int? ChooseFood;
  bool isPrepare = false;
  bool isCookLevel = false;
  bool isDescription = false;
  bool isIngridient = false;
  bool isAllergens = false;
  bool isSteak = false;
  bool isAddons = false;
  bool addons = false;
  bool sideDish = false;
  bool suace = false;
  bool adonsDes = false;
  bool adonsInd = false;
  bool adonsAler = false;
  bool adonsNoPrice = false;
  List<PortionModel> pList = [];
  TextEditingController portionController = TextEditingController(text: '');
  TextEditingController portionPriceController =
      TextEditingController(text: '');


  List<AddOns> adList = [];
   TextEditingController adOnsName = TextEditingController(text: '');
  TextEditingController adonsPrice =
      TextEditingController(text: '');

  int pageItemAdd = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('WST'),
            Spacer(),
            Visibility(
              child: GestureDetector(
                onTap: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return addMenuItemSection(context);
                    },
                  );
                },
                child: Container(
                  width: 150,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffef7700)),
                  child: Row(
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
      ],
    ));
  }

  Widget addMenuItemSection(
    BuildContext context,
  ) {
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
                height: 900,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (pageItemAdd == 1) ...[
                        SizedBox(
                          width: 1000,
                          height: 900,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 900,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(''),
                                        Spacer(),
                                        Text('MENU ITEM SET UP PAGE',
                                            style: TextStyle(
                                                color: systemDefaultColorOrange,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
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
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //MENU info
                                  Expanded(
                                    flex: 1,
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
                                                  'ENTER ITEM NAME',
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 400,
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
                                                          // controller: txtmenusectionName,
                                                          ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 100),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  //DateTime info
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setStateDialog(() {
                                                    ChooseFood = 1;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                        value: ChooseFood == 1,
                                                        onChanged: (value) {
                                                          setStateDialog(() {
                                                            ChooseFood = 1;
                                                          });
                                                        }),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'FOOD ITEM',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '(Ex. Pasta, Meat, Fish, Dessert)',
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                  visible: ChooseFood == 1,
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  40, 0, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'PREPARING MEAT DISH',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              SizedBox(
                                                                width: 12,
                                                              ),
                                                              Switch(
                                                                value:
                                                                    isPrepare,
                                                                activeColor: Color(
                                                                    0xffef7700),
                                                                onChanged: (bool
                                                                    value) {
                                                                  setStateDialog(
                                                                      () {
                                                                    isPrepare =
                                                                        value;
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (isPrepare) ...[
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(80,
                                                                    20, 0, 0),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      'COOKING LEVEL REQUIRED',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Text(
                                                                        'This creates a window in the Drinklink app asking the cooking level of the meat. Ideal for Steaks',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Switch(
                                                                  value:
                                                                      isCookLevel,
                                                                  activeColor:
                                                                      Color(
                                                                          0xffef7700),
                                                                  onChanged: (bool
                                                                      value) {
                                                                    setStateDialog(
                                                                        () {
                                                                      isCookLevel =
                                                                          value;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ]
                                                      ],
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setStateDialog(() {
                                                    ChooseFood = 2;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                        value: ChooseFood == 2,
                                                        onChanged: (value) {
                                                          setStateDialog(() {
                                                            ChooseFood = 2;
                                                          });
                                                        }),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'DRINK ITEM',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '(Ex. Beer, Coca Cola, Water)',
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setStateDialog(() {
                                                    ChooseFood = 3;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                        value: ChooseFood == 3,
                                                        onChanged: (value) {
                                                          setStateDialog(() {
                                                            ChooseFood = 3;
                                                          });
                                                        }),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'MIXOLOGY ITEM',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '(Ex. Mojito, Negroni, Gin-Tonic)',
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.black),
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
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[800],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[100],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[100],
                                      ),
                                    ),
                                  ],
                                ),
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
                                        text: 'NEXT',
                                        width: 200,
                                        height: 45,
                                        backColor: [
                                          btnColorGreenLight,
                                          btnColorGreenDark
                                        ],
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
                            ],
                          ),
                        ),
                      ] else if (pageItemAdd == 2) ...[
                        SizedBox(
                          width: 1000,
                          height: 900,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 800,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(''),
                                        Spacer(),
                                        Text('D, I, A, PRICES',
                                            style: TextStyle(
                                                color: systemDefaultColorOrange,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
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
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //MENU info
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 10, 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'ENTER DESCRIPTION',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Switch(
                                                    value: isDescription,
                                                    activeColor:
                                                        Color(0xffef7700),
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
                                                    width: 400,
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
                                                          // controller: txtmenusectionName,
                                                          ),
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'ENTER INGRIDIENTS',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Switch(
                                                    value: isIngridient,
                                                    activeColor:
                                                        Color(0xffef7700),
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
                                                    width: 400,
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
                                                          // controller: txtmenusectionName,
                                                          ),
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'ENTER ALLERGENS',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Switch(
                                                    value: isAllergens,
                                                    activeColor:
                                                        Color(0xffef7700),
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
                                                    width: 400,
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
                                                          // controller: txtmenusectionName,
                                                          ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 100),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(),
                                  //DateTime info
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      const Text(
                                                        'ENTER PRICE',
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
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextField(
                                                                // controller: txtmenusectionName,
                                                                ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'SET PRICES FOR MULTIPLE PORTIONS',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        'Ideal for Steaks orders',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Switch(
                                                    value: isSteak,
                                                    activeColor:
                                                        Color(0xffef7700),
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
                                                child: Text(
                                                  'DISHES',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isSteak,
                                                child: Row(
                                                  children: [
                                                    DecoratedBox(
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
                                                              'ENTER PORTION',
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
                                                                      .grey
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        portionController,
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Visibility(
                                                      visible: isSteak,
                                                      child: DecoratedBox(
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
                                                                  .fromLTRB(10,
                                                                  10, 10, 10),
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
                                                                'ENTER PRICE',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                  width: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          portionPriceController,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Visibility(
                                                visible: isSteak,
                                                child: Padding(
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
                                                                (pList.length +
                                                                        1)
                                                                    .toString();
                                                            PortionModel po =
                                                                new PortionModel(
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
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'ADD',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'SFPro',
                                                                  fontSize: 14,
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(),

                                        //Show portionList
                                        Visibility(
                                          visible: isSteak,
                                          child: Text(
                                            'PORTIONS LISTED',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isSteak,
                                          child: SizedBox(
                                            width: 400,
                                            height: 50,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'PORTION SIZE',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Text(
                                                    'PRICE',
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
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
                                                                  pList[index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  pList[index]
                                                                      .price,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Checkbox(
                                                                    value: pList[
                                                                            index]
                                                                        .status,
                                                                    onChanged:
                                                                        null)
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
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[100],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[800],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[100],
                                      ),
                                    ),
                                  ],
                                ),
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
                                        text: 'NEXT',
                                        width: 200,
                                        height: 45,
                                        backColor: [
                                          btnColorGreenLight,
                                          btnColorGreenDark
                                        ],
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
                            ],
                          ),
                        ),
                      ] else if (pageItemAdd == 3) ...[
                        SizedBox(
                          width: 1000,
                          height: 900,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 800,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(''),
                                        Spacer(),
                                        Text('ADD-ONS',
                                            style: TextStyle(
                                                color: systemDefaultColorOrange,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'CREATE ADD-ONS/SIDE DISHES/SAUCES',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Switch(
                                                value: isAddons,
                                                activeColor: Color(0xffef7700),
                                                onChanged: (bool value) {
                                                  setStateDialog(() {
                                                    isAddons = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Ex. Creamy Spinach, Wedge Potatoes, French Fries',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Visibility(
                                            visible: isAddons,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                    value: addons,
                                                    onChanged: (value) {
                                                      setStateDialog(() {
                                                        addons = true;
                                                        sideDish = false;
                                                        suace = false;
                                                      });
                                                    }),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'ADD-ONS',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: isAddons,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                    value: sideDish,
                                                    onChanged: (value) {
                                                      setStateDialog(() {
                                                        addons = false;
                                                        sideDish = true;
                                                        suace = false;
                                                      });
                                                    }),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'SIDE DISH',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: isAddons,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                    value: suace,
                                                    onChanged: (value) {
                                                      setStateDialog(() {
                                                        addons = false;
                                                        sideDish = false;
                                                        suace = true;
                                                      });
                                                    }),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'SAUCE',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Visibility(
                                              visible: isAddons,
                                              child: Column(
                                                children: [
                                                  DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
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
                                                            'ENTER NAME',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                              width: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: TextField(
                                                                    controller:
                                                                        adOnsName,
                                                                    ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
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
                                                          SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  'ENTER DESCRIPTION',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Spacer(),
                                                                Switch(
                                                                  value:
                                                                      adonsDes,
                                                                  activeColor:
                                                                      Color(
                                                                          0xffef7700),
                                                                  onChanged: (bool
                                                                      value) {
                                                                    setStateDialog(
                                                                        () {
                                                                      adonsDes =
                                                                          value;
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
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: TextField(
                                                                      // controller:
                                                                      //     portionPriceController,
                                                                      ),
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
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
                                                          SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  'ENTER INGRIDIENTS',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Spacer(),
                                                                Switch(
                                                                  value:
                                                                      adonsInd,
                                                                  activeColor:
                                                                      Color(
                                                                          0xffef7700),
                                                                  onChanged: (bool
                                                                      value) {
                                                                    setStateDialog(
                                                                        () {
                                                                      adonsInd =
                                                                          value;
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
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: TextField(
                                                                      // controller:
                                                                      //     portionPriceController,
                                                                      ),
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
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
                                                          SizedBox(
                                                            width: 200,
                                                            height: 50,
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  'ENTER ALLERGENS',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Spacer(),
                                                                Switch(
                                                                  value:
                                                                      adonsAler,
                                                                  activeColor:
                                                                      Color(
                                                                          0xffef7700),
                                                                  onChanged: (bool
                                                                      value) {
                                                                    setStateDialog(
                                                                        () {
                                                                      adonsAler =
                                                                          value;
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
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: TextField(
                                                                      // controller:
                                                                      //     portionPriceController,
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
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Visibility(
                                      visible: isAddons,
                                      child: Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
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
                                                      DecoratedBox(
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
                                                              SizedBox(
                                                                width: 150,
                                                                height: 50,
                                                                child: Row(
                                                                  children: [
                                                                    const Text(
                                                                      'ENTER PRICE',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                  width: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                20),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: TextField(
                                                                        controller:
                                                                            adonsPrice,
                                                                        ),
                                                                  )),
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                      value:
                                                                          adonsNoPrice,
                                                                      onChanged:
                                                                          (value) {
                                                                        setStateDialog(
                                                                            () {
                                                                          adonsNoPrice =
                                                                              value!;
                                                                         
                                                                        });
                                                                      }),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    'NO PRICE REQUIRED',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setStateDialog(() {
                                                              String id = (adList.length + 1).toString();
                                                              String inf = '';
                                                              if(adonsDes){
                                                                inf = inf + 'D';
                                                              }
                                                               if(adonsInd){
                                                                inf = inf + ',I';
                                                              }
                                                               if(adonsAler){
                                                                inf = inf + ',A';
                                                              }
                                                              AddOns tmp = AddOns(id, adOnsName.text, adonsPrice.text, inf, false);
                                                              adList.add(tmp);
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
                                                            child: Row(
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
                                                                    fontSize: 14,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ]))
                                          ],
                                        ),
                                      ),
                                    ),
                                     Visibility(
                                      visible: isAddons,
                                       child: Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //LIST of adons
                                            SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: ListView.builder(
                                                  itemCount: adList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: SizedBox(
                                                            width: 200,
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    adList[index]
                                                                        .name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    adList[index]
                                                                        .price,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                    Text(
                                                                    adList[index]
                                                                        .info,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Checkbox(
                                                                      value: adList[
                                                                              index]
                                                                          .status,
                                                                      onChanged:
                                                                          null)
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
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[100],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[100],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.amber[800],
                                      ),
                                    ),
                                  ],
                                ),
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
                                        text: 'NEXT',
                                        width: 200,
                                        height: 45,
                                        backColor: [
                                          btnColorGreenLight,
                                          btnColorGreenDark
                                        ],
                                        textColor: iconButtonTextColor,
                                      ),
                                      onTap: () {
                                        setStateDialog(() {
                                          pageItemAdd = 1;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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

  AddOns(this.id, this.name, this.price, this.info, this.status);
}
