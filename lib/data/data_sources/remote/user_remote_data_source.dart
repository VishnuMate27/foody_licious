import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_phone_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<AuthenticationResponseModel> signUpWithEmail(
      SignUpWithEmailParams params);
  Future<Unit> sendVerificationEmail();    
  Future<Unit> signUpWithPhone(SignUpWithPhoneParams params);
  Future<AuthenticationResponseModel> signUpWithGoogle(
      SignUpWithEmailParams params);
  Future<AuthenticationResponseModel> signUpWithFacebook(
      SignUpWithEmailParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final FirebaseAuth firebaseAuth;
  User? user;
  GoogleSignIn googleSignIn = GoogleSignIn.instance;
  String _verificationId = "";
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
  Future<AuthenticationResponseModel> signUpWithEmail(
      SignUpWithEmailParams params) async {
    User? user;
    // Create user
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email!,
      password: params.password!,
    );
    user = userCredential.user;
    return await _sendRegisterRequest(user!, params);
  }

  @override
  Future<Unit> signUpWithPhone(SignUpWithPhoneParams params) async {
    return Future.value(unit);
  }

  @override
  Future<AuthenticationResponseModel> signUpWithGoogle(
      SignUpWithEmailParams params) async {
    return await _sendRegisterRequest(user!, params);
  }

  @override
  Future<AuthenticationResponseModel> signUpWithFacebook(
      SignUpWithEmailParams params) async {
    return await _sendRegisterRequest(user!, params);
  }

  Future<AuthenticationResponseModel> _sendRegisterRequest(
      User user, SignUpWithEmailParams params) async {
    final requestBody = json.encode({
      "email": user.email ?? params.email,
      "id": user.uid,
      "name": params.name,
      "phone": user.phoneNumber ?? "",
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

  @override
  Future<Unit> sendVerificationEmail() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.reload();
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          throw TooManyRequestsException();
        } else {
          throw ServerException();
        }
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw NoUserException();
    }
    return Future.value(unit);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authCredential) {
      print("phone is verified : token ${authCredential.token}");
    };
    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException authCredential) {
      print("phone failed ${authCredential.message},${authCredential.code}");
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
      print("time out $verificationId");
    };
    final PhoneCodeSent phoneCodeSent =
        (String verificationID, [int? forceResendingToken]) {
      this._verificationId = verificationID;
      print("sendPhoneCode $verificationID");
    };

    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }
}
