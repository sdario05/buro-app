import 'package:buro_app/features/welcome/domain/model/carousel_model.dart';

abstract class CarouselRepository {
  Future<List<CarouselModel>> getCarousel();
}