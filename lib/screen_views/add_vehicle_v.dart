import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../navigation/navbars.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Vehicle {
  String? nickname;
  String make;
  String model;
  int year;
  double batteryCapacity;
  String chargingPortType;
  String licensePlate;
  double? preferredChargingSpeed;
  double? targetChargePercentage;
  String? photoUrl;
  bool isPrimary;
  String vehicleType; // sedan, suv, hatchback, etc.

  Vehicle({
    this.nickname,
    required this.make,
    required this.model,
    required this.year,
    required this.batteryCapacity,
    required this.chargingPortType,
    required this.licensePlate,
    this.preferredChargingSpeed,
    this.targetChargePercentage,
    this.photoUrl,
    this.isPrimary = false,
    required this.vehicleType,
  });
}

class AddVehicleV extends StatefulWidget {
  final Vehicle? vehicleToEdit;

  AddVehicleV({this.vehicleToEdit});

  @override
  _AddVehicleVState createState() => _AddVehicleVState();
}

class _AddVehicleVState extends State<AddVehicleV> {
  final _formKey = GlobalKey<FormState>();
  String? _photoUrl;
  bool _isPrimary = false;
  String _selectedPortType = 'CCS';
  String _vehicleType = 'sedan';

  final _nicknameController = TextEditingController();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _batteryController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _chargingSpeedController = TextEditingController();
  final _targetPercentageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.vehicleToEdit != null) {
      _nicknameController.text = widget.vehicleToEdit!.nickname ?? '';
      _makeController.text = widget.vehicleToEdit!.make;
      _modelController.text = widget.vehicleToEdit!.model;
      _yearController.text = widget.vehicleToEdit!.year.toString();
      _batteryController.text =
          widget.vehicleToEdit!.batteryCapacity.toString();
      _licensePlateController.text = widget.vehicleToEdit!.licensePlate;
      _selectedPortType = widget.vehicleToEdit!.chargingPortType;
      _isPrimary = widget.vehicleToEdit!.isPrimary;
      _photoUrl = widget.vehicleToEdit!.photoUrl;
      _vehicleType = widget.vehicleToEdit!.vehicleType;
      if (widget.vehicleToEdit!.preferredChargingSpeed != null) {
        _chargingSpeedController.text =
            widget.vehicleToEdit!.preferredChargingSpeed.toString();
      }
      if (widget.vehicleToEdit!.targetChargePercentage != null) {
        _targetPercentageController.text =
            widget.vehicleToEdit!.targetChargePercentage.toString();
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _photoUrl = image.path;
      });
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? hint,
      TextInputType? keyboardType,
      String? Function(String?)? validator}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: MCColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: MCColors.greyLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: MCColors.green),
              ),
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
                child: Form(
                  key: _formKey,
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
                            widget.vehicleToEdit != null
                                ? "Edit Vehicle"
                                : "Add Vehicle",
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
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: MCColors.greenLight,
                              shape: BoxShape.circle,
                            ),
                            child: _photoUrl != null
                                ? ClipOval(
                                    child: Image.file(
                                      File(_photoUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.add_a_photo,
                                    color: MCColors.green,
                                    size: 40,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      _buildTextField(
                        "Vehicle Nickname (Optional)",
                        _nicknameController,
                        hint: "e.g., Family Car",
                      ),
                      _buildTextField(
                        "Make *",
                        _makeController,
                        hint: "e.g., Tesla",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle make';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        "Model *",
                        _modelController,
                        hint: "e.g., Model 3",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle model';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        "Year *",
                        _yearController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter year';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid year';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        "Battery Capacity (kWh) *",
                        _batteryController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter battery capacity';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Charging Port Type *",
                            style: TextStyle(
                              fontSize: 16,
                              color: MCColors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedPortType,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: MCColors.greyLight),
                              ),
                            ),
                            items: ['CCS', 'CHAdeMO', 'Tesla', 'Type 2']
                                .map((type) => DropdownMenuItem(
                                      value: type,
                                      child: Text(type),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedPortType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        "License Plate *",
                        _licensePlateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter license plate';
                          }
                          return null;
                        },
                      ),
                      ExpansionTile(
                        title: Text(
                          "Charging Preferences",
                          style: TextStyle(
                            color: MCColors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: [
                          _buildTextField(
                            "Preferred Charging Speed (kW)",
                            _chargingSpeedController,
                            keyboardType: TextInputType.number,
                          ),
                          _buildTextField(
                            "Target Charge Percentage",
                            _targetPercentageController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      SwitchListTile(
                        title: Text(
                          "Set as Primary Vehicle",
                          style: TextStyle(
                            color: MCColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: _isPrimary,
                        activeColor: MCColors.green,
                        onChanged: (bool value) {
                          setState(() {
                            _isPrimary = value;
                          });
                        },
                      ),
                      SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MCColors.green,
                            minimumSize: Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MCConstants.ctaBtnCornerRadius),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Create vehicle object and save
                              final vehicle = Vehicle(
                                nickname: _nicknameController.text.isEmpty
                                    ? null
                                    : _nicknameController.text,
                                make: _makeController.text,
                                model: _modelController.text,
                                year: int.parse(_yearController.text),
                                batteryCapacity:
                                    double.parse(_batteryController.text),
                                chargingPortType: _selectedPortType,
                                licensePlate: _licensePlateController.text,
                                preferredChargingSpeed:
                                    _chargingSpeedController.text.isEmpty
                                        ? null
                                        : double.parse(
                                            _chargingSpeedController.text),
                                targetChargePercentage:
                                    _targetPercentageController.text.isEmpty
                                        ? null
                                        : double.parse(
                                            _targetPercentageController.text),
                                photoUrl: _photoUrl,
                                isPrimary: _isPrimary,
                                vehicleType: _vehicleType,
                              );

                              Navigator.pop(context, vehicle);
                            }
                          },
                          child: Text(
                            widget.vehicleToEdit != null
                                ? "Save Changes"
                                : "Add Vehicle",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
