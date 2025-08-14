import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String userName;
  final String password;

  UserDto({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}