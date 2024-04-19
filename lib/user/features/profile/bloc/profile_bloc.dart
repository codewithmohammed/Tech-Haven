import 'dart:async';

import 'package:bloc/bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    
  on<ProfileSignOutUserEvent>(_onSignOutUserEvent);
  }


  FutureOr<void> _onSignOutUserEvent(ProfileSignOutUserEvent event, Emitter<ProfileState> emit) {
  }
}
