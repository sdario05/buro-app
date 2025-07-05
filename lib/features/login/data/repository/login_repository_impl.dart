import 'package:buro_app/features/login/domain/model/login_model.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';

import '../service/login_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService service;

  LoginRepositoryImpl(this.service);

  @override
  Future<LoginModel> login(String userName, String password) async {
    return await service.login(userName, password);
  }
}