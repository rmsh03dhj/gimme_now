import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpProcessingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  SignUpSuccessState();
}

class SignUpFailedState extends SignUpState {
  final String errorMessage;
  SignUpFailedState(this.errorMessage);
}

class ConfirmSignUpStepState extends SignUpState {
  final String email;
  final String password;

  ConfirmSignUpStepState(this.email, this.password);
}
