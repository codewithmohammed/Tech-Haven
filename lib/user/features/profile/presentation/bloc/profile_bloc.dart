import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserData _getUserData;
  ProfileBloc({required GetUserData getUserData})
      : _getUserData = getUserData,
        super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      emit(ProfileLoading());
    });
    on<GetUserProfileDataEvent>(_onGetUserProfileDataEvent);

    on<ProfileSignOutUserEvent>(_onSignOutUserEvent);
  }

  FutureOr<void> _onSignOutUserEvent(
      ProfileSignOutUserEvent event, Emitter<ProfileState> emit) {}

  FutureOr<void> _onGetUserProfileDataEvent(
      GetUserProfileDataEvent event, Emitter<ProfileState> emit) async {
    final result = await _getUserData(NoParams());
    result.fold(
        (failure) => emit(GetProfileDataFailedState(message: failure.message)),
        (success) => emit(GetProfileDataSuccessState(user: success!)));
  }
}
