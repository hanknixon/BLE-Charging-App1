import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';

class VehiclesV extends StatelessWidget {
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
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
                        "My Vehicles",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MCColors.green,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
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
                            onPressed: () {
                              // Add vehicle logic here
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
