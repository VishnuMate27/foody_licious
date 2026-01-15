import 'package:foody_licious/data/models/cart/cart_item_model.dart';
import 'package:foody_licious/data/models/cart/cart_item_response_model.dart';
import 'package:foody_licious/data/models/cart/cart_items_response_model.dart';
import 'package:foody_licious/data/models/cart/cart_model.dart';
import 'package:foody_licious/data/models/menuItem/menu_item_model.dart';
import 'package:foody_licious/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious/data/models/restaurant/restaurant_model.dart';
import 'package:foody_licious/data/models/restaurant/restaurant_response_model.dart';
import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/domain/usecase/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_in_restaurant_usecase.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';
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
var tSignUpWithEmailParams = SignUpWithEmailParams(
    name: "Test User",
    email: "test@gmail.com",
    password: "testPassword",
    authProvider: "email");
var tSignUpWithPhoneParams = SignUpWithPhoneParams(
    name: "Test User",
    phone: "+9198796543210",
    code: "1234",
    authProvider: "phone");
// Restaurant
const tRestaurantModel = RestaurantModel(
  id: "1R0AVGdoIGeXxPFs1JGoy9eFois1",
  ownerName: "Flutter Dev",
  name: "Anasuya Mata Restaurant",
  email: "meflutterdev@gmail.com",
  phone: "+91",
  authProvider: "google",
  address: AddressModel(
      addressText: "Abc Address",
      city: "Delhi",
      coordinates:
          CoordinatesModel(type: "Point", coordinates: [78.087, 87.098])),
  photoUrl: "",
  description: "",
  menuItems: [],
  receivedOrders: [],
  receivedFeedback: [],
);
var tGetRestaurantDetailsParams =
    GetRestaurantDetailsParams("1R0AVGdoIGeXxPFs1JGoy9eFois1");
var tGetAllItemsInRestaurantsOfUsersCityParams =
    GetAllItemsInRestaurantsOfUsersCityParams(
        userId: "qK3kv062JvQ2NOZrRZYhtl8wX7v2", page: 1, limit: 10);
var tGetAllMenuItemsInRestaurantParams = GetAllMenuItemsInRestaurantParams(
  restaurantId: "1R0AVGdoIGeXxPFs1JGoy9eFois1",
  page: 1,
  limit: 10,
);
var tRestaurantResponseModel =
    RestaurantResponseModel(restaurant: tRestaurantModel);

// MenuItem
const tMenuItemModel = MenuItemModel(
    id: '6905ed15f3fabd415a4a54dd',
    restaurantId: 'pygupNfZONbMeMmBJb2htMxzAR23',
    name: 'Tarri poha',
    description: 'Nagpur\'s pride dish with spicy curry tarri',
    price: 30,
    availableQuantity: 1,
    images: [
      "https://foodylicious.s3.ap-south-1.amazonaws.com/restaurants/pygupNfZONbMeMmBJb2htMxzAR23/menu_items/6905ed15f3fabd415a4a54dd/image_1.jpg"
    ],
    ingredients: [
      "Poha",
      "Tarri",
      "Sev",
      "Onion"
    ]);

const tMenuItem = MenuItem(
    id: '6905ed15f3fabd415a4a54dd',
    restaurantId: 'pygupNfZONbMeMmBJb2htMxzAR23',
    name: 'Tarri poha',
    description: 'Nagpur\'s pride dish with spicy curry tarri',
    price: 30,
    availableQuantity: 1,
    images: [
      "https://foodylicious.s3.ap-south-1.amazonaws.com/restaurants/pygupNfZONbMeMmBJb2htMxzAR23/menu_items/6905ed15f3fabd415a4a54dd/image_1.jpg"
    ],
    ingredients: [
      "Poha",
      "Tarri",
      "Sev",
      "Onion"
    ]);

var tMenuItemsResponseModel = MenuItemsResponseModel(menuItems: [
  tMenuItemModel,
]);

// CartModel
var tCartModel = CartModel(
    id: '6958105007cded6646018078',
    restaurantId: 'pygupNfZONbMeMmBJb2htMxzAR23',
    userId: 'qK3kv062JvQ2NOZrRZYhtl8wX7v2',
    items: [],
    totalAmount: 2200,
    status: 'active');

var tCartItem = CartItem(
    menuItemId: '6905ec15f3fabd415a4a54db',
    quantity: 26,
    price: 15,
    totalPrice: 390);

var tCartItemModel = CartItemModel(
    menuItemId: '6905ec15f3fabd415a4a54db',
    quantity: 26,
    price: 15,
    totalPrice: 390);

// var tCartResponseModel = CartResponseModel(
//   cartItems: [tCartItemModel]
// );

var tCartItemResponseModel = CartItemResponseModel(cartItem: tCartItemModel);

var tCartItemsResponseModel =
    CartItemsResponseModel(cartItems: [tCartItemModel]);

var tGetAllCartItemParams =
    GetAllCartItemParams(userId: '6905ed15f3fabd415a4a54dd', page: 1, limit: 1);

var tAddItemToCartParams = AddItemToCartParams(
  menuItemId: "693866120f0966dedfb943f4",
  restaurantId: "1R0AVGdoIGeXxPFs1JGoy9eFois1",
  userId: "iaqoMindJiPQAa6UHreLq4ielM22",
);

var tDeleteItemInCartParams = DeleteItemInCartParams(
  menuItemId: "693866120f0966dedfb943f4",
  cartId: "69590f62d131470bcb38f7c7",
  userId: "iaqoMindJiPQAa6UHreLq4ielM22",
);

var tIncreaseItemQuantityParams = IncreaseItemQuantityParams(
  menuItemId: "693866120f0966dedfb943f4",
  cartId: "69590f62d131470bcb38f7c7",
  userId: "iaqoMindJiPQAa6UHreLq4ielM22",
);

var tDecreaseItemQuantityParams = DecreaseItemQuantityParams(
  menuItemId: "693866120f0966dedfb943f4",
  cartId: "69590f62d131470bcb38f7c7",
  userId: "iaqoMindJiPQAa6UHreLq4ielM22",
);

var tIncreasedQuantityCartItem = CartItem(
    menuItemId: '6905ec15f3fabd415a4a54db',
    quantity: 27,
    price: 15,
    totalPrice: 390);

var tDecreasedQuantityCartItem = CartItem(
    menuItemId: '6905ec15f3fabd415a4a54db',
    quantity: 25,
    price: 15,
    totalPrice: 390);
