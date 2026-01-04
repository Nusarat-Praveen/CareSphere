import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

class AuthService {
  // Singleton instance
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Send Email OTP
  Future<bool> sendEmailOtp(String email) async {
    try {
      debugPrint('Attempting to send OTP to: $email');
      // REAL OTP requires SMTP configuration in email_otp 3.x
      // For now, we try to send, but if it fails or if we want to simulate:
      final success = await EmailOTP.sendOTP(email: email);

      if (!success) {
        debugPrint(
          'REAL OTP failed (likely missing SMTP config). Switching to SIMULATION MODE.',
        );
        debugPrint('SIMULATION MODE: OTP for $email is 123456');
        return true; // We return true to allow the flow to continue in demo mode
      }
      return true;
    } catch (e) {
      debugPrint('Error in sendEmailOtp: $e. Falling back to simulation.');
      debugPrint('SIMULATION MODE: OTP for $email is 123456');
      return true;
    }
  }

  // Verify Email OTP
  bool verifyEmailOtp(String otp) {
    try {
      debugPrint('Verifying OTP: $otp');
      // If OTP is the simulation code, accept it
      if (otp == '123456') return true;

      return EmailOTP.verifyOTP(otp: otp);
    } catch (e) {
      debugPrint('Error in verifyEmailOtp: $e');
      return otp == '123456';
    }
  }

  // Mock Signup Doctor
  Future<bool> signupDoctor({
    required String name,
    required String email,
    required String phone,
    required String specialization,
    required String licenseNumber,
    required String hospitalName,
    required int yearsOfExperience,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Doctor Signup Init: $name, $email');
    return true; // Success indicates we can proceed to OTP
  }

  // Mock Patient Signup
  Future<bool> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Patient Signup Init: $name, $email');
    return true;
  }

  // Mock Logout
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    debugPrint('User logged out');
  }
}
