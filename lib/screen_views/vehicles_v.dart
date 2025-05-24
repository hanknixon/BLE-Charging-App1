import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';
import 'add_vehicle_v.dart';
import 'vehicle_details_v.dart';
import 'dart:io';

class VehiclesV extends StatefulWidget {
  @override
  _VehiclesVState createState() => _VehiclesVState();
}

class _VehiclesVState extends State<VehiclesV> {
  List<Vehicle> vehicles = [];

  Widget _buildVehicleCard(Vehicle vehicle) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      elevation: 0,
      color: MCColors.greenLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VehicleDetailsV(vehicle: vehicle),
            ),
          );
          if (result != null) {
            setState(() {
              if (result == 'delete') {
                vehicles.remove(vehicle);
              } else if (result is Vehicle) {
                final index = vehicles.indexOf(vehicle);
                vehicles[index] = result;
              }
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: vehicle.photoUrl != null
                    ? ClipOval(
                        child: Image.file(
                          File(vehicle.photoUrl!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.directions_car,
                        color: MCColors.green,
                        size: 30,
                      ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicle.nickname ??
                                "${vehicle.year} ${vehicle.make} ${vehicle.model}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MCColors.green,
                            ),
                          ),
                        ),
                        if (vehicle.isPrimary)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: MCColors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Primary",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${vehicle.batteryCapacity} kWh • ${vehicle.chargingPortType}",
                      style: TextStyle(
                        color: MCColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: MCColors.grey),
            ],
          ),
        ),
      ),
    );
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
          // Back button and title (always shown)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: MCColors.green),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8),
                Text(
                  "My Vehicles",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MCColors.green,
                  ),
                ),
                Spacer(),
                // Add button if vehicles exist
                if (vehicles.isNotEmpty)
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: MCColors.green,
                      size: 28,
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddVehicleV(),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          vehicles.add(result);
                        });
                      }
                    },
                  ),
              ],
            ),
          ),
          // Vehicles List or Empty State
          Expanded(
            child: vehicles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 100,
                              color: MCColors.green,
                            ),
                            Transform.rotate(
                              angle: -0.5,
                              child: Container(
                                width: 120,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: MCColors.errorRed.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                          "No Vehicles Found",
                          style: TextStyle(
                            fontSize: 20,
                            color: MCColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 32),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(200, 50),
                            side: BorderSide(color: MCColors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MCConstants.ctaBtnCornerRadius),
                            ),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddVehicleV(),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                vehicles.add(result);
                              });
                            }
                          },
                          child: Text(
                            "Add Vehicle",
                            style: TextStyle(
                              color: MCColors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      return _buildVehicleCard(vehicles[index]);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
