import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/Screens/DocumentUploadScreen/UploadScreen.dart';
import 'package:goolemapuse/auth/AuthMainServices.dart';
import 'package:goolemapuse/auth/AuthMainState.dart';
import 'package:goolemapuse/auth/AuthMainevents.dart' hide SignOut;
import 'package:goolemapuse/utilities/Appcolors.dart';
import 'package:goolemapuse/utilities/SnackBarType.dart';

import '../CubitsBloc/DocumentFetchBloc.dart';
import '../CubitsBloc/DocumentFetchMapperClass.dart';
import '../CubitsBloc/FaviroouteItemListCubit.dart';
import '../CubitsBloc/FetchUserInfoCubit.dart';
import '../CubitsBloc/PageControllerCubit.dart';
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
import 'package:goolemapuse/Screens/FavirouteItemScreen.dart';
import 'package:goolemapuse/Screens/FlatScreen.dart';
import 'package:goolemapuse/Screens/ProfileSection.dart';
import 'package:goolemapuse/Screens/SignUpScreen.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../CubitsBloc/PageControllerCubit.dart';
import '../SigninBloc/SignInBlocMainEvents.dart';

import '../auth/AuthMainBloc.dart';
import '../documentUploadNew/DocumentUploadMainEvents.dart';
import '../documentUploadNew/DocumentUploadMainState.dart';
import '../documentUploadNew/DocumentUploadMianBloc2.dart';
import '../documentUploadNew/UploadScreen2.dart';
import 'GoogleMapIntegration.dart';
import 'HomeScreen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExploreScreen();
  }

}

class _ExploreScreen extends State<ExploreScreen>{


  late PageController pageController;
  var formattedDate;

  TextEditingController userName = TextEditingController();
  late List<DocumentFetchMapperClass> type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DocumentFetchedBloc>().fetchAllData();

    context.read<DocumentFetchedBloc>().zimInit();
    context.read<DocumentFetchedBloc>().zimInit();

    pageController = PageController();



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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.lightCream,
      drawer: Drawer(
        backgroundColor: AppColor.lightCream,
        width: width*0.55,
        

        child: ListView(
          children: [
            SizedBox(
              height: height*0.16,
              child: DrawerHeader(
               padding: EdgeInsets.symmetric(vertical: 8,),
                  child:Column(
                    children: [
                      ListTile(
                                      leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/images/hp33.jpg'),
                                      ),
                                      title: Text("Rental->",style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle: Text("33 Production"),
                                    ),
                      SizedBox(height: 10,),
                      Text("BROWSE")
                    ],
                  )),
            ),
            ListTile(
              onTap: (){
                context.read<CategorySelector>().addIndex(0);
                Navigator.pop(context);


              },
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            Divider(color: Colors.black12,),
            ListTile(
              leading: Icon(Icons.chat_outlined),
              title: Text('Appointments'),

            ),
            Divider(color: Colors.black12,),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>UploadScreen2()));
              },
              leading: Icon(Icons.upload),
              title: Text('Upload Docs'),


            ),
            Divider(color: Colors.black12,),
            ListTile(
              onTap: (){
                context.read<BottomIndexSelector>().indexSelector(3);
              },
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),

            ),
            Divider(color: Colors.black12,),
        BlocConsumer<AuthMianBloc, AuthMainState>(
          listener: (context, state) {
            if (state is UserClickedToChangeUserName) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Enter new username"),
                    content: TextField(
                      controller: userName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<AuthMianBloc>().add(
                            UdateUserName(userNmae: userName.text),
                          );

                        },
                        child: const Text("Confirm"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ],
                  );
                },
              );
            }

            if (state is UpdateUserNameSuccessState) {
              ShowSnacBar(
                context: context,
                discrip: "Updated UserName Successfully",
                type: SnackBarType.Success,
              );
              context.read<BottomIndexSelector>().indexSelector(3);
            }
          },
          builder: (context, state) {
            return ListTile(
              onTap: () {
                context.read<AuthMianBloc>().add(UserClickToChangeUserName());
              },
              leading: Icon(Icons.border_color_outlined),
              title: Text('Display Name'),
            );
          },
        ),

            Divider(color: Colors.black12,),
            BlocBuilder<AuthMianBloc,AuthMainState>(
              builder: (context,state) {
                if(state is SignOutLoadingState)
                  {
                    return  ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('SigningOut......'),

                    );
                  }
                else{
                  return  ListTile(
                    onTap: (){
                      context.read<AuthMianBloc>().add(SignOut1());
                    },
                    leading: Icon(Icons.logout),
                    title: Text('SignOut'),

                  );
                }
              }
            ),
           SizedBox(height: height*0.02,),
            Column(
              children: [
                Divider(color: Colors.black87,),
                Text("Contact for more:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(height: 4,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          child: CircleAvatar(backgroundImage:AssetImage('assets/images/ig.webp'),)),
                      CircleAvatar(backgroundImage:AssetImage('assets/images/facebook.png'),),
                      CircleAvatar(backgroundImage:AssetImage('assets/images/ldn.jpg'),)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(

        onPressed: () {
          showModalBottomSheet(
            shape:OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.black45,
            builder: (context) {
              return Stack(
                  children: [ DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.3,
                    maxChildSize: 0.9,
                    expand: false,
                    builder: (_, controller) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GoogleMapIntegration(),
                      );
                    },
                  ),

                    Positioned(
                        top: 8,
                        left: 0,
                        right: 0,
                        child: Center(
                            child: Container(
                              height: 5.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(20),
                              ),)))


                  ] );
            },
          );
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.map_rounded, size: 40.h),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      body:
      SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
            await context.read<DocumentFetchedBloc>().fetchAllData();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                //SearchBar
                Padding(padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 7
                                )
                              ]
                          ),
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                            child: Row(
                              children: [
                                Icon(Icons.search,size: 35.h,),
                                SizedBox(width: 15.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Where to?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    Text("Find Rooms. Upload Rooms.",style: TextStyle(fontSize: 12.sp,color: Colors.grey,overflow: TextOverflow.ellipsis),)
                                  ],
                                )
                              ],
                            ),
                          ),

                        ),
                      ),
                      SizedBox(width: 10,),
                      Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap: (){
                              Scaffold.of(context).openDrawer();
                            },
                            child: Card(
                                color: Colors.white,
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset('assets/images/settings.png',height: 25,color: Colors.black,),
                                )),
                          );
                        }
                      ),



                    ],
                  ),),
                SizedBox(
                  height: height*0.025,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: SizedBox(
                    height: height*0.109,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context,index){
                          return BlocConsumer<CategorySelector,int>(
                              listener: (context,state){


                              },
                              builder: (context,state) {
                                return GestureDetector(
                                  onTap: (){
                                    context.read<CategorySelector>().addIndex(index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: state == index ?Colors.black :Colors.grey.shade300
                                            )
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only( right: 18,left: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(category[index],height: 35.h,color:state==index ? Colors.pink:Colors.grey,),
                                          SizedBox(height: height*0.01,),
                                          Text(categoryName[index],style: TextStyle(fontSize: 14,color:state==index ? Colors.pink:Colors.grey,overflow: TextOverflow.ellipsis,),),

                                        ],
                                      ),

                                    ),
                                  ),

                                );
                              }
                          );
                        }),
                  ),
                ),



                SizedBox(height: height*0.02,),
                BlocBuilder<DocumentFetchedBloc,DocumentFetchedState>(builder: (context,state){


                  if(state.isLoading)
                  {
                    return CircularProgressIndicator();
                  }
                  if(state.lists.isNotEmpty)
                  {
                    late List<DocumentFetchMapperClass> items;

                    switch(context.watch<CategorySelector>().state)
                    {
                      case 0: items = state.singleRoom;
                      break;
                      case 1: items = state.houses;
                      break;
                      case 2: items = state.flat;
                      break;
                      case 3: items = state.apartment;
                      break;
                      case 4: items = state.emptyLand;
                    }

                    if(items.isEmpty)
                      {
                        return Center(child: Text("No Uploads Here"),);
                      }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.4,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                          controller: pageController,
                                          itemCount: item.images.length,
                                          itemBuilder: (context, indexImg) {
                                            final rawDate = item.createdAt;
                                            final parseDate = DateTime.parse(rawDate);
                                            final formattedDate = DateFormat("yyyy-MM-dd").format(parseDate);

                                            return GestureDetector(
                                              onTap: () {
                                               authServices.value.currentUser!.uid == item.id ? ShowSnacBar(context: context, discrip: "Can't go inside in own document,", type: SnackBarType.Error)
                                                   :Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailScreen(item: item),
                                                  ),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: AnotherCarousel(
                                                  images: item.images
                                                      .map((element) => Image.network(
                                                    element,
                                                    fit: BoxFit.cover,
                                                  ))
                                                      .toList(),
                                                  dotSize: 6,
                                                  indicatorBgPadding: 5,
                                                  dotColor: Colors.lightGreenAccent,
                                                  dotBgColor: Colors.transparent,
                                                  borderRadius: false,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: BlocBuilder<PageIndicatorCubit, Set<String>>(
                                            builder: (context, favState) {
                                              final isFav = favState.contains(item.id);
                                              return GestureDetector(
                                                onTap: () {
                                                  context.read<PageIndicatorCubit>().toggleFav(item.id);
                                                  context.read<FaviroouteItemListCubit>().addItem(item);
                                                },
                                                child: isFav
                                                    ? Icon(Icons.favorite, color: Colors.pink, size: 35.h)
                                                    : Icon(Icons.favorite_border, size: 35.h),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "\$${item.price}",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Icon(Icons.location_pin, size: 20),
                                            Text(
                                              item.address,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt)),
                                              style: TextStyle(fontSize: 18),
                                            ),

                                            item.id == authServices.value.currentUser!.uid ? BlocConsumer<DocumentUploadMainBloc2,DocumentUploadMainState2>(
                                              listener: (context,state){
                                                if(state is DeleateDocsSuccessStae)
                                                  {
                                                  ShowSnacBar(context: context, discrip: "Deleted Successfully", type: SnackBarType.Success);
                                                  context.read<BottomIndexSelector>().indexSelector(0);
                                                  }

                                              },
                                              builder: (context,state) {
                                                if(state is DeleateDocsLoadingStae)
                                                  {
                                                    return Text("Delating...");
                                                  }
                                                return IconButton(onPressed: (){
                                                  context.read<DocumentUploadMainBloc2>().add(deleateDocs());

                                                }, icon: Icon(Icons.delete,color: Colors.red,size: 25,) );
                                              },
                                            ) : const SizedBox.shrink()

                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );

                  }
                  return SizedBox();
                })




              ],
            ),
          ),
        ),
      ),




    );
  }

}