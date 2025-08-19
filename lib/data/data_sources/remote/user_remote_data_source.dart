import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final FirebaseAuth firebaseAuth;
  User? user;
  GoogleSignIn googleSignIn = GoogleSignIn.instance;
  UserRemoteDataSourceImpl({required this.firebaseAuth, required this.client});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    // final response =
    //     await client.post(Uri.parse('$baseUrl/authentication/local/sign-in'),
    //         headers: {
    //           'Content-Type': 'application/json',
    //         },
    //         body: json.encode({
    //           'identifier': params.username,
    //           'password': params.password,
    //         }));
    // if (response.statusCode == 200) {
    //   return authenticationResponseModelFromJson(response.body);
    return authenticationResponseModelFromJson("");
    // } else if (response.statusCode == 400 || response.statusCode == 401) {
    //   throw CredentialFailure();
    // } else {
    //   throw ServerException();
    // }
  }

  @override
  Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
    User? user;

    if (params.authProvider == "email") {
      // Create user
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email!,
        password: params.password!,
      );
      user = userCredential.user;

      // Send verification mail
      await user?.sendEmailVerification().then((value){
  

      });

      // Refresh user (to get latest status)
      // await user?.reload();
      // user = firebaseAuth.currentUser;

      // // Check verification
      // if (user == null || !user.emailVerified) {
      //   throw Exception("Please verify your email first.");
      // }

      // Now call backend
      return await _sendRegisterRequest(user!, params);
    } else if (params.authProvider == "phone") {
      // Phone verification
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91${params.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          final phoneCredentials =
              await firebaseAuth.signInWithCredential(credential);
          user = phoneCredentials.user;
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception("Phone verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Normally ask user to input OTP
          String smsCode = '123456'; // ⚠️ Replace with user input!

          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          final phoneCredentials =
              await firebaseAuth.signInWithCredential(credential);
          user = phoneCredentials.user;

          // if (user != null) {
          //   return await _sendRegisterRequest(user, params);
          // }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      // Fallback: if callback didn't return
      if (user == null) {
        throw Exception("Phone verification did not complete.");
      }
      return await _sendRegisterRequest(user!, params);
    } else if (params.authProvider == "google") {
      try {
        googleSignIn.initialize(serverClientId: kServerClientId);
        final GoogleSignInAccount? googleUser =
            await googleSignIn.authenticate();
        if (googleUser == null) {
          throw Exception("Google authentication cancelled.");
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        final userCredential =
            await firebaseAuth.signInWithCredential(credential);
        user = userCredential.user;

        if (user == null) throw Exception("Google sign-in failed.");
        return await _sendRegisterRequest(user, params);
      } catch (e) {
        throw Exception("Google SignIn failed: $e");
      }
    } else if (params.authProvider == "facebook") {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status != LoginStatus.success) {
        throw Exception("Facebook login failed.");
      }

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      final userCredential =
          await firebaseAuth.signInWithCredential(facebookAuthCredential);
      user = userCredential.user;

      if (user == null) throw Exception("Facebook sign-in failed.");
      return await _sendRegisterRequest(user, params);
    }

    throw Exception("Unsupported auth provider: ${params.authProvider}");
  }

  Future<AuthenticationResponseModel> _sendRegisterRequest(
      User user, SignUpParams params) async {
    final requestBody = json.encode({
      "email": user.email ?? params.email,
      "id": user.uid,
      "name": params.name,
      "phone": user.phoneNumber ?? params.phone ?? "",
      "authProvider": params.authProvider
    });

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }
}
