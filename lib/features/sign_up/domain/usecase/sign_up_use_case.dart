import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:dartz/dartz.dart';
import 'package:gimmenow/core/error/failure.dart';

import 'base_use_case.dart';

abstract class SignUpUseCase implements BaseUseCase<String, SignUpParams> {}

class SignUpUseCaseImpl implements SignUpUseCase {
  @override
  Future<Either<Failure, String>> execute(SignUpParams signUpParams) async {
    try {
      Map<String, dynamic> userAttributes = {
        'email': signUpParams.email,
      };

      final res = await Amplify.Auth.signUp(
          username: signUpParams.email,
          password: signUpParams.password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      print(res.nextStep);
      print(res.isSignUpComplete);
      return Right(res.nextStep.signUpStep);
    } on AuthError catch (e) {
      print(e.cause);
      return Left(GeneralFailure(failureMessage: e.toString()));
    } catch (e) {
      print(e);
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({this.email, this.password});
}
