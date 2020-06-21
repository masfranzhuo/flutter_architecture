part of 'users_list_page.dart';

class _$list extends StatefulWidget {
  @override
  __$listState createState() => __$listState();
}

class __$listState extends State<_$list> {
  final scrollController = ScrollController();
  String lastNodeId;

  @override
  void initState() {
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll == currentScroll) {
        BlocProvider.of<UsersListBloc>(context).add(
          GetUsersEvent(nodeId: lastNodeId),
        );
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
    return BlocConsumer<UsersListBloc, UsersListState>(
      listener: (context, state) {
        if (state is UsersListLoadedState && state.users.isNotEmpty) {
          setState(() {
            lastNodeId = state.users[state.users.length - 1].id;
          });
        }
      },
      builder: (context, state) {
        if (state is UsersListLoadedState) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount:
                state.isLoadMore ? state.users.length + 1 : state.users.length,
            itemBuilder: (context, index) {
              if (index >= state.users.length) {}
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

                      /// could remove this padding later
                      /// used for testing infinite list
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 16,
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
