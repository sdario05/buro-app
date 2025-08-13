import 'package:buro_app/shared/action/getImage/domain/repository/image_repository.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';

class GetImageUseCase {
  final ImageRepository repository;

  GetImageUseCase(this.repository);

  Future<String> call(ImageType type) async {
    return await repository.getImage(type);
  }
}