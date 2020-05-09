import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/menus/admin_menu.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/menus/customer_menu.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/menus/super_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuDrawer extends StatelessWidget {
  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure to logout from this application?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () {
                BlocProvider.of<AccountBloc>(context).add(LogoutEvent());
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountErrorState &&
            state.error == AccountErrorGroup.general) {
          Navigator.of(context).pop();
          CustomSnackBar.showSnackBar(
            context: context,
            message: state.message,
            mode: SnackBarMode.error,
          );
        }

        if (state is AccountLoadedState && !state.isLogin) {
          Navigator.of(context).pushAndRemoveUntil(
            CustomPageRoute.slide(
              page: LoginPage(),
              pageType: AppPageType.login,
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        Widget _menuWidget = SizedBox();
        if (state is AccountLoadedState) {
          if (state.role == StaffRole.admin) {
            _menuWidget = AdminMenu();
          } else if (state.role == StaffRole.superAdmin) {
            _menuWidget = SuperAdminMenu();
          } else {
            _menuWidget = CustomerMenu();
          }
        }
        return Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('John Doe'),
                accountEmail: Text('john@doe.com'),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onDetailsPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              _menuWidget,
              ListTile(
                title: Text('Logout'),
                trailing: Icon(Icons.exit_to_app),
                onTap: () => logout(context),
              ),
            ],
          ),
        );
      },
    );
  }
}