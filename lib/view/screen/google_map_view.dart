import 'package:flutter/material.dart';
import 'package:google_map_intergration/utils/Services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
   GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  late LocationService locationService;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      //required
      target: LatLng(29.955404, 32.476655),
      zoom: 16,
    );
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      //ده بيبقي ثابت مش بيتغير و بيشتغل اول ما افتح ماب
      initialCameraPosition: initialCameraPosition,
      //لو محتاجه اعمل ابديت ع ماب
      onMapCreated: (GoogleMapController controller) async {
        googleMapController = controller;
        initialMapStyle();
      },

      markers: markers,
    );
  }

  // inquire about location service
  // request permission
  // get location
  // display
  void initialMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style/map_style.json');
    googleMapController!.setMapStyle(style);
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission = await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        setMyLocationMarker(locationData);
        setMyCameraPosition(locationData);
      });
    } else {}
  }
  void setMyCameraPosition(LocationData locationData) {
    var camerPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 15);

    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(camerPosition));
  }
  void setMyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
        markerId: const MarkerId('my_location_marker'),
        position: LatLng(locationData.latitude!, locationData.longitude!));

    markers.add(myLocationMarker);
    setState(() {});
  }
}
