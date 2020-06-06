import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_image_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/user_profile_form_bloc/user_profile_form_bloc.dart';
import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_architecture/features/storage/presentation/blocs/storage_bloc/storage_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'user_profile_form.w.dart';
part 'user_profile_image.w.dart';

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
        builder: (context) => BlocBuilder<AccountBloc, AccountState>(
          builder: (context, accountState) =>
              BlocBuilder<StorageBloc, StorageState>(
            builder: (context, storageState) =>
                BlocBuilder<UserProfileFormBloc, UserProfileFormState>(
              builder: (context, state) => CustomSafeArea(
                isLoading: state is UserProfileFormLoadingState ||
                    storageState is AccountLoadingState ||
                    accountState is StorageLoadingState,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      isUpdate ? 'Update User Profile' : 'User Profile',
                    ),
                  ),
                  body: LayoutBuilder(builder: _buildBody),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, accountState) {
        if (accountState is AccountLoadedState) {
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
                    BlocProvider.of<AccountBloc>(context)
                        .add(GetUserProfileEvent(
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
              BlocListener<StorageBloc, StorageState>(
                listener: (context, state) {
                  if (state is StorageUploadedState) {
                    BlocProvider.of<UserProfileFormBloc>(context).add(
                      UpdateUserProfileImageEvent(
                        account: accountState.account,
                        photoUrl: state.url,
                      ),
                    );
                  }
                },
              ),
            ],
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: ListView(
                children: <Widget>[
                  _$UserProfileImage(
                    imageUrl: accountState.account.photoUrl,
                  ),
                  _$UserProfileForm(
                    account: accountState.account,
                    pageFormType: pageFormType,
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
