import 'package:auth/core/errors/error_model.dart';
import 'package:dio/dio.dart';

// ignore: camel_case_types
class serverExceptions implements Exception {
  final ErrorModel errorModel;

  serverExceptions({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw serverExceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw serverExceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw serverExceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw serverExceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw serverExceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw serverExceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw serverExceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400: // Bad request
          throw serverExceptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 401: //unauthorized
          throw serverExceptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 403: //forbidden
          throw serverExceptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 404: //not found
          throw serverExceptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 409: //coefficient
          throw serverExceptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 422: //  Unprocessable Entity
          throw serverExceptions(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 504:
          throw serverExceptions(
              errorModel:
                  ErrorModel.fromJson(e.response!.data)); // Server exception
      }
  }
}
