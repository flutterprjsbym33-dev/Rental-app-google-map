import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

ValueNotifier<AuthenticationServices> authServices = ValueNotifier(AuthenticationServices());

class AuthenticationServices{

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FacebookAuth facebookAuth = FacebookAuth.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static bool isInitialize = false;

  // Future<void> googlesignIninit()async
  // {
  // if(!isInitialize)
  //   {
  //     await googleSignIn.initialize(
  //       serverClientId: "589043590353-h64vq92osca7ttaa5tamfcp6n5j36ve4.apps.googleusercontent.com"
  //  );
  //  isInitialize = true;
  //}

  //}



  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();


  //Create User in firebase with email and password----------------------------->>>>>>
  Future<void> signupUserWithEmail(String fullName,String email,String password)async
  {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await firebaseFirestore.collection('users').doc(currentUser!.uid).set({
      'fullname':fullName,
      'email':email,
      'provider':"EmailProvider",
      'photo':"https://s3.eu-central-1.amazonaws.com/uploads.mangoweb.org/shared-prod/visegradfund.org/uploads/2021/08/placeholder-male.jpg",
      'created_at':FieldValue.serverTimestamp(),
    });

  }


  //Login User in firebase with email and password----------------------------->>>>>>

  Future<void> loginUserWithEmail(String email,String password)async
  {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }


  //Sign Out User in firebase----------------------------->>>>>>

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }



  //Reset Password  of User in firebase  (Recover from email)----------------------------->>>>>>
  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }


  //Update  Username  of User in firebase  ----------------------------->>>>>>
  Future<void> UpdateUSerName(String userName) async {
    await firebaseAuth.currentUser!.updateDisplayName(userName);
    await currentUser!.reload();
  }


  //GoogleSignIn (Sign In User with Google as a Provider)

  Future<void> signInWithGoogle()async
  {
    //googlesignIninit();


    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
    await firebaseAuth.signInWithCredential(credential);

    final User? user = userCredential.user;


    if(user!=null)
    {
      final existingUser = firebaseFirestore.collection('users').doc(currentUser!.uid).get();
      if(existingUser!=null)
      {
        await firebaseFirestore.collection('users').doc(user.uid).set({
          'fullname':user.displayName ?? googleUser.displayName,
          'email':user.email ?? googleUser.email,
          'provider':"GoogleProvider",
          'photo':googleUser.photoUrl ??"https://s3.eu-central-1.amazonaws.com/uploads.mangoweb.org/shared-prod/visegradfund.org/uploads/2021/08/placeholder-male.jpg",
          'created_at':FieldValue.serverTimestamp(),
        });

      }

    }


  }


//Sign in User with Facebook
  Future<void> facebookSignin()async
  {
    final result =  await facebookAuth.login(permissions: ['email','profile']);
    if(result.status==LoginStatus.success)
    {
      final AccessToken? accessTOken =  await result.accessToken;
      final credential = await FacebookAuthProvider.credential(accessTOken!.tokenString);
      final UserCredential user = await firebaseAuth.signInWithCredential(credential);

    }

  }






}




