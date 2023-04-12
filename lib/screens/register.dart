import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yine/controllers/account.dart';
import 'package:yine/models/account.dart';
import 'package:yine/network/account.dart';
import 'package:yine/network/network_helper.dart';
import 'package:yine/screens/init_profile.dart';
import 'package:yine/screens/login.dart';
import 'package:yine/themes/styles.dart';
import 'package:yine/utils/utils.dart';

import '../main.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  static String id = "register";

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final emailTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();
  final cPasswordTextEditController = TextEditingController();

  String emailCaution = "";
  String passwordCaution = "";
  String cPasswordCaution = "";

  void _requestRegister(String email, String password, String cPassword) async {
    if (validateEmail(email) &&
        validatePassword(password) &&
        password == cPassword) {
      var response = await requestRegister(email, password);
      switch (response.statusCode) {
        case StatusCode.Conflict:
          {
            emailCaution = "Email already exist!";
            passwordCaution = "";
            cPasswordCaution = "";
          }
          break;
        case StatusCode.NotAccepable:
          {
            print(response.body);
          }
          break;
        case StatusCode.BadRequest:
          {
            emailCaution = "Unexpected Error?!??";
            passwordCaution = "Unexpected Error?!??";
            cPasswordCaution = "Unexpected Error?!??";
          }
          break;
        case StatusCode.OK:
          {
            account = Account.fromJson(jsonDecode(response.body));
            await insertAccount(account);
            if (context.mounted) Navigator.pushNamed(context, InitProfile.id);
          }
      }
    } else {
      if (!validateEmail(email)) {
        emailCaution = "Invalid email!";
      } else {
        emailCaution = "";
      }

      if (!validatePassword(password)) {
        passwordCaution = "Invalid password!";
        cPasswordCaution = "";
      } else if (password != cPassword) {
        passwordCaution = "";
        cPasswordCaution = "Password is not match!";
      } else {
        passwordCaution = "";
        cPasswordCaution = "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: LightTheme.secondaryColor,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 110,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: LightTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 15, 20, 10),
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Image(
                                image: AssetImage('images/message.png'),
                                height: 100,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(25, 0, 0, 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "YINE",
                                style: TextStyle(
                                  color: LightTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      inputField(
                          "Email", emailTextEditController, Icons.email, false),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            emailCaution,
                            style: TextStyle(
                              color: LightTheme.errorColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      inputField("Password", passwordTextEditController,
                          Icons.key, true),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            passwordCaution,
                            style: TextStyle(
                              color: LightTheme.errorColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      inputField("Confirm Password",
                          cPasswordTextEditController, Icons.key, true),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            cPasswordCaution,
                            style: TextStyle(
                              color: LightTheme.errorColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: LightTheme.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _requestRegister(
                                  emailTextEditController.text,
                                  passwordTextEditController.text,
                                  cPasswordTextEditController.text);
                            });
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: LightTheme.neutralColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Already have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Login.id);
                                },
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: LightTheme.primaryColor,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
