import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/customer_home_page/customer_home_page.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_architecture/features/account/presentation/pages/staff_home_page/staff_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = PageType.splashScreen;

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(AutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountErrorState) {
          Navigator.of(context).pushReplacement(CustomPageRoute.slide(
            page: LoginPage(),
            pageType: PageType.login,
          ));
        }

        if (state is AccountLoadedState && state.isLogin) {
          if (state.isStaff) {
            Navigator.of(context).pushReplacement(CustomPageRoute.slide(
              page: StaffHomePage(),
              pageType: PageType.staffHome,
            ));
          } else {
            Navigator.of(context).pushReplacement(CustomPageRoute.slide(
              page: CustomerHomePage(),
              pageType: PageType.customerHome,
            ));
          }
        }
      },
      builder: (context, state) => CustomSafeArea(
        isLoading: state is AccountLoadingState,
        child: Scaffold(
          body: Container(),
        ),
      ),
    );
  }
}
