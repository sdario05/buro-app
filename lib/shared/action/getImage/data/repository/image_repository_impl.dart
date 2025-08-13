import 'package:buro_app/shared/action/getImage/data/service/image_service.dart';
import 'package:buro_app/shared/action/getImage/domain/repository/image_repository.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageService service;

  ImageRepositoryImpl(this.service);

  @override
  Future<String> getImage(ImageType type) async {
    return await service.getImage(type);
  }
}