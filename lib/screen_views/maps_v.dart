import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:permission_handler/permission_handler.dart';
import '../navigation/navbars.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class MapsV extends StatefulWidget {
  @override
  _MapsVState createState() => _MapsVState();
}

class _MapsVState extends State<MapsV> {
  HereMapController? _mapController;
  LocationIndicator? _locationIndicator;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
  }

  void _onMapCreated(HereMapController controller) {
    _mapController = controller;
    
    // Enable user location indicator
    _locationIndicator = LocationIndicator();
    _locationIndicator?.enable(_mapController!);
    
    // Set map scene to show buildings, roads, etc.
    _mapController?.mapScene.loadSceneForMapScheme(MapScheme.normalDay);

    // Set initial camera position (you can adjust these coordinates)
    _mapController?.camera.lookAt(
      GeoCoordinates(37.7749, -122.4194),
      MapMeasure(MapMeasureKind.distance, 10000)
    );
  }

  @override
  void dispose() {
    _locationIndicator?.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCColors.white,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TopNavBar(),
          ),
          Expanded(
            child: Stack(
              children: [
                HereMap(onMapCreated: _onMapCreated),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    backgroundColor: MCColors.green,
                    child: Icon(Icons.my_location, color: MCColors.white),
                    onPressed: () {
                      _locationIndicator?.enable(_mapController!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}