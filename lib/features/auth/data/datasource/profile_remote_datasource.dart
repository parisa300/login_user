

import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/profile/profile_entity.dart';
import '../model/profile/profile_model.dart';


 class ProfileRemoteDataSource {

  final Dio _dio = DioClient().dio;

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _dio.get(
      'accounts/profile/',
    );

    return ProfileModel.fromJson(response.data);
  }
  Future<ProfileModel> updateProfile(ProfileEntity profile) async {
    final response = await _dio.put(
      'accounts/profile/',
      data: {
        'phone': profile.phone,
        'email': profile.email,
        'first_name': profile.firstName,
        'last_name': profile.lastName,
        'address': profile.address,
        'postal_code': profile.postalCode,
        'fixed_number': profile.fixedNumber,
        'gender': profile.gender,
        'national_code': profile.nationalCode,
        'card_number': profile.cardNumber,
        'profile_image': profile.profileImage,
        'birth_date': profile.birthDate,
        'sheba_number': profile.shebaNumber,
      },
    );
    return ProfileModel.fromJson(response.data);
  }
}
