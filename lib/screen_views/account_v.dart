import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';
import 'edit_profile_v.dart';
import 'vehicles_v.dart';
import 'charging_history_v.dart';
import 'payment_methods_v.dart';
import 'account_settings_v.dart';
import 'help_support_v.dart';

class AccountV extends StatelessWidget {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: MCColors.greyLight, width: 1),
                      ),
                    ),
                    child: Row(
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: MCColors.greenLight,
                        borderRadius: BorderRadius.circular(
                            MCConstants.ctaBtnCornerRadius),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hank Nixon",
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfileV()),
                                    );
                                  },
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileV()),
                              );
                            },
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: MCColors.green,
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                    color: MCColors.white,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: MCColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                      color: MCColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: MCColors.greyLight),
                        borderRadius: BorderRadius.circular(
                            MCConstants.ctaBtnCornerRadius),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(context, "0", "Total\nSessions",
                              Icons.ev_station),
                          _buildStatItem(context, "\$0", "Amount\nSpent",
                              Icons.attach_money),
                          _buildStatItem(
                              context, "0 kWh", "Energy\nUsed", Icons.bolt),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildMenuItem(
                    context,
                    "My Vehicles",
                    Icons.directions_car_filled,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VehiclesV()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "Charging History",
                    Icons.history,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChargingHistoryV()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "Payment Methods",
                    Icons.payment,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentMethodsV()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "Settings",
                    Icons.settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppSettingsV()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "Help & Support",
                    Icons.help_outline,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpSupportV()),
                      );
                    },
                  ),
                  _buildMenuItem(context, "About", Icons.info_outline),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    alignment: Alignment.center,
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildStatItem(
      BuildContext context, String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
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

  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
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
            Icon(
              icon,
              size: 24,
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
