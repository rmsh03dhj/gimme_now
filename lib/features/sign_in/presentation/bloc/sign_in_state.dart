import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final String successMessage;

  SignInSuccessState({this.successMessage});
}

class SignInErrorState extends SignInState {
  final String errorMessage;

  SignInErrorState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ConfirmSignInStepState extends SignInState {
  final String email;
  final String password;

  ConfirmSignInStepState(this.email, this.password);
}
