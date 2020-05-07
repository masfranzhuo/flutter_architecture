part of 'login_page.dart';

class _$LoginFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text('Register Here'),
            onPressed: () {
              Navigator.of(context).pushReplacement(CustomPageRoute.slide(
                page: RegisterPage(),
                pageType: AppPageType.register,
              ));
            },
          ),
          FlatButton(
            child: Text('Forget Password'),
            onPressed: () {
              Navigator.of(context).pushReplacement(CustomPageRoute.slide(
                page: ForgetPasswordPage(),
                pageType: AppPageType.forgetPassword,
              ));
            },
          ),
        ],
      ),
    );
  }
}
