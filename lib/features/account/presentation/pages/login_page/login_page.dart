import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/register_page/register_page.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/account_header.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/application_version.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'login_form.w.dart';
part 'login_footer.w.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState &&
            state.error == LoginErrorGroup.general) {
          CustomSnackBar.showSnackBar(
            context: context,
            message: state.message,
            mode: SnackBarMode.error,
          );
        }

        if (state is LoginLoadedState) {
          // Timer(Duration(milliseconds: 500), () {
          //   if (state.isStaff) {
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(
          //       builder: (context) => LoginPage(),
          //     ));
          //   } else {
          //     Navigator.of(context).pushReplacement(BCPPageRoute.slide(
          //       page: CustomerHomePage(),
          //       pageType: BCPAppPage.customerHome,
          //     ));
          //   }
          // });
        }
      },
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ApplicationVersion(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AccountHeader(
                  headerText: 'Flutter Architecture',
                  subHeaderText: 'Login here',
                ),
                _$LoginForm(),
                _$LoginFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
