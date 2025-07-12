import 'package:buro_app/features/login/domain/model/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> login(String userName, String password);
}