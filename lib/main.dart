import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/CubitsBloc/BottomIndexSelector.dart';
import 'package:goolemapuse/CubitsBloc/CategorySelector.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchBloc.dart';
import 'package:goolemapuse/CubitsBloc/FaviroouteItemListCubit.dart';
import 'package:goolemapuse/CubitsBloc/FetchUserInfoCubit.dart';
import 'package:goolemapuse/CubitsBloc/ImageIndexesCubit.dart';
import 'package:goolemapuse/CubitsBloc/RoomTypeCubit.dart';
import 'package:goolemapuse/CubitsBloc/UserDocumentFetchCubit.dart';
import 'package:goolemapuse/DocumentUploadBloc/DocumentUploadMainBloc.dart';
import 'package:goolemapuse/MyImage.dart';
import 'package:goolemapuse/Screens/HomeScreen.dart';
import 'package:goolemapuse/Screens/LoginScreen.dart';
import 'package:goolemapuse/SigninBloc/SignInMainBloc.dart';
import 'package:goolemapuse/appConst/AppConstant.dart';
import 'package:goolemapuse/auth/AuthMainServices.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'CubitsBloc/PageControllerCubit.dart';
import 'auth/AuthMainBloc.dart';
import 'documentUploadNew/DocumentUploadMianBloc2.dart';
import 'firebase_options.dart';
import 'package:zego_zimkit/zego_zimkit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await Supabase.initialize(url: "https://waehwngyhmljtnegoncj.supabase.co",
       anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndhZWh3bmd5aG1sanRuZWdvbmNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc4MTc2NDksImV4cCI6MjA3MzM5MzY0OX0.h5mIfYFNY553EOCywHdxECJtpJTUFmDyWEamQ5OLcDk");
  await ZIMKit().init(
    appID: AppConstant.appId, // your appid
    appSign: AppConstant.appSignIn, // your appSign
  );
  runApp(ScreenUtilInit(
    designSize: const Size(412.0, 847.0),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create:(_)=>DocumentUploadMainBloc2()),
        BlocProvider(create:(_)=>FetchUserInfoCubit()),
        BlocProvider(create:(_)=>AuthMianBloc()),
        BlocProvider(create: (context)=>BottomIndexSelector()),
        BlocProvider(create: (context)=>CategorySelector()),
        BlocProvider(create: (context)=>DocumentFetchedBloc()),
        BlocProvider(create: (context)=>PageIndicatorCubit()),
        BlocProvider(create: (context)=>ImageIndexesCubit()),
        BlocProvider(create: (context)=>FaviroouteItemListCubit()),

        BlocProvider(create: (context)=>UserDocumentFetchCubit()),
        BlocProvider(create: (context)=>RoomTypeCubit()),
        BlocProvider(create: (context)=>DocumentUploadMainBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: StreamBuilder(
          stream: authServices.value.authStateChange,
          builder: (context,snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting)
              {
                return CircularProgressIndicator();
              }
            if(snapshot.hasData )
            {
              return HomeScreen();
            }
            else{
              return LoginScreen();
            }
          }
        )
      ),
    );
  }
}
