import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/features/account/presentation/pages/staff_home_page/staff_home_page.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Admin'),
          trailing: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).push(CustomPageRoute.slide(
              page: StaffHomePage(),
              pageType: AppPageType.staffHome,
            ));
          },
        ),
        Divider(),
      ],
    );
  }
}
