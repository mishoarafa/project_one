abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

//Register States
class SocialRegisterLoadingState extends SocialRegisterStates {}
class SocialRegisterSuccessState extends SocialRegisterStates {}
class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}

//Create User States
class SocialCreateUserSuccessState extends SocialRegisterStates {}
class SocialCreateUserErrorState extends SocialRegisterStates {
  final String error;
  SocialCreateUserErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {}