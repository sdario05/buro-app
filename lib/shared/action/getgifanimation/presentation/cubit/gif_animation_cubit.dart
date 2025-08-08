import 'package:buro_app/shared/action/getgifanimation/domain/usecase/get_gif_animation_use_case.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GifAnimationCubit extends Cubit<GifAnimationStates> {
  final GetGifAnimationUseCase _useCase;

  GifAnimationCubit(this._useCase) : super(Initial());

  void getAnimation(GifType type) async {
    emit(Loading());
    try {
      final response = await _useCase.call(type);
      emit(Success(response));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

enum GifType {
  explorerExplanation,
  explorerWelcome,
}