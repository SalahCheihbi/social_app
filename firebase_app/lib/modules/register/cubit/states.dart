abstract class SocialRegisterStates {}

class SocialRegisterInitialStates extends SocialRegisterStates {}

class SocialRegisterLoadingStates extends SocialRegisterStates {}

class SocialRegisterSuccesStates extends SocialRegisterStates {}

class SocialRegisterErrorStates extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorStates(this.error);
}

class SocialCreateUserSuccesStates extends SocialRegisterStates {}

class SocialCreateUserErrorStates extends SocialRegisterStates {
  final String error;

  SocialCreateUserErrorStates(this.error);
}

class SocialChangePasswordVisibilityStates extends SocialRegisterStates {}
