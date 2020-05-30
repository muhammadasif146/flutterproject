

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class AskForPermission extends StatefulWidget {
  @override
  _AskForPermissionState createState() => _AskForPermissionState();

}

class _AskForPermissionState extends State<AskForPermission> {
  // variables for decleairtion

  String _locationMessage = "";

  final PermissionHandler permissionHandler = PermissionHandler();
  Map<PermissionGroup, PermissionStatus> permissions;

// current location function

  void _getCurrentLocation() async {

    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });

  }
  // initionalized the state

  void initState() {
    super.initState();
    requestLocationPermission();
    _gpsService();
  }
// permission deny

  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (granted!=true) {
      requestLocationPermission();
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }
  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      showDialog(context: context,
        builder: (BuildContext context){
        return AlertDialog(
          title: Text("Can not Get the current location"),
          content:const Text('Please make sure you enable Location Service'
              ' and try again'),
          actions: <Widget>[
FlatButton(
  color: Colors.deepPurpleAccent,
  child:Text('Ok') ,
  onPressed: (){
    Navigator.of(context, rootNavigator: true).pop();
    _gpsService();
  },
)
          ],
        );

        }

      );

    }

  }
  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask for permisions'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(

          children: <Widget>[
            Text("All Permission Granted"),
            Text(_locationMessage),
            FlatButton(
              color: Colors.deepPurpleAccent,
              onPressed: (){
                _getCurrentLocation();
              },
              child: Text('Find Location',
              style: TextStyle(
                color: Colors.white
              ),
              ),
            ) 
          ],
        ),
      ),
    );
  }
}
