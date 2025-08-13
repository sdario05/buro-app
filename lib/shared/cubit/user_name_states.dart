import 'package:buro_app/features/login/domain/model/user_model.dart';

abstract class UserNameStates {}

class UserNameInitial extends UserNameStates {}

class UserNameSuccess extends UserNameStates {
  final UserModel? user;
  UserNameSuccess(this.user);
}