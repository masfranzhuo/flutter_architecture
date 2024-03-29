import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_search_delegate.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/features/storage/presentation/blocs/storage_bloc/storage_bloc.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_list_bloc/users_list_bloc.dart';
import 'package:flutter_architecture/features/users_overview/presentation/pages/user_detail/user_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'list.w.dart';

class UsersListPage extends StatelessWidget {
  static const routeName = PageType.usersList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersListBloc>(
      create: (_) => GetIt.I()..add(GetUsersEvent()),
      child: Builder(
        builder: (context) => BlocBuilder<UsersListBloc, UsersListState>(
          builder: (context, state) => CustomSafeArea(
            isLoading: state is UsersListLoadedState && state.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: Text('List of Users'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      final query = await showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(hintText: 'Search'),
                      );
                      if (query != null) {
                        BlocProvider.of<UsersListBloc>(context).add(
                          GetUsersEvent(query: query),
                        );
                      }
                    },
                  ),
                ],
              ),
              body: LayoutBuilder(builder: _buildBody),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return BlocListener<UsersListBloc, UsersListState>(
      listener: (context, state) {
        if (state is UsersListErrorState &&
            state.error == UsersListErrorGroup.general) {
          Scaffold.of(context).showSnackBar(CustomSnackBar(
            message: state.message,
            mode: SnackBarMode.error,
          ));
        }

        if (state is UsersListLoadedState && state.hasReachMax) {
          if (state.users.isNotEmpty) {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                CustomSnackBar(
                  message: 'No more data available',
                ),
              );
          } else {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                CustomSnackBar(
                  message: 'No data found',
                ),
              );
          }
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<UsersListBloc>(context).add(
            GetUsersEvent(),
          );
        },
        child: BlocListener<StorageBloc, StorageState>(
            listener: (context, stateS) {
              if (stateS is StorageErrorState) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    CustomSnackBar(
                      message: stateS.message,
                    ),
                  );
              }
            },
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: _$list(),
            )),
      ),
    );
  }
}
