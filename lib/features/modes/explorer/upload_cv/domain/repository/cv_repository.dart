import 'dart:io';

abstract class CvRepository {
  Future<void> sendCv(File file);
}