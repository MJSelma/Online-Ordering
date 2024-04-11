import 'package:drinklinkmerchant/%20model/smart_menu_model.dart';
import 'package:drinklinkmerchant/%20model/smart_menu_section_model.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:drinklinkmerchant/ui/constant/theme_data.dart';
import 'package:drinklinkmerchant/ui/smart_menu/menu_section/menu_section.dart';
import 'package:drinklinkmerchant/widgets/button.dart';
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
  TextEditingController txtTo = TextEditingController(text: '');
  TextEditingController txtFrom = TextEditingController(text: '');
  TextEditingController txtDay = TextEditingController(text: 'Monday');
  TextEditingController txtDates = TextEditingController(text: '');
  TextEditingController txtmenusectionName = TextEditingController(text: '');
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
  List<String> daysMenu = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String selectedLanugage = 'English';
  String selectedMenu = '';
  bool dayFrom = true;
  int? menuIndex;
  int? menuIndexSection;
  List<MenuModel> smartMenu = [];
  List<MenuSectionModel> smartMenuSection = [];
  int everyDay = 3;
  List<String> listDays = [];
  List<String> listDates = [];
  int showHideMenu = 0;
  String workingStaion = 'wst';
  int sendAllWst = 0;

  TimeOfDay _timeFrom =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TimeOfDay _timeTo =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  DateTime dtnow1 = DateTime.now();
  DateTime dtnow2 = DateTime.now();
  void _selectTimeFrom(StateSetter myState) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _timeFrom,
    );
    if (newTime != null) {
      myState(() {
        _timeFrom = newTime;
      });
    }
  }

  void _selectTimeTo(StateSetter myState) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _timeTo,
    );
    if (newTime != null) {
      myState(() {
        _timeTo = newTime;
      });
    }
  }

  void _selectDateAll(StateSetter myState) async {
    final DateTime? newTime = await showDatePicker(
        context: context,
        initialDate: dtnow1,
        firstDate: dtnow1,
        lastDate: DateTime.now().add(const Duration(days: 500)));
    if (newTime != null) {
      myState(() {
        dtnow1 = newTime;
      });
    }
  }

  void _selectDateFromTo(StateSetter myState) async {
    final DateTime? newTime = await showDatePicker(
        context: context,
        initialDate: dtnow2,
        firstDate: dtnow2,
        lastDate: DateTime.now().add(const Duration(days: 500)));
    if (newTime != null) {
      myState(() {
        dtnow2 = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
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
                      child: const Icon(Icons.arrow_forward_ios)),
                )),
            Visibility(
              visible: showOrderingMenu,
              child: SizedBox(
                width: 250,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showOrderingMenu = false;
                                });
                              },
                              child: const Icon(Icons.arrow_back_ios))
                        ],
                      ),
                      const SizedBox(
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
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  //TODO
                                });
                              },
                              child: const Icon(Icons.settings))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      showMainMenu(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text('Lanugage'),
                            const SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(language.text)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: btnColorBlueLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text('View')),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: btnColorPurpleDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text('Add/Edit')),
                            ),
                          ],
                        ),
                      )
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
                visible: menuIndex != null,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('SHOW'),
                            const Spacer(),
                            Visibility(
                              child: GestureDetector(
                                onTap: () async {
                                  await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return addMenuSection(context);
                                    },
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: iconButtonTextColorPurple),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ADD NEW \nMENU SECTION',
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
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Visibility(
                              child: GestureDetector(
                                onTap: () async {
                                  await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return editMenuSection(context);
                                    },
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color(0xffef7700)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'EDIT',
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        showMainMenuSection(),
                        Divider(
                          color: Colors.amber[800],
                          thickness: 3,
                        ),
                        if (menuIndexSection != null) ...[
                          const MenuSectionItems()
                        ] else ...[
                          Container()
                        ]
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
              style: const TextStyle(
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

  Widget myButton(String text, String daysDes, int val, IconData iconMenu,
      double height, double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: menuIndex == val
              ? const Color(0xffef7700)
              : const Color.fromARGB(255, 65, 76, 237),
        ),
        child: Column(
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
              style: const TextStyle(
                fontFamily: 'SFPro',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              daysDes,
              style: const TextStyle(
                fontFamily: 'SFPro',
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget myButtonSection(String text, int val, IconData iconMenu, double height,
      double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: menuIndexSection == val
              ? const Color(0xffef7700)
              : const Color.fromARGB(255, 65, 76, 237),
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
                  color: menuIndexSection == val
                      ? Colors.white
                      : const Color.fromARGB(255, 66, 64, 64),
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
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

  Widget addMenu(
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
            child: SizedBox(
              width: 900,
              height: 600,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //MENU info
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (value) {}),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'IMPORT MENU FROM ANOTHER OUTELET',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xffef7700)),
                                  )
                                ],
                              ),
                              const SizedBox(
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
                                                  setStateDialog(() {
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
                                                  setStateDialog(() {
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setStateDialog(() {
                                          dayFrom = true;
                                          listDates = [];
                                          listDays = [];
                                          everyDay = 3;
                                          txtDates.text = '';
                                          txtDay.text = 'Monday';
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
                                                setStateDialog(() {
                                                  dayFrom = true;
                                                  listDates = [];
                                                  listDays = [];
                                                  everyDay = 3;
                                                  txtDates.text = '';
                                                  txtDay.text = 'Monday';
                                                });
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'ALL DAY',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffef7700)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 8, 8, 8),
                                      child: Visibility(
                                        visible: dayFrom,
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              everyDay = 0;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: everyDay == 0,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      everyDay = 0;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'EVERY DAY',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffef7700)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 8, 8, 8),
                                      child: Visibility(
                                        visible: dayFrom,
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              everyDay = 1;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: everyDay == 1,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      everyDay = 1;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'SPECIFIC DAYS',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffef7700)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible:
                                            dayFrom == true && everyDay == 1,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: true,
                                                          hint: Text(
                                                            txtDay.text,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                            ),
                                                          ),
                                                          items: daysMenu
                                                              .map((String
                                                                      item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item,
                                                                    child: Text(
                                                                      item,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          // value: selectedValue,
                                                          value: txtDay.text,
                                                          onChanged:
                                                              (String? value) {
                                                            setStateDialog(() {
                                                              txtDay.text =
                                                                  value!;
                                                            });
                                                          },
                                                          buttonStyleData:
                                                              const ButtonStyleData(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16),
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
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                child: ButtonMenu(
                                                  text: 'Add',
                                                  width: 100,
                                                  height: 45,
                                                  backColor: [
                                                    btnColorGreenLight,
                                                    btnColorGreenDark
                                                  ],
                                                  textColor:
                                                      iconButtonTextColor,
                                                ),
                                                onTap: () {
                                                  setStateDialog(() {
                                                    listDays.add(txtDay.text);
                                                    txtDay.text = 'Monday';
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            dayFrom == true && everyDay == 1,
                                        child: showDays(setStateDialog)),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 8, 8, 8),
                                      child: Visibility(
                                        visible: dayFrom,
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              everyDay = 2;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: everyDay == 2,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      everyDay = 2;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'SPECIFIC DATES',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffef7700)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible:
                                            dayFrom == true && everyDay == 2,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _selectDateAll(
                                                      setStateDialog);
                                                },
                                                child: Container(
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
                                                      child: Text(
                                                          '${dtnow1.day}/${dtnow1.month}/${dtnow1.year}'),
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                child: ButtonMenu(
                                                  text: 'Add',
                                                  width: 100,
                                                  height: 45,
                                                  backColor: [
                                                    btnColorGreenLight,
                                                    btnColorGreenDark
                                                  ],
                                                  textColor:
                                                      iconButtonTextColor,
                                                ),
                                                onTap: () {
                                                  setStateDialog(() {
                                                    listDates.add(
                                                        '${dtnow1.day}/${dtnow1.month}/${dtnow1.year}');
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            dayFrom == true && everyDay == 2,
                                        child: showDates(setStateDialog)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setStateDialog(() {
                                          dayFrom = false;
                                          listDates = [];
                                          listDays = [];
                                          everyDay = 3;
                                          txtDates.text = '';
                                          txtDay.text = 'Monday';
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
                                                setStateDialog(() {
                                                  dayFrom = false;
                                                  listDates = [];
                                                  listDays = [];
                                                  everyDay = 3;
                                                  txtDates.text = '';
                                                  txtDay.text = 'Monday';
                                                });
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'T0-FROM',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffef7700)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        visible: !dayFrom == true,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _selectTimeFrom(
                                                      setStateDialog);
                                                },
                                                child: Container(
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            '${_timeFrom.hour}:${_timeFrom.minute}'))),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _selectTimeTo(setStateDialog);
                                                },
                                                child: Container(
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            '${_timeTo.hour}:${_timeTo.minute}'))),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 8, 8, 8),
                                      child: Visibility(
                                        visible: !dayFrom,
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              everyDay = 0;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: everyDay == 0,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      everyDay = 0;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'EVERY DAY',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffef7700)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 8, 8, 8),
                                      child: Visibility(
                                        visible: !dayFrom,
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              everyDay = 1;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: everyDay == 1,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      everyDay = 1;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'SPECIFIC DAYS',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffef7700)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible:
                                            !dayFrom == true && everyDay == 1,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: true,
                                                          hint: Text(
                                                            txtDay.text,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                            ),
                                                          ),
                                                          items: daysMenu
                                                              .map((String
                                                                      item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item,
                                                                    child: Text(
                                                                      item,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          // value: selectedValue,
                                                          value: txtDay.text,
                                                          onChanged:
                                                              (String? value) {
                                                            setStateDialog(() {
                                                              txtDay.text =
                                                                  value!;
                                                            });
                                                          },
                                                          buttonStyleData:
                                                              const ButtonStyleData(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16),
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
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                child: ButtonMenu(
                                                  text: 'Add',
                                                  width: 100,
                                                  height: 45,
                                                  backColor: [
                                                    btnColorGreenLight,
                                                    btnColorGreenDark
                                                  ],
                                                  textColor:
                                                      iconButtonTextColor,
                                                ),
                                                onTap: () {
                                                  setStateDialog(() {
                                                    listDays.add(txtDay.text);
                                                    txtDay.text = 'Monday';
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            !dayFrom == true && everyDay == 1,
                                        child: showDays(setStateDialog)),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 8, 8, 8),
                                      child: Visibility(
                                        visible: !dayFrom,
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              everyDay = 2;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: everyDay == 2,
                                                  onChanged: (value) {
                                                    setStateDialog(() {
                                                      everyDay = 2;
                                                    });
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'SPECIFIC DATES',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffef7700)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible:
                                            !dayFrom == true && everyDay == 2,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _selectDateFromTo(
                                                      setStateDialog);
                                                },
                                                child: Container(
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
                                                      child: Text(
                                                          '${dtnow2.day}/${dtnow2.month}/${dtnow2.year}'),
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                child: ButtonMenu(
                                                  text: 'Add',
                                                  width: 100,
                                                  height: 45,
                                                  backColor: [
                                                    btnColorGreenLight,
                                                    btnColorGreenDark
                                                  ],
                                                  textColor:
                                                      iconButtonTextColor,
                                                ),
                                                onTap: () {
                                                  setStateDialog(() {
                                                    listDates.add(
                                                        '${dtnow2.day}/${dtnow2.month}/${dtnow2.year}');
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            !dayFrom == true && everyDay == 2,
                                        child: showDates(setStateDialog))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Visibility(
                                visible: !(dayFrom && everyDay == 0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setStateDialog(() {
                                          showHideMenu = 1;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                              value: showHideMenu == 1,
                                              onChanged: (value) {
                                                setStateDialog(() {
                                                  showHideMenu = 1;
                                                });
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'SHOW MENU',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffef7700)),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setStateDialog(() {
                                          showHideMenu = 2;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                              value: showHideMenu == 2,
                                              onChanged: (value) {
                                                setStateDialog(() {
                                                  showHideMenu = 2;
                                                });
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'HIDE MENU',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffef7700)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
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
                              String daysChosse = '';
                              if (dayFrom) {
                                daysChosse = 'ALL DAY';
                              } else {
                                daysChosse = '${txtFrom.text} - ${txtTo.text}';
                              }
                              setState(() {
                                MenuModel model = MenuModel(
                                    'asd',
                                    selectedMenu,
                                    selectedLanugage,
                                    daysChosse,
                                    '24 hrs',
                                    true);

                                smartMenu.add(model);
                                context
                                    .read<MenuProvider>()
                                    .addSmartMainMenu(model);
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

  Widget addMenuSection(
    BuildContext context,
  ) {
    List<String> work = context.select((MenuProvider p) => p.workStation) ?? [];
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
            child: SizedBox(
              width: 900,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MENU-SECTION SETUP PAGE',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        'ENTER MENU SECTION TITLE',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: txtmenusectionName,
                                            ),
                                          )),
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
                                        'LANGUAGES',
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: txtDay,
                                            ),
                                          )),
                                    ],
                                  ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setStateDialog(() {
                                          sendAllWst = 1;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                              value: sendAllWst == 1,
                                              onChanged: (value) {
                                                setStateDialog(() {
                                                  sendAllWst = 1;
                                                });
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'SEND ALL MENU SECTION TO SPECIFIC WST',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffef7700)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: sendAllWst == 1,
                                      child: Center(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: Text(
                                              workingStaion,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: work
                                                .map((String item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            // value: selectedValue,
                                            value: workingStaion ?? 'wst',
                                            onChanged: (String? value) {
                                              setStateDialog(() {
                                                workingStaion = value!;
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
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setStateDialog(() {
                                          sendAllWst = 2;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                    const SizedBox(
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
                                MenuSectionModel model = MenuSectionModel(
                                    'asd', txtmenusectionName.text, [], true);

                                smartMenuSection.add(model);
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

  int menuEdit = 0;

  Widget editMenuSection(
    BuildContext context,
  ) {
    List<String> work = context.select((MenuProvider p) => p.workStation) ?? [];
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
            child: SizedBox(
              width: 1000,
              height: 600,
              child: Stack(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('MENU-SECTION EDIT PAGE',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //MENU info
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child: ButtonMenu(
                                        text: 'MENU SECTION LIST',
                                        width: 200,
                                        height: 45,
                                        backColor: menuEdit == 0
                                            ? [
                                                btnColorOrangeDark,
                                                btnColorOrangeLight
                                              ]
                                            : [
                                                btnColorGreyDark,
                                                btnColorGreyDark
                                              ],
                                        textColor: menuEdit == 0
                                            ? iconButtonTextColor
                                            : Colors.black54,
                                      ),
                                      onTap: () {
                                        setStateDialog(() {
                                          menuEdit = 0;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    GestureDetector(
                                      child: ButtonMenu(
                                        text: 'TEMPLATES',
                                        width: 200,
                                        height: 45,
                                        backColor: menuEdit == 1
                                            ? [
                                                btnColorOrangeDark,
                                                btnColorOrangeLight
                                              ]
                                            : [
                                                btnColorGreyDark,
                                                btnColorGreyDark
                                              ],
                                        textColor: menuEdit == 1
                                            ? iconButtonTextColor
                                            : Colors.black54,
                                      ),
                                      onTap: () {
                                        setStateDialog(() {
                                          menuEdit = 1;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    GestureDetector(
                                      child: ButtonMenu(
                                        text: 'FONTS',
                                        width: 200,
                                        height: 45,
                                        backColor: menuEdit == 2
                                            ? [
                                                btnColorOrangeDark,
                                                btnColorOrangeLight
                                              ]
                                            : [
                                                btnColorGreyDark,
                                                btnColorGreyDark
                                              ],
                                        textColor: menuEdit == 2
                                            ? iconButtonTextColor
                                            : Colors.black54,
                                      ),
                                      onTap: () {
                                        setStateDialog(() {
                                          menuEdit = 2;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(),
                              if(menuEdit == 0)...[
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 700,
                                    height: 100,
                                    child: SizedBox(
                                      height: 60,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: smartMenuSection.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      menuIndexSection = index;
                                                    });
                                                  },
                                                  child: Card(
                                                    child: myButtonSection(
                                                        smartMenuSection[index]
                                                            .name,
                                                        index,
                                                        Icons.payment,
                                                        50,
                                                        12,
                                                        false),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              )
                              ]else if(menuEdit == 1)...[

                              ]else if(menuEdit == 2)...[
                                
                              ]else...[
  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 700,
                                    height: 100,
                                    child: SizedBox(
                                      height: 60,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: smartMenuSection.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      menuIndexSection = index;
                                                    });
                                                  },
                                                  child: Card(
                                                    child: myButtonSection(
                                                        smartMenuSection[index]
                                                            .name,
                                                        index,
                                                        Icons.payment,
                                                        50,
                                                        12,
                                                        false),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              )
                              ],
                            
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.delete,color: Colors.red,)),
                          
                        ],
                      ),
                    ),
                  )
                ],
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
                        child: myButton(
                            smartMenu[index].name,
                            smartMenu[index].dayAvailable,
                            index,
                            Icons.payment,
                            100,
                            12,
                            false),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  Widget showMainMenuSection() {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: smartMenuSection.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          menuIndexSection = index;
                        });
                      },
                      child: Card(
                        child: myButtonSection(smartMenuSection[index].name,
                            index, Icons.payment, 50, 12, false),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  Widget showDays(StateSetter myState) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 400,
            height: 50,
            child: ListView.builder(
                itemCount: listDays.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 65, 76, 237),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              listDays[index],
                              style: const TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                myState(() {
                                  listDays.removeAt(index);
                                });
                              },
                              child: const Visibility(
                                visible: true,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget showDates(StateSetter myState) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 400,
            height: 50,
            child: ListView.builder(
                itemCount: listDates.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 65, 76, 237),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              listDates[index],
                              style: const TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                myState(() {
                                  listDates.removeAt(index);
                                });
                              },
                              child: const Visibility(
                                visible: true,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
