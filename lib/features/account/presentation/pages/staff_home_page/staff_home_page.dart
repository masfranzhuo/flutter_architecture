import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/staff_home_page/users_chart.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/menu_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffHomePage extends StatelessWidget {
  static const routeName = PageType.staffHome;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return CustomSafeArea(
          isLoading: state is AccountLoadingState,
          child: Scaffold(
            drawer: MenuDrawer(),
            appBar: AppBar(title: Text('Home Page')),
            body: LayoutBuilder(builder: _buildBody),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ListView(
        children: <Widget>[
          UsersChart(),
        ],
      ),
    );
  }
}
