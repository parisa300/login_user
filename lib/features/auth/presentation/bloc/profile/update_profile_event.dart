
import 'package:neww/features/auth/presentation/bloc/profile/profile_event.dart';

import '../../../domain/entities/profile/profile_entity.dart';

class UpdateProfileEvent extends ProfileEvent {
  final ProfileEntity profile;

  const UpdateProfileEvent(this.profile);

  @override
  List<Object?> get props => [profile];
}
