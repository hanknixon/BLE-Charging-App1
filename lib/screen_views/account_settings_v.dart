import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';

class AppSettingsV extends StatefulWidget {
  @override
  _AppSettingsVState createState() => _AppSettingsVState();
}

class _AppSettingsVState extends State<AppSettingsV> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _promotionalEmails = false;
  bool _darkMode = false;
  String _selectedLanguage = 'English';
  String _selectedUnit = 'kWh';
  String _selectedCurrency = 'USD';

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
                          "Settings",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MCColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSection(
                    "Account Management",
                    [
                      ListTile(
                        leading:
                            Icon(Icons.person_outline, color: MCColors.green),
                        title: Text("Change Password"),
                        trailing:
                            Icon(Icons.chevron_right, color: MCColors.grey),
                        onTap: () {
                          // Implement password change
                        },
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.email_outlined, color: MCColors.green),
                        title: Text("Update Email"),
                        trailing:
                            Icon(Icons.chevron_right, color: MCColors.grey),
                        onTap: () {
                          // Implement email update
                        },
                      ),
                    ],
                  ),
                  _buildSection(
                    "Notifications",
                    [
                      SwitchListTile(
                        secondary: Icon(Icons.notifications_outlined,
                            color: MCColors.green),
                        title: Text("Push Notifications"),
                        value: _pushNotifications,
                        activeColor: MCColors.greenDark,
                        onChanged: (bool value) {
                          setState(() {
                            _pushNotifications = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        secondary: Icon(Icons.mark_email_unread,
                            color: MCColors.green),
                        title: Text("Email Notifications"),
                        value: _emailNotifications,
                        activeColor: MCColors.greenDark,
                        onChanged: (bool value) {
                          setState(() {
                            _emailNotifications = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        secondary: Icon(Icons.local_offer_outlined,
                            color: MCColors.green),
                        title: Text("Promotional Emails"),
                        value: _promotionalEmails,
                        activeColor: MCColors.greenDark,
                        onChanged: (bool value) {
                          setState(() {
                            _promotionalEmails = value;
                          });
                        },
                      ),
                    ],
                  ),
                  _buildSection(
                    "App Settings",
                    [
                      ListTile(
                        leading: Icon(Icons.language, color: MCColors.green),
                        title: Text("Language"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_selectedLanguage,
                                style: TextStyle(color: MCColors.grey)),
                            Icon(Icons.chevron_right, color: MCColors.grey),
                          ],
                        ),
                        onTap: () {
                          _showLanguageSelector();
                        },
                      ),
                      SwitchListTile(
                        secondary: Icon(Icons.dark_mode_outlined,
                            color: MCColors.green),
                        title: Text("Dark Mode"),
                        value: _darkMode,
                        onChanged: (bool value) {
                          setState(() {
                            _darkMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                  _buildSection(
                    "Units & Measurements",
                    [
                      ListTile(
                        leading:
                            Icon(Icons.electric_bolt, color: MCColors.green),
                        title: Text("Energy Unit"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_selectedUnit,
                                style: TextStyle(color: MCColors.grey)),
                            Icon(Icons.chevron_right, color: MCColors.grey),
                          ],
                        ),
                        onTap: () {
                          _showUnitSelector();
                        },
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.attach_money, color: MCColors.green),
                        title: Text("Currency"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_selectedCurrency,
                                style: TextStyle(color: MCColors.grey)),
                            Icon(Icons.chevron_right, color: MCColors.grey),
                          ],
                        ),
                        onTap: () {
                          _showCurrencySelector();
                        },
                      ),
                    ],
                  ),
                  _buildSection(
                    "Privacy & Security",
                    [
                      ListTile(
                        leading: Icon(Icons.security, color: MCColors.green),
                        title: Text("Privacy Settings"),
                        trailing:
                            Icon(Icons.chevron_right, color: MCColors.grey),
                        onTap: () {
                          // Implement privacy settings
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.bluetooth, color: MCColors.green),
                        title: Text("Bluetooth Permissions"),
                        trailing:
                            Icon(Icons.chevron_right, color: MCColors.grey),
                        onTap: () {
                          // Implement bluetooth settings
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on, color: MCColors.green),
                        title: Text("Location Services"),
                        trailing:
                            Icon(Icons.chevron_right, color: MCColors.grey),
                        onTap: () {
                          // Implement location settings
                        },
                      ),
                    ],
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

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: MCColors.green,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: MCColors.greenLight,
            border: Border(
              top: BorderSide(color: MCColors.greyLight),
              bottom: BorderSide(color: MCColors.greyLight),
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Language",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MCColors.green,
              ),
            ),
            SizedBox(height: 16),
            ...["English", "Spanish", "French", "German"].map(
              (language) => ListTile(
                title: Text(language),
                trailing: _selectedLanguage == language
                    ? Icon(Icons.check, color: MCColors.green)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = language;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUnitSelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Energy Unit",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MCColors.green,
              ),
            ),
            SizedBox(height: 16),
            ...["kWh", "MWh", "Wh"].map(
              (unit) => ListTile(
                title: Text(unit),
                trailing: _selectedUnit == unit
                    ? Icon(Icons.check, color: MCColors.green)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedUnit = unit;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCurrencySelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Currency",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MCColors.green,
              ),
            ),
            SizedBox(height: 16),
            ...["USD", "EUR", "GBP", "CAD"].map(
              (currency) => ListTile(
                title: Text(currency),
                trailing: _selectedCurrency == currency
                    ? Icon(Icons.check, color: MCColors.green)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedCurrency = currency;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
