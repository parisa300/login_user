import 'package:dio/dio.dart';
import 'package:neww/features/auth/data/model/login/login_response_model.dart';

import '../../../../core/network/dio_client.dart';
import '../../domain/entities/login/login_response.dart';
import '../model/profile/profile_model.dart';
import '../model/verify/verify_response_model.dart';

// abstract class AuthRemoteDataSource {
//   Future<VerifyResponseModel> verifyPhone({
//     required String phone,
//     required String code,
//     required String deviceId,
//   });
// }
// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final Dio dio;
//
//   AuthRemoteDataSourceImpl(this.dio);
//
//   @override
//   Future<VerifyResponseModel> verifyPhone({
//     required String phone,
//     required String code,
//     required String deviceId,
//   }) async {
//     final response = await dio.post(
//       'https://dev.api.wikiq.app/api/v1/accounts/verify/',
//       data: {
//         'phone': phone,
//         'code': code,
//         'device_id': deviceId,
//       },
//     );
//
//     return VerifyResponseModel.fromJson(response.data['data']);
//   }
//
//   // Method to login and retrieve the OTP
//   Future<LoginModel> login(String phone) async {
//     final response = await dio.post(
//       'https://dev.api.wikiq.app/api/v1/accounts/login/',
//       data: {'phone': phone}, // Sending the phone number as the request body
//     );
//
//     // Parse OTP from response
//     if (response.statusCode == 200) {
//       return response.data['data']['otp'];
//     } else {
//       throw Exception('Failed to load OTP');
//     }
//   }
// }


class AuthRemoteDataSource {
  final Dio _dio = DioClient().dio;

  Future<LoginResponseModel> login(String phone) async {
    final response = await _dio.post('accounts/login/', data: {
      'phone': phone,
    });

    return LoginResponseModel.fromJson(response.data);
  }

    Future<VerifyResponseModel> verify({
      required String phone,
      required String code,
      required String deviceId,
    }) async {
      final response = await _dio.post('accounts/verify/', data: {
        'phone': phone,
        'code': code,
        'device_id': deviceId,
      });

      return VerifyResponseModel.fromJson(response.data);
    }

  Future<ProfileModel> profile({
    required String phone,

  }) async {
    final response = await _dio.post('accounts/profile/', data: {
      'phone': phone,
    });
    return ProfileModel.fromJson(response.data);
  }
  }
