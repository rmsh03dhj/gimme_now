import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:dartz/dartz.dart';
import 'package:gimmenow/core/error/failure.dart';

import 'base_use_case.dart';

abstract class ConfirmCodeUseCase implements BaseUseCase<bool, ConfirmCodeParams> {}

class ConfirmCodeUseCaseImpl implements ConfirmCodeUseCase {
  @override
  Future<Either<Failure, bool>> execute(ConfirmCodeParams confirmCodeParams) async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
          username: confirmCodeParams.email, confirmationCode: confirmCodeParams.code);
      print(res.nextStep);
      print(res.isSignUpComplete);
      if (res.isSignUpComplete) {
        return Right(true);
      } else {
        return Left(GeneralFailure(failureMessage: "failed"));
      }
    } on AuthError catch (e) {
      print(e.cause);
      return Left(GeneralFailure(failureMessage: e.toString()));
    } catch (e) {
      print(e);
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class ConfirmCodeParams {
  final String email;
  final String code;

  ConfirmCodeParams({this.email, this.code});
}
