import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/common/widgets.dart';
import 'package:stream_e_cart/constants/string_constants.dart';

import '../../constants/storage_constants.dart';
import '../../event_listing/ui/event_listing_screen.dart';
import '../login_repo/LoginRepo.dart';

class LoginController extends GetxController {
  final hostIdController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  var showLoader = false.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    hostIdController.value.text = "HOST802440";
    emailController.value.text = "kulwinder12@yopmail.com";
    passwordController.value.text = "123456";
    super.onInit();
  }

  bool isValidEmail(String? value) {
    if (value != null) {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value);
    } else {
      return false;
    }
  }

  loginClick(BuildContext context) {
    if (hostIdController.value.text.isEmpty) {
      showMessage(enterAValidHostId);
    } else if (emailController.value.text.isEmpty ||
        !isValidEmail(emailController.value.text)) {
      showMessage(enterAValidEmailAddress);
    } else if (passwordController.value.text.isEmpty) {
      showMessage(enterYourPassword);
    } else {
      showLoader.value = true;
      LoginRepo()
          .loginUser(
              hostId: hostIdController.value.text.trim(),
              email: emailController.value.text.trim(),
              password: passwordController.value.text.trim(),
              controller: this)
          .then((value) async {
        showLoader.value = false;

        if (value.code == 200) {
          if (value.token != null) {
            storage.write(userToken, value.token!);
            storage.write(userHostId, value.host!.hostId!.toString());
            storage.write(userName, value.host!.name!.toString());

            Get.offAll(() => EventListingScreen());
            showDebugPrint(
                "user token is after login ---> ${storage.read(userToken)}");
            showMessage(
              "${value.message} \nHello ${value.host!.name} ",
            );
            return;
          } else {
            showMessage(value.message ?? "");
          }
        } else {
          showMessage(value.message ?? "");
          return;
        }
      });
    }
  }
}
