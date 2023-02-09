import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/constants/api_endpoints.dart';
import 'package:stream_e_cart/constants/storage_constants.dart';
import 'package:stream_e_cart/go_live/model/agora_register_model.dart';
import 'package:stream_e_cart/go_live/model/audience_model.dart';
import 'package:stream_e_cart/go_live/model/chat_token_model.dart';

import '../common/widgets.dart';

class GoLiveRepo extends GetConnect {
  final store = GetStorage();

  Future<AudienceModel> getTotalAudienceCount(
      String channelName, String audienceToken) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await get(
            "https://api.agora.io/dev/v1/channel/user/${APIEndpoints.agoraAppId}/$channelName",
            headers: {'Authorization': audienceToken});

        showDebugPrint(
            "get audience api url --->  https://api.agora.io/dev/v1/channel/user/${APIEndpoints.agoraAppId}/$channelName");

        if (response.statusCode == 200) {
          showDebugPrint(
              "get audience api response----->  ${response.bodyString}");

          return AudienceModel.fromJson(response.body);
        } else {
          return AudienceModel(success: false);
        }
      } else {
        return AudienceModel(success: false);
      }
    } catch (e) {
      return AudienceModel(success: false);
    }
  }


  Future<ChatTokenModel> getChatToken(
      String userId) async {
    var map = {
      "appId": APIEndpoints.agoraAppId,
      "appCertificate": APIEndpoints.agoraAppCertificates,
      "userUuid": userId,

    };
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await post(
            "https://agorastream.softuvo.click/generateChatToken",
              map);

        showDebugPrint(
            "get chat token api url --->  https://agorastream.softuvo.click/generateChatToken");

        if (response.statusCode == 200) {
          showDebugPrint(
              "get chat token api response----->  ${response.bodyString}");

          return ChatTokenModel.fromJson(response.body);
        } else {
          return ChatTokenModel();
        }
      } else {
        return ChatTokenModel();
      }
    } catch (e) {
      return ChatTokenModel();
    }
  }

 Future<AgoraRegisterModel> agoraRegisterUser(
      String appToken, String userId) async {
    var map = {
      "username": userId,
      "password": "123456",
      "nickname": store.read(userName)
    };

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await post(
            "https://${APIEndpoints.agoraHostRestApi}/${APIEndpoints.agoraOrgName}/${APIEndpoints.agoraAppName}/users",
            headers: {'Content-Type': "application/json",
              'Authorization': "Bearer $appToken"},
              map);

        showDebugPrint(
            "  api url --->  https://${APIEndpoints.agoraHostRestApi}/${APIEndpoints.agoraOrgName}/${APIEndpoints.agoraAppName}/users \n params: $map");

        if (response.statusCode == 200) {
          showDebugPrint(
              "get register user api response----->  ${response.bodyString}");

          return AgoraRegisterModel.fromJson(response.body);
        } else {
          return AgoraRegisterModel();
        }
      } else {
        return AgoraRegisterModel();
      }
    } catch (e) {
      return AgoraRegisterModel();
    }
  }


}
