import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentFetchForGMap extends Cubit<Set<Marker>>
{
  DocumentFetchForGMap():super({});

  void fetchAllMarker()async{

   final list =  await Supabase.instance.client.from("images").select();
   final datas = list as List;
   datas.map((i)=>Marker(markerId: i['address'],onTap: (){

   },
   position: LatLng(i['Latitude'], i['Longitude']),
     icon: BitmapDescriptor.defaultMarker,

   ),);

  }


}