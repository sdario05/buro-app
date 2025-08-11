class UserModel {
  final String name;
  final String lastName;
  final String email;

  UserModel({
    required this.name,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'lastName': lastName,
    'email': email,
  };
}