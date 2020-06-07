part of 'change_password_page.dart';

class _$ChangePasswordForm extends StatefulWidget {
  @override
  __$ChangePasswordFormState createState() => __$ChangePasswordFormState();
}

class __$ChangePasswordFormState extends State<_$ChangePasswordForm> {
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final retypedPasswordController = TextEditingController();

  void onSubmit(BuildContext context) {
    BlocProvider.of<ChangePasswordBloc>(context).add(AccountChangePasswordEvent(
      password: passwordController.text,
      retypedPassword: retypedPasswordController.text,
      currentPassword: currentPasswordController.text,
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    passwordController.dispose();
    retypedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildCurrentPassword(context),
          _buildPassword(context),
          _buildRetypedPassword(context),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildCurrentPassword(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          String errorText;
          if (state is ChangePasswordErrorState &&
              state.error == ChangePasswordErrorGroup.currentPassword) {
            errorText = state.message;
          }
          return CustomTextField(
            context: context,
            controller: currentPasswordController,
            iconData: Icons.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Curret Password',
            errorText: errorText,
          );
        },
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          String errorText;
          if (state is ChangePasswordErrorState &&
              state.error == ChangePasswordErrorGroup.password) {
            errorText = state.message;
          }
          return CustomTextField(
            context: context,
            controller: passwordController,
            iconData: Icons.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Password',
            errorText: errorText,
          );
        },
      ),
    );
  }

  Widget _buildRetypedPassword(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          String errorText;
          if (state is ChangePasswordErrorState &&
              state.error == ChangePasswordErrorGroup.retypedPassword) {
            errorText = state.message;
          }
          return CustomTextField(
            context: context,
            controller: retypedPasswordController,
            iconData: Icons.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Retyped Password',
            errorText: errorText,
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          ButtonState buttonState = ButtonState.idle;
          if (state is ChangePasswordLoadingState) {
            buttonState = ButtonState.loading;
          }

          return CustomButton(
            state: buttonState,
            child: Text('Submit'),
            onPressed: () => onSubmit(context),
          );
        },
      ),
    );
  }
}
