import 'package:dio/dio.dart';
import 'package:neww/features/auth/data/model/login/login_response_model.dart';

import '../../../../core/network/dio_client.dart';
import '../../domain/entities/login/login_response.dart';
import '../model/profile/profile_model.dart';
import '../model/verify/verify_response_model.dart';



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

  }
