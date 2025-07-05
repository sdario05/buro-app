class LoginSupport {
  final String url;
  final String text;

  LoginSupport({
    required this.url,
    required this.text,
  });

  factory LoginSupport.fromJson(Map<String, dynamic> json) {
    return LoginSupport(
      url: json['url'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'text': text,
  };
}