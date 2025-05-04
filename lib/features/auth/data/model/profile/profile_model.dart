
import '../../../domain/entities/profile/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.phone,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.address,
    required super.postalCode,
    required super.fixedNumber,
    required super.gender,
    required super.nationalCode,
    required super.cardNumber,
    required super.profileImage,
    required super.birthDate,
    required super.shebaNumber,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ProfileModel(
      phone: data['phone'],
      email: data['email'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      address: data['address'],
      postalCode: data['postal_code'],
      fixedNumber: data['fixed_number'],
      gender: data['gender'],
      nationalCode: data['national_code'],
      cardNumber: data['card_number'],
      profileImage: data['profile_image'],
      birthDate: data['birth_date'],
      shebaNumber: data['sheba_number'],
    );
  }
}
