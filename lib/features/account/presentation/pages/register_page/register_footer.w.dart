part of 'register_page.dart';

class _$RegisterFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FlatButton(
          child: Text('Login Here'),
          onPressed: () {
            Navigator.of(context).pushReplacement(CustomPageRoute.slide(
              page: LoginPage(),
              pageType: PageType.login,
            ));
          },
        ),
      ),
    );
  }
}
