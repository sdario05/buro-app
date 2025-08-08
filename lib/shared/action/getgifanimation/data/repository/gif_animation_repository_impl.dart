import 'package:buro_app/shared/action/getgifanimation/data/service/gif_animation_service.dart';
import 'package:buro_app/shared/action/getgifanimation/domain/repository/gif_animation_repository.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';

class GifAnimationRepositoryImpl implements GifAnimationRepository {
  final GifAnimationService service;

  GifAnimationRepositoryImpl(this.service);

  @override
  Future<String> getAnimation(GifType type) async {
    return await service.getAnimation(type);
  }
}