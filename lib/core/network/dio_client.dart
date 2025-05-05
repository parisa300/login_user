import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://dev.api.wikiq.app/api/v1/',
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          final prefs = await SharedPreferences.getInstance();
          final refreshToken = prefs.getString('refresh_token');

          if (refreshToken != null) {
            // ریکوئست جدید برای گرفتن توکن جدید
            final phone = prefs.getString('phone')!;
            final code = prefs.getString('code')!;
            final deviceId = prefs.getString('device_id')!;

            final response = await dio.post('accounts/verify/', data: {
              'phone': phone,
              'code': code,
              'device_id': deviceId,
            });

            final newAccess = response.data['data']['access'];
            final newRefresh = response.data['data']['refresh'];

            // ذخیره توکن جدید
            await prefs.setString('access_token', newAccess);
            await prefs.setString('refresh_token', newRefresh);

            // تکرار درخواست اولیه با توکن جدید
            final retryRequest = e.requestOptions;
            retryRequest.headers['Authorization'] = 'Bearer $newAccess';

            final newResponse = await dio.fetch(retryRequest);
            return handler.resolve(newResponse);
          }
        }

        return handler.next(e);
      },
    ));
  }
}
