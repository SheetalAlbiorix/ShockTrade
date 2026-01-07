import 'package:dio/dio.dart';

/// Creates and configures a Dio client for HTTP requests
Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl:
          'https://api.example.com', // Replace with your actual API base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptors for logging, authentication, etc.
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
    ),
  );

  // Add authentication interceptor if needed
  // dio.interceptors.add(AuthInterceptor());

  return dio;
}
