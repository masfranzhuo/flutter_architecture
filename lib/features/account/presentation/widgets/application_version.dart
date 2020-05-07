import 'package:flutter/material.dart';

class ApplicationVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Flutter Architecture, 2020 (C) Version 0.0.1',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
