abstract class SignInBlocMainEvents {}

class SignOut extends SignInBlocMainEvents{}

class SignInWithEmail extends SignInBlocMainEvents{
  String email;
  String password;
  String fullname;
  SignInWithEmail({
    required this.email,
    required this.password,
    required this.fullname
});
}
class SignInWithPhoneNumber extends SignInBlocMainEvents{
  String phone;
  SignInWithPhoneNumber({required this.phone});
}

class SignInWithOtp extends SignInBlocMainEvents{
  String otp;
  String phone;
  SignInWithOtp({required this.otp,required this.phone});

}
class SignInWithGoogle extends SignInBlocMainEvents{

}