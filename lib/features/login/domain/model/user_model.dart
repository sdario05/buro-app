import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String lastName;
  final String email;

  UserModel({
    required this.name,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
    _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}