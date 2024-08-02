part of 'package:dio_client/dio_client.dart';

class DioClient with HandleMessageServices {
  final Dio _dio;
  // injecting dio instance
  final void Function(DioException exception) handleTokenExpiry;
  final BuildContext context;
  DioClient(this._dio, this.handleTokenExpiry, this.context);

  // Get:-----------------------------------------------------------------------
  Future<RestResponse> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? contentType,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool paginate = false,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleSuccessDisplay,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleErrorDisplay,
  }) async {
    RestResponse restResponse = RestResponse(
      apiSuccess: false,
      statusCode: 400,
    );

    try {
      _dio.options.contentType =
          contentType ?? 'application/json; charset=utf-8';
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.data is String) {
        return restResponse;
      }
      if (response.statusCode == 200) {
        if (context.mounted) {
          handleSuccess(
              responseOrignal: response,
              responseRestModal: restResponse,
              onHandleSuccessDisplay: onHandleSuccessDisplay,
              onHandleErrorDisplay: onHandleErrorDisplay,
              currentContext: context);
        } else {
          handleSuccess(
            responseOrignal: response,
            responseRestModal: restResponse,
            onHandleSuccessDisplay: onHandleSuccessDisplay,
            onHandleErrorDisplay: onHandleErrorDisplay,
          );
        }
      }
      if (paginate) {
        restResponse.totalPages =
            response.data['response']['pageable']['page_size'];
      }
    } on DioException catch (e) {
      handleTokenExpiry(e);
      if (context.mounted) {
        handleError(
            dioError: e,
            responseRestModal: restResponse,
            onHandleErrorDisplay: onHandleErrorDisplay,
            currentContext: context);
      } else {
        handleError(
          dioError: e,
          responseRestModal: restResponse,
          onHandleErrorDisplay: onHandleErrorDisplay,
        );
      }
    }
    return restResponse;
  }

  // Post:----------------------------------------------------------------------
  Future<RestResponse> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? contentType,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool paginate = false,
    header,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleSuccessDisplay,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleErrorDisplay,
  }) async {
    RestResponse restResponse = RestResponse(
      apiSuccess: false,
      statusCode: 400,
    );
    try {
      _dio.options.contentType =
          contentType ?? 'application/json; charset=utf-8';
      if (header != null) {
        _dio.options.headers.addAll(header);
      }
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200 && response.data is String) {
        restResponse = RestResponse(
          apiSuccess: true,
          statusCode: 200,
        );
        return restResponse;
      }

      if (response.data is String) {
        return restResponse;
      }
      if (response.statusCode == 200) {
        if (context.mounted) {
          handleSuccess(
              responseOrignal: response,
              responseRestModal: restResponse,
              onHandleSuccessDisplay: onHandleSuccessDisplay,
              onHandleErrorDisplay: onHandleErrorDisplay,
              currentContext: context);
        } else {
          handleSuccess(
            responseOrignal: response,
            responseRestModal: restResponse,
            onHandleSuccessDisplay: onHandleSuccessDisplay,
            onHandleErrorDisplay: onHandleErrorDisplay,
          );
        }
      }
      if (paginate) {
        restResponse.totalPages = response.data['response']['totalPages'];
      }
    } on DioException catch (e) {
      log("${e.error}");

      handleTokenExpiry(e);
      if (context.mounted) {
        handleError(
            dioError: e,
            responseRestModal: restResponse,
            onHandleErrorDisplay: onHandleErrorDisplay,
            currentContext: context);
      } else {
        handleError(
          dioError: e,
          responseRestModal: restResponse,
          onHandleErrorDisplay: onHandleErrorDisplay,
        );
      }
    }
    return restResponse;
  }

  //Put:------------------------------------------------------------------------
  Future<RestResponse> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    String? contentType,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    header,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleSuccessDisplay,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleErrorDisplay,
  }) async {
    RestResponse restResponse = RestResponse(apiSuccess: false);
    try {
      _dio.options.contentType =
          contentType ?? 'application/json; charset=utf-8';
      if (header != null) {
        _dio.options.headers.addAll(header);
      }
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.data is String) {
        return restResponse;
      }
      if (response.statusCode == 200) {
        if (context.mounted) {
          handleSuccess(
              responseOrignal: response,
              responseRestModal: restResponse,
              onHandleSuccessDisplay: onHandleSuccessDisplay,
              onHandleErrorDisplay: onHandleErrorDisplay,
              currentContext: context);
        } else {
          handleSuccess(
            responseOrignal: response,
            responseRestModal: restResponse,
            onHandleSuccessDisplay: onHandleSuccessDisplay,
            onHandleErrorDisplay: onHandleErrorDisplay,
          );
        }
      }
    } on DioException catch (e) {
      log("${e.error}");
      handleTokenExpiry(e);
      if (context.mounted) {
        handleError(
            dioError: e,
            responseRestModal: restResponse,
            onHandleErrorDisplay: onHandleErrorDisplay,
            currentContext: context);
      } else {
        handleError(
          dioError: e,
          responseRestModal: restResponse,
          onHandleErrorDisplay: onHandleErrorDisplay,
        );
      }
    }
    return restResponse;
  }

  //Delete:------------------------------------------------------------------------
  Future<RestResponse> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleSuccessDisplay,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleErrorDisplay,
  }) async {
    RestResponse restResponse = RestResponse(
      apiSuccess: false,
      statusCode: 400,
    );
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.data is String) {
        return restResponse;
      }
      if (response.statusCode == 200) {
        if (context.mounted) {
          handleSuccess(
              responseOrignal: response,
              responseRestModal: restResponse,
              onHandleSuccessDisplay: onHandleSuccessDisplay,
              onHandleErrorDisplay: onHandleErrorDisplay,
              currentContext: context);
        } else {
          handleSuccess(
            responseOrignal: response,
            responseRestModal: restResponse,
            onHandleSuccessDisplay: onHandleSuccessDisplay,
            onHandleErrorDisplay: onHandleErrorDisplay,
          );
        }
      }
    } on DioException catch (e) {
      log("${e.error}");
      handleTokenExpiry(e);
      if (context.mounted) {
        handleError(
            dioError: e,
            responseRestModal: restResponse,
            onHandleErrorDisplay: onHandleErrorDisplay,
            currentContext: context);
      } else {
        handleError(
          dioError: e,
          responseRestModal: restResponse,
          onHandleErrorDisplay: onHandleErrorDisplay,
        );
      }
    }
    return restResponse;
  }

  Future<RestResponse> download(
    String uri, {
    required String savePath,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleSuccessDisplay,
    void Function(
      int? httpStatusCode,
      RestResponse? responseBody,
    )? onHandleErrorDisplay,
  }) async {
    RestResponse restResponse = RestResponse(
      apiSuccess: false,
      statusCode: 400,
    );
    try {
      final Response response = await _dio.download(
        uri,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.data is String) {
        return restResponse;
      }
      if (response.data != null && response.statusCode == 200) {
        if (context.mounted) {
          handleSuccess(
              responseOrignal: response,
              responseRestModal: restResponse,
              onHandleSuccessDisplay: onHandleSuccessDisplay,
              onHandleErrorDisplay: onHandleErrorDisplay,
              currentContext: context);
        } else {
          handleSuccess(
            responseOrignal: response,
            responseRestModal: restResponse,
            onHandleSuccessDisplay: onHandleSuccessDisplay,
            onHandleErrorDisplay: onHandleErrorDisplay,
          );
        }
      }
    } on DioException catch (e) {
      log("${e.error}");
      handleTokenExpiry(e);
      if (context.mounted) {
        handleError(
            dioError: e,
            responseRestModal: restResponse,
            onHandleErrorDisplay: onHandleErrorDisplay,
            currentContext: context);
      } else {
        handleError(
          dioError: e,
          responseRestModal: restResponse,
          onHandleErrorDisplay: onHandleErrorDisplay,
        );
      }
    }
    return restResponse;
  }
}
