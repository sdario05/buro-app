import 'package:buro_app/features/login/data/dto/user_dto.dart';
import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'login_service.g.dart';

@RestApi(baseUrl: "https://reqres.in/api/")
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST("users/2")
  Future<UserModel> login(
    @Body() UserDto body,
    @Header("x-api-key") String apiKey,
  );
}