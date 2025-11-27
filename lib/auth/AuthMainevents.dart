import 'package:goolemapuse/auth/AuthMainState.dart';

abstract class AuthMainEvents{}

class SignOut1 extends AuthMainEvents{}


class CreateUserWithEmail extends AuthMainEvents{
  String fullName;
  String email;
  String pass;
  CreateUserWithEmail({required this.fullName,required this.email,required this.pass});
}

class LoginUserWithEmail extends AuthMainEvents{

  String email;
  String pass;
  LoginUserWithEmail({required this.email,required this.pass});
}

class GoogleSignIn extends AuthMainEvents{}

class FacebookSignIn extends AuthMainEvents{}

class ForgotPassword extends AuthMainEvents{
  String email;
  ForgotPassword({required this.email});
}



class SignInUSerWithFacebook extends AuthMainEvents{}

class UdateUserName extends AuthMainEvents{
  String userNmae;
  UdateUserName({required this.userNmae});

}

class UserClickToChangeUserName extends AuthMainEvents{}

class UpdateprofilePicture2 extends AuthMainEvents{}







