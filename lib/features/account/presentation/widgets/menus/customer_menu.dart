import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/features/account/presentation/pages/customer_home_page/customer_home_page.dart';

class CustomerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Customer'),
          trailing: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).push(CustomPageRoute.slide(
              page: CustomerHomePage(),
              pageType: AppPageType.customerHome,
            ));
          },
        ),
        Divider(),
      ],
    );
  }
}
