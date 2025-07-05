import 'package:buro_app/features/login/domain/model/login_model.dart';

abstract class LoginRepository {
  Future<LoginModel> login(String userName, String password);
}