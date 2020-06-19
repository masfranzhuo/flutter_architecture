import 'package:flutter_architecture/features/account/account_injection_container.dart'
    as accountDI;
import 'package:flutter_architecture/features/storage/storage_injection_container.dart'
    as storageDI;
import 'package:flutter_architecture/features/users_overview/users_overview_injection_container.dart'
    as usersOverviewDI;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/util/bloc_delegate.dart';

void init() {
  accountDI.init();
  storageDI.init();
  usersOverviewDI.init();

  // External
  BlocSupervisor.delegate = FlutterBlocDelegate();
  GetIt.I.registerLazySingleton(() => BlocSupervisor.delegate);
}
