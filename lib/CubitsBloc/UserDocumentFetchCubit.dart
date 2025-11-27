import 'package:bloc/bloc.dart';
import 'package:goolemapuse/CubitsBloc/UserDocumentMapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDocumentFetchCubit extends Cubit<UserDocumentMapper>
{

  UserDocumentFetchCubit():super(UserDocumentMapper(name: '', images: [], uploadedAt: '', isLoading: true));


  void fetchUserData()async
  {
    try{
      final response = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', Supabase.instance.client.auth.currentUser!.id)
          .single();
      print("UserId:????${Supabase.instance.client.auth.currentUser!.id}");

      final name = response['fullname'] as String;
      print("name>>>>>>>>>>$name");

      final response1 = await Supabase.instance.client
          .from('images')
          .select()
          .eq('id', Supabase.instance.client.auth.currentUser!.id)
          .single();

      final images = response1['uplodimg'] as List;
      final listImages = images.map((i)=>i.toString()).toList();
      print('>>>>>>>>$images');
      final createdAt = response1['created_at'];
      print('>>>>>>>>$createdAt');
      
      emit(UserDocumentMapper(name: name , images: listImages, uploadedAt: createdAt,isLoading: false));

    }catch(e){
      print(e.toString());
    }


  }



}

