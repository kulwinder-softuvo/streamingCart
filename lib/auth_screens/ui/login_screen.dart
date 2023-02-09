import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_e_cart/auth_screens/controller/login_controller.dart';
import 'package:stream_e_cart/common/size_config.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/app_images.dart';

import '../../common/widgets.dart';
import '../../constants/string_constants.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var controller = Get.put(LoginController());

  LoginScreen({super.key});

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
              margin: const EdgeInsets.only(left: 20, right: 20),
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
                      hostId, SizeConfig.blockSizeHorizontal * 3.5, colorBlack,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SizedBox(
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
                        hintText: enterHostId,
                        hintStyle: const TextStyle(color: colorGrey),
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
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey, width: 0.7),
                        ),
                        focusedBorder: const OutlineInputBorder(
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
                  headingText(hostEmailAddress,
                      SizeConfig.blockSizeHorizontal * 3.5, colorBlack,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 6,
                    child: TextFormField(
                      controller: controller.emailController.value,
                      cursorColor: colorRed,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: colorBlack),
                      decoration: InputDecoration(
                        hintText: enterHostEmailAddress,
                        hintStyle: const TextStyle(color: Colors.grey),
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
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey, width: 0.7),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  headingText(hostPassword,
                      SizeConfig.blockSizeHorizontal * 3.5, colorBlack,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 6,
                    child: TextFormField(
                      controller: controller.passwordController.value,
                      obscureText: true,
                      cursorColor: colorRed,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: const TextStyle(color: colorBlack),
                      decoration: InputDecoration(
                        hintText: enterHostPassword,
                        hintStyle: const TextStyle(color: Colors.grey),
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
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: colorGrey, width: 0.7),
                        ),
                        focusedBorder: const OutlineInputBorder(
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
