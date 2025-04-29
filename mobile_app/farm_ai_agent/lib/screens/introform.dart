import 'dart:convert';

import 'package:farm_ai_agent/screens/homescreen.dart';
import 'package:farm_ai_agent/utilities/storeLocalDetails.dart';
import 'package:farm_ai_agent/widgets/showErrorSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/submitRegistration.dart';

class Introform extends StatefulWidget {
  const Introform({Key? key}) : super(key: key);
  static const String id = 'inform';

  @override
  State<Introform> createState() => _IntroformState();
}

class _IntroformState extends State<Introform> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late var _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _workex = TextEditingController();

  bool _isFormValid = false;
  bool _farmer = false;
  bool _labor = false;

  String? _selectedLanguage = 'English';
  List<String> _languages = ['Hindi', 'English', 'Bengali', 'Kannada', 'Telugu'];

  String? _selectedGender = 'Male';
  List<String> _genders = ['Male', 'Female', 'Others'];

  String? _selectedSkill;
  List<String> _skillsList = [
    'Basic Farm Labor',
    'Crop Planting & Seeding',
    'Soil Preparation & Tilling',
    'Irrigation & Watering',
    'Harvesting & Picking',
    'Animal Husbandry & Livestock Care',
    'Equipment Operation (e.g., tractor, mower)',
    'Machinery Maintenance',
    'Pest & Weed Control',
    'Packing & Post-Harvest Processing'
  ];

  void _validateForm() {
    final isValid = _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        (_farmer || _labor) && (_farmer || (_labor&&_selectedSkill!=null&&_workex!=null)) ;

    setState(() {
      _isFormValid = isValid;
    });
  }

  Future<void> updatephonenumb() async {
    String ph = await readData('phone');
    setState(() {
      _phoneController.text = ph;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _locationController.addListener(_validateForm);
    _workex.addListener(_validateForm);
    updatephonenumb();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _workex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                readOnly: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email (Optional)'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: const InputDecoration(labelText: 'Select Language'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                },
                items: _languages.map((language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Select Gender'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                items: _genders.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              _labor?TextFormField(
                controller: _workex,
                decoration: const InputDecoration(labelText: 'Work Experience in years'),
                keyboardType: TextInputType.number,
              ):SizedBox(height: MediaQuery.of(context).size.height / 20),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              _labor? DropdownButtonFormField<String>(
                value: _selectedSkill,
                decoration: const InputDecoration(labelText: 'Select Skill'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSkill = newValue;
                  });
                },
                items: _skillsList.map((skill) {
                  return DropdownMenuItem<String>(
                    value: skill,
                    child: Text(skill),
                  );
                }).toList(),
              ):
              SizedBox(
                height: 0,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _farmer = true;
                        _labor = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _farmer ? Colors.green : Colors.grey,
                      ),
                      child: Text('Farmer', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _farmer = false;
                        _labor = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _labor ? Colors.green : Colors.grey,
                      ),
                      child: Text('Worker', style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),


              SizedBox(height: MediaQuery.of(context).size.height / 20),
              ElevatedButton(
                onPressed: () {
                  _validateForm();
                  if (_isFormValid) {


                    if (_farmer) {
                      var data = json.encode({
                        'Name': _nameController.text,
                        'Contact_Number__c': _phoneController.text,
                        'Location__c': _locationController.text,
                        'Language__c': _selectedLanguage,
                        'Gender__c': _selectedGender,
                      });
                      SendRegistrationdata('Farmer__c', data);
                    } else {
                      var data = json.encode({
                        'Name': _nameController.text,
                        'Contact_Number__c': _phoneController.text,
                        'Location__c': _locationController.text,
                        'Language__c': _selectedLanguage,
                        'Gender__c': _selectedGender,
                        'Skill__c': _selectedSkill,
                        'Experience_years__c':_workex.text
                      });
                      SendRegistrationdata('Labour__c', data);
                    }
                    Storedata('Name', _nameController.text);
                    Storedata('UserType', _farmer?'Farmer':'Labor');
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreen()),
                    );
                  } else {
                    showErrorMessage(context, 'Invalid form data');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
