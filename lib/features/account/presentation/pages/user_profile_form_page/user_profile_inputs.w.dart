part of 'user_profile_form_page.dart';

class _$UserProfileInputs extends StatefulWidget {
  final PageFormType pageFormType;

  const _$UserProfileInputs({
    Key key,
    @required this.pageFormType,
  }) : super(key: key);

  bool get readOnly => pageFormType == PageFormType.read;

  @override
  __$UserProfileInputsState createState() => __$UserProfileInputsState();
}

class __$UserProfileInputsState extends State<_$UserProfileInputs> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _imageUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildImage(context),
          _buildEmail(context),
          _buildName(context),
          _buildPhoneNumber(context),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: CircleAvatar(
        child: Icon(Icons.person),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return CustomTextField(
            context: context,
            controller: _emailController
              ..text = (state as AccountLoadedState).account.email,
            iconData: Icons.email,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            readOnly: true,
          );
        },
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          String errorText;
          return CustomTextField(
            context: context,
            controller: _nameController
              ..text = (state as AccountLoadedState).account.name,
            iconData: Icons.person,
            keyboardType: TextInputType.text,
            hintText: 'Name',
            readOnly: widget.readOnly,
            errorText: errorText,
          );
        },
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          String errorText;
          return CustomTextField(
            context: context,
            controller: _phoneNumberController
              ..text = (state as AccountLoadedState).account.phoneNumber,
            iconData: Icons.phone,
            keyboardType: TextInputType.phone,
            hintText: 'Phone Number',
            readOnly: widget.readOnly,
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          ButtonState buttonState = ButtonState.idle;
          if (state is AccountLoadingState) {
            buttonState = ButtonState.loading;
          }

          return CustomButton(
            state: buttonState,
            child: Text('Edit'),
            onPressed: () {},
          );
        },
      ),
    );
  }
}
