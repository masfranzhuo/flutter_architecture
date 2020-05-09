import 'package:flutter/material.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Admin'),
          trailing: Icon(Icons.person),
        ),
        Divider(),
      ],
    );
  }
}
