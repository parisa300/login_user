
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neww/features/auth/presentation/bloc/profile/profile_event.dart';
import 'package:neww/features/auth/presentation/bloc/profile/profile_state.dart';
import 'package:neww/features/auth/presentation/bloc/profile/update_profile_event.dart';
import '../../../domain/usecases/profile_usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;

  ProfileBloc(this.getProfile) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await getProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final updatedProfile = await getProfile.repository.updateProfile(event.profile);
        emit(ProfileLoaded(updatedProfile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

  }
}