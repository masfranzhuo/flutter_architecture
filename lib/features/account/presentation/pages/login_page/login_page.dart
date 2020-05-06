import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/register_page/register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
            Text('Title'),
            Text('Form'),
            FlatButton(
              child: Text('Register Page'),
              onPressed: () {
                Navigator.of(context).push(CustomPageRoute.slide(
                  page: RegisterPage(),
                  pageType: AppPageType.register,
                ));
              },
            ),
            Text('Forget Password'),
          ],
        ),
      ),
    );
  }
}
