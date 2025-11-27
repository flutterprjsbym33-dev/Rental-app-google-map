import 'dart:ffi';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleMapIntegration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleMapIntegration();
  }
}

class _GoogleMapIntegration extends State<GoogleMapIntegration> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllMarkers();
  }
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

   Set<Marker> markers = {
     Marker(markerId: MarkerId("one"),
       position: LatLng(27, 31),
       onTap: (){
        
       }
     )
   };




  Future<void> fetchAllMarkers() async
  {
    final list = await Supabase.instance.client.from("images").select();
    final datas = list as List;
    final loadMarkers =datas.map((i){
      final lat = double.tryParse(i["Latitude"].toString()) ?? 0;
      final log = double.tryParse(i["Longitude"].toString()) ?? 0;
      return Marker(markerId: MarkerId(i["id"].toString()),
      position: LatLng(lat, log),
        icon: BitmapDescriptor.defaultMarker,
        onTap: (){
        print(i['uplodimg']);
        _customInfoWindowController.addInfoWindow!(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
              ),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(i['uplodimg'][0],fit: BoxFit.cover,)
              ),

            ),
          ),
          LatLng(lat, log)

        );

        },

      );
    }).toSet();

    setState(() {
      markers = loadMarkers;
    });




  }
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    LatLng initialPosition = LatLng(28.3949, 84.1240);


    return Scaffold(
      body: Stack(children :[
        GoogleMap(initialCameraPosition: CameraPosition(target: initialPosition,zoom: 7),
          markers: markers,
      onTap: (pos) => _customInfoWindowController.hideInfoWindow!(),
      onCameraMove: (pos) => _customInfoWindowController.onCameraMove!(),
      onMapCreated: (controller) =>
      _customInfoWindowController.googleMapController = controller,
    ),

        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 100.h,
          width: 200.w,
          offset: 65,
        ),
      ]),
    );
  }
  
}
