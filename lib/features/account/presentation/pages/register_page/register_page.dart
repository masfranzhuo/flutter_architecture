import 'package:flutter/material.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (_) => GetIt.I(),
      child: SafeArea(
        child: Scaffold(
          body: LayoutBuilder(builder: _buildBody),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState &&
            state.error == RegisterErrorGroup.general) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }

        if (state is RegisterLoadedState) {}
      },
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: ListView(
          children: <Widget>[
            Text('Title'),
            Text('Form'),
            FlatButton(
              child: Text('Login Page'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
