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
  late GoogleMapController googleMapController;
  @override
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      //required
      target: LatLng(29.955404, 32.476655),
      //World View 0 -> 3
      //Country View 4 -> 6
      //City View 10 -> 12
      //Street View 13 -> 17
      //Building View 18 -> 20
      zoom: 16,

    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            //ده بيبقي ثابت مش بيتغير و بيشتغل اول ما افتح ماب
            initialCameraPosition: initialCameraPosition,
            //لو محتاجه اعمل ابديت ع ماب
            onMapCreated: (  GoogleMapController controller){
              googleMapController=controller;
            },
            //بتحدد النطاق الي عاوزه اعرضه في ماب بس
            // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            //     southwest: const LatLng(29.936142, 32.476483),
            //     northeast:const LatLng(29.970306, 32.522784))),

          ),
          Positioned(
            bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(onPressed: (){
                CameraPosition   newLocation = const CameraPosition(
                  target: LatLng(29.936142, 32.476483),
                  zoom: 16,

                );

                googleMapController.animateCamera(CameraUpdate.newCameraPosition(newLocation));
              }, child: const Text("Change Location")))
        ],
      ),
    );
  }
}
