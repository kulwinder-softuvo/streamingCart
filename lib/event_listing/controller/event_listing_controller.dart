import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stream_e_cart/auth_screens/ui/login_screen.dart';
import 'package:stream_e_cart/constants/api_endpoints.dart';
import 'package:stream_e_cart/constants/string_constants.dart';
import 'package:stream_e_cart/event_listing/model/agora_token_generator_model.dart';
import 'package:stream_e_cart/go_live/ui/go_live_screen.dart';

import '../../auth_screens/login_repo/LoginRepo.dart';
import '../../common/size_config.dart';
import '../../common/widgets.dart';
import '../events_repo.dart';
import '../model/list_event_model.dart';

class EventListingController extends GetxController {
  var showLoader = false.obs;
  var eventList = <Events>[].obs;
  final store = GetStorage();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    eventListDetails();
    super.onInit();
  }

  String compareDatesForEventStatus(String startDate, String endDate) {
    DateTime startEventDate = DateTime.parse(startDate);
    DateTime endEventDate = DateTime.parse(endDate);
    DateTime currentDate = DateTime.now();

    if (currentDate.compareTo(startEventDate) < 0) {
      return upcoming;
    } else if (currentDate.compareTo(endEventDate) < 0) {
      return live;
    } else {
      return completed;
    }
  }

  String formatEventDate(String eventDate) {
    DateTime dateFromString = DateTime.parse(eventDate.toString());
    final DateFormat formatter = DateFormat('dd MMM,').add_jm();
    final String formatted = formatter.format(dateFromString);
    return formatted;
  }

  void eventListDetails({bool? fromRefresh}) {
    if (fromRefresh == null) {
      showLoader.value = true;
    }
    EventsRepo().getEventsListing(controller: this).then((value) async {
      showLoader.value = false;
      refreshController.refreshCompleted();
      if (value.code == 200) {
        if (value.data != null) {
          eventList.clear();
          for (int i = 0; i < value.data!.length; i++) {
            eventList.add(value.data![i]);
            eventList.refresh();
          }
        } else {
          showMessage(value.message ?? "");
        }
      } else {
        if (value.code == 301) {
          Get.offAll(() => LoginScreen());
        }
        showMessage(value.message ?? "");
        return;
      }
    });
  }

  gotoGoLiveScreen(Events? events) {
    String userId = DateTime.now().microsecondsSinceEpoch.toString();
String audienceToken ="";
    EventsRepo().generateAgoraToken(events!.channelName.toString(), userId, events.id.toString()).then((value) async {
      showLoader.value = false;
      if (value.rtmToken != "") {
        if (value.rtmToken != null) {
          audienceToken = await EventsRepo().getTokenForViewerCount();
          Get.to(() =>
              GoLiveScreen(
                  value.rtcTokenUID.toString(), userId, events.id.toString(),
                  events.channelName.toString(), audienceToken));
        } else {
          showMessage("Token not found.");
        }
      }

    });
  }

  void logoutClick() {
    LoginRepo().logoutUser().then((value) {
      if (value != null) {
        if (value.success == true) {
          store.erase();
          Get.offAll(() => LoginScreen());
          showMessage(value.message.toString());
          return;
        } else {
          showMessage(value.message ?? "");
        }
      } else {
        showMessage(value.message ?? "");
      }
    });
  }



}
