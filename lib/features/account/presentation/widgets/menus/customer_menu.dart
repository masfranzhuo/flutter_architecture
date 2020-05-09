import 'package:flutter/material.dart';

class CustomerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Customer'),
          trailing: Icon(Icons.person),
        ),
        Divider(),
      ],
    );
  }
}
