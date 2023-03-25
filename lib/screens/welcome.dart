import 'package:flutter/material.dart';
import 'package:yine/screens/login.dart';
import 'package:yine/screens/register.dart';
import 'package:yine/themes/styles.dart';

void test() {
  print("hehe");
}

class Welcome extends StatelessWidget {

  static String id = "Welcome";

  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.secondaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: LightTheme.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 125,
                  height: 125,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Positioned.fill(child: Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage('images/message.png'),
                          ),
                        )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Positioned.fill(child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "YINE",
                            style: TextStyle(
                              color: LightTheme.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: double.infinity, height: 30,),
                Container(
                  child: const Text(
                      "Welcome to YINE",
                      style: TextStyle(
                        fontSize: 30
                      ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    "Free messaging, voice and video calls, and more! ",
                    style: TextStyle(
                      color: LightTheme.tertiaryColor
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: LightTheme.primaryColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Login.id);
                      },
                      child: Text(
                          "Log in",
                        style: TextStyle(
                          color: LightTheme.neutralColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: LightTheme.neutralColor,
                    ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Register.id);
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: LightTheme.primaryColor,
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}