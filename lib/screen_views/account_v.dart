import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class AccountV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: MCColors.green,
                      letterSpacing: MCConstants.letterSpacing1,
                    ),
                  ),
                  SizedBox(height: 24),
                  // User Info Section
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: MCColors.greenLight,
                      borderRadius: BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Doe",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MCColors.green,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "+1 234 567 8900",
                          style: TextStyle(
                            fontSize: 16,
                            color: MCColors.grey,
                          ),
                        ),
                        SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: MCColors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(color: MCColors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  // Stats Section
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: MCColors.greyLight),
                      borderRadius: BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(context, "0", "Total\nSessions", 'assets/images/card_icon_station.svg'),
                        _buildStatItem(context, "\$0", "Amount\nSpent", 'assets/images/card_icon_time_el.svg'),
                        _buildStatItem(context, "0 kWh", "Energy\nUsed", 'assets/images/card_icon_ev.svg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Menu Items
            _buildMenuItem(context, "My Vehicles", 'assets/images/card_icon_ev.svg'),
            _buildMenuItem(context, "Charging History", 'assets/images/card_icon_time_el.svg'),
            _buildMenuItem(context, "Payment Methods", 'assets/images/card_icon_station.svg'),
            _buildMenuItem(context, "Settings", 'assets/images/card_icon_station.svg'),
            _buildMenuItem(context, "Help & Support", 'assets/images/card_icon_station.svg'),
            _buildMenuItem(context, "About", 'assets/images/card_icon_station.svg'),
            
            // Version Info
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: MCColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Terms of Service and Privacy Policy",
                      style: TextStyle(
                        color: MCColors.green,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, String iconPath) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          color: MCColors.green,
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MCColors.green,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: MCColors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String iconPath) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: MCColors.greyLight,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              color: MCColors.green,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: MCColors.grey,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: MCColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}