import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:dartz/dartz.dart';
import 'package:gimmenow/amplifyconfiguration.dart';
import 'package:gimmenow/core/error/failure.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/base_use_case.dart';

import 'configure_amplify_use_case.dart';

abstract class LogOutUserUseCase implements BaseUseCase<bool, NoParams> {}

class LogOutUserUseCaseImpl implements LogOutUserUseCase {
  @override
  Future<Either<Failure, bool>> execute(NoParams noParams) async {
    try {
      await Amplify.Auth.signOut();
      return Right(true);
    } on AuthError catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
