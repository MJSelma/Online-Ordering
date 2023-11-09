import 'package:drinklinkmerchant/%20model/operators_model.dart';
import 'package:drinklinkmerchant/%20model/smart_menu_model.dart';
import 'package:drinklinkmerchant/%20model/waiters_model.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:drinklinkmerchant/ui/constant/theme_color.dart';
import 'package:drinklinkmerchant/widgets/button.dart';
import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmartMenu extends StatefulWidget {
  const SmartMenu({super.key});

  @override
  State<SmartMenu> createState() => _SmartMenuState();
}

class _SmartMenuState extends State<SmartMenu> {
  bool showOrderingMenu = true;
  int orderingMenu = 0;
  int hardSoft = 0;
  TextEditingController language = TextEditingController(text: 'ENGLISH');
  TextEditingController menuName = TextEditingController(text: '');
  TextEditingController textPass = TextEditingController(text: '');
  TextEditingController textConPass = TextEditingController(text: '');
  List<String> menuOptionName = [
    'Breakfast',
    'Lunch',
    'Brunch',
    'Dinner',
    'All Day',
    'Snacks',
    'Day Menu',
    'Meal Package',
    'Night Menu',
    'Drinks',
    'Hot Drinks',
    'Cocktails',
    'Promotions',
    ''
  ];
  List<String> menuLanguage = ['English', 'Filipino', 'Spanish', ''];
  String selectedLanugage = 'English';
  String selectedMenu = '';
  bool dayFrom = true;
  int menuIndex = 0;
  List<MenuModel> smartMenu = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Smart Menu > Menu',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontFamily: 'SFPro', fontSize: 20),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 2,
              color: Colors.black87,
              height: MediaQuery.of(context).size.height - 200,
            ),
            Visibility(
                visible: !showOrderingMenu,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showOrderingMenu = true;
                        });
                      },
                      child: Icon(Icons.arrow_forward_ios)),
                )),
            Visibility(
              visible: showOrderingMenu,
              child: SizedBox(
                width: 250,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showOrderingMenu = false;
                                });
                              },
                              child: Icon(Icons.arrow_back_ios))
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 140,
                            child: GestureDetector(
                                onTap: () async {
                                  await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return addMenu(context);
                                    },
                                  );
                                },
                                child: addMenuButton('ADD NEW \nMENU', 1,
                                    Icons.payment, 50, 12, false)),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  //TODO
                                });
                              },
                              child: Icon(Icons.settings))
                        ],
                      ),
                      SizedBox(height: 20,),
                      showMainMenu()
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 2,
                color: Colors.black87,
                height: MediaQuery.of(context).size.height - 200,
              ),
            ),
            Visibility(
                visible: true,
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xffef7700)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ADD NEW SECTION',
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18,
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )))
          ],
        ),
      ],
    );
  }

  Widget addMenuButton(String text, int val, IconData iconMenu, double height,
      double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xffef7700)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: showIcon,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                child: Icon(iconMenu, color: Colors.white),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget myButton(String text, int val, IconData iconMenu, double height,
      double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: menuIndex == val
              ? const Color(0xffef7700)
              : Color.fromARGB(255, 65, 76, 237),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: showIcon,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                child: Icon(
                  iconMenu,
                  color: menuIndex == val
                      ? Colors.white
                      : const Color.fromARGB(255, 66, 64, 64),
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 18,
                color: menuIndex == val
                    ? Colors.white
                    : const Color.fromARGB(255, 66, 64, 64),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget addMenu(
    BuildContext context,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
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
            child: SizedBox(
              width: 900,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('MENU SETUP PAGE',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
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
                    Row(
                      children: [
                        //MENU info
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (value) {}),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'IMPORT MENU FROM ANOTHER OUTELET',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xffef7700)),
                                  )
                                ],
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        'SELECT DEFAULT LANGUAGE',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: Text(
                                                  selectedLanugage,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                items: menuLanguage
                                                    .map((String item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                // value: selectedValue,
                                                value: selectedLanugage,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedLanugage = value!;
                                                  });
                                                },
                                                buttonStyleData:
                                                    const ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16),
                                                  height: 40,
                                                  width: 140,
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  height: 40,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100),
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
                                        'SELECT MENU',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: Text(
                                                  selectedMenu,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                items: menuOptionName
                                                    .map((String item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                // value: selectedValue,
                                                value: selectedMenu,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedMenu = value!;
                                                  });
                                                },
                                                buttonStyleData:
                                                    const ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16),
                                                  height: 40,
                                                  width: 140,
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  height: 40,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayFrom = true;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                              value: dayFrom,
                                              onChanged: (value) {
                                                setState(() {
                                                  dayFrom = true;
                                                });
                                              }),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'ALL DAY',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffef7700)),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayFrom = false;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                              value: !dayFrom,
                                              onChanged: (value) {
                                                setState(() {
                                                  dayFrom = false;
                                                });
                                              }),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'T0-FROM',
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
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: ButtonMenu(
                                text: 'Cancel',
                                width: 200,
                                height: 45,
                                backColor: [
                                  btnColorOrangeLight,
                                  btnColorOrangeDark
                                ],
                                textColor: iconButtonTextColor,
                                // backColor: isImagedLoaded == true
                                //     ? const sys_color_defaultorange
                                //     : const button_color_grey,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: ButtonMenu(
                              text: 'Add',
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
                                MenuModel model = MenuModel(
                                    'asd',
                                    selectedMenu,
                                    selectedLanugage,
                                    'All day',
                                    '24 hrs',
                                    true);
                                context
                                    .read<MenuProvider>()
                                    .addSmartMainMenu(model);
                                smartMenu.add(model);
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget showMainMenu() {
    return Column(
      children: [
        SizedBox(
          height: 500,
          child: ListView.builder(
              itemCount: smartMenu.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                                menuIndex = index;
                              });
                      },
                      child: Card(
                        
                        child: myButton(smartMenu[index].name, index,
                            Icons.payment, 100, 12, false),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
