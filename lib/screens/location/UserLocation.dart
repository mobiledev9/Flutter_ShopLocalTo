import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shimmer/shimmer.dart';

class UserLocation extends StatefulWidget {

  UserLocation({
    Key key,
  }) : super(key: key);

  @override
  _UserLocationState createState() {
    return _UserLocationState();
  }
}

class _UserLocationState extends State<UserLocation> {

  GoogleMapController mapController;
  // CameraPosition _initPosition ;
  // Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  // Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
    List<Address> addresses;
    Address first;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  void initState() {
    // _onLoadMap();
    print('map');
    super.initState();
  }
  ///On load map
//   void _onLoadMap() async {
//
//      await Future.delayed(Duration(seconds: 1));
//      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       final coordinates = new Coordinates(_currentPosition.latitude,_currentPosition.longitude);
// log(coordinates.toString());
//
// addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
// setState(() {
//       first = addresses.first;
//     });
//     final MarkerId markerId = MarkerId(_currentPosition.altitude.toString());
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(_currentPosition.latitude,_currentPosition.longitude),
//       infoWindow: InfoWindow(title: first.thoroughfare),
//       onTap: () {},
//     );
// // print(widget.location.id.toString());
//     setState(() {
//       _initPosition = CameraPosition(
//         target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
//         zoom: 14.4746,
//       );
//       _markers[markerId] = marker;
//     });
//   }

  @override
  Widget build(BuildContext context) {
   Position pos = _currentPosition == null? null: _currentPosition;
   // if(pos == null){
   //    return Scaffold(
   //       appBar: AppBar(
   //      centerTitle: true,
   //      title: Text(
   //        Translate.of(context).translate('location'),
   //      ),
   //    ),
   //            body: Shimmer.fromColors(
   //      baseColor: Theme.of(context).hoverColor,
   //      highlightColor: Theme.of(context).highlightColor,
   //      enabled: true,
   //      child: Container(
   //        color: Colors.white,
   //      ),
   //  ),
   //    );
   // }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('location'),
        ),
      ),
      body: Container(
        // child: GoogleMap(
        //   mapType: MapType.hybrid,
        //   initialCameraPosition: _kGooglePlex,
        //   onMapCreated: (GoogleMapController controller) {
        //     _controller.complete(controller);
        //   },
        // ),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
