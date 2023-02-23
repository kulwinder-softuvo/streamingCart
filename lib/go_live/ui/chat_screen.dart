import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_e_cart/common/widgets.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/app_images.dart';
import 'package:stream_e_cart/go_live/controller/chat_controller.dart';
import 'package:stream_e_cart/go_live/model/chat_model.dart';

import '../../common/size_config.dart';
import '../../constants/string_constants.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  var controller = Get.put(ChatController());

  ChatScreen(String chatRoomId, {super.key}){
    controller.agoraChatRoomId.value = chatRoomId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      body: Column(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 31,
            child: Obx (() => controller.chatList.isNotEmpty ? SingleChildScrollView(
              child: ListView.builder(
                controller: controller.scrollController.value,
                itemCount: controller.chatList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                itemBuilder: (context, index) {
                  return chatRowItem(controller.chatList[index], index);
                },
              ),
            ) : Center(
              child: headingText(chatIsNotStartedYet ,   SizeConfig.blockSizeHorizontal * 4, colorGrey, weight: FontWeight.w500),
            ),
          ),),

          Container(
              height: SizeConfig.blockSizeVertical * 6.5,
              decoration: const BoxDecoration(
                  color: colorLightGreyBg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  )),
              margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10  ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: controller.chatController,
                  cursorColor: colorRed,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: colorBlack),
                  decoration: InputDecoration(
                    hintText: typeHere,
                    hintStyle: const TextStyle(color: colorGrey),
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    suffixIcon: InkWell(
                      onTap: () {
                        controller.sendMessage();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Container(
                        width: SizeConfig.blockSizeVertical * 1,
                        height: SizeConfig.blockSizeVertical * 1,
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(greyCircle),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            send,
                            width: SizeConfig.blockSizeVertical * 3,
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chatRowItem(ChatModel chatList, int index) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        children: [
          headingText(
              chatList.name.toString(),
              SizeConfig.blockSizeHorizontal * 3.8,
              chatList.color,
              weight: FontWeight.w600),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 3,
          ),
          Expanded(
            child: Text(
              chatList.message.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppins,
                  color: textColor,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.8),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
        ],
      ),
    ));
  }
}
