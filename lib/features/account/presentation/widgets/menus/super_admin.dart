import 'package:flutter/material.dart';

class SuperAdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Super Admin'),
          trailing: Icon(Icons.person),
        ),
        Divider(),
      ],
    );
  }
}
