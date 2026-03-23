import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_provider.dart';
import '../../core/network/interceptors/auth_interceptor.dart';
import '../../core/network/interceptors/retry_interceptor.dart';
import '../../core/network/network_info.dart';

Future<void> initCoreModule(GetIt sl) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<InternetConnectionChecker>(
    InternetConnectionChecker.createInstance,
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: sl()),
  );

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiProvider().baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<RetryInterceptor>(
    () => RetryInterceptor(dio: sl()),
  );

  final dio = sl<Dio>();
  dio.interceptors.add(sl<AuthInterceptor>());
  dio.interceptors.add(sl<RetryInterceptor>());

  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<DioClient>(
    () => DioClient(
      sl<ApiProvider>().baseUrl,
      dio,
      sharedPreferences: sl(),
    ),
  );
}
