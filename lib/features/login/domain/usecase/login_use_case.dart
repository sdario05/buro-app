import 'package:buro_app/features/login/domain/model/login_model.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<LoginModel> call(String userName, String password) async {
    return await repository.login(userName, password);
  }
}