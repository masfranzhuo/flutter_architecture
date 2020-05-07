part of 'login_page.dart';

class _$LoginForm extends StatefulWidget {
  @override
  __$LoginFormState createState() => __$LoginFormState();
}

class __$LoginFormState extends State<_$LoginForm> {
  void login(BuildContext context) {
    print('Login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildEmailTextField(context),
          _buildPasswordTextField(context),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              hintText: 'Email',
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: new InputDecoration(
              hintText: 'Password',
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return RaisedButton(
          child: Text('Login'),
          onPressed: () => login(context),
        );
      },
    );
  }
}
