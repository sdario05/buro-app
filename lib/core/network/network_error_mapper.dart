import 'package:dio/dio.dart';

String mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Tiempo de conexión agotado';
    case DioExceptionType.sendTimeout:
      return 'Tiempo de envío agotado';
    case DioExceptionType.receiveTimeout:
      return 'Tiempo de espera en la respuesta agotado';
    case DioExceptionType.badCertificate:
      return 'Certificado inválido';
    case DioExceptionType.badResponse:
      return 'Error del servidor: ${e.response?.statusCode}';
    case DioExceptionType.cancel:
      return 'La solicitud fue cancelada';
    case DioExceptionType.connectionError:
      return 'Error de conexión';
    case DioExceptionType.unknown:
      return 'Error desconocido';
  }
}