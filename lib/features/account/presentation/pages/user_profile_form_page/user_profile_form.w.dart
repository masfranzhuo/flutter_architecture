part of 'user_profile_form_page.dart';

class _$UserProfileForm extends StatefulWidget {
  final PageFormType pageFormType;

  const _$UserProfileForm({
    Key key,
    @required this.pageFormType,
  }) : super(key: key);

  bool get readOnly => pageFormType == PageFormType.read;

  @override
  __$UserProfileFormState createState() => __$UserProfileFormState();
}

class __$UserProfileFormState extends State<_$UserProfileForm> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _imageUrl;

  void _onSubmitUpdate(BuildContext context, UserProfileFormLoadedState state) {
    BlocProvider.of<UserProfileFormBloc>(context).add(UpdateUserProfileEvent(
      account: state.account,
      name: _nameController.text,
      phoneNumber: _phoneNumberController.text,
    ));
  }

  void _onNavigateUpdate(BuildContext context) {
    Navigator.of(context).push(CustomPageRoute.slide(
      page: UserProfileFormPage(pageFormType: PageFormType.update),
      pageType: PageType.userProfile,
    ));
  }

  @override
  void initState() {
    // TODO: if error then affect account bloc, split the bloc and test
    // remove account and isStaff in event, use copyWith instead
    // https://bloclibrary.dev/#/flutterinfinitelisttutorial
    // final account = (BlocProvider.of<AccountBloc>(context) as AccountLoadedState).account;
    _emailController.text = 'update';
    _nameController.text = 'update';
    _phoneNumberController.text = 'update';
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
      child: BlocBuilder<UserProfileFormBloc, UserProfileFormState>(
        builder: (context, state) {
          return CustomTextField(
            context: context,
            controller: _emailController,
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
      child: BlocBuilder<UserProfileFormBloc, UserProfileFormState>(
        builder: (context, state) {
          String errorText;
          return CustomTextField(
            context: context,
            controller: _nameController,
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
      child: BlocBuilder<UserProfileFormBloc, UserProfileFormState>(
        builder: (context, state) {
          String errorText;
          return CustomTextField(
            context: context,
            controller: _phoneNumberController,
            iconData: Icons.phone,
            keyboardType: TextInputType.phone,
            hintText: 'Phone Number',
            readOnly: widget.readOnly,
            errorText: errorText,
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: BlocBuilder<UserProfileFormBloc, UserProfileFormState>(
        builder: (context, state) {
          ButtonState buttonState = ButtonState.idle;
          if (state is UserProfileFormLoadingState) {
            buttonState = ButtonState.loading;
          }

          return CustomButton(
            state: buttonState,
            child: Text(widget.readOnly ? 'Edit' : 'Submit'),
            onPressed: () {
              widget.readOnly
                  ? _onNavigateUpdate(context)
                  : _onSubmitUpdate(
                      context, (state as UserProfileFormLoadedState));
            },
          );
        },
      ),
    );
  }
}
