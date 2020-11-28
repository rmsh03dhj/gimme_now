import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInPressed extends SignInEvent {
  final String email;
  final String password;

  SignInPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
