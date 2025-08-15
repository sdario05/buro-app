import 'dart:io';

import 'package:buro_app/features/modes/explorer/upload_cv/data/service/cv_service.dart';
import 'package:buro_app/features/modes/explorer/upload_cv/domain/repository/cv_repository.dart';

class CvRepositoryImpl implements CvRepository {
  final CvService service;

  CvRepositoryImpl(this.service);

  @override
  Future<void> sendCv(File file) async {
    return await service.sendCv(file);
  }
}