import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:untitled1/core/constant/app_theme.dart';
import 'package:untitled1/services/notification_services.dart';
import 'package:untitled1/services/prefrense_services.dart';
import 'package:untitled1/services/socket_services.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreference().init();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  NotificationServices().initlizedNotification();
  NotificationServices().getPermission();
  
  // Connect to socket if user is already logged in
  if (preferences.getBool(SharedPreference.login) ?? false) {
    SocketService().connect();
  }

  String? fcmToken = '';
  try {
    fcmToken = await FirebaseMessaging.instance.getToken();
    log("fcmToken--------------> $fcmToken");
  } catch (e) {
    log('e============fcmToken==>>>$e');
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(
    ProviderScope(
      child: GlobalLoaderOverlay(
        overlayWidgetBuilder: (_) {
          return const Center(child: CupertinoActivityIndicator(radius: 10, color: AppColors.primaryDark));
        },
        child: MyApp(),
      ),
    ),
  );
}
