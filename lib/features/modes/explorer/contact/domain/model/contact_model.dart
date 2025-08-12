class ContactModel {
  final String? email;
  final String? phone;
  final List<String>? additional;

  ContactModel({
    this.email,
    this.phone,
    this.additional,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'additional': additional
    };
  }
}