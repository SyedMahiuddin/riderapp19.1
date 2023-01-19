import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../utils/colors.dart';
const LatLng SOURCE_LOCATION = LatLng(42.7477863,-71.1699932);
const LatLng DEST_LOCATION = LatLng(24.372160,88.587103);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;
class MapPage extends StatefulWidget {
  static const String routeName='/mappage';
  static const initialcamerapossition  = CameraPosition(
    target: LatLng(23.777176, 90.399452),
    zoom: 10,
    tilt: 80,
    bearing: 30,
  );

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng sourceLocation = LatLng(24.372160, 88.587103);
  LatLng destinationLatlng = LatLng(24.374160, 88.587103);
  Uint8List? markerimages;
  List<String> images = ['images/bg.png','images/map.png'];
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _marker = Set<Marker>();

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  late StreamSubscription<LocationData> subscription;

  LocationData? currentLocation;
  late LocationData destinationLocation;
  late Location location;


  void setSourceAndDesMarkIc() async{}
  void setInitialLocation(){}
  @override
  void initState() {
    super.initState();

    location = Location();
    polylinePoints = PolylinePoints();

    subscription = location.onLocationChanged.listen((clocation) async {
      currentLocation = clocation;
      updatePinsOnMap();
    });

    setInitLocation();
  }
  void setInitLocation() async {
    await location.getLocation().then((value) {
      currentLocation = value;
      setState(() {});
    });

    destinationLocation = LocationData.fromMap({
      "latitude": destinationLatlng.latitude,
      "longitude": destinationLatlng.longitude,
    });
  }
  void showLocationPins() {
    var sourceposition = LatLng(
        currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);

    var destinationPosition =
    LatLng(destinationLatlng.latitude, destinationLatlng.longitude);

    _marker.add(Marker(
      markerId: MarkerId('sourcePosition'),
      position: sourceposition,
    ));

    _marker.add(
      Marker(
        markerId: MarkerId('destinationPosition'),
        position: destinationPosition,
      ),
    );

    setPolylinesInMap();
  }

  void setPolylinesInMap() async {
    var result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAXE8HlQ-q9loKBtRHm6ykDOixQDGlNgFA'
          '',
      PointLatLng(
          currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
      PointLatLng(destinationLatlng.latitude, destinationLatlng.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((pointLatLng) {
        polylineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    setState(() {
      _polylines.add(Polyline(
        width: 5,
        polylineId: PolylineId('polyline'),
        color: Colors.red,
        points: polylineCoordinates,
      ));
    });
  }

  void updatePinsOnMap() async {
    CameraPosition cameraPosition = CameraPosition(
      zoom: 20,
      tilt: 80,
      bearing: 30,
      target: LatLng(
          currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
    );

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    var sourcePosition = LatLng(
        currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);

    setState(() async {
      _marker.removeWhere((marker) => marker.mapsId.value == 'sourcePosition');
      final Uint8List markIcons = await getImages('images/bg.png', 250);
      _marker.add(Marker(
        markerId: MarkerId('sourcePosition'),
        icon:BitmapDescriptor.fromBytes(markIcons) ,
        position: sourcePosition,
      ));
    });
  }

  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF565d91),
        title: const Text('Navigation',
          style: TextStyle(fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 8),
              child: Row(
                children: [
                  Expanded(
                      child: Text('Are You Facing Any Trouble?', style: TextStyle(color: themeColorBlue),)
                  ),
                  Expanded(
                      child: TextButton(
                        child: Text('CLICK HERE',style: TextStyle(color: themeColorBlue, decoration: TextDecoration.underline,),),
                        onPressed: (){},
                      ))
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Container(
              height: 640.h,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    markers: _marker,
                    polylines: _polylines,
                    mapType: MapType.normal,
                    initialCameraPosition: MapPage.initialcamerapossition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      setPolylinesInMap();
                      showLocationPins();
                    },
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      width: 80.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: firstbuttoncolor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8), // <-- Radius
                          ),
                        ),
                        onPressed: (){

                        },
                        child: Text('CALL ME',style: TextStyle(fontSize: 17.h),),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w,),
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      width: 80.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: themeColorBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8), // <-- Radius
                          ),
                        ),
                        onPressed: (){

                        },
                        child: Text('DELIVERED',style: TextStyle(fontSize: 17.h),),
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}
