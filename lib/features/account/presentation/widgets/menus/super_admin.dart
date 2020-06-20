import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/features/account/presentation/pages/staff_home_page/staff_home_page.dart';
import 'package:flutter_architecture/features/users_overview/presentation/pages/users_list_page/users_list_page.dart';

class SuperAdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Super Admin'),
          trailing: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).push(CustomPageRoute.slide(
              page: StaffHomePage(),
              pageType: PageType.staffHome,
            ));
          },
        ),
        Divider(),
        ListTile(
          title: Text('List of Users'),
          trailing: Icon(Icons.people),
          onTap: () {
            Navigator.of(context).push(CustomPageRoute.slide(
              page: UsersListPage(),
              pageType: PageType.usersList,
            ));
          },
        ),
        Divider(),
      ],
    );
  }
}
