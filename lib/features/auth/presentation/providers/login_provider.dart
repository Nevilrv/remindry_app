import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/services/prefrense_services.dart';

import '../../../../core/constant/api_const.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/api_services.dart';
import '../../model/user_data_model.dart';

final loginProvider = ChangeNotifierProvider.autoDispose((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
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

  LoginProvider() {
    phoneController.addListener(_onTextChanged);
    clearAll();
  }

  void clearAll() {
    phoneController.clear();
    notifyListeners();
  }

  void _onTextChanged() {
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

  login({required String countryCode, required String phoneNumber, required BuildContext context}) async {
    String? token = await FirebaseMessaging.instance.getToken();

    ApiResponse<UserResponse> response = await ApiService().post(
      ApiConsts.loginAccount,
      data: {"country_code": "+${countryCode}", "phone_number": phoneNumber, "fcm_token": token},
      fromJson: (json) => UserResponse.fromJson(json),
    );

    if (response.statusCode == 200) {
      await preferences.setUserData(response.data!);
      await preferences.setString(SharedPreference.accessToken, response.data?.data?.token ?? "");
      preferences.setBool(SharedPreference.login, true);
      context.pushNamed(AppRoutes.verifyCode);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Failed to create account")));
    }
  }

  @override
  void dispose() {
    phoneController.removeListener(_onTextChanged);
    phoneController.dispose();
    super.dispose();
  }
}
