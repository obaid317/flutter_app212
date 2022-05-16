import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapPages extends StatefulWidget {
  double long,lat;
String name;
  @override
  _MapPagesState createState() => _MapPagesState();

  MapPages({this.long, this.lat,this.name});
}

class _MapPagesState extends State<MapPages> {
  static   LatLng _kMapCenter =  LatLng(19.018255973653343, 72.84793849278007);
  static final CameraPosition _kInitialPosition =  CameraPosition(target: _kMapCenter, zoom: 1.0, tilt: 0, bearing: 0);
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kMapCenter =  LatLng(widget.long, widget.lat);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
      ),
floatingActionButton: FloatingActionButton(
        child: Text(widget.name),
    ),
    );
  }
}
