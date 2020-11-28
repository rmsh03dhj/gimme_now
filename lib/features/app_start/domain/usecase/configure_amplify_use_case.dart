import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:dartz/dartz.dart';
import 'package:gimmenow/amplifyconfiguration.dart';
import 'package:gimmenow/core/error/failure.dart';
import 'package:gimmenow/features/sign_up/domain/usecase/base_use_case.dart';

abstract class ConfigureAmplifyUseCase implements BaseUseCase<bool, NoParams> {}

class ConfigureAmplifyUseCaseImpl implements ConfigureAmplifyUseCase {
  @override
  Future<Either<Failure, bool>> execute(NoParams noParams) async {
    try {
      Amplify amplifyInstance = Amplify();

      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      amplifyInstance.addPlugin(authPlugins: [authPlugin]);
      await amplifyInstance.configure(amplifyconfig);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class NoParams {
  NoParams();
}
