import 'package:flutter/material.dart';
import 'package:yine/themes/styles.dart';

class Service extends StatelessWidget {

  const Service({super.key, required this.iconData, required this.field});

  final IconData iconData;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: LightTheme.secondaryColor,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: Column(
                children: <Widget>[
                  Icon(
                    iconData,
                    size: 35,
                    color: LightTheme.sprimaryColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      field,
                      style: TextStyle(
                        color: LightTheme.sprimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }

}