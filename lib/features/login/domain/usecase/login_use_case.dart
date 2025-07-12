import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel> call(String userName, String password) async {
    return await repository.login(userName, password);
  }
}