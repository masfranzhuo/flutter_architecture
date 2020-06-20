part of 'users_list_page.dart';

class _$list extends StatefulWidget {
  @override
  __$listState createState() => __$listState();
}

class __$listState extends State<_$list> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll <= currentScroll) {
        BlocProvider.of<UsersListBloc>(context).add(GetUsersEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// TODO: infinite list with bloc
    /// page limit in firebase database realtime
    /// fix bloc + test
    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {
        if (state is UsersListLoadedState) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount:
                state.isLoadMore ? state.users.length + 1 : state.users.length,
            itemBuilder: (context, index) {
              return index >= state.users.length
                  ? Center(child: LinearProgressIndicator())
                  : ListTile(
                      leading: ClipOval(
                        child: state.users[index]?.photoUrl != null
                            ? CircleAvatar(
                                child: Image.network(
                                state.users[index].photoUrl,
                              ))
                            : CircleAvatar(child: Icon(Icons.person)),
                      ),
                      title: Text('${index + 1}. ' + state.users[index].name),
                      subtitle: Text(state.users[index].email),
                      trailing: IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Navigator.of(context).push(CustomPageRoute.slide(
                            page: UserDetailPage(user: state.users[index]),
                            pageType: PageType.userDetail,
                          ));
                        },
                      ),
                    );
            },
          );
        }

        return SizedBox();
      },
    );
  }
}
