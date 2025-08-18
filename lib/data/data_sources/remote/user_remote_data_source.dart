import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
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
    if (params.authProvider == "email") {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: params.email!, password: params.password!);
      user = userCredential.user;
      await user?.sendEmailVerification();
    } else if (params.authProvider == "phone") {
      final confirmationResult = await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91${params.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign the user in (or link) with the auto-generated credential
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = '123456';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await firebaseAuth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      //final user = confirmationResult.confirm("");
    } else if (params.authProvider == "google") {
      // Trigger the authentication flow
      try {
        googleSignIn.initialize(
          serverClientId: kServerClientId,
        );
        final GoogleSignInAccount? googleUser =
            await googleSignIn.authenticate();
        if (googleUser == null) print("Authuser is null");
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            googleUser?.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
        );
        // Once signed in, return the UserCredential
        final userCredential =
            await firebaseAuth.signInWithCredential(credential);
        final user = userCredential.user;
      } catch (e) {
        print("Exception ${e}");
      }
    } else if (params.authProvider == "facebook") {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      final userCredential =
          await firebaseAuth.signInWithCredential(facebookAuthCredential);

      final user = userCredential.user;
    }
    print({
        "id": user!.uid,
        "name": user!.displayName ?? params.name,
        "email": params.email ?? "",
        params.phone ?? "phone": params.phone,
        "authProvider": params.authProvider
      });
    final response = await client.post(
      Uri.parse('$kBaseUrl/api/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "id": user!.uid,
        "name": user!.displayName ?? params.name,
        "email": params.email ?? "",
        "phone": "0123456788",
        "authProvider": params.authProvider
      }),
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
