import 'package:flutter/material.dart';
import 'package:yine/themes/styles.dart';

import '../../../models/profile.dart';

class FriendList extends StatelessWidget {

  const FriendList({super.key, required this.friendList});

  final List<Profile> friendList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: friendList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(1),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: LightTheme.secondaryColor,
              elevation: 0,
            ),
            child: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: friendList[index].avatar == ""
                        ? const AssetImage("images/user.png")
                        : NetworkImage(
                        friendList[index].avatar) as ImageProvider,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        friendList[index].username == ""
                            ? "Username??"
                            : friendList[index].username,
                        style: TextStyle(
                          color: LightTheme.sprimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}