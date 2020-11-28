import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpPressed extends SignUpEvent {
  final String email;
  final String password;

  SignUpPressed(this.email, this.password);
}

class ConfirmCodeEntered extends SignUpEvent {
  final String code;
  final String email;

  ConfirmCodeEntered(this.code, this.email);
}
