import 'package:flutter/material.dart';
import 'package:google_map_intergration/utils/constants/app_image.dart';
import 'package:google_map_intergration/utils/function/get_image_from_raw_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      //required
      target: LatLng(29.955404, 32.476655),
      zoom: 16,

    );
    setMarker();
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
            onMapCreated: (  GoogleMapController controller)async{
              googleMapController=controller;
              initialMapStyle();

            },
            //بتحدد النطاق الي عاوزه اعرضه في ماب بس
            // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            //     southwest: const LatLng(29.936142, 32.476483),
            //     northeast:const LatLng(29.970306, 32.522784))),
            markers: markers,

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
  void initialMapStyle()async{
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style/map_style.json');
    googleMapController.setMapStyle(style);
  }


  void setMarker() async{
    var customMarkerIcon=   BitmapDescriptor.fromBytes(await getImageFromRawData(image:AppImagePaths.locationIconImage,width: 100));
    Marker newMarker = Marker(
      markerId: MarkerId(const LatLng(29.955404, 32.476655).toString()),
      icon: customMarkerIcon,
      position: const LatLng(29.955404, 32.476655),
      infoWindow: const InfoWindow(
          title: "Home",
          snippet: "${29.955404}, ${32.476655}"),
    );
    markers.add(newMarker);
    setState(() {

    });
  }
}
