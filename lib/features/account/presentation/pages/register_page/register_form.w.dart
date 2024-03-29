part of 'register_page.dart';

class _$RegisterForm extends StatefulWidget {
  @override
  __$RegisterFormState createState() => __$RegisterFormState();
}

class __$RegisterFormState extends State<_$RegisterForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypedPasswordController = TextEditingController();

  void register(BuildContext context) {
    BlocProvider.of<RegisterBloc>(context).add(RegisterWithPasswordEvent(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      retypedPassword: retypedPasswordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildNameTextField(context),
          _buildEmailTextField(context),
          _buildPasswordTextField(context),
          _buildRetypedPasswordTextField(context),
          _buildRegisterButton(context),
        ],
      ),
    );
  }

  Widget _buildNameTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          String errorText;
          if (state is RegisterErrorState &&
              state.error == RegisterErrorGroup.name) {
            errorText = state.message;
          }

          return CustomTextField(
            context: context,
            controller: nameController,
            hintText: 'Name',
            keyboardType: TextInputType.text,
            readOnly: state is RegisterLoadingState,
            errorText: errorText,
            iconData: Icons.person,
          );
        },
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          String errorText;
          if (state is RegisterErrorState &&
              state.error == RegisterErrorGroup.email) {
            errorText = state.message;
          }

          return CustomTextField(
            context: context,
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            readOnly: state is RegisterLoadingState,
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
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          String errorText;
          if (state is RegisterErrorState &&
              state.error == RegisterErrorGroup.password) {
            errorText = state.message;
          }

          return CustomTextField(
            context: context,
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            readOnly: state is RegisterLoadingState,
            errorText: errorText,
            iconData: Icons.lock_open,
          );
        },
      ),
    );
  }

  Widget _buildRetypedPasswordTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          String errorText;
          if (state is RegisterErrorState &&
              state.error == RegisterErrorGroup.retypedPassword) {
            errorText = state.message;
          }

          return CustomTextField(
            context: context,
            controller: retypedPasswordController,
            hintText: 'Retyped Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            readOnly: state is RegisterLoadingState,
            errorText: errorText,
            iconData: Icons.lock,
          );
        },
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        ButtonState buttonState = ButtonState.idle;
        if (state is RegisterLoadingState) {
          buttonState = ButtonState.loading;
        }

        if (state is RegisterLoadedState) {
          buttonState = ButtonState.done;
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
          child: CustomButton(
            child: Text('Register'),
            state: buttonState,
            onPressed: () => register(context),
          ),
        );
      },
    );
  }
}
