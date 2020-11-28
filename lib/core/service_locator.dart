import 'package:get_it/get_it.dart';
import 'package:gimmenow/features/app_start/domain/usecase/check_for_authentication_use_case.dart';
import 'package:gimmenow/features/app_start/domain/usecase/configure_amplify_use_case.dart';
import 'package:gimmenow/features/app_start/domain/usecase/logout_user_use_case.dart';
import 'package:gimmenow/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:gimmenow/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gimmenow/features/sign_in/domain/usecase/sign_in_use_case.dart';
import 'package:gimmenow/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/confirm_confirmation_code_use_case.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/sign_up_use_case.dart';
import 'package:gimmenow/features/sign_up/presentation/bloc/sign_up_bloc.dart';

import 'navigation_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///bloc
  sl.registerFactory(() => SignUpBloc());
  sl.registerFactory(() => SignInBloc());
  sl.registerFactory(() => AppStartBloc());
  sl.registerFactory(() => DashboardBloc());

  ///sign up use case
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCaseImpl());
  sl.registerLazySingleton<ConfirmCodeUseCase>(() => ConfirmCodeUseCaseImpl());

  ///app start use case
  sl.registerLazySingleton<ConfigureAmplifyUseCase>(() => ConfigureAmplifyUseCaseImpl());
  sl.registerLazySingleton<CheckForAuthenticationUseCase>(
      () => CheckForAuthenticationUseCaseImpl());
  sl.registerLazySingleton<LogOutUserUseCase>(() => LogOutUserUseCaseImpl());

  ///sign in use case
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCaseImpl());

  ///other services
  sl.registerLazySingleton(() => NavigationService());
}
