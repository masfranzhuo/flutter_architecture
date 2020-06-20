part of 'users_list_page.dart';

class _$list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {
        List<Account> users;
        if (state is UsersListLoadedState && state.users != null) {
          users = state.users;
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipOval(
                child: users[index]?.photoUrl != null
                    ? CircleAvatar(child: Image.network(users[index].photoUrl))
                    : CircleAvatar(child: Icon(Icons.person)),
              ),
              title: Text(users[index].name),
              subtitle: Text(users[index].email),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  Navigator.of(context).push(CustomPageRoute.slide(
                    page: UserDetailPage(user: users[index]),
                    pageType: PageType.userDetail,
                  ));
                },
              ),
            );
          },
        );
      },
    );
  }
}
