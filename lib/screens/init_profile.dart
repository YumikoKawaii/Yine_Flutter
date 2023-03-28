import 'package:flutter/material.dart';
import 'package:yine/models/profile.dart';
import 'package:yine/network/network_helper.dart';
import 'package:yine/screens/main_nav.dart';
import 'package:yine/themes/styles.dart';
import 'package:yine/utils/utils.dart';

import '../main.dart';
import '../network/profile.dart';

class InitProfile extends StatefulWidget {
  const InitProfile({super.key});

  static String id = "init_profile";

  @override
  _InitProfile createState() => _InitProfile();
}

class _InitProfile extends State<InitProfile> {

  final usernameController = TextEditingController();

  String usernameCaution = "";

  void _requestChangeProfile(String value) async {

    if (value != "") {
      var response = await requestChangeProfile(account.id, account.session, "username", value);
      print(response.statusCode);
      switch(response.statusCode) {
        case StatusCode.BadRequest: {
          usernameCaution = "Unexpected error!";
        }
        break;
        case StatusCode.NotAccepable: {
          usernameCaution = "Unexpected error!";
        }
        break;
        case StatusCode.TooEarly: {
          usernameCaution = "You have changed your username within 60 days!";
        }
        break;
        case StatusCode.OK: {
          await insertProfile(Profile(id: account.id, avatar: "", username: value, birthday: "", address: "", gender: "", hobbies: ""));
          if (context.mounted) Navigator.pushNamed(context, MainNav.id);
        }
      }

    } else {
      usernameCaution = "Username can't be null!";
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.secondaryColor,
      body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding:  const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 160,
                            width: 160,
                            child: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 78,
                                  backgroundColor: LightTheme.neutralColor,
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundImage: AssetImage("images/user.png"),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: LightTheme.secondaryColor,
                                          border: Border.all(color: LightTheme.neutralColor)
                                      ),
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: () {  },
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color: LightTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                        inputField("Username(*)", usernameController, Icons.co_present, false),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            usernameCaution,
                            style: TextStyle(
                              color: LightTheme.errorColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: buttonText(() {
                        setState(() {
                          _requestChangeProfile(usernameController.text);
                        });
                      }, "Continue"),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
                ],
              ),
            ),
          )
        ],
      ),
      ),
    );
  }
}