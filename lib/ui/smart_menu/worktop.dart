import 'package:drinklinkmerchant/%20model/operators_model.dart';
import 'package:drinklinkmerchant/%20model/waiters_model.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:drinklinkmerchant/ui/constant/theme_color.dart';
import 'package:drinklinkmerchant/widgets/button.dart';
import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:drinklinkmerchant/widgets/menu_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkTop extends StatefulWidget {
  const WorkTop({super.key});

  @override
  State<WorkTop> createState() => _WorkTopState();
}

class _WorkTopState extends State<WorkTop> {
  bool showOrderingMenu = true;
  int orderingMenu = 0;
  int hardSoft = 0;
  TextEditingController textName = TextEditingController(text: '');
  TextEditingController textEmail = TextEditingController(text: '');
  TextEditingController textPass = TextEditingController(text: '');
  TextEditingController textConPass = TextEditingController(text: '');
  List<OperatorsModel> operators = [];
  List<WaitersModel> waiters = [];
  String selectedValue = 'wst';
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Smart Menu > Worktop',
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
                      Text(
                        'Through their worktops, the worktop - operator will be able to: \n- Receive Orders \n- Accept Orders \n- Accept Payments - Reject Order\n- Notify DGuest when orders are ready \n- Send notifications to Waiter ',
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              orderingMenu = 1;
                            });
                          },
                          child: myButton1('Worktop Operators', 1,
                              Icons.payment, 50, 12, false)),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                            'The WTP-Operator will receive from and prepare orders to DGuests. Your DGuests will be notified of the waiting time and when their order will be ready',
                            style: TextStyle(fontSize: 10)),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              orderingMenu = 2;
                            });
                          },
                          child: myButton1('Worktop Waiters', 2, Icons.payment,
                              50, 12, false)),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                            'Create here your Waiters WTPs. \nIf HARD COUPLED \nWtp operators will be able to send specific notifications to designated waiters \nIf SOFT COUPLED\nWtp Operator will be able to send specific notifications to all waiters',
                            style: TextStyle(fontSize: 10)),
                      ),
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
                visible: orderingMenu == 1 || orderingMenu == 2,
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (orderingMenu == 1) {
                              await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return addOperator(context);
                                },
                              );
                            } else {
                              await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return addWaiters(context);
                                },
                              );
                            }
                          },
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
                                  orderingMenu == 1
                                      ? 'Create New Operator'
                                      : 'Create New Waiter',
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
                        SizedBox(
                          width: 200,
                        ),
                        Visibility(
                          visible: orderingMenu == 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                hardSoft = 1;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: hardSoft == 1
                                      ? const Color(0xffef7700)
                                      : Colors.grey.withOpacity(.8),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('Hard Coupled')
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Visibility(
                          visible: orderingMenu == 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                hardSoft = 2;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: hardSoft == 2
                                      ? const Color(0xffef7700)
                                      : Colors.grey.withOpacity(.8),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('Soft Coupled')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //panel operators or waiters
                    if (orderingMenu == 1) ...[
                      OperatorPanel(),
                    ] else ...[
                      WaitersPanel(),
                    ]
                  ],
                )))
          ],
        ),
      ],
    );
  }

  Widget OperatorPanel() {
    List<String> work = context.select((MenuProvider p) => p.workStation) ?? [];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text('WTP-OPERATORS'),
              SizedBox(
                width: 300,
              ),
              Text('WST'),
              SizedBox(
                width: 200,
              ),
              Text('STATUS'),
            ],
          ),
        ),
        SizedBox(
          width: 800,
          height: 400,
          child: ListView.builder(
              itemCount: operators.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            textName.text = operators[index].name;
                            textEmail.text = operators[index].email;
                            textPass.text = operators[index].password;
                          });
                        },
                        child: Card(
                          child: Container(
                            color: selectedIndex == index
                                ? Colors.purple
                                : Colors.white,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(operators[index].name),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        child: Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //   if(operators[index].status)...[
                                //     Text(operators[index].workStation),
                                // ]else...[
                                //   Text('-----'),
                                // ]
                                Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        operators[index].workStation,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
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
                                      value: operators[index].workStation ?? 'wst',
                                      onChanged: (String? value) {
                                        setState(() {
                                          // selectedValue = value!;
                                          print(value);
                                          operators
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  operators[index].id)
                                              .workStation = value!;
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            operators
                                .firstWhere((element) =>
                                    element.id == operators[index].id)
                                .status = !operators[index].status;
                          });
                        },
                        child: Card(
                          child: Container(
                            width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (operators[index].status) ...[
                                    Text('ACT'),
                                  ] else ...[
                                    Text('D-ACT'),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                if (selectedIndex != null) {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return UpdateOperator(context);
                    },
                  );
                }
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffef7700)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Modify',
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
              width: 20,
            ),
            GestureDetector(
              onTap: () async{
                 if (selectedIndex != null) {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return deleteOperator(context);
                    },
                  );
                }
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.purple),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Delete',
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
        )
      ],
    );
  }

  Widget WaitersPanel() {
    List<String> work = context.select((MenuProvider p) => p.workStation) ?? [];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text('WTP-WAITERS'),
              SizedBox(
                width: 300,
              ),
              Text('WST'),
              SizedBox(
                width: 200,
              ),
              Text('STATUS'),
            ],
          ),
        ),
        SizedBox(
          width: 800,
          height: 400,
          child: ListView.builder(
              itemCount: waiters.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                             selectedIndex = index;
                            textName.text = waiters[index].name;
                            textEmail.text = waiters[index].email;
                            textPass.text = waiters[index].password;
                          });
                        },
                        child: Card(
                          child: Container(
                            color: selectedIndex == index
                                ? Colors.purple
                                : Colors.white,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(waiters[index].name),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        child: Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // if (waiters[index].status) ...[
                                //   Text(waiters[index].workStation),
                                // ] else ...[
                                //   Text('-----'),
                                // ]
                                Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        waiters[index].workStation,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
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
                                      value: operators[index].workStation ?? 'wst',
                                      onChanged: (String? value) {
                                        setState(() {
                                          // selectedValue = value!;
                                          print(value);
                                          waiters
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  waiters[index].id)
                                              .workStation = value!;
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            waiters
                                .firstWhere((element) =>
                                    element.id == waiters[index].id)
                                .status = !waiters[index].status;
                          });
                        },
                        child: Card(
                          child: Container(
                            width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (waiters[index].status) ...[
                                    Text('ACT'),
                                  ] else ...[
                                    Text('D-ACT'),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                if (selectedIndex != null) {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return updateWaiters(context);
                    },
                  );
                }
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffef7700)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Modify',
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
              width: 20,
            ),
            GestureDetector(
              onTap: () async{
                if (selectedIndex != null) {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return deleteWaiter(context);
                    },
                  );
                }
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.purple),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Delete',
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
        )
      ],
    );
  }

  Widget addOperator(
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
              width: 500,
              height: 550,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('NEW OPERATOR',
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
                                    controller: textName,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Email',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textEmail,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Confirmed Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textConPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
                                OperatorsModel model = OperatorsModel(
                                    (operators.length + 1).toString(),
                                    textName.text,
                                    textEmail.text,
                                    textPass.text,
                                    true,
                                    'wst');
                                operators.add(model);
                                clearText();
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

  Widget addWaiters(
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
              width: 500,
              height: 550,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('NEW WAITERS',
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
                                    controller: textName,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Email',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textEmail,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Confirmed Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textConPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
                                WaitersModel model = WaitersModel(
                                    (waiters.length + 1).toString(),
                                    textName.text,
                                    textEmail.text,
                                    textPass.text,
                                    true,
                                    'wst');
                                waiters.add(model);
                                clearText();
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

  List<DropdownMenuItem<List<String>>> myList() {
    List<String> work = context.select((MenuProvider p) => p.workStation) ?? [];

    return work
        .map<DropdownMenuItem<List<String>>>(
          (e) => DropdownMenuItem(
            value: work,
            child: Container(
              // color: Colors.grey[900],
              child: Center(
                child: Text(
                  e,
                  style: const TextStyle(
                    color: Color(0xffbef7700),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  clearText() {
    setState(() {
      textName.text = '';
      textEmail.text = '';
      textPass.text = '';
      textConPass.text = '';
    });
  }

  Widget myButton1(String text, int val, IconData iconMenu, double height,
      double paddingLeft, bool showIcon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
      child: Container(
        width: 200,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: orderingMenu == val
              ? const Color(0xffef7700)
              : Colors.grey.shade200,
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
                  color: orderingMenu == val
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
                color: orderingMenu == val
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

  Widget UpdateOperator(
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
              width: 500,
              height: 550,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('UPDATE OPERATOR',
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
                                    controller: textName,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Email',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textEmail,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Confirmed Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textConPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
                              text: 'Update',
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
                                operators[selectedIndex!].name = textName.text;
                                operators[selectedIndex!].email = textEmail.text;
                                operators[selectedIndex!].password = textPass.text;
                                selectedIndex = null;
                                clearText();
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

   Widget updateWaiters(
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
              width: 500,
              height: 550,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('UPDATE WAITERS',
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
                                    controller: textName,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Email',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textEmail,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Enter Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                              'Confirmed Password',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: textConPass,
                                    obscureText: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
                              text: 'Update',
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
                                waiters[selectedIndex!].name = textName.text;
                                waiters[selectedIndex!].email = textEmail.text;
                                waiters[selectedIndex!].password = textPass.text;
                                selectedIndex = null;
                                clearText();
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

   Widget deleteWaiter(
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
              width: 500,
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('DELETE WAITER',
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
                      Text('Are you sure you want to delete this waiter?',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                                 const SizedBox(
                      height: 14,
                    ),
                        Text('Delete ${textName.text}',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
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
                              text: 'Delete',
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
                                waiters.removeAt(selectedIndex!);
                                clearText();
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

   Widget deleteOperator(
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
              width: 500,
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('DELETE OPERATOR',
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
                      Text('Are you sure you want to delete this operator?',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
                                 const SizedBox(
                      height: 14,
                    ),
                        Text('Delete ${textName.text}',
                            style: TextStyle(
                                color: systemDefaultColorOrange,
                                fontWeight: FontWeight.bold)),
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
                              text: 'Delete',
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
                                operators.removeAt(selectedIndex!);
                                clearText();
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

  
}
