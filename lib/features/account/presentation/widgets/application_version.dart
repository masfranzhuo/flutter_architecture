import 'package:flutter/material.dart';

class ApplicationVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 64, 32, 16),
      child: Text(
        'Flutter Architecture, 2020 (C) Version 0.0.1',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
