abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetPostLoadingState extends SocialState {}

class SocialGetPostSuccessState extends SocialState {}

class SocialGetPostErrorState extends SocialState {
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialGetAllUserSuccessState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialGetLikePostSuccessState extends SocialState {}

class SocialGetLikePostErrorState extends SocialState {
  final String error;

  SocialGetLikePostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialPostBottomNavState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialProfileCoverPickedSuccessState extends SocialState {}

class SocialProfileCoverPickedErrorState extends SocialState {}

class SocialUploadProfileImageSuccessState extends SocialState {}

class SocialUploadProfileImageErrorState extends SocialState {}

class SocialUploadCoverImageSuccessState extends SocialState {}

class SocialUploadCoverImageErrorState extends SocialState {}

class SocialUserUpdateLoadingState extends SocialState {}

class SocialUserUpdateErrorState extends SocialState {}

//create Post

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {
  final String error;
  SocialCreatePostErrorState(this.error);
}

class SocialUploadPostImageSuccessState extends SocialState {}

class SocialUploadPostImageErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

class SocialUploadPostLoadingState extends SocialState {}

class SocialUploadPostErrorState extends SocialState {}

class SocialSendMessageSuccesState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessageSuccessState extends SocialState {}
