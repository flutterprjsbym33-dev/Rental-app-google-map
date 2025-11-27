import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchMapperClass.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchState.dart';
import 'package:goolemapuse/appConst/AppConstant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class DocumentFetchedBloc extends Cubit<DocumentFetchedState>
{
  DocumentFetchedBloc():super(DocumentFetchedState(lists: [], isLoading: true, apartment: [], flat: [], houses: [], singleRoom: [],emptyLand: []));

  Future<void> fetchAllData()async
  {
    try{
      final response =  await Supabase.instance.client.from("images").select();
      List<DocumentFetchMapperClass> imagesList = [];
      List<DocumentFetchMapperClass> singleRoom = [];
      List<DocumentFetchMapperClass> flat = [];
      List<DocumentFetchMapperClass> house = [];
      List<DocumentFetchMapperClass> apartment = [];
      List<DocumentFetchMapperClass> emptyLand = [];

      final fetchedDataList = response as List;
      //Single Room
      // Single Room
      final tempSingleRoom = fetchedDataList.where((i) => i["type"] == "Singleroom").toList();
      singleRoom.addAll(tempSingleRoom.map((i) => DocumentFetchMapperClass.fromJson(i)).toList());

// Flat
      final tempFlat = fetchedDataList.where((i) => i["type"] == "Flat").toList();
      flat.addAll(tempFlat.map((i) => DocumentFetchMapperClass.fromJson(i)).toList());

// House
      final tempHouse = fetchedDataList.where((i) => i["type"] == "House").toList();
      house.addAll(tempHouse.map((i) => DocumentFetchMapperClass.fromJson(i)).toList());

// Apartment
      final tempApartment = fetchedDataList.where((i) => i["type"] == "Apartment").toList();
      apartment.addAll(tempApartment.map((i) => DocumentFetchMapperClass.fromJson(i)).toList());

// Empty Land
      final tempEmptyland = fetchedDataList.where((i) => i["type"] == "Emptyland").toList();
      emptyLand.addAll(tempEmptyland.map((i) => DocumentFetchMapperClass.fromJson(i)).toList());


      for(var i in fetchedDataList)
      {
        

        imagesList.add( DocumentFetchMapperClass.fromJson(i));
        

      }
      print(imagesList);
      emit(DocumentFetchedState(lists: imagesList, isLoading: false, apartment: apartment, flat: flat, houses: house, singleRoom: singleRoom,emptyLand: emptyLand));

    }catch(e){
      print("eror>>>>>...${e.toString()}");
      emit(DocumentFetchedState(lists: [], isLoading: false, apartment: [], flat: [], houses: [], singleRoom: [],emptyLand: []));

    }

  }

  void zimInit()async
  {
   await ZIMKit().connectUser(id: FirebaseAuth.instance.currentUser!.uid, name: AppConstant.userName);
   print("ZIMKIT Image url>>>>>>>>>>>>>>${AppConstant.imageUrl}");
   await ZIMKit().updateUserInfo(avatarUrl: AppConstant.imageUrl, name:AppConstant.userName );
  }


  

  
}