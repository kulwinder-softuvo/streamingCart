import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_e_cart/common/widgets.dart';
import 'package:stream_e_cart/event_listing/controller/event_listing_controller.dart';
import 'package:stream_e_cart/event_listing/ui/event_listing_screen.dart';
import 'package:stream_e_cart/go_live/go_live_repo.dart';
import '../../common/size_config.dart';
import '../../constants/api_endpoints.dart';
import '../../constants/app_colors.dart';
import '../../constants/string_constants.dart';
import 'chat_controller.dart';

class GoLiveController extends GetxController {
  var channelName = "".obs;
  var streamingToken = "".obs;
  var eventId = "".obs;
  var audienceToken = "".obs;
  var agoraChatRoomId = "".obs;
  var showLoader = false.obs;
  var uid = "0".obs; // uid of the local user
  var remoteUid = "".obs; // uid of the remote user
  var isHost =
      true.obs; // Indicates whether the user has joined as a host or audience
  var agoraEngine = createAgoraRtcEngine().obs;
  var isLoadingVideoView = false.obs;
  var viewerCount = 0.obs;
  int endStreamingTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(minutes: 30).inMilliseconds;
  late CountdownTimerController controller;
  var isBottomSheetOpen = false.obs;


  @override
  void onInit() {
    controller =
        CountdownTimerController(endTime: endStreamingTime, onEnd: onEnd);
    setupVideoSDKEngine();
    super.onInit();
  }

  void onEnd() {
    endStreamingTime = DateTime.now().millisecondsSinceEpoch +
        const Duration(minutes: 30).inMilliseconds;
    showHostingTimeOutDialog();
    Future.delayed(const Duration(seconds: 3), () {
      backPressButton();
    });
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
 //   agoraEngine = createAgoraRtcEngine();
    await agoraEngine.value.initialize(const RtcEngineContext(
      appId: APIEndpoints.agoraAppId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    isLoadingVideoView.value = true;

    agoraEngine.value.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
        },
        onUserJoined: (RtcConnection connection, int remoteUid1, int elapsed) {
          debugPrint("remote user $remoteUid1 joined");
          remoteUid.value = remoteUid.toString();
        },
        onUserOffline: (RtcConnection connection, int remoteUid1,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid1 left channel");
          remoteUid.value = "";
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await agoraEngine.value.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await agoraEngine.value.enableVideo();

    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    );

    await agoraEngine.value.startPreview();

    await agoraEngine.value.joinChannel(
      token: streamingToken.value,
      channelId: channelName.value,
      uid: 0,
      options: options,
    );
      getAudienceCountApi();
  }

  void leave() {
    remoteUid.value = "";
    viewerCount.value = 0;
    agoraEngine.value.leaveChannel();
  }

  void getAudienceCountApi() {

    GoLiveRepo().getTotalAudienceCount(channelName.value, audienceToken.value).then((value) async {

      if (value.success == true) {
        if (value.data != null) {
          viewerCount.value = int.parse(value.data!.audienceTotal.toString());

          Future.delayed(const Duration(seconds: 15), () {
            getAudienceCountApi();
          });
        }
      } else {
        return;
      }
    });
  }

  void showHostingTimeOutDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        content: SizedBox(
            width: SizeConfig.screenWidth / 1.5,
            height: SizeConfig.blockSizeVertical * 14,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  headingText(opsYourStreamingTimeIsOver,
                      SizeConfig.blockSizeHorizontal * 3.6, colorBlack,
                      weight: FontWeight.w500),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 15.0,
                        ),
                        child: SizedBox(
                            width: SizeConfig.screenWidth / 5,
                            height: SizeConfig.blockSizeVertical * 4,
                            child: Center(
                                child: headingText(
                                    ok,
                                    SizeConfig.blockSizeHorizontal * 4,
                                    colorWhite)))),
                  ),

                ])),
      ),
    );
  }

  Future<void> backPressButton() async {
    await agoraEngine.value.leaveChannel();
    agoraEngine.value.release();
    leave();
    Get.delete<GoLiveController>();
    Get.delete<ChatController>();
    Get.delete<EventListingController>();
    Get.back();
    Get.to(() => EventListingScreen());
  }
}
