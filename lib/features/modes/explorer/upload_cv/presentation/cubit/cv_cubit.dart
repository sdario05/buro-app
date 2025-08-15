import 'dart:io';

import 'package:buro_app/features/modes/explorer/upload_cv/domain/usecase/send_cv_use_case.dart';
import 'package:buro_app/features/modes/explorer/upload_cv/presentation/cubit/cv_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CvCubit extends Cubit<CvStates> {
  final SendCvUseCase _useCase;

  CvCubit(this._useCase) : super(Initial());

  Future<void> sendCv(File file) async {
    emit(Loading());
    try {
      await _useCase.call(file);
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}