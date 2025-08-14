import 'package:buro_app/features/login/data/dto/user_dto.dart';
import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<UserModel, String>> login(UserDto body);
}