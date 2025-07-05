import 'package:buro_app/features/login/domain/model/login_data.dart';
import 'package:buro_app/features/login/domain/model/login_support.dart';

class LoginModel {
  final LoginData data;
  final LoginSupport support;

  LoginModel({
    required this.data,
    required this.support,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      data: LoginData.fromJson(json['data']),
      support: LoginSupport.fromJson(json['support']),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.toJson(),
    'support': support.toJson(),
  };
}