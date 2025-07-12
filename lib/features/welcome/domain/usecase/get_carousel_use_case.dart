import 'package:buro_app/features/welcome/domain/model/carousel_model.dart';
import 'package:buro_app/features/welcome/domain/repository/carousel_repository.dart';

class GetCarouselUseCase {
  final CarouselRepository repository;

  GetCarouselUseCase(this.repository);

  Future<List<CarouselModel>> call() async {
    return await repository.getCarousel();
  }
}