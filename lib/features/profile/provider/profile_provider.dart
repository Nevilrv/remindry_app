import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/services/api_services.dart';
import 'package:untitled1/services/prefrense_services.dart';

import '../../../../core/constant/api_const.dart';
import '../../../routes/app_routes.dart' show AppRoutes;
import '../../auth/presentation/providers/create_account_provider.dart';
import '../../auth/presentation/providers/login_provider.dart';
import '../../auth/presentation/providers/otp_provider.dart';
import '../../home/presentation/providers/home_provider.dart';
import '../../settings/presentation/providers/settings_provider.dart';

final profileProvider = ChangeNotifierProvider.autoDispose((ref) {
  final homeData = ref.read(homeProvider);
  return ProfileProvider(homeData, ref);
});

class ProfileProvider extends ChangeNotifier {
  final Ref ref;
  final HomeProvider homeData;
  TextEditingController fullNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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

  ProfileProvider(this.homeData, this.ref) {
    initializeFromHome(homeData);
    
    // Add listener to homeData to catch profile updates
    homeData.addListener(_homeListener);

    // If data is missing and not currently loading, trigger a fetch
    if (homeData.profileData == null && !homeData.isLoading) {
      Future.microtask(() => homeData.fetchProfile());
    }

    // Listeners for bi-directional sync
    fullNameController.addListener(_onFullNameChanged);
    firstNameController.addListener(_onPartsChanged);
    lastNameController.addListener(_onPartsChanged);
    phoneController.addListener(() => notifyListeners());
  }

  void _homeListener() {
    initializeFromHome(homeData);
  }

  void initializeFromHome(HomeProvider homeData) {
    if (homeData.profileData?.data == null) return;
    
    final data = homeData.profileData!.data!;
    
    // Only initialize if controllers are currently empty to avoid overwriting user input
    // and ensure we actually have data to set.
    if (firstNameController.text.isEmpty && data.firstName != null) {
      firstNameController.text = data.firstName!;
    }
    if (lastNameController.text.isEmpty && data.lastName != null) {
      lastNameController.text = data.lastName!;
    }
    
    // If parts are now set, update full name if it's still empty
    if (fullNameController.text.isEmpty) {
      final name = "${firstNameController.text} ${lastNameController.text}".trim();
      if (name.isNotEmpty) {
        fullNameController.text = name;
      }
    }
    
    selectedGender = data.gender ?? "Male";
    
    if (phoneController.text.isEmpty && data.phoneNumber != null) {
      phoneController.text = data.phoneNumber!;
    }
    
    notifyListeners();
  }

  bool _isUpdating = false;

  void _onFullNameChanged() {
    if (_isUpdating) return;
    _isUpdating = true;
    final name = fullNameController.text;
    final parts = name.trim().split(' ');
    if (parts.isNotEmpty) {
      firstNameController.text = parts[0];
      if (parts.length > 1) {
        lastNameController.text = parts[1];
      } else {
        lastNameController.clear();
      }
    } else {
      firstNameController.clear();
      lastNameController.clear();
    }
    _isUpdating = false;
    notifyListeners();
  }

  void _onPartsChanged() {
    if (_isUpdating) return;
    _isUpdating = true;
    final newFullName = "${firstNameController.text} ${lastNameController.text}".trim();
    if (fullNameController.text != newFullName) {
      fullNameController.text = newFullName;
    }
    _isUpdating = false;
    notifyListeners();
  }

  void editNameChange({required String fullName}) {
    fullNameController.text = fullName;
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

  bool isLoading = false;

  Future<void> updateProfile(BuildContext context, WidgetRef ref) async {
    if (firstNameController.text.trim().isEmpty || lastNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().put(
        ApiConsts.upgradeProfile,
        data: {
          "first_name": firstNameController.text.trim(),
          "last_name": lastNameController.text.trim(),
          "gender": selectedGender.toLowerCase(),
        },
      );

      if (response.isSuccess) {
        // Refresh home profile data
        await ref.read(homeProvider).fetchProfile();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated successfully")));
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Update failed")));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePhoneNumber(BuildContext context, WidgetRef ref) async {
    if (phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().put(
        ApiConsts.upgradeNumber,
        data: {"country_code": "+${selectedCountry.phoneCode}", "phone_number": phoneController.text.trim()},
      );

      if (response.isSuccess) {
        // Refresh home profile data
        await ref.read(homeProvider).fetchProfile();
        if (context.mounted) {
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone number updated successfully")));
          context.pushNamed(AppRoutes.verifyCode, extra: true);

          // Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Update failed")));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().delete(ApiConsts.deleteProfile);

      if (response.isSuccess) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account deleted successfully")));
          preferences.clear();
          
          // Invalidate providers to clear state
          ref.invalidate(loginProvider);
          ref.invalidate(createAccountProvider);
          ref.invalidate(otpProvider);
          ref.invalidate(settingsProvider);
          ref.invalidate(homeProvider);

          context.goNamed(AppRoutes.login);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Delete failed")));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logoutAccount(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().post(ApiConsts.logout);

      if (response.isSuccess) {
        // Clear Preferences
        await preferences.clear();
        
        // Invalidate providers to clear state
        ref.invalidate(loginProvider);
        ref.invalidate(createAccountProvider);
        ref.invalidate(otpProvider);
        ref.invalidate(settingsProvider);
        ref.invalidate(homeProvider);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged out successfully")));
          context.goNamed(AppRoutes.login);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Logout failed")));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool _isDisposed = false;

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    homeData.removeListener(_homeListener);
    fullNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
