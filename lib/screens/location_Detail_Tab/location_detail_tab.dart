import 'package:flutter/material.dart';

class LocationDetailTab extends StatefulWidget {
  final num id;

  const LocationDetailTab({Key key, this.id}) : super(key: key);
  @override
  _LocationDetailTabState createState() => _LocationDetailTabState();
}

class _LocationDetailTabState extends State<LocationDetailTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LocationDetailPage"),
      ),
    );
  }
}
