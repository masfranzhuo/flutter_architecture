import 'package:flutter/material.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/menu_drawer.dart';

class StaffHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(title: Text('Home Page')),
        body: LayoutBuilder(builder: _buildBody),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ListView(
        children: <Widget>[],
      ),
    );
  }
}
