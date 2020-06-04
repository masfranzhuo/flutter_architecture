import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/forget_password_bloc/forget_password_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/account_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'forget_password_form.w.dart';
part 'forget_password_footer.w.dart';

class ForgetPasswordPage extends StatelessWidget {
  static const routeName = PageType.forgetPassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordBloc>(
      create: (_) => GetIt.I(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: LayoutBuilder(builder: _buildBody),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordErrorState &&
            state.error == ForgetPasswordErrorGroup.general) {
          Scaffold.of(context).showSnackBar(CustomSnackBar(
            message: state.message,
            mode: SnackBarMode.error,
          ));
        }

        if (state is ForgetPasswordLoadedState) {
          Scaffold.of(context).showSnackBar(CustomSnackBar(
            message: state.message,
            mode: SnackBarMode.success,
          ));
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is ForgetPasswordLoadingState,
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: AccountHeader(
                    headerText: 'Forget Password Form',
                    subHeaderText: 'Enter your email to reset the password',
                  ),
                ),
                _$ForgetPasswordForm(),
                _$ForgetPasswordFooter(),
              ],
            ),
          ),
        );
      },
    );
  }
}
