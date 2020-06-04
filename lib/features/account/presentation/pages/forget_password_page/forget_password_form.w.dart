part of 'forget_password_page.dart';

class _$ForgetPasswordForm extends StatefulWidget {
  @override
  __$ForgetPasswordFormState createState() => __$ForgetPasswordFormState();
}

class __$ForgetPasswordFormState extends State<_$ForgetPasswordForm> {
  final emailController = TextEditingController();

  void resetPassword(BuildContext context) {
    BlocProvider.of<ForgetPasswordBloc>(context).add(ResetPasswordEvent(
      email: emailController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildEmailTextField(context),
          _buildResetPasswordButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
      child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
        builder: (context, state) {
          String errorText;
          if (state is ForgetPasswordErrorState &&
              state.error == ForgetPasswordErrorGroup.email) {
            errorText = state.message;
          }

          return CustomTextField(
            context: context,
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            readOnly: state is ForgetPasswordLoadingState,
            errorText: errorText,
            iconData: Icons.email,
          );
        },
      ),
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
      builder: (context, state) {
        ButtonState buttonState = ButtonState.idle;
        if (state is ForgetPasswordLoadingState) {
          buttonState = ButtonState.loading;
        }

        if (state is ForgetPasswordLoadedState) {
          buttonState = ButtonState.done;
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
          child: CustomButton(
            child: Text('Reset Password'),
            state: buttonState,
            onPressed: () => resetPassword(context),
          ),
        );
      },
    );
  }
}
