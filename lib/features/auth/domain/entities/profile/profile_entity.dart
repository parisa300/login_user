


import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? phone;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? postalCode;
  final String? fixedNumber;
  final String? gender;
  final String? nationalCode;
  final String? cardNumber;
  final String? profileImage;
  final String? birthDate;
  final String? shebaNumber;

  const ProfileEntity({
    required this.phone,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.postalCode,
    required this.fixedNumber,
    required this.gender,
    required this.nationalCode,
    required this.cardNumber,
    required this.profileImage,
    required this.birthDate,
    required this.shebaNumber,
  });

  @override
  List<Object?> get props => [phone, email, firstName, lastName];
}
