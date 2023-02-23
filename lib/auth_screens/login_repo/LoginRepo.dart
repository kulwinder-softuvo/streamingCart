import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/auth_screens/model/default_model.dart';
import 'package:stream_e_cart/common/widgets.dart';

import '../../constants/api_endpoints.dart';
import '../../constants/storage_constants.dart';
import '../../constants/string_constants.dart';
import '../controller/login_controller.dart';
import '../model/login_model.dart';

class LoginRepo extends GetConnect {
  final store = GetStorage();

  Future<LoginModel> loginUser(
      {String? hostId,
      String? email,
      String? password,
      LoginController? controller}) async {
    // ?email=kulwinder@yopmail.com&password=123456&host_id=HOST302195
    var params = "?email=$email&password=$password&host_id=$hostId";
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response =
            await post(APIEndpoints.baseUrl + APIEndpoints.login + params, "");

        showDebugPrint(
            "Login api url --->  ${APIEndpoints.baseUrl + APIEndpoints.login + params}");

        if (response.statusCode == 200) {
          showDebugPrint("get Login response----->  ${response.bodyString}");

          return LoginModel.fromJson(response.body);
        } else {
          return LoginModel(
              code: response.statusCode, message: response.statusText);
        }
      } else {
        return LoginModel(code: 502, message: noInternetConnectionConst);
      }
    } catch (e) {
      return LoginModel(code: 502, message: noInternetConnectionConst);
    }
  }

  Future<DefaultModel> logoutUser() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await post(
            APIEndpoints.baseUrl + APIEndpoints.logout,
            headers: {'Authorization': "bearer ${store.read(userToken)}"},
            "");

        showDebugPrint(
            "logout api url --->  ${APIEndpoints.baseUrl + APIEndpoints.logout}");

        if (response.statusCode == 200) {
          showDebugPrint("get logout response----->  ${response.bodyString}");

          return DefaultModel.fromJson(response.body);
        } else {
          return DefaultModel(success: false, message: somethingWentWrongConst);
        }
      } else {
        return DefaultModel(success: false, message: noInternetConnectionConst);
      }
    } catch (e) {
      return DefaultModel(success: false, message: noInternetConnectionConst);
    }
  }
}
