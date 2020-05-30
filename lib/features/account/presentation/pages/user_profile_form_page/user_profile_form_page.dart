import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_inputs.w.dart';

class UserProfileFormPage extends StatelessWidget {
  static const routeName = PageType.userProfile;

  final PageFormType pageFormType;

  const UserProfileFormPage({
    Key key,
    this.pageFormType = PageFormType.read,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return CustomSafeArea(
          isLoading: state is AccountLoadingState,
          child: Scaffold(
            appBar: AppBar(title: Text('User Profile')),
            body: LayoutBuilder(builder: _buildBody),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ListView(
        children: <Widget>[
          _$UserProfileInputs(pageFormType: pageFormType),
        ],
      ),
    );
  }
}
