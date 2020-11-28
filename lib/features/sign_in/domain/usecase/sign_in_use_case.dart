import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:dartz/dartz.dart';
import 'package:gimmenow/core/error/failure.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/base_use_case.dart';

abstract class SignInUseCase implements BaseUseCase<bool, SignInParams> {}

class SignInUseCaseImpl implements SignInUseCase {
  @override
  Future<Either<Failure, bool>> execute(SignInParams signInParams) async {
    try {
      final res =
          await Amplify.Auth.signIn(username: signInParams.email, password: signInParams.password);
      return Right(res.isSignedIn);
    } on AuthError catch (e) {
      print(e.cause);
      return Left(GeneralFailure(failureMessage: e.toString()));
    } catch (e) {
      print(e);
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({this.email, this.password});
}
