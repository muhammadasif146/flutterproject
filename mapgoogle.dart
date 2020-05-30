

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController myController;
  String _locationMessage = "";
  static const LatLng _lastlocation= const LatLng(45.521563, -122.677433);
// current location function

  void _getCurrentLocation() async {

    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
//_lastlocation=_locationMessage;
  }


  void onMapCreated (controller){
    setState(() {
      myController=controller;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Google maps"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 500,
            width: 350,

            child: GoogleMap(

              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target:_lastlocation,
                zoom: 11.0,
              ),


            ),
          ),


        ],

      ),
    );
  }
}


