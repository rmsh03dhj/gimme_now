import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimmenow/core/service_locator.dart';
import 'package:gimmenow/features/app_start/domain/usecase/check_for_authentication_use_case.dart';
import 'package:gimmenow/features/app_start/domain/usecase/configure_amplify_use_case.dart';
import 'package:gimmenow/features/app_start/domain/usecase/logout_user_use_case.dart';

import 'app_start_event.dart';
import 'app_start_state.dart';

class AppStartBloc extends Bloc<AppStartEvent, AppStartState> {
  final configureAmplifyUseCase = sl<ConfigureAmplifyUseCase>();
  final checkForAuthenticationUseCase = sl<CheckForAuthenticationUseCase>();
  final logOutUserUseCase = sl<LogOutUserUseCase>();
  AppStartBloc() : super(Uninitialized());

  @override
  Stream<AppStartState> mapEventToState(
    AppStartEvent event,
  ) async* {
    if (event is InitializeAmplify) {
      final failureOrBool = await configureAmplifyUseCase.execute(NoParams());
      yield failureOrBool.fold((failure) => AmplifyConfiguringFailed(failure.failureMessage),
          (bool) => AmplifyConfigured());
    }
    if (event is CheckForAuthentication) {
      final failureOrUser = await checkForAuthenticationUseCase.execute(NoParams());
      yield failureOrUser.fold((failure) => Unauthenticated(), (user) {
        if (user != null) {
          return Authenticated();
        } else {
          return Unauthenticated();
        }
      });
    }
    if (event is LoggedOut) {
      final failureOrBool = await logOutUserUseCase.execute(NoParams());
      yield failureOrBool.fold((failure) => Unauthenticated(), (bool) {
        return Unauthenticated();
      });
    }
  }
}
