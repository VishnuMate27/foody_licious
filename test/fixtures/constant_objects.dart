import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
import 'package:foody_licious/domain/usecase/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';

//user
const tUserModel = UserModel(
    id: 'foody_licious_001',
    name: 'Foody Licious',
    email: 'test@gmail.com',
    phone: '+919876543210',
    authProvider: 'email',
    address: AddressModel(
        addressText: "Abc Address",
        city: "Delhi",
        coordinates:
            CoordinatesModel(type: "Point", coordinates: [78.087, 87.098])),
    orderHistory: []);

const tAuthenticationResponseModel =
    AuthenticationResponseModel(user: tUserModel);
const tUserResponseModel = UserResponseModel(user: tUserModel);

//params
//User
var tUpdateUserParams = UpdateUserParams(
    id: "RcrNpesIeKSd3afH67ndyDLUaMJ3",
    name: "Test Name",
    phone: "+919876543210");
//Auth
var tSignInWithEmailParams = SignInWithEmailParams(
    email: "test@gmail.com", password: "testPassword", authProvider: "email");
var tSignInWithPhoneParams = SignInWithPhoneParams(
    phone: "+9198796543210", code: "1234", authProvider: "phone");
var tSendPasswordResetEmailParams =
    SendPasswordResetEmailParams(email: "test@gmail.com");
var tSignUpWithEmailParams = SignUpWithEmailParams(name:"Test User", email: "test@gmail.com", password: "testPassword", authProvider: "email");
