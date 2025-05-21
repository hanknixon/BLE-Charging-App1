# ble_app

A Flutter Bluetooth app for EV Charging.

## Getting Started
This app was built in VS Code using Flutter and tested on an Samsung Galaxy Tab 8 Android tablet that was running Android 12.

## INSTALL PROCESS
Make sure your Android Device is set to Developer Mode and that USB debugging is enabled.
This setup differs from each device

This app uses Flutter as its framework so follow the instructions bewlow to get up and running.

Follow https://docs.flutter.dev/get-started/install/windows for installing Flutter and setup for Android Studio.
* When installing Flutter if you install it in a place where you need admin access, you will need admin access to install packages/libraries.

After that if you want to use VS code folloow these instructions: https://docs.flutter.dev/get-started/editor?tab=vscode and https://docs.flutter.dev/development/tools/vs-code

After that is done you might need to install some dependencies or libraries if they don't install when you try to run the app or if there are error messages with the include statements. Naviagte into the folder that this program is in and run the commands:
* flutter pub add flutter_blue_plus
* flutter pub add slider_button
* flutter pud add percent_indicator
* flutter pub add provider
* flutter pub add mobile_scanner
* flutter pud add mockito

You may need to restart Android Studio or VS Code to ensure dependencies are regonized.

To run the app, first you need to select the device to run on (BLE library only works on pyhsical devices).
For VS Code you can find/select the device on the bottom right corner of the screen.
On VS Code go to the main.dart file and run in debug mode, (on the top right side there should be an arrow with a bug icon) and it will take some time to launch the app on your device.

## TIPS/ISSUES
*You may need to change file path of where sdk.dir= and flutter.sdk= point to in the app/local.properties as currently they point to the locations of my Android sdk and flutter sdk

*Sometimes after you install a package or libraries it will not take effect until you restart VS Code

*Sometimes the device will not grant access to location services for the app, so you might need to add
that manually in your device location settings and give permissions to the app.

*If there is a bug or an error is thrown, to restart the app without fully restarting the app, in VS Code use the circular green arrow on the top right to do a quick restart.

*If there is an error witht he build try: "flutter clean" and then "flutter pub get" to rebuild.

There are three files in the project:
* main.dart - Contains the home page of the app
* ble.dart - Contains all the connection to ble and the corresponding pages (search, session settings, session and sumary pages)
* blemessages.dart - Contains functions for writing and parsing packets for ble messaging
* widgets.dart - Contains widget from the ble example which is not used anymore