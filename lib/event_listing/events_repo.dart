import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/constants/storage_constants.dart';

import '../common/widgets.dart';
import '../constants/api_endpoints.dart';
import '../constants/string_constants.dart';
import '../go_live/model/event_details_model.dart';
import 'controller/event_listing_controller.dart';
import 'model/agora_token_generator_model.dart';
import 'model/list_event_model.dart';

class EventsRepo extends GetConnect {
  final store = GetStorage();

  Future<ListEventModel> getEventsListing(
      {EventListingController? controller}) async {
    // ?host_id=HOST302195
    var params = "?host_id=${store.read(userHostId)}";
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await post(
            APIEndpoints.baseUrl + APIEndpoints.listEvents + params,
            headers: {'Authorization': "bearer ${store.read(userToken)}"},
            "");

        showDebugPrint(
            "event listing api url --->  ${APIEndpoints.baseUrl + APIEndpoints.listEvents + params}");

        if (response.statusCode == 200) {
          showDebugPrint(
              "get event listing response----->  ${response.bodyString}");

          return ListEventModel.fromJson(response.body);
        } else {
          return ListEventModel(
              code: response.statusCode, message: somethingWentWrongConst);
        }
      } else {
        return ListEventModel(code: 502, message: noInternetConnectionConst);
      }
    } catch (e) {
      return ListEventModel(code: 502, message: noInternetConnectionConst);
    }
  }

  Future<AgoraTokenGeneratorModel> generateAgoraToken(
      String channelName, String userId, String eventId) async {
    var map = {
      "appID": APIEndpoints.agoraAppId,
      "appCertificate": APIEndpoints.agoraAppCertificates,
      "channelName": channelName,
      "uid": "0",
      "role": "publisher"
    };

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final response =
          await post(APIEndpoints.agoraBaseUrl+APIEndpoints.generateToken, map);
      if (response.statusCode == 200) {
        showDebugPrint(
            "get agora token response----->  ${response.bodyString}");
        return AgoraTokenGeneratorModel.fromJson(response.body);
      } else {
        return AgoraTokenGeneratorModel(
            rtcTokenAccount: "", rtcTokenUID: "", rtmToken: "");
      }
    } else {
      return AgoraTokenGeneratorModel(
          rtcTokenAccount: "", rtcTokenUID: "", rtmToken: "");
    }
  }

  Future<EventDetailModel> getEventDetails(String eventId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await get(
            "${APIEndpoints.baseUrl}${APIEndpoints.eventDetail}/$eventId");

        showDebugPrint(
            "event details api url --->  ${APIEndpoints.baseUrl}${APIEndpoints.eventDetail}/$eventId");

        if (response.statusCode == 200) {
          showDebugPrint(
              "get event details response----->  ${response.bodyString}");

          return EventDetailModel.fromJson(response.body);
        } else {
          return EventDetailModel(
              code: response.statusCode, message: somethingWentWrongConst);
        }
      } else {
        return EventDetailModel(code: 502, message: noInternetConnectionConst);
      }
    } catch (e) {
      return EventDetailModel(code: 502, message: noInternetConnectionConst);
    }
  }

  Future<String> getTokenForViewerCount() async {

    String plainCredentials = "${APIEndpoints.agoraCustomerKey}:${APIEndpoints.agoraCustomerSecretKey}";
    String base64Credentials = base64.encode(utf8.encode(plainCredentials));

    String authorizationHeader = "Basic $base64Credentials";

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response =
            await get("https://api.agora.io/dev/v1/projects", headers: {
          'Authorization': authorizationHeader,
          'Content-Type': "application/json"
        });

        showDebugPrint(
            "token generation api url --->  https://api.agora.io/dev/v1/projects");
        showDebugPrint("token authorizationHeader --->  $authorizationHeader");

        if (response.statusCode == 200) {
          showDebugPrint(
              "token generation api url----->  ${response.bodyString}");

          return authorizationHeader;
        } else {
          return authorizationHeader;
        }
      } else {
        return authorizationHeader;
      }
    } catch (e) {
      return authorizationHeader;
    }
  }
}
