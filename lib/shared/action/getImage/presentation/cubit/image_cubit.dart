import 'package:buro_app/shared/action/getImage/domain/usecase/get_image_use_case.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCubit extends Cubit<ImageStates> {
  final GetImageUseCase _useCase;

  ImageCubit(this._useCase) : super(Initial());

  void getImage(ImageType type) async {
    emit(Loading());
    try {
      final response = await _useCase.call(type);
      emit(Success(response));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

enum ImageType {
  explorerExplanation,
  explorerWelcome,
  explorerCvSuccess,
  explorerProfessionSuccess,
  explorerCompleted,
  explorerReminder,
}