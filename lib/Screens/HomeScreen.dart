import 'dart:async';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/CubitsBloc/BottomIndexSelector.dart';
import 'package:goolemapuse/CubitsBloc/CategorySelector.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchBloc.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchMapperClass.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchState.dart';
import 'package:goolemapuse/CubitsBloc/FaviroouteItemListCubit.dart';
import 'package:goolemapuse/Screens/DetailsScreen.dart';
import 'package:goolemapuse/Screens/ExploreScreen.dart';
import 'package:goolemapuse/Screens/FavirouteItemScreen.dart';
import 'package:goolemapuse/Screens/FlatScreen.dart';
import 'package:goolemapuse/Screens/ProfileSection.dart';
import 'package:goolemapuse/Screens/SignUpScreen.dart';
import 'package:goolemapuse/chat/ChatSection.dart';
import 'package:goolemapuse/chats/AllChats.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../CubitsBloc/FetchUserInfoCubit.dart';
import '../CubitsBloc/PageControllerCubit.dart';
import 'GoogleMapIntegration.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }



}

class _HomeScreen extends State<HomeScreen>{
  late PageController pageController;
  var formattedDate;

  late List<DocumentFetchMapperClass> type;

  List<Widget> screens =[
    ExploreScreen(),
    FavirouteItemScreen(),
    AllChatsPage(),
    ProfileSection(),
  ];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DocumentFetchedBloc>().fetchAllData();
    pageController = PageController();
    context.read<FetchUserInfoCubit>().fetchUserDetails();



  }

  List<String> bottomIcons = [
    "assets/images/btn_1.png",
    "assets/images/btn_2.png",
    "assets/images/btm_3.png",
    "assets/images/btn_4.png"
  ];

  List<String> bottomIconsNmae = [
    "Explore",
    "Favourite",
    "CheckList",
    "Profile"
  ];

  List<String> category = [
    "assets/images/cat_1.png",
    "assets/images/cat_2.png",
    "assets/images/cat_3.png",
    "assets/images/cat_4.png",
    "assets/images/cat_5.png"
  ];

  List<String> categoryName = [
    "Rooms",
    "Houses",
    "Flat",
    "Apartment",
    "Empty Land"
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),

            ),
            height: height*0.1,
            child: Center(

              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate( bottomIcons.length, (index){
                    return GestureDetector(
                      onTap: (){
                        context.read<BottomIndexSelector>().indexSelector(index);


                      },
                      child: BlocBuilder<BottomIndexSelector,int>(
                          builder: (context,state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(bottomIcons[index],height: 25.h,color:  state==index ? Colors.pink : Colors.black),
                                SizedBox(height: height*0.008,),
                                Text(bottomIconsNmae[index],style: TextStyle(color:   state==index ? Colors.pink : Colors.black),)
                              ],
                            );
                          }
                      ),
                    );
                  }),

                ),
              ),
            ),
          ),
        ),



      body: BlocBuilder<BottomIndexSelector,int>(builder: (context,state){
        return screens[state];
      })




    );
  }
}

void bootomIndexNavigator(int index,BuildContext context)
{
  switch(index)
  {
    case 1: context.read<BottomIndexSelector>().indexSelector(0);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>FavirouteItemScreen()));
    break;


  }

}