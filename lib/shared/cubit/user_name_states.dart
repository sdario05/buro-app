abstract class UserNameStates {}

class UserNameInitial extends UserNameStates {}

class UserNameSuccess extends UserNameStates {
  final String name;
  UserNameSuccess(this.name);
}