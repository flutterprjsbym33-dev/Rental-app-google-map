abstract class AuthMainState{}

class AuthInitialState extends AuthMainState{}

class SignInLoadingState extends AuthMainState{

}
class SignInUserWithEmailSuccessState extends AuthMainState{}
class SignInUserWithEmailErrorState extends AuthMainState{}
class LoginUserWithEmailSuccessState extends AuthMainState{}
class LoginUserWithEmailErrorState extends AuthMainState{}
class SignInUserWithGoogleSuccessState extends AuthMainState{}
class SignInUserWithGoogleErrorState extends AuthMainState{}
class SignInUserWithFacebookSuccessState extends AuthMainState{}
class SignInUserWithFacebookErrorState extends AuthMainState{}
class SignOutSuccessState  extends AuthMainState{}
class SignInErrorState extends AuthMainState{
  String errMsg;
  SignInErrorState({required this.errMsg});
}

class UpdateUserNameLoadingState extends AuthMainState{}
class UpdateUserNameSuccessState extends AuthMainState{}
class UpdateUserNameErrorState extends AuthMainState{
  String errMsg;
  UpdateUserNameErrorState(
  {
    required this.errMsg
}
      );



}

class SignOutSucessState extends AuthMainState{}
class SignOutLoadingState extends AuthMainState{}
class ResetPasswordSuccessState extends AuthMainState{}
class UserClickedToChangeUserName extends AuthMainState{}


class UpdateProfileLoadingState extends AuthMainState{
}
class UpdateProfileSuccessState extends AuthMainState{
}
class UpdateProfileErrorState extends AuthMainState{
  String errMsg;
  UpdateProfileErrorState({required this.errMsg});

}
