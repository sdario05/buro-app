import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';

abstract class GifAnimationRepository {
  Future<String> getAnimation(GifType type);
}