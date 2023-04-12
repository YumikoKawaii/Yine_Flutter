import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yine/screens/calls.dart';
import 'package:yine/screens/Chats/chats.dart';
import 'package:yine/screens/Home/homepage.dart';
import 'package:yine/screens/voom.dart';
import 'package:yine/themes/styles.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  static String id = "mainNav";

  @override
  _MainNav createState() => _MainNav();
}

class _MainNav extends State<MainNav> {

  int selected = 0;
  List<Widget> screens = [
    const Home(),
    const Chats(),
    const Voom(),
    const Calls()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selected],
      backgroundColor: LightTheme.secondaryColor,
      bottomNavigationBar: Container(
        color: LightTheme.sprimaryColor,
        padding: const EdgeInsets.only(top: 1),
        child: GNav(
          backgroundColor: LightTheme.secondaryColor,
          color: LightTheme.stertiaryColor,
          padding: const EdgeInsets.all(15),
          activeColor: LightTheme.ssecondaryColor,
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.message,
              text: "Chats",
            ),
            GButton(
              icon: Icons.video_collection,
              text: "Voom",
            ),
            GButton(
              icon: Icons.phone,
              text: "Calls",
            ),
          ],
          onTabChange: (i){
            setState(() {
              selected = i;
            });
          },
        ),
      ),
    );
  }
}