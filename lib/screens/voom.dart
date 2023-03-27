import 'package:flutter/material.dart';
import 'package:yine/themes/styles.dart';

class Voom extends StatefulWidget {
  const Voom({super.key});



  _Voom createState() => _Voom();
}

class _Voom extends State<Voom> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.secondaryColor,
        title: Text(
          "Voom",
          style: TextStyle(
            color: LightTheme.stertiaryColor,
          ),
        )
        ,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.add, color: LightTheme.stertiaryColor,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person, color: LightTheme.stertiaryColor,)),
        ],
      ),
      body: SafeArea(
        child: Container(
        ),
      ),
    );
  }
}