import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gimmenow/core/config/gimme_now_routes.dart';
import 'package:gimmenow/features/app_start/presentation/bloc/app_start_event.dart';

import 'amplifyconfiguration.dart';
import 'core/navigation_service.dart';
import 'core/service_locator.dart';
import 'features/app_start/presentation/bloc/app_start_bloc.dart';
import 'features/app_start/presentation/bloc/app_start_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _navigator = sl<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStartBloc, AppStartState>(
      listener: (context, state) {
        if (state is AmplifyConfigured) {
          BlocProvider.of<AppStartBloc>(context).add(CheckForAuthentication());
        }
        if (state is Uninitialized || state is Unauthenticated) {
          Timer(
            Duration(seconds: 2),
            () => _navigator.navigateToAndReplace(GimmeNowRoutes.signUp),
          );
        }
        if (state is AmplifyConfiguringFailed) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("failed to initialize")));
        }
        if (state is Authenticated) {
          _navigator.navigateTo(GimmeNowRoutes.dashboard);
        }
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Text("Gimme Now")
                  ],
                ),
              ),
              Positioned.fill(
                child: Text("Hahah"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
