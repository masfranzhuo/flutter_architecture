import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/pages/custom_widget.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';

class CustomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Custom Page')),
        body: Container(
          child: ListView(
            children: <Widget>[
              CustomWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
