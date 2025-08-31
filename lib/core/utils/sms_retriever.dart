import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsRetrieverApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsWithUserConsentApi();
    if (res.hasData && res.data != null) {
      final message = res.data!.sms ?? '';
      final otpMatch = RegExp(r'\d{4}').firstMatch(message);
      final otp = otpMatch?.group(0);
      return otp;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
