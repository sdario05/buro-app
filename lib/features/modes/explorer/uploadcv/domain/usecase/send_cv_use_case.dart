import 'dart:io';

import 'package:buro_app/features/modes/explorer/uploadcv/domain/repository/cv_repository.dart';

class SendCvUseCase {
  final CvRepository repository;

  SendCvUseCase(this.repository);

  Future<void> call(File file) async {
    return await repository.sendCv(file);
  }
}