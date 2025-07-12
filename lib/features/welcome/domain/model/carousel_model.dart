class CarouselModel {
  final String imageUrl;
  final String title;
  final String description;
  final String mode;

  CarouselModel({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.mode,
  });

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      mode: json['mode'],
    );
  }

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'title': title,
    'description': description,
    'mode': mode,
  };
}