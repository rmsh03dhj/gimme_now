import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimmenow/app_config.dart';
import 'package:gimmenow/core/config/gimme_now_routes.dart';
import 'package:gimmenow/core/service_locator.dart' as di;
import 'package:gimmenow/core/service_locator.dart';
import 'package:gimmenow/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gimmenow/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:gimmenow/splash_screen.dart';

import 'core/navigation_service.dart';
import 'core/simple_bloc_delegate.dart';
import 'features/app_start/presentation/bloc/app_start_bloc.dart';
import 'features/app_start/presentation/bloc/app_start_event.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'features/sign_up/presentation/pages/confirmation_code_entry_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  Bloc.observer = SimpleBlocDelegate();

  runApp(
    AppConfig(child: RunApp()),
  );
}

class RunApp extends StatefulWidget {
  RunApp({Key key}) : super(key: key);

  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStartBloc>(
      create: (context) => sl<AppStartBloc>()..add(InitializeAmplify()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (context) => sl<SignUpBloc>(),
          ),
          BlocProvider<SignInBloc>(
            create: (context) => sl<SignInBloc>(),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => sl<DashboardBloc>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: sl<NavigationService>().navigationKey,
          debugShowCheckedModeBanner: false,
          routes: _registerRoutes(),
          onGenerateRoute: _registerRoutesWithParameters,
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    GimmeNowRoutes.signUp: (context) => _buildSignUpBloc(),
    GimmeNowRoutes.home: (context) => SplashScreen(),
    GimmeNowRoutes.dashboard: (context) => DashBoardPageWrapper(),
  };
}

BlocProvider<SignUpBloc> _buildSignUpBloc() {
  return BlocProvider<SignUpBloc>(
    create: (context) => sl<SignUpBloc>(),
    child: SignUpPageWrapper(),
  );
}

Route _registerRoutesWithParameters(RouteSettings settings) {
  if (settings.name == GimmeNowRoutes.code) {
    final email = settings.arguments;
    return MaterialPageRoute(
      settings: RouteSettings(
        name: GimmeNowRoutes.code,
      ),
      builder: (context) {
        return ConfirmCodeEntryPage(email);
      },
    );
  } else {
    return MaterialPageRoute(
      builder: (context) {
        return SignUpPageWrapper();
      },
    );
  }
}
