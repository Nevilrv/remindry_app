import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createAccountProvider = ChangeNotifierProvider((ref) => CreateAccountProvider());

class CreateAccountProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  
  bool _showClearButton = false;
  Country _selectedCountry = Country(
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

  bool get showClearButton => _showClearButton;
  Country get selectedCountry => _selectedCountry;

  CreateAccountProvider() {
    phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final show = phoneController.text.isNotEmpty;
    if (show != _showClearButton) {
      _showClearButton = show;
      notifyListeners();
    }
  }

  void setCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void clearPhone() {
    phoneController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.removeListener(_onPhoneChanged);
    phoneController.dispose();
    super.dispose();
  }
}

