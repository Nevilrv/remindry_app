import 'dart:ui';

import 'package:go_router/go_router.dart';
import 'package:untitled1/features/auth/presentation/pages/create_account_page.dart';
import 'package:untitled1/features/auth/presentation/pages/login_page.dart';
import 'package:untitled1/features/auth/presentation/pages/set_permissions_page.dart';
import 'package:untitled1/features/auth/presentation/pages/verify_code_page.dart';
import 'package:untitled1/features/home/presentation/pages/dashboard/ai_message_page.dart';
import 'package:untitled1/features/home/presentation/pages/dashboard/ai_start_page.dart'
    show AiStartPage;
import 'package:untitled1/features/home/presentation/pages/dashboard/ai_start_page.dart';
import 'package:untitled1/features/home/presentation/pages/dashboard/main_dashboard.dart';
import 'package:untitled1/features/home/presentation/pages/events/add_event_page.dart';
import 'package:untitled1/features/home/presentation/pages/events/events_page.dart';
import 'package:untitled1/features/home/presentation/pages/expense/add_expense_page.dart';
import 'package:untitled1/features/home/presentation/pages/health/add_visit_page.dart';
import 'package:untitled1/features/home/presentation/pages/health/health_care_page.dart';
import 'package:untitled1/features/home/presentation/pages/reminder/add_reminder_page.dart';
import 'package:untitled1/features/home/presentation/pages/reminder/reminder_details_page.dart';
import 'package:untitled1/features/home/presentation/pages/reminder/reminders_see_all_page.dart';
import 'package:untitled1/features/home/presentation/pages/vault/review_document_page.dart';
import 'package:untitled1/features/home/presentation/pages/vault/scan_document_page.dart';
import 'package:untitled1/features/home/presentation/pages/warranty/add_warranty_page.dart';
import 'package:untitled1/features/home/presentation/pages/warranty/warranties_page.dart';
import 'package:untitled1/features/notification/notification_screen.dart';
import 'package:untitled1/features/subscription/presentation/pages/go_premium_screen.dart';

import '../features/home/presentation/pages/health/health_care_page.dart'
    show HealthCarePage;
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/onboarding/presentation/pages/splash_screen.dart';
import '../features/profile/screen/edit_full_name_screen.dart';
import '../features/profile/screen/edit_phone_number_screen.dart';
import '../features/profile/screen/profile_screen.dart';
import '../features/settings/presentation/pages/privacy_policy_screen.dart';
import '../features/settings/presentation/pages/settings_screen.dart';
import '../features/settings/presentation/pages/terms_and_conditions_screen.dart';

class AppRoutes {
  static const String initial = "/";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String createAccount = "/createAccount";
  static const String verifyCode = "/verifyCode";
  static const String setPermissions = "/setPermissions";
  static const String home = "/home";
  static const String aiStart = "/aiStart";
  static const String aiMessage = "/aiMessage";
  static const String scanDocument = "/scanDocument";
  static const String reviewDocument = "/reviewDocument";
  static const String addReminder = "/addReminder";
  static const String events = "/events";
  static const String addEvent = "/addEvent";
  static const String healthCare = "/healthCare";
  static const String addVisit = "/addVisit";
  static const String warranties = "/warranties";
  static const String addWarranty = "/addWarranty";
  static const String notification = "/notification";
  static const String reminderDetails = "/reminderDetails";
  static const String remindersSeeAll = "/remindersSeeAll";
  static const String addExpense = "/addExpense";
  static const String profile = "/profile";
  static const String editFullName = "/editFullName";
  static const String editPhoneNumber = "/editPhoneNumber";
  static const String settings = "/settings";
  static const String privacyPolicy = "/privacyPolicy";
  static const String termsAndConditions = "/termsAndConditions";
  static const String goPremium = "/goPremium";

  static final router = GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: initial,
        name: initial,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        name: onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: login,
        name: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: createAccount,
        name: createAccount,
        builder: (context, state) => const CreateAccountPage(),
      ),
      GoRoute(
        path: verifyCode,
        name: verifyCode,
        builder: (context, state) {
          final isFromProfile = state.extra as bool? ?? false;
          return VerifyCodePage(isFromProfile: isFromProfile);
        },
      ),
      GoRoute(
        path: setPermissions,
        name: setPermissions,
        builder: (context, state) => const SetPermissionsPage(),
      ),
      GoRoute(
        path: home,
        name: home,
        builder: (context, state) => const MainDashboard(),
      ),
      GoRoute(
        path: addReminder,
        name: addReminder,
        builder: (context, state) => const AddReminderPage(),
      ),
      GoRoute(
        path: events,
        name: events,
        builder: (context, state) => const EventsPage(),
      ),
      GoRoute(
        path: addEvent,
        name: addEvent,
        builder: (context, state) => const AddEventPage(),
      ),
      GoRoute(
        path: healthCare,
        name: healthCare,
        builder: (context, state) => const HealthCarePage(),
      ),
      GoRoute(
        path: addVisit,
        name: addVisit,
        builder: (context, state) => const AddVisitPage(),
      ),
      GoRoute(
        path: warranties,
        name: warranties,
        builder: (context, state) => const WarrantiesPage(),
      ),
      GoRoute(
        path: addWarranty,
        name: addWarranty,
        builder: (context, state) => const AddWarrantyPage(),
      ),
      GoRoute(
        path: reminderDetails,
        name: reminderDetails,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return ReminderDetailsPage(
            icon: extra['icon'] as String,
            iconBgColor: extra['iconBgColor'] as Color,
            iconColor: extra['iconColor'] as Color,
            title: extra['title'] as String,
            subtitle: extra['subtitle'] as String,
          );
        },
      ),
      GoRoute(
        path: remindersSeeAll,
        name: remindersSeeAll,
        builder: (context, state) => const RemindersSeeAllPage(),
      ),
      GoRoute(
        path: aiStart,
        name: aiStart,
        builder: (context, state) => const AiStartPage(),
      ),
      GoRoute(
        path: aiMessage,
        name: aiMessage,
        builder: (context, state) => const AiMessagePage(),
      ),
      GoRoute(
        path: scanDocument,
        name: scanDocument,
        builder: (context, state) => const ScanDocumentPage(),
      ),
      GoRoute(
        path: reviewDocument,
        name: reviewDocument,
        builder: (context, state) => const ReviewDocumentPage(),
      ),
      GoRoute(
        path: notification,
        name: notification,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: addExpense,
        name: addExpense,
        builder: (context, state) => const AddExpensePage(),
      ),
      GoRoute(
        path: profile,
        name: profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: editFullName,
        name: editFullName,
        builder: (context, state) => const EditFullNameScreen(),
      ),
      GoRoute(
        path: editPhoneNumber,
        name: editPhoneNumber,
        builder: (context, state) => const EditPhoneNumberScreen(),
      ),
      GoRoute(
        path: settings,
        name: settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: privacyPolicy,
        name: privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: termsAndConditions,
        name: termsAndConditions,
        builder: (context, state) => const TermsAndConditionsScreen(),
      ),
      GoRoute(
        path: goPremium,
        name: goPremium,
        builder: (context, state) => const GoPremiumScreen(),
      ),
    ],
  );
}
