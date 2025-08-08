import 'package:buro_app/shared/action/getgifanimation/domain/repository/gif_animation_repository.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';

class GetGifAnimationUseCase {
  final GifAnimationRepository repository;

  GetGifAnimationUseCase(this.repository);

  Future<String> call(GifType type) async {
    return await repository.getAnimation(type);
  }
}