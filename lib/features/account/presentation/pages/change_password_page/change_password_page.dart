import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'change_password_form.w.dart';

class ChangePasswordPage extends StatelessWidget {
  static const routeName = PageType.changePassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
      create: (_) => GetIt.I(),
      child: Builder(
        builder: (context) =>
            BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) => CustomSafeArea(
            isLoading: state is ChangePasswordLoadingState,
            child: Scaffold(
              appBar: AppBar(title: Text('Change Password')),
              body: LayoutBuilder(builder: _buildBody),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordErrorState &&
            state.error == ChangePasswordErrorGroup.general) {
          Scaffold.of(context).showSnackBar(CustomSnackBar(
            message: state.message,
            mode: SnackBarMode.error,
          ));
        }

        if (state is ChangePasswordLoadedState) {
          Scaffold.of(context).showSnackBar(CustomSnackBar(
            message: state.message,
            mode: SnackBarMode.success,
          ));
        }
      },
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Change Password Form',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            _$ChangePasswordForm(),
          ],
        ),
      ),
    );
  }
}
