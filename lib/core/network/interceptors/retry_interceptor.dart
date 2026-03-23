import 'dart:io';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final Duration retryDelay;

  RetryInterceptor({
    required this.dio,
    this.retries = 2,
    this.retryDelay = const Duration(milliseconds: 500),
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra['retry_attempt'] as int?) ?? 0;

    final canRetry =
        attempt < retries &&
        _isRetryable(err) &&
        _isIdempotent(options.method);

    if (!canRetry) {
      handler.next(err);
      return;
    }

    options.extra['retry_attempt'] = attempt + 1;
    await Future<void>.delayed(retryDelay);

    try {
      final response = await dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _isIdempotent(String method) {
    final upper = method.toUpperCase();
    return upper == 'GET' || upper == 'HEAD' || upper == 'OPTIONS';
  }

  bool _isRetryable(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    final status = err.response?.statusCode;
    if (status != null && status >= 500) {
      return true;
    }

    return err.error is SocketException;
  }
}
