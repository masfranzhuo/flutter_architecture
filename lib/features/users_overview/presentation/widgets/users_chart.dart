import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_overview_bloc/users_overview_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UsersChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersOverviewBloc>(
      create: (_) => GetIt.I()..add(GetUsersDataEvent()),
      child: Builder(builder: (context) => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<UsersOverviewBloc, UsersOverviewState>(
        listener: (context, state) {
      if (state is UsersOverviewErrorState) {
        Scaffold.of(context).showSnackBar(CustomSnackBar(
          message: state.message,
          mode: SnackBarMode.error,
        ));
      }
    }, builder: (context, state) {
      List<Series<Map<String, dynamic>, String>> series = [];
      if (state is UsersOverviewLoadedState) {
        series = [
          Series(
            id: 'Account',
            domainFn: (Map<String, dynamic> data, _) => data['status'],
            measureFn: (Map<String, dynamic> data, _) => data['count'],
            data: state.usersData,
          ),
        ];
      }

      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
              child: Text(
                'Users Account Status Chart',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(32),
              height: 250,
              child: BarChart(series),
            ),
            Container(
              padding: const EdgeInsets.all(32),
              height: 250,
              child: PieChart(series),
            )
          ],
        ),
      );
    });
  }
}
