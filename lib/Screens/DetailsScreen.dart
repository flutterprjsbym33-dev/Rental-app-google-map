import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchMapperClass.dart';
import 'package:goolemapuse/CubitsBloc/ImageIndexesCubit.dart';
import 'package:goolemapuse/auth/AuthMainServices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chats/particularChatScreen.dart';

class DetailScreen extends StatelessWidget {
  DocumentFetchMapperClass item;
  DetailScreen({required this.item});

  List<String> facelities = [
    "assets/images/wifi.png",
    "assets/images/bath.png",
    "assets/images/bed.png",
    "assets/images/garage.png"
  ];

  late final index;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar:  Container(
        height: height*0.1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){},
                  icon: Icon(Icons.message,color: Colors.teal,size: 35,)),

              GestureDetector(
                onTap: () async{
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(targetUserId: item.id,)));



                },
                child: Container(

                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.teal
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Center(
                       child: Text("Book Appointment from here",
                         style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),),
                     ),
                   ),
                 ),
              ),

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height*0.4,
              child: Stack(
                children: [ PageView.builder(
                  itemCount: item.images.length,
                  itemBuilder: (BuildContext context, int indexi) {
        
        
                  return ClipRRect(
                    child: AnotherCarousel(images: item.images.map((element)=>Image.network(element,fit: BoxFit.cover,),).toList(),
                      dotSize: 6,
                      indicatorBgPadding: 5,
                      dotColor: Colors.lightGreenAccent,
                      dotBgColor: Colors.transparent,
                      borderRadius: false,
                    onImageChange: (oldIndex, newIndex){
                      context.read<ImageIndexesCubit>().addIndex(newIndex);
        
                    },),
                  );},
                ),
                  Positioned(
                    bottom: 10,
                      right: 10,
        
                      child: CircleAvatar(
                        backgroundColor: Colors.black38,
                        child: BlocBuilder<ImageIndexesCubit,int>(
                            builder: (context,state) {
                              return Text("${state+1}/${item.images.length}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white),);
                            }
                        ),
                      ),)
             ] ),
            ),
            SizedBox(height: 5.h,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(item.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                  SizedBox(height: 5.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${item.price}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_pin,size: 20,),
                           Text(item.address,style: TextStyle(fontSize: 16,),)
                        ],
                      ),
        
                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  Text("Facilities",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: height*0.02,),

                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(facelities.length, (index){
                        return Image.asset(facelities[index],height: height*0.05,);

                      })
                    ),

                  SizedBox(height: height*0.02,),
        

                  SizedBox(height: height*0.01,),
                  SizedBox(
                    height: height*0.25,width: double.infinity,
                    child: 
                       Card(
                         elevation: 4,
                        shape: OutlineInputBorder(
                          borderRadius:  BorderRadius.circular(10),
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(child: Text(item.description,style: TextStyle(color: Colors.grey.shade700,fontSize: 18),)),
                          )),
                    ),
                  
        
        
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}