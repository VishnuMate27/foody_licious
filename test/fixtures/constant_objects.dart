import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
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
const tUserResponseModel =
    UserResponseModel(user: tUserModel);

//params
var tUpdateUserParams = UpdateUserParams(id: "RcrNpesIeKSd3afH67ndyDLUaMJ3", name: "Test Name", phone: "+919876543210");
