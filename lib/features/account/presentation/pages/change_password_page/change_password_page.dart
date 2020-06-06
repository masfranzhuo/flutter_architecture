import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/menu_drawer.dart';

class ChangePasswordPage extends StatelessWidget {
  static const routeName = PageType.changePassword;

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(title: Text('Change Password')),
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
