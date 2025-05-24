import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';

class HelpSupportV extends StatelessWidget {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: MCColors.green),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          "Help & Support",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MCColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildSupportItem(
                    context,
                    "FAQs",
                    Icons.help_outline,
                    () {
                      print("Navigate to FAQ page");
                    },
                  ),
                  _buildSupportItem(
                    context,
                    "Contact Support",
                    Icons.support_agent,
                    () {
                      print("Navigate to Contact Support page");
                    },
                  ),
                  _buildSupportItem(
                    context,
                    "Report a Bug",
                    Icons.bug_report,
                    () {
                      print("Navigate to Report Bug page");
                    },
                  ),
                  _buildSupportItem(
                    context,
                    "App Feedback",
                    Icons.feedback_outlined,
                    () {
                      print("Navigate to Feedback page");
                    },
                  ),
                  _buildSupportItem(
                    context,
                    "Terms & Privacy Policy",
                    Icons.policy,
                    () {
                      print("Navigate to Terms and Privacy Policy page");
                    },
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

  Widget _buildSupportItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
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
