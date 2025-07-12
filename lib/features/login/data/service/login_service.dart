import 'dart:convert';
//import 'package:buro_app/features/login/domain/model/login_model.dart';
import 'package:buro_app/features/login/domain/model/user_model.dart';
import 'package:http/http.dart' as http;

/*class LoginService {
  Future<LoginModel> login(String userName, String password) async {
    if ((userName == 'germanrepetto@buro.com' && password == 'German12345678')
        || (userName == 'dario' && password == 'dario')
    ) {
      final url = Uri.parse('https://reqres.in/api/users/2');
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'reqres-free-v1',
        },
      );
      print('Status code login: ${response.statusCode}');
      print('Response body login: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return LoginModel.fromJson(data);
      } else {
        throw Exception('Hubo un error al hacer login');
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception('Correo electrónico o contraseña incorrectos');
    }
  }
}*/

class LoginService {
  Future<UserModel> login(String userName, String password) async {
    if ((userName == 'germanrepetto@buro.com' && password == 'German12345678')
        || (userName == 'dario' && password == 'dario')
    ) {
      final url = Uri.parse('https://reqres.in/api/users/2');
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'reqres-free-v1',
        },
      );
      print('Status code login: ${response.statusCode}');
      print('Response body login: ${response.body}');
      if (response.statusCode == 200) {
        String jsonString = userName == 'germanrepetto@buro.com'
            ? '''
          {"name":"Germán","lastName":"Repetto","email":"germanrepetto@buro.com"}
        '''
            : '''
          {"name":"Darío","lastName":"Sosa","email":"sdario05@gmail.com"}
        ''';
        final data = json.decode(jsonString);
        return UserModel.fromJson(data);
      } else {
        throw Exception('Hubo un error al hacer login');
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception('Correo electrónico o contraseña incorrectos');
    }
  }
}