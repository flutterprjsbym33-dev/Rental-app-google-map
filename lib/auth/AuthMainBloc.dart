import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import 'AuthMainServices.dart';
import 'AuthMainState.dart';
import 'AuthMainevents.dart';


class AuthMianBloc extends Bloc<AuthMainEvents,AuthMainState>
{
  AuthMianBloc():super(AuthInitialState()){

    on(SignInUSerWithemail);
    on(LoginInUSerWithemail);
    on(googleSignIn);
    on(facebookSIgnin);
    on(signOut);
    on(_userClickToChangeuserName);
    on(_updateUserName);
    on(updateProfile);


  }


  void SignInUSerWithemail(CreateUserWithEmail event,Emitter<AuthMainState> emit)async
  {
    try{
      if(event.fullName.isNotEmpty && event.email.isNotEmpty && event.pass.isNotEmpty)
      {
        if (event.fullName.length < 6 || !RegExp(r'^[a-zA-Z]').hasMatch(event.fullName)) {
          emit(SignInErrorState(errMsg: "Full name must be 6 characters and start with a letter"));
          return;
        }

        // Validate email
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(event.email)) {
          emit(SignInErrorState(errMsg: "Invalid email address"));
          return;
        }
          emit(SignInLoadingState());
           await  authServices.value.signupUserWithEmail(event.fullName, event.email, event.pass);
          emit(SignInUserWithEmailSuccessState());






      }
      else{
        emit(SignInErrorState(errMsg: "All Field Should be Filled"));

      }


    }
    catch(e){
      emit(SignInErrorState(errMsg: e.toString()));
    }

  }


  void LoginInUSerWithemail(LoginUserWithEmail event,Emitter<AuthMainState> emit)async
  {
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(event.email)) {
      emit(SignInErrorState(errMsg: "Invalid email address"));
      return;
    }
    try{

      emit(SignInLoadingState());
       await authServices.value.loginUserWithEmail( event.email, event.pass);
      emit(LoginUserWithEmailSuccessState());

    }
    catch(e){
      emit(SignInErrorState(errMsg: e.toString()));
    }

  }


  void googleSignIn(GoogleSignIn event,Emitter<AuthMainState> emit)async
  {
    try{
      emit(SignInLoadingState());
      await authServices.value.signInWithGoogle();
      emit(SignInUserWithGoogleSuccessState());

    }
    catch(e){
      emit(SignInErrorState(errMsg: e.toString()));
      print("Error Google  ${e.toString()}");
    }

  }

  void facebookSIgnin(FacebookSignIn event,Emitter<AuthMainState> emit)async
  {
    try{
      emit(SignInLoadingState());
      await authServices.value.facebookSignin();
      emit(SignInUserWithFacebookSuccessState());

    }
    catch(e){
      emit(SignInErrorState(errMsg: e.toString()));
    }

  }


  void _resetPassword(ForgotPassword event, Emitter<AuthMainState> emit)
  {
    try{
      emit(SignInLoadingState());
      authServices.value.resetPassword(event.email);
      emit(ResetPasswordSuccessState());

    }catch(e){
      emit(SignInErrorState(errMsg: e.toString()));

    }
  }

  void signOut(SignOut1 event,Emitter<AuthMainState> emit)async
  {
    emit(SignOutLoadingState());
    await authServices.value.signOut();
    emit(SignOutSuccessState());


  }

  void _updateUserName(UdateUserName event,Emitter<AuthMainState> emit)async
  {
    try{

      emit(UpdateUserNameLoadingState());
       await authServices.value.UpdateUSerName(event.userNmae);
      emit(UpdateUserNameSuccessState());

    }catch(e){
      emit(UpdateUserNameErrorState(errMsg: e.toString()));
    }

  }

  void _userClickToChangeuserName(UserClickToChangeUserName event,Emitter<AuthMainState> emit)async
  {
    emit(UserClickedToChangeUserName());

  }


  void updateProfile(UpdateprofilePicture2 event,Emitter<AuthMainState> emit)async
  {
    try{
      ImagePicker imagePicker = ImagePicker();
      final XFile? images = await  imagePicker.pickImage(source: ImageSource.gallery);
      if(images==null)
        {
          UpdateUserNameErrorState(errMsg: "Image isn't Slected");

        }
      emit(UpdateProfileLoadingState());
      final image = File(images!.path);
      final id ="${DateTime.now().microsecondsSinceEpoch}";

      await Supabase.instance.client.storage.from("images").upload(id, image);
      final profileUrl =  await Supabase.instance.client.storage.from("images").getPublicUrl(id);

      await FirebaseFirestore.instance.collection('users').doc(authServices.value.currentUser!.uid).update({
        "photo":profileUrl

      });

      emit(UpdateProfileSuccessState());


    }catch(e){
      emit(UpdateProfileErrorState(errMsg: "Error While Uploading Image"));
      print(e.toString());
    }
  }







}