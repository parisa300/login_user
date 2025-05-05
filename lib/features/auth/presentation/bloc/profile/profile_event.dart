
import 'package:equatable/equatable.dart';
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfileEvent extends ProfileEvent {
  final String accessToken;

  const GetProfileEvent(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}