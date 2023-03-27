import 'package:flutter/material.dart';
import 'package:yine/themes/styles.dart';

Container inputField(String field, TextEditingController controller, IconData iconData, bool hidden) {
  return Container(
    child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(10, 15, 0, 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                field,
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
              scrollPadding: const EdgeInsets.only(bottom:40),
              obscureText: hidden,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 15),
                border: InputBorder.none,
                icon: Icon(
                  iconData,
                  color: LightTheme.tertiaryColor,
                ),
              ),
            ),
          ),
        ]
    ),
  );
}

Container buttonText(Function() f, String action) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: LightTheme.primaryColor,
    ),
    child: TextButton(
      onPressed: f,
      child: Text(
        action,
        style: TextStyle(
          color: LightTheme.neutralColor,
        ),
      ),
    ),
  );
}