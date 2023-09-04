import 'package:drinklinkmerchant/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WebMainPage extends StatefulWidget {
  const WebMainPage({Key? key}) : super(key: key);

  @override
  State<WebMainPage> createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {
  TextEditingController userController = TextEditingController(text: 'john');
  TextEditingController passController = TextEditingController(text: 'pass');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            children: [
              const Column(
                children: [
                  Text(
                    'DRINKLINK',
                    style: TextStyle(
                        fontFamily: 'SFPro',
                        color: Color(0xffbef7700),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'MORE TIMES FOR FUN',
                    style: TextStyle(
                        fontFamily: 'SFPro',
                        color: Color.fromRGBO(115, 115, 114, 0.976),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  'Home',
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  'About Us',
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: const Color(0xffef7700),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(55.0),
              color: const Color(0xffe9f9fc),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 100, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Your Best \nFood Anytime ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 40,
                          color: Color.fromARGB(255, 131, 131, 133),
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. \nAliquam ligula ipsum, sollicitudin eget erat a, sollicitudin lobortis augue.\n Sed in tristique justo. Class aptent taciti sociosqu ad litora torquent per \nconubia nostra, per inceptos himenaeos. ',
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 14,
                        color: Color(0x5e4b4b4b),
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            color: const Color(0xffef7700),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(
                              'Download App',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Android',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'SFPro',
                              fontSize: 18,
                              color: Color.fromARGB(255, 77, 76, 76),
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'iOS',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'SFPro',
                              fontSize: 18,
                              color: Color.fromARGB(255, 77, 76, 76),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Container(
                      width: 430,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/drinks.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 100, 100, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sing In',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 24,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: userController,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Username'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: passController,
                            obscureText: true,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Password'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      'Forgot password',
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 18,
                        color: Color(0xff696767),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (userController.text == 'john' &&
                            passController.text == 'pass') {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.dashBoard);
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Drinklink'),
                              content: const Text(
                                  'Incorrect username or password. Please try again.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 300,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.0),
                          color: const Color(0xffef7700),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
