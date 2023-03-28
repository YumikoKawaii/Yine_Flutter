import 'package:flutter/material.dart';
import 'package:yine/controllers/account.dart';
import 'package:yine/network/account.dart';
import 'package:yine/network/network_helper.dart';
import 'package:yine/screens/register.dart';
import 'package:yine/screens/welcome.dart';
import 'package:yine/themes/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String id = "login";

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {

  bool? remember = false;
  String emailCautions = "";
  String passwordCautions = "";

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void _requestLogin(String email, String password) async {

    if (validateEmail(email) && password != "") {
        var responce = await requestLogin(email, password);
        switch (responce.statusCode) {
          case StatusCode.NotFound: {
            emailCautions = "Account is not exist!";
            passwordCautions = "";
          }
          break;
          case StatusCode.Forbidden: {
            emailCautions = "";
            passwordCautions = "Wrong password!";
          }
          break;
        }
    }

    if (!validateEmail(email)) {
      emailCautions = "Invalid email!";
    } else {
      emailCautions = "";
    }

    if (password == "") {
      passwordCautions = "Invalid password!";
    } else {
      passwordCautions = "";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Container(
          color: LightTheme.secondaryColor,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                          borderRadius: BorderRadius.circular(20)
                        ),
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
                      margin: const EdgeInsets.fromLTRB(25,0 , 0, 5),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Email",
                        style: TextStyle(
                         color: LightTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: LightTheme.neutralColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: emailTextController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.mail,
                        color: LightTheme.tertiaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        emailCautions,
                      style: TextStyle(
                        color: LightTheme.errorColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        color: LightTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  decoration: BoxDecoration(
                      color: LightTheme.neutralColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: passwordTextController,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.key,
                        color: LightTheme.tertiaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      passwordCautions,
                      style: TextStyle(
                        color: LightTheme.errorColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: LightTheme.primaryColor,
                          checkColor: LightTheme.secondaryColor,
                          value: remember,
                          onChanged: (bool? value) {
                            setState(() {
                              remember = value;
                            });
                          },
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(
                            color: LightTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ]
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: test,
                    child: Text(
                      "Forgotten password?",
                      style: TextStyle(
                        color: LightTheme.primaryColor
                    ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: LightTheme.primaryColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _requestLogin(emailTextController.text, passwordTextController.text);
                      });
                    },
                    child: Text(""
                        "Log in",
                        style: TextStyle(
                          color: LightTheme.secondaryColor,
                        ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Register.id);
                          },
                          child: Text(
                              "Register",
                            style: TextStyle(color: LightTheme.primaryColor),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}