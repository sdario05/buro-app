import 'package:buro_app/features/welcome/data/service/carousel_service.dart';
import 'package:buro_app/features/welcome/domain/model/carousel_model.dart';
import 'package:buro_app/features/welcome/domain/repository/carousel_repository.dart';

class CarouselRepositoryImpl implements CarouselRepository {
  final CarouselService service;

  CarouselRepositoryImpl(this.service);

  @override
  Future<List<CarouselModel>> getCarousel() async {
    return await service.getCarousel();
  }
}