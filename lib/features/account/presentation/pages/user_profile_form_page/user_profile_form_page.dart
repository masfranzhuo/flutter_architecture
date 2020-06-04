import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/core/presentation/widgets/loading_indicator.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/user_profile_form_bloc/user_profile_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'user_profile_form.w.dart';

class UserProfileFormPage extends StatelessWidget {
  static const routeName = PageType.userProfile;

  final PageFormType pageFormType;

  const UserProfileFormPage({
    Key key,
    this.pageFormType = PageFormType.read,
  }) : super(key: key);

  bool get isUpdate => pageFormType == PageFormType.update;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileFormBloc>(
      create: (_) => GetIt.I(),
      child: Builder(
        builder: (context) =>
            BlocBuilder<UserProfileFormBloc, UserProfileFormState>(
          builder: (context, state) {
            return CustomSafeArea(
              isLoading: state is UserProfileFormLoadingState ||
                  BlocProvider.of<AccountBloc>(context).state
                      is AccountLoadingState,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    isUpdate ? 'Update User Profile' : 'User Profile',
                  ),
                ),
                body: LayoutBuilder(builder: _buildBody),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserProfileFormBloc, UserProfileFormState>(
          listener: (context, state) {
            if (state is UserProfileFormErrorState &&
                state.error == UserProfileFormErrorGroup.general) {
              Scaffold.of(context).showSnackBar(CustomSnackBar(
                message: state.message,
                mode: SnackBarMode.error,
              ));
            }

            if (state is UserProfileFormLoadedState) {
              BlocProvider.of<AccountBloc>(context).add(GetUserProfileEvent(
                id: state.account.id,
              ));
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountLoadedState) {
              if (isUpdate) {
                Navigator.pop<Account>(context, state.account);
              }
            }
          },
        ),
      ],
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: ListView(
          children: <Widget>[
            BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
              if (state is AccountLoadedState) {
                return _$UserProfileForm(
                  account: state.account,
                  pageFormType: pageFormType,
                );
              }

              return LoadingIndicator();
            }),
          ],
        ),
      ),
    );
  }
}
