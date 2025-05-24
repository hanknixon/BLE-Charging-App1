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
  bool _mapReady = false;
  bool _sdkInitialized = false;
  String? _errorMessage;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void dispose() {
    _isDisposed = true;
    if (_userLocationMarker != null && _mapController != null) {
      _mapController!.mapScene.removeMapMarker(_userLocationMarker!);
    }
    _mapController?.finalize();
    super.dispose();
  }

  Future<void> _initializeMap() async {
    try {
      await _requestPermissions();

      if (SDKNativeEngine.sharedInstance == null) {
        final sdkOptions = SDKOptions.withAccessKeySecret(
          '848HTu2nccaIgyZr64SS9g',
          'LXQOIDsXCUvMh_MRx9jU49f0ZlPljijA5BzWJj9I_aJbQ68rEJktVlP6YoQKsMEY3GgmH5G4zRTjrjW1PwKhjg',
        );
        SDKNativeEngine.makeSharedInstance(sdkOptions);
        print('✅ SDKNativeEngine initialized');
      }

      // ✅ Mark as initialized AFTER SDK engine is created
      if (!_isDisposed && mounted) {
        setState(() {
          _sdkInitialized = true;
        });
      }
    } catch (e) {
      print('Error in _initializeMap: $e');
      if (!_isDisposed && mounted) {
        setState(() {
          _errorMessage = 'Failed to initialize map: $e';
        });
      }
    }
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('Location permission granted');
    } else if (status.isDenied) {
      print('Location permission denied');
      throw Exception('Location permission required');
    } else if (status.isPermanentlyDenied) {
      print('Location permission permanently denied');
      await openAppSettings();
      throw Exception('Please enable location permissions in settings');
    }
  }

  void _onMapCreated(HereMapController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed && mounted) {
        _mapController = controller;
        print('✅ Map controller created');
        _loadMapScene();
      }
    });
  }

  void _loadMapScene() {
    if (_mapController == null || _isDisposed) return;

    try {
      _mapController!.mapScene.loadSceneForMapScheme(
        MapScheme.normalDay,
        (MapError? error) {
          if (error != null) {
            print('❌ Error loading map scene: ${error.toString()}');
            if (!_isDisposed && mounted) {
              setState(() {
                _errorMessage = 'Failed to load map scene: ${error.toString()}';
              });
            }
            return;
          }

          print('✅ Map scene loaded successfully');

          if (_mapController == null) {
            print('❌ mapController is null at load time');
            return;
          }

          final target = GeoCoordinates(37.7749, -122.4194);
          _mapController!.camera.lookAtPoint(target);
          _mapController!.camera.setDistanceToTarget(1000.0);
          _mapController!.camera.setOrientationAtTarget(
            GeoOrientationUpdate(0.0, 0.0),
          );

          if (!_isDisposed && mounted) {
            setState(() {
              _mapReady = true; // ✅ Only mark ready after successful load
            });
          }
        },
      );
    } catch (e) {
      print('❌ Exception in loadMapScene: $e');
      if (!_isDisposed && mounted) {
        setState(() {
          _errorMessage = 'Failed to load map: $e';
        });
      }
    }
  }

  void _setCameraPosition() {
    if (_mapController == null || _isDisposed) return;

    try {
      final target = GeoCoordinates(37.7749, -122.4194);
      _mapController!.camera.lookAtPoint(target);
      _mapController!.camera.setDistanceToTarget(1000.0);
      _mapController!.camera
          .setOrientationAtTarget(GeoOrientationUpdate(0.0, 0.0));
    } catch (e) {
      print('Error setting camera position: $e');
    }
  }

  void _moveToUserLocation() async {
    if (_mapController == null || _isDisposed) return;

    try {
      var status = await Permission.location.status;
      if (!status.isGranted) {
        await _requestPermissions();
        return;
      }

      // Mock location for demo
      final userLocation = GeoCoordinates(37.7849, -122.4094);

      _mapController!.camera.lookAtPoint(userLocation);
      _mapController!.camera.setDistanceToTarget(500.0);
      _mapController!.camera
          .setOrientationAtTarget(GeoOrientationUpdate(0.0, 0.0));

      _addUserLocationMarker(userLocation);
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  void _addUserLocationMarker(GeoCoordinates coordinates) {
    if (_mapController == null || _isDisposed) return;

    try {
      if (_userLocationMarker != null) {
        _mapController!.mapScene.removeMapMarker(_userLocationMarker!);
      }

      final mapImage = MapImage.withPixelDataAndImageFormat(
        _createCircleMarkerPixelData(),
        ImageFormat.png,
      );

      _userLocationMarker = MapMarker(coordinates, mapImage);
      _mapController!.mapScene.addMapMarker(_userLocationMarker!);
    } catch (e) {
      print('Error adding user location marker: $e');
    }
  }

  Uint8List _createCircleMarkerPixelData() {
    // Simple blue circle PNG data
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
            child: Builder(
              builder: (context) {
                if (_errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
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
                            if (!_isDisposed && mounted) {
                              setState(() {
                                _errorMessage = null;
                                _mapReady = false;
                                _sdkInitialized = false;
                              });
                              _initializeMap();
                            }
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (!_sdkInitialized || !_mapReady) {
                  // Show loading indicator until SDK engine and map scene are ready
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading map...'),
                      ],
                    ),
                  );
                } else {
                  // ✅ Only show the HereMap widget once the SDK engine is ready and map scene is loaded!
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: HereMap(
                          onMapCreated: _onMapCreated,
                        ),
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
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
