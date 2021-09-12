abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {
  final String uId;

  ShopLoginSuccessStates(this.uId);
}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;
  ShopLoginErrorStates(this.error);
}

class ShopChangePasswordVisibilityStates extends ShopLoginStates {}
