import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import '../navigation/navbars.dart';
import '../utils/colors.dart';

class MapsV extends StatefulWidget {
  @override
  _MapsVState createState() => _MapsVState();
}

class _MapsVState extends State<MapsV> {
  HereMapController? _mapController;
  MapMarker? _userLocationMarker;
  bool _mapReady = false;
  bool _sdkInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      await _requestPermissions();

      // Wait longer for SDK to be ready since it's initialized in MainActivity
      await Future.delayed(Duration(milliseconds: 3000));

      if (mounted) {
        setState(() {
          _sdkInitialized = true;
          _mapReady = true;
        });
      }
    } catch (e) {
      print('Error in _initializeMap: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to initialize map: $e';
        });
      }
    }
  }

  // bool _checkSDKInitialization() {
  //   try {
  //     // For HERE SDK 4.x, we can check if the context is available
  //     return true; // Simplified check since we're handling initialization in main.dart
  //   } catch (e) {
  //     print('SDK not initialized: $e');
  //     return false;
  //   }
  // }

  Future<void> _requestPermissions() async {
    // Request location permissions
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('Location permission granted');
    } else if (status.isDenied) {
      print('Location permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Location permission permanently denied');
      await openAppSettings();
    }
  }

  void _onMapCreated(HereMapController controller) {
    try {
      _mapController = controller;
      print('Map controller created successfully');

      // Load map scene first, then set camera position
      _loadMapScene();
    } catch (e) {
      print('Error in _onMapCreated: $e');
      setState(() {
        _errorMessage = 'Failed to create map: $e';
      });
    }
  }

  void _loadMapScene() {
    try {
      _mapController?.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
          (MapError? error) {
        if (error != null) {
          print('Error loading map scene: ${error.toString()}');
          String errorMsg = 'Failed to load map scene: ${error.toString()}';

          // Check for specific authentication errors
          if (error.toString().contains('Authentication') ||
              error.toString().contains('Authorization') ||
              error.toString().contains('Forbidden')) {
            errorMsg =
                'Authentication failed. Please check your HERE API key.\n\nMake sure:\n1. Your API key is valid\n2. Your API key has Map Rendering API enabled\n3. Your API key is correctly set in gradle.properties';
          }

          setState(() {
            _errorMessage = errorMsg;
          });
        } else {
          print('Map scene loaded successfully');
          // Set camera position after scene is loaded
          Future.delayed(Duration(milliseconds: 500), () {
            _setCameraPosition();
          });
        }
      });
    } catch (e) {
      print('Error in _loadMapScene: $e');
      setState(() {
        _errorMessage = 'Error loading map scene: $e';
      });
    }
  }

  void _setCameraPosition() {
    if (_mapController == null) {
      print('Map controller is null, cannot set camera position');
      return;
    }

    try {
      final target = GeoCoordinates(37.7749, -122.4194);

      // Use lookAtPoint method to set camera position
      _mapController!.camera.lookAtPoint(target);
      _mapController!.camera
          .setDistanceToTarget(1000.0); // 1km distance as double
      _mapController!.camera.setOrientationAtTarget(
          GeoOrientationUpdate(0.0, 0.0)); // bearing and tilt

      print('Camera position set to San Francisco successfully');
    } catch (e) {
      print('Error setting camera position: $e');
    }
  }

  void _moveToUserLocation() async {
    // Check if location permission is granted
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await _requestPermissions();
      return;
    }

    try {
      // For demonstration, using a mock location near San Francisco
      // In a real app, you would get actual user location using geolocator package
      final userLocation = GeoCoordinates(37.7849, -122.4094);

      // Move camera to user location
      _mapController?.camera.lookAtPoint(userLocation);
      _mapController?.camera
          .setDistanceToTarget(500.0); // 500m distance for closer view
      _mapController?.camera.setOrientationAtTarget(
          GeoOrientationUpdate(0.0, 0.0)); // bearing and tilt

      // Add or update user location marker
      _addUserLocationMarker(userLocation);

      print('Moved to user location');
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  void _addUserLocationMarker(GeoCoordinates coordinates) {
    if (_mapController == null) return;

    try {
      // Remove previous marker if exists
      if (_userLocationMarker != null) {
        _mapController!.mapScene.removeMapMarker(_userLocationMarker!);
      }

      // Create a simple marker for user location
      final mapImage = MapImage.withPixelDataAndImageFormat(
        _createCircleMarkerPixelData(),
        ImageFormat.png,
      );

      _userLocationMarker = MapMarker(coordinates, mapImage);
      _mapController!.mapScene.addMapMarker(_userLocationMarker!);

      print('User location marker added');
    } catch (e) {
      print('Error adding user location marker: $e');
    }
  }

  // Create a simple blue circle for user location marker
  Uint8List _createCircleMarkerPixelData() {
    // Create a minimal valid PNG for a 16x16 blue circle
    final List<int> pngData = [
      // PNG signature
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
      // IHDR chunk (16x16, 8-bit RGB+Alpha)
      0x00, 0x00, 0x00, 0x0D, // chunk length
      0x49, 0x48, 0x44, 0x52, // "IHDR"
      0x00, 0x00, 0x00, 0x10, // width: 16
      0x00, 0x00, 0x00, 0x10, // height: 16
      0x08, 0x06, 0x00, 0x00,
      0x00, // bit depth, color type, compression, filter, interlace
      0x1F, 0xF3, 0xFF, 0x61, // CRC
      // IDAT chunk (minimal data for transparency)
      0x00, 0x00, 0x00, 0x0A,
      0x49, 0x44, 0x41, 0x54,
      0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01,
      0x0D, 0x0A, 0x2D, 0xB4,
      // IEND chunk
      0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
    ];

    return Uint8List.fromList(pngData);
  }

  @override
  void dispose() {
    try {
      if (_userLocationMarker != null && _mapController != null) {
        _mapController!.mapScene.removeMapMarker(_userLocationMarker!);
      }
    } catch (e) {
      print('Error in dispose: $e');
    }
    super.dispose();
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
            child: Container(
              child: Stack(
                children: [
                  // Show error message if there is one
                  if (_errorMessage != null)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Map Error',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              _errorMessage!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _errorMessage = null;
                                _mapReady = false;
                                _sdkInitialized = false;
                              });
                              _initializeMap();
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  // Show loading if not ready and no error
                  else if (!_mapReady || !_sdkInitialized)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading map...'),
                        ],
                      ),
                    )
                  // Show the map if ready and no error
                  else
                    HereMap(
                      onMapCreated: _onMapCreated,
                    ),

                  // Show location button only if map is ready and no error
                  if (_mapReady && _sdkInitialized && _errorMessage == null)
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: FloatingActionButton(
                        backgroundColor: MCColors.green,
                        child: Icon(
                          Icons.my_location,
                          color: MCColors.white,
                        ),
                        onPressed: _moveToUserLocation,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
