import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/localization/locale/app_localization_delegate.dart';
import 'package:flutter_architecture/core/presentation/custom_theme.dart';
import 'package:flutter_architecture/core/presentation/pages/custom_page.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/pages/login_page/login_page.dart';
import 'package:flutter_architecture/features/storage/presentation/blocs/storage_bloc/storage_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_architecture/injection_container.u.dart'
    as injectionContainer;

void main() {
  injectionContainer.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => GetIt.I()),
        BlocProvider<RegisterBloc>(create: (_) => GetIt.I()),
      ],
      child: Builder(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AccountBloc>(
              create: (_) => AccountBloc(
                logout: GetIt.I(),
                loginBloc: BlocProvider.of<LoginBloc>(context),
                registerBloc: BlocProvider.of<RegisterBloc>(context),
                getUserProfile: GetIt.I(),
                validateUpdateUserProfile: GetIt.I(),
                updateUserProfile: GetIt.I(),
              ),
            ),
            BlocProvider<StorageBloc>(create: (_) => GetIt.I()),
          ],
          child: MaterialApp(
            title: 'Flutter Architecture',
            theme: CustomTheme.dark(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizationDelegate(),
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('id', 'ID'),
            ],
            home: LoginPage() ?? CustomPage() ?? LoginPage(),
          ),
        ),
      ),
    );
  }
}
