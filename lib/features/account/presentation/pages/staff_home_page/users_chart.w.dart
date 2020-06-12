part of 'staff_home_page.dart';

class _$UsersChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: get real data
    List<Account> accounts = [
      Customer(
        id: 'fake_id',
        name: 'name',
        email: 'email',
        accountStatus: AccountStatus.active,
      ),
      Customer(
        id: 'fake_id',
        name: 'name',
        email: 'email',
        accountStatus: AccountStatus.active,
      ),
      Customer(
        id: 'fake_id',
        name: 'name',
        email: 'email',
        accountStatus: AccountStatus.inactive,
      ),
    ];

    List<Map<String, dynamic>> data = [
      {
        'status': AccountStatus.active,
        'count': accounts
            .where((account) => account.accountStatus == AccountStatus.active)
            .length,
      },
      {
        'status': AccountStatus.inactive,
        'count': accounts
            .where((account) => account.accountStatus == AccountStatus.inactive)
            .length,
      },
    ];

    List<Series<Map<String, dynamic>, String>> series = [
      Series(
        id: 'Account',
        domainFn: (Map<String, dynamic> data, _) => data['status'],
        measureFn: (Map<String, dynamic> data, _) => data['count'],
        data: data,
      ),
    ];

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
          child: Text(
            'Users Account Status Chart',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        CustomButton(
          child: Text('GetUsersData'),
          onPressed: () {
            BlocProvider.of<AccountBloc>(context).add(
              GetUserProfileEvent(id: 'GetUsersData'),
            );
          },
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
    );
  }
}
