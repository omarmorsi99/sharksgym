abstract class AuthenticationStates{}

class AuthenticationInitialState extends AuthenticationStates{}

class RegisterInitialState extends AuthenticationStates{}
class RegisterLoadingState extends AuthenticationStates{}
class RegisterSuccessState extends AuthenticationStates{}
class RegisterErrorState extends AuthenticationStates{
  String error;
  RegisterErrorState(this.error);
}

class CreateUserInitialState extends AuthenticationStates{}
class CreateUserSuccessState extends AuthenticationStates{
  String uid;
  CreateUserSuccessState(this.uid);
}
class CreateUserLoadingState extends AuthenticationStates{}
class CreateUserErrorState extends AuthenticationStates{
  String error;
  CreateUserErrorState(this.error);
}




class LoginInitialState extends AuthenticationStates{}
class LoginLoadingState extends AuthenticationStates{}
class LoginSuccessState extends AuthenticationStates{}
class LoginErrorState extends AuthenticationStates{
  String error;
  LoginErrorState(this.error);
}

class LogoutLoadingState extends AuthenticationStates{}
class LogoutSuccessState extends AuthenticationStates{}

class GoogleLoginInitialState extends AuthenticationStates{}
class GoogleLoginLoadingState extends AuthenticationStates{}
class GoogleLoginSuccessState extends AuthenticationStates{}
class GoogleLoginErrorState extends AuthenticationStates{
  String error;
  GoogleLoginErrorState(this.error);
}

class GoogleLogoutSuccessState extends AuthenticationStates{}