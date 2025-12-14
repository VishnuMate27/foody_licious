import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/models/menuItem/menu_items_response_model.dart';
import 'package:http/http.dart' as http;

abstract class MenuItemsRemoteDataSource {
  Future<MenuItemsResponseModel> getAllItemsInRestaurantsOfUsersCity(
      GetAllItemsInRestaurantsOfUsersCityParams params);
}

class MenuItemsRemoteDataSourceImpl extends MenuItemsRemoteDataSource {
  final http.Client client;
  MenuItemsRemoteDataSourceImpl({required this.client});

  @override
  Future<MenuItemsResponseModel> getAllItemsInRestaurantsOfUsersCity(GetAllItemsInRestaurantsOfUsersCityParams params) {
    return sendGetAllItemsInRestaurantsOfUsersCityRequest(params);
  }

  Future<MenuItemsResponseModel> sendGetAllItemsInRestaurantsOfUsersCityRequest(
    GetAllItemsInRestaurantsOfUsersCityParams params,
  ) async {
    final response = await client.get(
      Uri.parse(
        "$kBaseUrl/api/users/menuItems/allItems?user_id=${params.userId}&page=${params.page}&page_size=${params.limit}",
      ),
    );
    if (response.statusCode == 200) {
      return menuItemsResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
  }
}
