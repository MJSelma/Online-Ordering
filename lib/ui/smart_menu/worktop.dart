import 'package:drinklinkmerchant/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class WorkTop extends StatefulWidget {
  const WorkTop({super.key});

  @override
  State<WorkTop> createState() => _WorkTopState();
}

class _WorkTopState extends State<WorkTop> {
  bool showOrderingMenu = true;
  int orderingMenu = 0;
  int hardSoft = 0;

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
                        height: 24,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              orderingMenu = 1;
                            });
                          },
                          child: myButton1('Operator Setup', 1, Icons.payment,
                              50, 12, false)),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                            'The WTP-Operator will receive from and prepare orders to DGuests. Your DGuests will be notified of the waiting time and when their order will be ready'),
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
                          child: myButton1(
                              'Waiter Setup', 2, Icons.payment, 50, 12, false)),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                            'Create here your Waiters WTPs. \nIf HARD COUPLED \nWtp operators will be able to send specific notifications to designated waiters \nIf SOFT COUPLED\nWtp Operator will be able to send specific notifications to all waiters'),
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
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
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
                    )
                  ],
                )))
          ],
        ),
      ],
    );
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
}
