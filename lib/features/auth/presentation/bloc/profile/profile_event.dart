
import 'package:equatable/equatable.dart';
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfileEvent extends ProfileEvent {

  const GetProfileEvent();

  @override
  List<Object> get props => [];
}