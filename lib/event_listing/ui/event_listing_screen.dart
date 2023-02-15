import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stream_e_cart/common/widgets.dart';
import 'package:stream_e_cart/constants/api_endpoints.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/string_constants.dart';

import '../../common/size_config.dart';
import '../controller/event_listing_controller.dart';
import '../model/list_event_model.dart';

// ignore: must_be_immutable
class EventListingScreen extends StatelessWidget {
  var controller = Get.put(EventListingController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  EventListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _key,
          appBar: appBar(context, _key, broadcastYourShows),
          // drawer: drawerLayout(context),
          backgroundColor: colorWhite,
          body: Obx(
            () => controller.showLoader.value == false
                ? SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: const WaterDropHeader(waterDropColor: colorRed),
                    controller: controller.refreshController,
                    onRefresh: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.eventListDetails(fromRefresh: true);
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            normalText(showsDescription,
                                SizeConfig.blockSizeHorizontal * 3.8, colorGrey,
                                alignment: TextAlign.start),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 3,
                            ),
                            Obx(() => ListView.builder(
                                  itemCount: controller.eventList.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    return showRowItem(
                                        controller.eventList[index], index);
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                : commonLoader(),
          )),
    );
  }

  Widget showRowItem(Events eventList, int index) {
    return Card(
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        elevation: 2,
        shadowColor: colorGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical * 31,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.darken),
                    image: NetworkImage(
                        "${APIEndpoints.imageBaseUrl}${eventList.bannerImage}"),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 23,
                    height: SizeConfig.blockSizeVertical * 4,
                    decoration: const BoxDecoration(
                        color: colorRed,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                        )),
                    child: Center(
                      child: headingText(
                          controller.compareDatesForEventStatus(
                              eventList.eventStartTime.toString(),
                              eventList.eventEndTime.toString()),
                          SizeConfig.blockSizeHorizontal * 2.9,
                          colorWhite,
                          weight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 16,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: headingText(eventList.title.toString(),
                        SizeConfig.blockSizeHorizontal * 4.2, colorWhite,
                        weight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        headingText(start, SizeConfig.blockSizeHorizontal * 2.9,
                            colorRed,
                            weight: FontWeight.w600),
                        headingText(
                            controller.formatEventDate(
                                    eventList.eventStartTime.toString()),
                            SizeConfig.blockSizeHorizontal * 2.9,
                            colorWhite,
                            weight: FontWeight.w600),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        headingText(
                            end, SizeConfig.blockSizeHorizontal * 2.9, colorRed,
                            weight: FontWeight.w600),
                        headingText(
                            controller.formatEventDate(
                                    eventList.eventEndTime.toString()),
                            SizeConfig.blockSizeHorizontal * 2.9,
                            colorWhite,
                            weight: FontWeight.w600),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () async {
                    showDebugPrint(
                        "join hosting through this link ----->   ${"https://streamingweb.softuvo.click/?event_id=${eventList.id}"}");

                    controller.compareDatesForEventStatus(
                                eventList.eventStartTime.toString(),
                                eventList.eventEndTime.toString()) ==
                            completed
                        ? showMessage(thisEventIsCompleted)
                        : controller.compareDatesForEventStatus(
                                    eventList.eventStartTime.toString(),
                                    eventList.eventEndTime.toString()) ==
                                upcoming
                            ? showMessage(thisEventIsNotLiveNow)
                            : controller.gotoGoLiveScreen(eventList);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.compareDatesForEventStatus(
                                eventList.eventStartTime.toString(),
                                eventList.eventEndTime.toString()) ==
                            completed
                        ? colorGrey
                        : colorRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 15.0,
                  ),
                  child: SizedBox(
                      width: SizeConfig.screenWidth / 1.7,
                      height: SizeConfig.blockSizeVertical * 6,
                      child: Center(
                          child: headingText(goLive,
                              SizeConfig.blockSizeHorizontal * 3.5, colorWhite,
                              weight: FontWeight.w600)))),
            )
          ],
        ));
  }
}
