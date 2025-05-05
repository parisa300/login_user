

import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../model/profile/profile_model.dart';


 class ProfileRemoteDataSource {

  final Dio _dio = DioClient().dio;

  @override
  Future<ProfileModel> getProfile(String accessToken) async {
    final response = await _dio.get(
      'accounts/profile/',
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );

    return ProfileModel.fromJson(response.data);
  }
}
