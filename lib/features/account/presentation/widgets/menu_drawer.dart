import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_architecture/features/account/presentation/pages/user_profile_form_page/user_profile_form_page.dart';
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
                Navigator.of(context).pop();
                BlocProvider.of<AccountBloc>(context).add(LogoutEvent());
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
          Scaffold.of(context).showSnackBar(CustomSnackBar(
            message: state.message,
            mode: SnackBarMode.error,
          ));
        }

        if (state is AccountLoadedState && !state.isLogin) {
          Navigator.of(context).pop();
          Navigator.of(context).pushAndRemoveUntil(
            CustomPageRoute.slide(
              page: LoginPage(),
              pageType: PageType.login,
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        Widget _userAccount = SizedBox();
        Widget _menuWidget = SizedBox();

        if (state is AccountLoadedState) {
          _userAccount = UserAccountsDrawerHeader(
            accountName: Text(state.account?.name ?? 'Name'),
            accountEmail: Text(state.account?.email ?? 'Email'),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            onDetailsPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(CustomPageRoute.slide(
                page: UserProfileFormPage(),
                pageType: PageType.userProfile,
              ));
            },
          );

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
              _userAccount,
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
