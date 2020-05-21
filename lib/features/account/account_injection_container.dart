import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart';
import 'package:flutter_architecture/features/account/data/data_sources/account_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_messaging_data_source.dart';
import 'package:flutter_architecture/features/account/data/repositories/account_repository_impl.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/change_password.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/login_with_password.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/logout.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/register_with_password.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/reset_password.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/forget_password_bloc/forget_password_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_change_password.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_login.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_register.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_forget_password.dart';
import 'package:get_it/get_it.dart';

void init() {
  // Bloc
  GetIt.I.registerFactory(
    () => RegisterBloc(
      registerWithPassword: GetIt.I(),
      validateRegister: GetIt.I(),
    ),
  );
  GetIt.I.registerFactory(
    () => LoginBloc(
      loginWithPassword: GetIt.I(),
      validateLogin: GetIt.I(),
    ),
  );
  GetIt.I.registerFactory(
    () => ForgetPasswordBloc(
      resetPassword: GetIt.I(),
      validateForgetPassword: GetIt.I(),
    ),
  );
  GetIt.I.registerFactory(
    () => ChangePasswordBloc(
      changePassword: GetIt.I(),
      validateChangePassword: GetIt.I(),
    ),
  );

  // Use cases
  GetIt.I.registerLazySingleton(
    () => RegisterWithPassword(repository: GetIt.I()),
  );
  GetIt.I.registerLazySingleton(() => LoginWithPassword(repository: GetIt.I()));
  GetIt.I.registerLazySingleton(() => ResetPassword(repository: GetIt.I()));
  GetIt.I.registerLazySingleton(() => ChangePassword(repository: GetIt.I()));
  GetIt.I.registerLazySingleton(() => Logout(repository: GetIt.I()));

  // Form validators
  GetIt.I.registerLazySingleton(
    () => ValidateRegister(
      validateEmail: GetIt.I(),
      validatePassword: GetIt.I(),
    ),
  );
  GetIt.I.registerLazySingleton(
    () => ValidateLogin(
      validateEmail: GetIt.I(),
      validatePassword: GetIt.I(),
    ),
  );
  GetIt.I.registerFactory(
    () => ValidateForgetPassword(validateEmail: GetIt.I()),
  );
  GetIt.I.registerFactory(
    () => ValidateChangePassword(validatePassword: GetIt.I()),
  );

  // Input validators
  GetIt.I.registerLazySingleton(() => ValidateEmail());
  GetIt.I.registerLazySingleton(() => ValidatePassword());

  // Repositories
  GetIt.I.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      firebaseAuthDataSource: GetIt.I(),
      firebaseMessagingDataSource: GetIt.I(),
      accountDataSource: GetIt.I(),
    ),
  );

  // Data sources
  GetIt.I.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(firebaseAuthInstance: GetIt.I()),
  );
  GetIt.I.registerLazySingleton<FirebaseMessagingDataSource>(
    () => FirebaseMessagingDataSourceImpl(firebaseMessagingInstance: GetIt.I()),
  );
  GetIt.I.registerLazySingleton<AccountDataSource>(
    () => AccountDataSourceImpl(client: GetIt.I()),
  );

  // Core
  GetIt.I.registerLazySingleton(
    () => HttpClient(firebaseAuthDataSource: GetIt.I()),
  );

  // Firebase
  GetIt.I.registerLazySingleton(() => FirebaseAuth.instance);
  GetIt.I.registerLazySingleton(() => FirebaseMessaging());
}
