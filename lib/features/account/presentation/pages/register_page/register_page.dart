import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/customer_home_page/customer_home_page.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/account_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_form.w.dart';
part 'register_footer.w.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = PageType.register;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: LayoutBuilder(builder: _buildBody),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState &&
            state.error == RegisterErrorGroup.general) {
          Scaffold.of(context).showSnackBar(CustomSnackBar(
            message: state.message,
            mode: SnackBarMode.error,
          ));
        }

        if (state is RegisterLoadedState) {
          Timer(Duration(milliseconds: 500), () {
            Navigator.of(context).pushReplacement(CustomPageRoute.slide(
              page: CustomerHomePage(),
              pageType: PageType.customerHome,
            ));
          });
        }
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is RegisterLoadingState,
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: AccountHeader(
                    headerText: 'Register Form',
                  ),
                ),
                _$RegisterForm(),
                _$RegisterFooter(),
              ],
            ),
          ),
        );
      },
    );
  }
}
