abstract class SocialState {}

class SocialIntialState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialPostBottomNavState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialProfileCoverPickedSuccessState extends SocialState {}

class SocialProfileCoverPickedErrorState extends SocialState {}
