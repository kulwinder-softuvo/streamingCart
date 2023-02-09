import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_e_cart/common/size_config.dart';
import 'package:stream_e_cart/common/widgets.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/app_images.dart';
import 'package:stream_e_cart/constants/string_constants.dart';

import '../controller/first_screen_controller.dart';

// ignore: must_be_immutable
class FirstScreen extends StatelessWidget {
  var controller = Get.put(FirstScreencontroller());

  FirstScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: colorWhite,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    firstLook,
                    width: SizeConfig.screenWidth / 1.2,
                    height: SizeConfig.screenHeight / 2.4,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                headingText(readyGetSetGo, SizeConfig.blockSizeHorizontal * 4.8,
                    colorBlack),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: normalText(firstScreenDescription,
                      SizeConfig.blockSizeHorizontal * 3.8, colorGrey),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.goLiveBtnClick();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 15.0,
                    ),
                    child: SizedBox(
                        width: SizeConfig.screenWidth / 1.5,
                        height: SizeConfig.blockSizeVertical * 6,
                        child: Center(
                            child: headingText(
                                goLive,
                                SizeConfig.blockSizeHorizontal * 4,
                                colorWhite))))
              ],
            )));
  }
}
