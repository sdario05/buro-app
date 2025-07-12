import 'package:buro_app/features/login/data/service/login_service.dart';
import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';
import 'package:buro_app/preferences/app_preferences.dart';


class LoginRepositoryImpl implements LoginRepository {
  final LoginService service;

  LoginRepositoryImpl(this.service);

  @override
  Future<UserModel> login(String userName, String password) async {
    final UserModel response = await service.login(userName, password);
    final prefs = AppPreferences.instance;
    await prefs.saveUser(response);
    return response;
  }
}