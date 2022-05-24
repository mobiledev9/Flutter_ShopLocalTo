import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/src/locations.dart' as locations;

class Location extends StatefulWidget {
  final LocationModel location;

  Location({
    Key key,
    this.location,
  }) : super(key: key);

  @override
  _LocationState createState() {
    return _LocationState();
  }
}

class _LocationState extends State<Location> {
   GoogleMapController mapController;
   List<MyLocation> myLocation;
   CameraPosition _initPosition;
   final Map<String, Marker> _markers = {};


   Future<void> _onMapCreated(GoogleMapController controller) async {

     setState(() {
       _markers.clear();

         final marker = Marker(
           markerId: MarkerId(widget.location.id.toString()),
           position: LatLng(widget.location.lat, widget.location.long),
           infoWindow: InfoWindow(
             title: widget.location.name,
           ),
         );
         _markers[widget.location.name] = marker;

     });
   }

   @override
  void initState() {

    super.initState();
  }

  ///On load map
//   void _onLoadMap() {
//     final MarkerId markerId = MarkerId(widget.location.id.toString());
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(widget.location.lat, widget.location.long),
//       infoWindow: InfoWindow(title: widget.location.name),
//       onTap: () {},
//     );
// print(widget.location.id.toString());
//     setState(() {
//       _initPosition = CameraPosition(
//         target: LatLng(widget.location.lat, widget.location.long),
//         zoom: 14.4746,
//       );
//       _markers[markerId] = marker;
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('location'),
        ),
      ),
      body: Container(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.lat, widget.location.long),
            zoom: 14.4746,
          ),
          markers: _markers.values.toSet(),
        ),
        // child: GoogleMap(
        //   initialCameraPosition: _initPosition,
        //   markers: Set<Marker>.of(_markers.values),
        //   myLocationEnabled: true,
        //   myLocationButtonEnabled: true,
        // ),
      ),
    );
  }
}
