import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:stream_e_cart/common/size_config.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/app_images.dart';
import 'package:stream_e_cart/go_live/controller/go_live_controller.dart';
import 'package:stream_e_cart/go_live/ui/chat_screen.dart';
import 'package:stream_e_cart/go_live/ui/productListScreen.dart';
import '../../common/widgets.dart';
import '../../constants/string_constants.dart';

// ignore: must_be_immutable
class GoLiveScreen extends StatelessWidget {
  var controller = Get.put(GoLiveController());

  GoLiveScreen(String token, String userId, String eventId, String channelName, String audienceToken, String chatRoomId, {super.key}) {
    controller.streamingToken.value = token;
    controller.uid.value = userId;
    controller.channelName.value = channelName;
    controller.eventId.value = eventId;
    controller.audienceToken.value = audienceToken;
    controller.agoraChatRoomId.value = chatRoomId;

    showDebugPrint("agora token ->  ${controller.streamingToken.value}\n channel name--> ${controller.channelName.value}");

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       controller.backPressButton();
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          SizedBox(
            height: SizeConfig.screenHeight,
            child: Center(child: _videoPanel()),
          ),
          Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4,
              ),
              Row(
                children: [
                  const Spacer(),
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 13,
                      height: SizeConfig.blockSizeVertical * 4,
                      decoration: const BoxDecoration(
                        color: colorRed,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            viewer,
                            width: SizeConfig.blockSizeHorizontal * 4,
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          Obx(
                            () => headingText(
                                controller.viewerCount.value.toString(),
                                SizeConfig.blockSizeHorizontal * 3.8,
                                colorWhite,
                                weight: FontWeight.w500),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 18,
                      height: SizeConfig.blockSizeVertical * 4,
                      decoration: const BoxDecoration(
                        color: colorRed,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            liveCasting,
                            width: SizeConfig.blockSizeHorizontal * 4,
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          headingText(live,
                              SizeConfig.blockSizeHorizontal * 3.8, colorWhite,
                              weight: FontWeight.w500)
                        ],
                      )),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  InkWell(
                    onTap: (){
                      controller.backPressButton();
                    },
                    child: Image.asset(
                      close,
                      width: SizeConfig.blockSizeHorizontal * 8,
                      height: SizeConfig.blockSizeVertical * 8,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4,
                  ),
                ],
              ),
            ],
          ),
          Obx(
            () => Align(
              alignment: controller.isBottomSheetOpen.value == true
                  ? Alignment.centerRight
                  : Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),

                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: SizeConfig.blockSizeHorizontal * 32,
                            height: SizeConfig.blockSizeVertical * 4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(appLogo),
                              fit: BoxFit.cover),


                            ),),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 30,
                              height: SizeConfig.blockSizeVertical * 4,
                              decoration: const BoxDecoration(
                                color: colorRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Center(
                                child: CountdownTimer(
                                  controller: controller.controller,
                                  widgetBuilder: (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return const Text('Time over');
                                    }
                                    return headingText(
                                        "${time.min ?? 0}M ${time.sec}S LEFT",
                                        SizeConfig.blockSizeHorizontal * 3.7,
                                        colorWhite,
                                        weight: FontWeight.w500);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
               InkWell(
                      onTap: () {
                        controller.isBottomSheetOpen.value = true;
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(45.0),
                              ),
                            ),
                            builder: (context) {
                              return bottomSheetWidget();
                            }).whenComplete(() {
                          controller.isBottomSheetOpen.value = false;
                        });
                      },
                      child: Obx(() =>Container(
                        margin: EdgeInsets.only(bottom: controller.isBottomSheetOpen.value == true ? SizeConfig.screenHeight / 8 : 00),
                        child: Image.asset(
                          controller.isBottomSheetOpen.value == true ? downArrow : upArrow,
                          width: SizeConfig.blockSizeHorizontal * 6,
                          height: SizeConfig.blockSizeVertical * 6,
                          color: colorWhite,
                        ),
                      ),),
                    ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _videoPanel() {
    return Obx(() => controller.isLoadingVideoView.value == true
        ?

        // Show local video preview
        AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: controller.agoraEngine.value,
              canvas: const VideoCanvas(uid: 0),
            ),
          )
        : commonLoader());
  }

  Widget bottomSheetWidget() {
    return SizedBox(
      height: SizeConfig.screenHeight / 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                indicatorColor: colorRed,
                labelColor: colorRed,
                unselectedLabelColor: textColor,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.poppins,
                    color: colorRed,
                    fontSize: SizeConfig.blockSizeHorizontal * 3.9),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                tabs: const [
                  Tab(
                    text: chat,
                  ),
                  Tab(
                    text: products,
                  ),
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                ChatScreen(controller.agoraChatRoomId.value),
                ProductListScreen(controller.eventId.value),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
