import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';
import 'add_vehicle_v.dart';
import 'dart:io';

class VehicleDetailsV extends StatelessWidget {
  final Vehicle vehicle;

  VehicleDetailsV({required this.vehicle});

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: MCColors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: MCColors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: MCColors.green),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          vehicle.nickname ??
                              "${vehicle.year} ${vehicle.make} ${vehicle.model}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MCColors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: MCColors.greenLight,
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
                                size: 60,
                              ),
                      ),
                    ),
                    if (vehicle.isPrimary)
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: MCColors.greenLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Primary Vehicle",
                            style: TextStyle(
                              color: MCColors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 32),
                    Text(
                      "Vehicle Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MCColors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      color: MCColors.greenLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoRow("Make", vehicle.make),
                            _buildInfoRow("Model", vehicle.model),
                            _buildInfoRow("Year", vehicle.year.toString()),
                            _buildInfoRow("Battery Capacity",
                                "${vehicle.batteryCapacity} kWh"),
                            _buildInfoRow(
                                "Charging Port", vehicle.chargingPortType),
                            _buildInfoRow(
                                "License Plate", vehicle.licensePlate),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Charging Preferences",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MCColors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      color: MCColors.greenLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoRow(
                                "Preferred Speed",
                                vehicle.preferredChargingSpeed != null
                                    ? "${vehicle.preferredChargingSpeed} kW"
                                    : "Not set"),
                            _buildInfoRow(
                                "Target Percentage",
                                vehicle.targetChargePercentage != null
                                    ? "${vehicle.targetChargePercentage}%"
                                    : "Not set"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Recent Charging Sessions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MCColors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        "No charging sessions yet",
                        style: TextStyle(
                          color: MCColors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: MCColors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MCConstants.ctaBtnCornerRadius),
                            ),
                            minimumSize: Size(150, 50),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddVehicleV(
                                  vehicleToEdit: vehicle,
                                ),
                              ),
                            );
                            if (result != null) {
                              Navigator.pop(context, result);
                            }
                          },
                          child: Text(
                            "Edit Vehicle",
                            style: TextStyle(color: MCColors.green),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MCColors.errorRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MCConstants.ctaBtnCornerRadius),
                            ),
                            minimumSize: Size(150, 50),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Delete Vehicle"),
                                content: Text(
                                    "Are you sure you want to delete this vehicle?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style:
                                          TextStyle(color: MCColors.errorRed),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context); // Close dialog
                                      Navigator.pop(
                                          context, 'delete'); // Return result
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            "Delete Vehicle",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
