import 'package:flutter/material.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_architecture/injection_container.u.dart'
    as injectionContainer;

void main() {
  injectionContainer.init();
  runApp(MyApp());
}

const PRIMARY_COLOR = Colors.blue;
const ACCENT_COLOR = Colors.brown;
const SUCCESS_COLOR = Colors.green;
const WARNING_COLOR = Colors.orange;
const ERROR_COLOR = Colors.red;
const DISABLED_COLOR = Colors.grey;
const DARK_BACKGROUND_COLOR = Colors.blueGrey;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(create: (_) => GetIt.I()),
      ],
      child: MaterialApp(
        title: 'Flutter Architecture',
        theme: ThemeData(
          brightness: Brightness.dark,
          // dividerColor: DISABLED_COLOR,
          // scaffoldBackgroundColor: DARK_BACKGROUND_COLOR,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: DISABLED_COLOR),
            filled: true,
            fillColor: Color.fromRGBO(0, 0, 0, 0.5),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WARNING_COLOR),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: WARNING_COLOR),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          // cardColor: DARK_BACKGROUND_COLOR,
          // textTheme: TextTheme(
          //   headline: TextStyle(fontSize: 36),
          //   subhead: TextStyle(fontSize: 18),
          //   title: TextStyle(fontSize: 24),
          //   body1: TextStyle(
          //     color: Colors.white,
          //     fontSize: 14,
          //   ),
          //   caption: TextStyle(
          //     color: DISABLED_COLOR,
          //     fontSize: 10,
          //   ),
          //   display1: TextStyle(
          //     fontSize: 12,
          //   ),
          // ),
          // errorColor: ERROR_COLOR,
          // disabledColor: DISABLED_COLOR,
          // highlightColor: Color(0xFF000000).withOpacity(0.75),
          // primaryColor: PRIMARY_COLOR,
          // accentColor: ACCENT_COLOR,
          // backgroundColor: DARK_BACKGROUND_COLOR,
          // primarySwatch: Colors.amber,
        ),
        home: LoginPage(),
      ),
    );
  }
}
