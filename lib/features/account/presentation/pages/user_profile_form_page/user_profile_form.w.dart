part of 'user_profile_form_page.dart';

class _$UserProfileForm extends StatefulWidget {
  final Account account;
  final PageFormType pageFormType;

  const _$UserProfileForm({
    Key key,
    @required this.account,
    @required this.pageFormType,
  }) : super(key: key);

  bool get readOnly => pageFormType == PageFormType.read;

  @override
  __$UserProfileFormState createState() => __$UserProfileFormState();
}

class __$UserProfileFormState extends State<_$UserProfileForm> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String _imageUrl;

  void onSubmit(BuildContext context) async {
    if (widget.readOnly) {
      final account = await Navigator.of(context).push<Account>(
        CustomPageRoute.slide(
          page: UserProfileFormPage(pageFormType: PageFormType.update),
          pageType: PageType.userProfile,
        ),
      );

      if (account != null) {
        Scaffold.of(context).showSnackBar(CustomSnackBar(
          message: 'Data updated',
          mode: SnackBarMode.success,
        ));
      }
    } else {
      BlocProvider.of<UserProfileFormBloc>(context).add(UpdateUserProfileEvent(
        account: widget.account,
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
      ));
    }
  }

  @override
  void initState() {
    emailController.text = widget.account?.email;
    nameController.text = widget.account?.name;
    phoneNumberController.text = widget.account?.phoneNumber;
    _imageUrl = widget.account?.photoUrl;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
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
    double width = MediaQuery.of(context).size.width / 4;
    return Container(
      padding: const EdgeInsets.all(32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width / 2),
        child: Container(
          width: width,
          height: width,
          child: Icon(Icons.person, size: width / 2),
        ),
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
            controller: emailController,
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
          if (state is UserProfileFormErrorState &&
              state.error == UserProfileFormErrorGroup.name) {
            errorText = state.message;
          }
          return CustomTextField(
            context: context,
            controller: nameController,
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
          if (state is UserProfileFormErrorState &&
              state.error == UserProfileFormErrorGroup.phoneNumber) {
            errorText = state.message;
          }
          return CustomTextField(
            context: context,
            controller: phoneNumberController,
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
            onPressed: () => onSubmit(context),
          );
        },
      ),
    );
  }
}
