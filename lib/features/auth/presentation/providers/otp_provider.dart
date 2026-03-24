import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpProvider = ChangeNotifierProvider((ref) => OtpProvider());

class OtpProvider extends ChangeNotifier {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  int _secondsRemaining = 30;
  bool _canResend = false;
  Timer? _timer;

  int get secondsRemaining => _secondsRemaining;
  bool get canResend => _canResend;

  // OTP expiry timer (4:56 = 296 seconds)
  int _otpExpireSeconds = 296;
  int get otpExpireMinutes => _otpExpireSeconds ~/ 60;
  int get otpExpireSecondsLeft => _otpExpireSeconds % 60;

  OtpProvider() {
    _startResendTimer();
    _startOtpExpireTimer();
  }

  void _startResendTimer() {
    _secondsRemaining = 30;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _canResend = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  Timer? _otpExpireTimer;
  void _startOtpExpireTimer() {
    _otpExpireTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpExpireSeconds > 0) {
        _otpExpireSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void resendCode() {
    if (_canResend) {
      for (final c in controllers) {
        c.clear();
      }
      _startResendTimer();
    }
  }

  String get otp => controllers.map((c) => c.text).join();

  void triggerNotify() {
    notifyListeners();
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    _otpExpireTimer?.cancel();
    super.dispose();
  }
}

