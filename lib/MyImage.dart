import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyImage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyImage();
  }



}

class _MyImage extends State<MyImage>{
  LatLng initialCamera = LatLng(28.3949, 84.1240);
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Stack(
        children:[ GoogleMap(initialCameraPosition: CameraPosition(target: initialCamera,zoom: 10),
          myLocationButtonEnabled: false,
          onTap: (latLang){
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position){
            _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (position){
          _customInfoWindowController.googleMapController = position;
          },
          markers: {
            Marker(
                markerId: MarkerId("Marker"),
                position: LatLng(35.6852,  85.6216),
                infoWindow: InfoWindow(
                    title: "One House",
                    snippet: "One house with two Rooms"
                ),
                onTap: (){


                },
                icon: BitmapDescriptor.defaultMarker


            ),
            Marker(
                markerId: MarkerId("Marker2"),
                position: LatLng(28.6852,  80.6216),
                infoWindow: InfoWindow(
                    title: "One House",
                    snippet: "One house with two Rooms"
                ),
                onTap: (){

                  _customInfoWindowController.addInfoWindow!(
                    Container(

                      height: 40,width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/bus.png'))
                      ),
                    ),
                    LatLng(28.6852,  80.6216),
                  );
                  setState(() {

                  });



                },
                icon: BitmapDescriptor.defaultMarker


            )
          },),
          CustomInfoWindow(controller: _customInfoWindowController,
            height: 50, width: 100, offset: 50,)
      ]),

    );
  }
}