import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  final String headerText;
  final String subHeaderText;

  const AccountHeader({
    Key key,
    @required this.headerText,
    this.subHeaderText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              headerText.toUpperCase(),
              style: Theme.of(context).textTheme.headline
            ),
          ),
          SizedBox(height: 16),
          Container(
            child: Text(
              subHeaderText ?? '',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
        ],
      ),
    );
  }
}
