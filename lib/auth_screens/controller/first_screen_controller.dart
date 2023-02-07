import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stream_e_cart/auth_screens/ui/login_screen.dart';
import 'package:stream_e_cart/common/widgets.dart';
import 'package:stream_e_cart/event_listing/ui/event_listing_screen.dart';

import '../../constants/storage_constants.dart';

class FirstScreencontroller extends GetxController {
  final storage = GetStorage();

  goLiveBtnClick() {
    showDebugPrint("user token is --->  ${storage.read(userToken)}");
    Get.off(() =>
        storage.read(userToken) != null && storage.read(userToken) != ""
            ? EventListingScreen()
            : LoginScreen());
  }
}
