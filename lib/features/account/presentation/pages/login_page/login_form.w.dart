part of 'login_page.dart';

class _$LoginForm extends StatefulWidget {
  @override
  __$LoginFormState createState() => __$LoginFormState();
}

class __$LoginFormState extends State<_$LoginForm> {
  final _emailController = TextEditingController(text: 'one@test.com');
  final _passwordController = TextEditingController(text: '123456');

  void login(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(LoginWithPasswordEvent(
      email: _emailController.text,
      password: _passwordController.text,
    ));
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
          String errorText;
          if (state is LoginErrorState &&
              state.error == LoginErrorGroup.email) {
            errorText = state.message;
          }

          return CustomTextField(
            context: context,
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            readOnly: state is LoginLoadingState,
            errorText: errorText,
            iconData: Icons.email,
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
          String errorText;
          if (state is LoginErrorState &&
              state.error == LoginErrorGroup.password) {
            errorText = state.message;
          }

          return CustomTextField(
            context: context,
            controller: _passwordController,
            hintText: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            readOnly: state is LoginLoadingState,
            errorText: errorText,
            iconData: Icons.lock,
          );
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        ButtonState buttonState = ButtonState.idle;
        if (state is LoginLoadingState) {
          buttonState = ButtonState.loading;
        }

        if (state is LoginLoadedState) {
          buttonState = ButtonState.done;
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
          child: CustomButton(
            child: Text('Login'),
            state: buttonState,
            onPressed: () => login(context),
          ),
        );
      },
    );
  }
}
