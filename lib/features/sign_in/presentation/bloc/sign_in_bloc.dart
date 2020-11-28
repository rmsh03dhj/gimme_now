import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:gimmenow/core/service_locator.dart';
import 'package:gimmenow/features/sign_in/domain/usecase/sign_in_use_case.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final signInUseCase = sl<SignInUseCase>();
  SignInBloc() : super(SignInInitialState());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInPressed) {
      yield SignInLoadingState();
      final failureOrValue =
          await signInUseCase.execute(SignInParams(password: event.password, email: event.email));
      yield failureOrValue.fold((failure) => SignInErrorState(errorMessage: failure.failureMessage),
          (isSignedIn) {
        if (isSignedIn) {
          return SignInSuccessState();
        } else {
          return SignInErrorState(errorMessage: "failed");
        }
      });
    }
  }
}
