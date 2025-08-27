import 'dart:async';
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
  Future<Unit> waitForEmailVerification();
  Future<Unit> verifyPhoneNumber(SignUpWithPhoneParams params);
  Future<AuthenticationResponseModel> signUpWithPhone(
      SignUpWithPhoneParams params);
  Future<AuthenticationResponseModel> signUpWithGoogle();
  Future<AuthenticationResponseModel> signUpWithFacebook();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  User? user;
  UserRemoteDataSourceImpl(
      {required this.firebaseAuth,
      required this.client,
      required this.googleSignIn});

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
    return await _sendRegisterRequest(user!, params: params);
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
          throw TooManyRequestsFailure();
        } else {
          throw ServerFailure();
        }
      } catch (e) {
        throw ServerFailure();
      }
    } else {
      throw NoUserFailure();
    }
    return Future.value(unit);
  }

  @override
  Future<Unit> waitForEmailVerification({
    Duration checkInterval = const Duration(seconds: 3),
    Duration timeout = const Duration(minutes: 5),
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw NoUserFailure();
    }

    final stopwatch = Stopwatch()..start();

    while (true) {
      await user.reload(); // Refresh user state
      final refreshedUser = firebaseAuth.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        //TODO: Update user verified to true in database
        return Future.value(unit);
      }

      if (stopwatch.elapsed >= timeout) {
        throw TimeOutFailure();
      }

      await Future.delayed(checkInterval);
    }
  }

  @override
  Future<Unit> verifyPhoneNumber(SignUpWithPhoneParams params) async {
    final requestBody = json.encode({
      "phone": params.phone ?? "",
    });

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/auth/sendVerificationCode'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 409) {
      throw UserAlreadyExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<AuthenticationResponseModel> signUpWithPhone(
      SignUpWithPhoneParams params) async {
    return await _sendRegisterWithPhoneRequest(params);
  }

  @override
  Future<AuthenticationResponseModel> signUpWithGoogle() async {
    try {
      googleSignIn.initialize(serverClientId: kServerClientId);
      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
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
      return await _sendRegisterRequest(user!, authProvider: "google");
    } catch (e) {
      throw ExceptionFailure();
    }
  }

  @override
  Future<AuthenticationResponseModel> signUpWithFacebook() async {
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
    return await _sendRegisterRequest(user!, authProvider: "facebook");
  }

  Future<AuthenticationResponseModel> _sendRegisterRequest(User user,
      {SignUpWithEmailParams? params, String? authProvider}) async {
    Object? requestBody;
    if (params != null) {
      requestBody = json.encode({
        "email": user.email ?? params.email,
        "id": user.uid,
        "name": params.name,
        "phone": user.phoneNumber ?? "",
        "authProvider": params.authProvider
      });
    } else {
      requestBody = json.encode({
        "email": user.email,
        "id": user.uid,
        "name": user.displayName,
        "phone": user.phoneNumber ?? "",
        "authProvider": authProvider
      });
    }

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
    } else if (response.statusCode == 409) {
      throw UserAlreadyExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<AuthenticationResponseModel> _sendRegisterWithPhoneRequest(
      SignUpWithPhoneParams params) async {
    final requestBody = json.encode({
      "phone": params.phone ?? "",
      "name": params.name ?? "",
      "authProvider": params.authProvider,
      "code": params.code
    });

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/auth/verifyCodeAndRegisterWithPhone'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 409) {
      throw UserAlreadyExistsFailure();
    } else {
      throw ServerFailure();
    }
  }
}
