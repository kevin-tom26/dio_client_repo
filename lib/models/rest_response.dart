part of 'package:dio_client/dio_client.dart';

class RestResponse {
  dynamic message;
  dynamic apiSuccess;
  dynamic data;
  dynamic totalPages;
  dynamic statusCode;

  RestResponse({
    this.message,
    this.apiSuccess,
    this.data,
    this.totalPages,
    this.statusCode,
  });
}
