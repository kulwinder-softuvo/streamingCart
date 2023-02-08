import 'dart:io';

import 'package:get/get.dart';
import 'package:stream_e_cart/constants/api_endpoints.dart';
import 'package:stream_e_cart/go_live/model/audience_model.dart';

import '../common/widgets.dart';

class GoLiveRepo extends GetConnect {
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
}
