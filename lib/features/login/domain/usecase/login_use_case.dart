import 'package:buro_app/features/login/data/dto/user_dto.dart';
import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<UserModel, String>> call(UserDto body) async {
    return await repository.login(body);
  }
}