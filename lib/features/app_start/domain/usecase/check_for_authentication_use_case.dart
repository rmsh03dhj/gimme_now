import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:dartz/dartz.dart';
import 'package:gimmenow/amplifyconfiguration.dart';
import 'package:gimmenow/core/error/failure.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/base_use_case.dart';

import 'configure_amplify_use_case.dart';

abstract class CheckForAuthenticationUseCase implements BaseUseCase<AuthUser, NoParams> {}

class CheckForAuthenticationUseCaseImpl implements CheckForAuthenticationUseCase {
  @override
  Future<Either<Failure, AuthUser>> execute(NoParams noParams) async {
    try {
      final currentUser = await Amplify.Auth.getCurrentUser();
      return Right(currentUser);
    } on AuthError catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
