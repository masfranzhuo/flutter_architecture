import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/loading_indicator.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_chart_bloc/users_chart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UsersChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersChartBloc>(
      create: (_) => GetIt.I()..add(GetUsersDataEvent()),
      child: Builder(builder: (context) => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<UsersChartBloc, UsersChartState>(
        listener: (context, state) {
      if (state is UsersChartErrorState) {
        Scaffold.of(context).showSnackBar(CustomSnackBar(
          message: state.message,
          mode: SnackBarMode.error,
        ));
      }
    }, builder: (context, state) {
      List<Series<Map<String, dynamic>, String>> series = [];
      if (state is UsersChartLoadedState) {
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
              child: state is UsersChartLoadingState
                  ? Center(child: LoadingIndicator())
                  : BarChart(series),
            ),
            Container(
              padding: const EdgeInsets.all(32),
              height: 250,
              child: state is UsersChartLoadingState
                  ? Center(child: LoadingIndicator())
                  : PieChart(series),
            )
          ],
        ),
      );
    });
  }
}
