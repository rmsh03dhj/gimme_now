import 'package:bloc/bloc.dart';
import 'package:gimmenow/core/service_locator.dart';
import 'package:gimmenow/features/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/confirm_confirmation_code_use_case.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/sign_up_use_case.dart';
import 'package:gimmenow/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:gimmenow/features/sign_up/presentation/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final signUpUseCase = sl<SignUpUseCase>();
  final confirmCodeUseCase = sl<ConfirmCodeUseCase>();
  SignUpBloc() : super(SignUpInitialState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpPressed) {
      yield* _mapSignUpToState(event);
    }
    if (event is ConfirmCodeEntered) {
      yield SignUpProcessingState();
      final failureOrBool =
          await confirmCodeUseCase.execute(ConfirmCodeParams(email: event.email, code: event.code));
      yield failureOrBool.fold((failure) => SignUpFailedState(failure.failureMessage), (bool) {
        return SignUpSuccessState();
      });
    }
  }

  Stream<SignUpState> _mapSignUpToState(SignUpPressed event) async* {
    yield SignUpProcessingState();
    final failureOrValue =
        await signUpUseCase.execute(SignUpParams(password: event.password, email: event.email));
    yield failureOrValue.fold((failure) => SignUpFailedState(failure.failureMessage), (value) {
      if (value == 'CONFIRM_SIGN_UP_STEP') {
        return ConfirmSignUpStepState(event.email, event.password);
      } else {
        return ConfirmSignUpStepState(event.email, event.password);
      }
    });
  }
}
