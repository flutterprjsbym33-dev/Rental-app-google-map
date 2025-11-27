import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/CubitsBloc/RoomTypeCubit.dart';
import 'package:goolemapuse/DocumentUploadBloc/DocumentUploadMainBloc.dart';
import 'package:goolemapuse/Screens/ExploreScreen.dart';

import '../../DocumentUploadBloc/DocumentUploadBloc.dart';
import '../../DocumentUploadBloc/DocumentUploadMainStates.dart';
import '../utilities/SnackBarType.dart';
import 'DocumentUploadMainEvents.dart';
import 'DocumentUploadMainState.dart';
import 'DocumentUploadMianBloc2.dart';

class UploadScreen2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadScreen2();
  }



}

class _UploadScreen2 extends State<UploadScreen2>{

  TextEditingController _title = TextEditingController();
  TextEditingController _District = TextEditingController();
  TextEditingController _fullAddress = TextEditingController();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _longitude = TextEditingController();
  TextEditingController _contactNo = TextEditingController();
  TextEditingController _description = TextEditingController();

  List<String> roomTypes = [
    "Singleroom",
    "Flat",
    "House",
    "Apartment",
    "EmptyLand"
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<DocumentUploadMainBloc2,DocumentUploadMainState2>(
              listener: (context,state){
                if(state is DocumentUploadSuccessState3)
                  {
                    ShowSnacBar(context: context, discrip: "Uploaded Document Successfully", type: SnackBarType.Success);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ExploreScreen()));
                  }
              },
              builder: (context, state) {
                if(state is DocumentUploadLoadingState3)
                  {
                    return CircularProgressIndicator();
                  }
                return IconButton(
                  icon: Icon(Icons.check, size: 35),
                  onPressed: () {
                    if (_title.text.isNotEmpty &&
                        _District.text.isNotEmpty &&
                        _fullAddress.text.isNotEmpty &&
                        _latitude.text.isNotEmpty &&
                        _longitude.text.isNotEmpty &&
                        _contactNo.text.isNotEmpty &&
                        _description.text.isNotEmpty) {



                      if (state is ImagePickedSuccessState) {
                        context.read<DocumentUploadMainBloc2>().add(
                          UploadDocumentEvent2(
                            title: _title.text,
                            district: _District.text,
                            fullAddress: _fullAddress.text,
                            latitude: _latitude.text,
                            longitude: _longitude.text,
                            type: context.read<RoomTypeCubit>().state,
                            description: _description.text,
                            contactNo: _contactNo.text,
                            files: state.images,   // ← FIXED
                          ),
                        );
                      } else {
                        ShowSnacBar(
                          context: context,
                          discrip: "Please select images first",
                          type: SnackBarType.Error,
                        );
                      }

                    } else {
                      ShowSnacBar(
                        context: context,
                        discrip: "Please fill all fields",
                        type: SnackBarType.Error,
                      );
                    }
                  }
                  ,
                );
              },
            ),
          )
        ],

        centerTitle: true,
        title: Text("Upload Data",),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height:height*0.26,width: double.infinity,
                  child: BlocConsumer<DocumentUploadMainBloc2,DocumentUploadMainState2>(
                    listener: (context,state){
                      if(state is ImagePickedErrorState)
                        {
                          return ShowSnacBar(context: context, discrip: state.errMsg, type: SnackBarType.Error);
                        }
                      if(state is DocumentUploadErrorState3)
                        {
                          ShowSnacBar(context: context, discrip: state.errMsg, type: SnackBarType.Error);
                        }

                    },
                      builder: (context,state) {
                        if(state is ImagePickedInitialState)
                        {
                          return InkWell(
                            onTap: (){
                              context.read<DocumentUploadMainBloc2>().add(UploadImageEvent());
                            },
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload,size: 45,),
                                  SizedBox(height: height*0.01,),
                                  Text("Upload",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          );
                        }

                        if(state is ImagePickedSuccessState)
                        {
                          return InkWell(
                            onTap: (){},
                            child: Card(
                                elevation: 2,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Stack(
                                  children: [
                                    ListView.builder(
                                      itemCount: state.images.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context,index)=>Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Image.file(state.images[index],fit: BoxFit.cover,),
                                        )
                                    ),
                                    Positioned(bottom: 10,
                                        right: 10,
                                        child: IconButton(onPressed: (){
                                          context.read<DocumentUploadMainBloc>().add(ImagePickAndUploadCancelEvents());
                                        }, icon: Icon(Icons.cancel)))
                                  ],
                                )
                            ),
                          );
                        }

                        return InkWell(
                          onTap: (){
                            context.read<DocumentUploadMainBloc2>().add(UploadImageEvent());
                          },
                          child: Card(
                            elevation: 2,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload,size: 45,),
                                SizedBox(height: height*0.01,),
                                Text("Upload",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: height*0.04,),
                TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                      label: Text("Short title about upload"),
                      suffixIcon: Icon(Icons.info_outline_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
                SizedBox(height: height*0.03,),
                Row(
                  children: [
                    Expanded(flex: 1,
                        child: customTextField("District",_District)),
                    SizedBox(width: 10.w,),
                    Expanded(flex: 1,
                        child: customTextField("Full Address",_fullAddress )),

                  ],
                ),
                SizedBox(height: height*0.03,),
                Row(
                  children: [
                    Expanded(flex: 1,
                        child: customTextField("Latitude",_latitude)),
                    SizedBox(width: 10.w,),
                    Expanded(flex: 1,
                        child: customTextField("Longitude", _longitude)),

                  ],
                ),
                SizedBox(height: height*0.03,),
                Row(
                  children: [
                    Expanded(flex: 1,
                        child: customTextField("Price",_contactNo)),
                    SizedBox(width: 10.w,),
                    Expanded(flex: 1,
                        child: DropdownButtonFormField<String>(
                            hint: Text("Type"),
                            items: roomTypes.map((type){
                              return DropdownMenuItem(
                                  value: type,
                                  child: Text(type));
                            }).toList(), onChanged: (newValue){
                          context.read<RoomTypeCubit>().addType(newValue!);
                        })),

                  ],
                ),
                SizedBox(height: height*0.032,),
                SizedBox(height: height*0.2,
                    child: TextFormField(
                      controller: _description,
                      decoration: InputDecoration(
                          label: Text("Description",style: TextStyle(fontSize: 18),),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    )),






              ],

            ),
          ),
        ),
      ),
    );
  }
}

Widget customTextField(String hint,TextEditingController controller)
{
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        label: Text(hint),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        )
    ),
  );
}