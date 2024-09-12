import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  @override
  @override
  void initState() {
    initialCameraPosition= const CameraPosition(
        //required
        target: LatLng(29.955404, 32.476655),
        //World View 0 -> 3
        //Country View 4 -> 6
        //City View 10 -> 12
        //Street View 13 -> 17
        //Building View 18 -> 20
        zoom: 18);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(initialCameraPosition: initialCameraPosition),
    );
  }
}
