import 'package:buro_app/core/network/network_error_mapper.dart';
import 'package:buro_app/features/login/data/dto/user_dto.dart';
import 'package:buro_app/features/login/data/service/login_service.dart';
import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:buro_app/features/login/domain/repository/login_repository.dart';
import 'package:buro_app/preferences/app_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService service;

  LoginRepositoryImpl(this.service);

  @override
  Future<Either<UserModel, String>> login(UserDto body) async {
    try {
      final response = await service.login(body, 'reqres-free-v1');
      final prefs = AppPreferences.instance;
      await prefs.saveUser(response);
      return Left(response);
    } on DioException catch (dioError) {
      return Right(mapDioError(dioError));
    } catch (e) {
      return Right('Ocurrió un error inesperado: $e');
    }
  }
}