import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/register_page/register_page.dart';
import 'package:flutter_architecture/features/account/presentation/widgets/account_header.dart';
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
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
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
        child: ListView(
          children: <Widget>[
            AccountHeader(
              headerText: 'Flutter Architecture',
              subHeaderText: 'Login here',
            ),
            _$LoginForm(),
            _$LoginFooter(),
            Container(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Versi 0.0.1\n(C) Flutter Architecture, 2020',
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      ),
    );
  }
}
