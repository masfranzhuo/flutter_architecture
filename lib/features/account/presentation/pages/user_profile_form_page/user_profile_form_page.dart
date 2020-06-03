import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
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
              isLoading: state is UserProfileFormLoadingState,
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
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ListView(
        children: <Widget>[
          _$UserProfileForm(pageFormType: pageFormType),
        ],
      ),
    );
  }
}
