import 'package:flutter/material.dart';
import 'package:yine/themes/styles.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});



  _Calls createState() => _Calls();
}

class _Calls extends State<Calls> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.secondaryColor,
        title: Text("Calls", style: TextStyle(color: LightTheme.stertiaryColor),),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.personal_video_outlined, color: LightTheme.stertiaryColor,)),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Make a call anytime, anywhere",
                  style: TextStyle(
                    color: LightTheme.sprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Talk to your friends whenever",
                  style: TextStyle(
                    color: LightTheme.sprimaryColor,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "with Yine voice calls.",
                  style: TextStyle(
                    color: LightTheme.sprimaryColor,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(
                    color: LightTheme.sprimaryColor,
                    width: 1,
                  )
                ),
                onPressed: (){},
                child: Text(
                  "Search contacts",
                  style: TextStyle(
                    color: LightTheme.sprimaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}