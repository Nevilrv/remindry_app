import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = ChangeNotifierProvider((ref) => ProfileProvider());

class ProfileProvider extends ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController(text: "John Doe");
  final TextEditingController firstNameController = TextEditingController(text: "John");
  final TextEditingController lastNameController = TextEditingController(text: "Doe");
  final TextEditingController phoneController = TextEditingController(text: "5550000000");
  String selectedGender = "Male";
  Country selectedCountry = Country(
    phoneCode: "1",
    countryCode: "US",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "United States",
    example: "United States",
    displayName: "United States",
    displayNameNoCountryCode: "United States",
    e164Key: "",
  );

  ProfileProvider() {
    fullNameController.addListener(_onTextChanged);
    phoneController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    notifyListeners();
  }

  void setGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void setCountry(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  void clearFullName() {
    fullNameController.clear();
    notifyListeners();
  }

  void clearPhone() {
    phoneController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.removeListener(_onTextChanged);
    phoneController.removeListener(_onTextChanged);
    fullNameController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
