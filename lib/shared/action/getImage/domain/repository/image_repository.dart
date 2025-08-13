import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';

abstract class ImageRepository {
  Future<String> getImage(ImageType type);
}