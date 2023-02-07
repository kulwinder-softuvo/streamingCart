import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/auth_screens/controller/login_controller.dart';
import 'package:stream_e_cart/common/size_config.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/app_images.dart';

import '../../common/widgets.dart';
import '../../constants/string_constants.dart';

class LoginScreen extends StatelessWidget {
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: colorWhite,
      body: Stack(
        children: [
          Container(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                bottomSlope,
                width: SizeConfig.blockSizeHorizontal * 40,
              )),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4,
                  ),
                  Center(
                    child: Image.asset(
                      loginImage,
                      width: SizeConfig.screenWidth / 2.2,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  headingText(welcome, SizeConfig.blockSizeHorizontal * 4.8,
                      colorBlack),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  normalText(loginDescription,
                      SizeConfig.blockSizeHorizontal * 3.5, colorGrey,
                      alignment: TextAlign.start),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  headingText(
                      host_id, SizeConfig.blockSizeHorizontal * 3.5, colorBlack,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 6,
                    child: TextFormField(
                      controller: controller.hostIdController.value,
                      cursorColor: colorRed,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                      validator: (input) => controller.isValidEmail(input)
                          ? null
                          : enterAValidHostId,
                      style: const TextStyle(color: colorBlack),
                      decoration: InputDecoration(
                        hintText: enter_host_id,
                        hintStyle: TextStyle(color: colorGrey),
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            keyImage,
                            width: SizeConfig.blockSizeHorizontal * 5,
                            height: SizeConfig.blockSizeVertical * 2.2,
                          ),
                        ),
                        fillColor: colorWhite,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey, width: 0.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey),
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: colorRed),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  headingText(host_email_address,
                      SizeConfig.blockSizeHorizontal * 3.5, colorBlack,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 6,
                    child: TextFormField(
                      controller: controller.emailController.value,
                      cursorColor: colorRed,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: colorBlack),
                      decoration: InputDecoration(
                        hintText: enter_host_email_address,
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            email,
                            width: SizeConfig.blockSizeHorizontal * 5,
                            height: SizeConfig.blockSizeVertical * 2.2,
                          ),
                        ),
                        fillColor: colorWhite,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey, width: 0.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  headingText(host_password,
                      SizeConfig.blockSizeHorizontal * 3.5, colorBlack,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 6,
                    child: TextFormField(
                      controller: controller.passwordController.value,
                      obscureText: true,
                      cursorColor: colorRed,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: colorBlack),
                      decoration: InputDecoration(
                        hintText: enter_host_password,
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            password,
                            width: SizeConfig.blockSizeHorizontal * 5,
                            height: SizeConfig.blockSizeVertical * 2.2,
                          ),
                        ),
                        fillColor: colorWhite,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey, width: 0.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          controller.loginClick(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: colorRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 15.0,
                        ),
                        child: Container(
                            width: SizeConfig.screenWidth / 1.5,
                            height: SizeConfig.blockSizeVertical * 6,
                            child: Center(
                                child: headingText(
                                    login,
                                    SizeConfig.blockSizeHorizontal * 4,
                                    colorWhite)))),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () =>
                controller.showLoader.value ? commonLoader() : const SizedBox(),
          ),
        ],
      ),
    ));
  }
}
