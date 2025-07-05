import 'package:buro_app/features/login/domain/model/login_model.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final LoginModel model;
  LoginSuccess(this.model);
}

class LoginError extends LoginStates {
  final String message;
  LoginError(this.message);
}