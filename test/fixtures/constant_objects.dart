import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/models/user/user_model.dart';

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
// //params
// const tSignInParams = SignInParams(username: 'username', password: 'password');
// const tSignUpParams = SignUpParams(
//     firstName: 'firstName',
//     lastName: 'lastName',
//     email: 'email',
//     password: 'password');
