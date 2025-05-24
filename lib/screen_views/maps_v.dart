import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import '../navigation/navbars.dart';
import '../utils/colors.dart';
import 'package:here_sdk/core.engine.dart';

class MapsV extends StatefulWidget {
  @override
  _MapsVState createState() => _MapsVState();
}

class _MapsVState extends State<MapsV> {
  HereMapController? _mapController;
  MapMarker? _userLocationMarker;
  String? _errorMessage;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    if (SDKNativeEngine.sharedInstance == null) {
      print(
          '❌ HERE SDK not initialized yet! Go back and fix main.dart initialization.');
    } else {
      print('✅ HERE SDK already initialized, ready to create map.');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    if (_userLocationMarker != null) {
      _mapController?.mapScene.removeMapMarker(_userLocationMarker!);
    }
    _mapController?.finalize();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.location.request();
    if (!status.isGranted) {
      throw Exception('Location permission required');
    }
  }

  void _onMapCreated(HereMapController controller) {
    _mapController = controller;
    print('✅ Map controller created');

    _mapController!.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        print('❌ Error loading map scene: $error');
        if (!_isDisposed && mounted) {
          setState(() {
            _errorMessage = 'Failed to load map scene: $error';
          });
        }
        return;
      }

      print('✅ Map scene loaded successfully');
      final target = GeoCoordinates(37.7749, -122.4194);
      _mapController!.camera.lookAtPoint(target);
      _mapController!.camera.setDistanceToTarget(1000.0);
      _mapController!.camera
          .setOrientationAtTarget(GeoOrientationUpdate(0.0, 0.0));
    });
  }

  void _moveToUserLocation() async {
    try {
      await _requestPermissions();

      final userLocation = GeoCoordinates(37.7849, -122.4094);
      _mapController?.camera.lookAtPoint(userLocation);
      _mapController?.camera.setDistanceToTarget(500.0);
      _addUserLocationMarker(userLocation);
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  void _addUserLocationMarker(GeoCoordinates coordinates) {
    if (_userLocationMarker != null) {
      _mapController?.mapScene.removeMapMarker(_userLocationMarker!);
    }

    final mapImage = MapImage.withPixelDataAndImageFormat(
        _createCircleMarkerPixelData(), ImageFormat.png);
    _userLocationMarker = MapMarker(coordinates, mapImage);
    _mapController?.mapScene.addMapMarker(_userLocationMarker!);
  }

  Uint8List _createCircleMarkerPixelData() {
    return Uint8List.fromList([
      0x89,
      0x50,
      0x4E,
      0x47,
      0x0D,
      0x0A,
      0x1A,
      0x0A,
      0x00,
      0x00,
      0x00,
      0x0D,
      0x49,
      0x48,
      0x44,
      0x52,
      0x00,
      0x00,
      0x00,
      0x10,
      0x00,
      0x00,
      0x00,
      0x10,
      0x08,
      0x06,
      0x00,
      0x00,
      0x00,
      0x1F,
      0xF3,
      0xFF,
      0x61,
      0x00,
      0x00,
      0x00,
      0x0A,
      0x49,
      0x44,
      0x41,
      0x54,
      0x78,
      0x9C,
      0x63,
      0x00,
      0x01,
      0x00,
      0x00,
      0x05,
      0x00,
      0x01,
      0x0D,
      0x0A,
      0x2D,
      0xB4,
      0x00,
      0x00,
      0x00,
      0x00,
      0x49,
      0x45,
      0x4E,
      0x44,
      0xAE,
      0x42,
      0x60,
      0x82
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCColors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TopNavBar(),
          ),
          Expanded(
            child: _errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text('Map Error',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(_errorMessage!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red)),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (!_isDisposed && mounted) {
                              setState(() {
                                _errorMessage = null;
                              });
                            }
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Positioned.fill(
                        child: HereMap(onMapCreated: _onMapCreated),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: FloatingActionButton(
                          backgroundColor: MCColors.green,
                          child: Icon(Icons.my_location, color: MCColors.white),
                          onPressed: _moveToUserLocation,
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
