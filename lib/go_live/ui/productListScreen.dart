import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_e_cart/common/widgets.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'package:stream_e_cart/constants/app_images.dart';
import 'package:stream_e_cart/go_live/controller/products_controller.dart';
import 'package:stream_e_cart/go_live/model/event_details_model.dart';

import '../../common/size_config.dart';
import '../../constants/string_constants.dart';

// ignore: must_be_immutable
class ProductListScreen extends StatelessWidget {
  var controller = Get.put(ProductsController());

  ProductListScreen(String eventId, {super.key}) {
    controller.eventId.value = eventId;
    controller.getEventDetails(controller.eventId.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.productsList.isNotEmpty
          ? ListView.builder(
              itemCount: controller.productsList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return productRowItem(controller.productsList[index]);
              },
            )
          : Center(
            child: headingText(noProductIsAvailableForSale,
                SizeConfig.blockSizeHorizontal * 4, colorGrey,
                weight: FontWeight.w500),
          ),
    );
  }

  Widget productRowItem(Products productsList) {
    return Card(
        margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        elevation: 2,
        shadowColor: colorGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            FadeInImage.assetNetwork(
              placeholder: appIcon,
              image: productsList.image.toString(),
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 10,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headingText(productsList.title.toString(),
                      SizeConfig.blockSizeHorizontal * 4, colorBlack,
                      weight: FontWeight.w700),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  headingText("\$ ${productsList.price}",
                      SizeConfig.blockSizeHorizontal * 4.5, colorRed,
                      weight: FontWeight.w700),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                bag,
                width: SizeConfig.blockSizeHorizontal * 5,
                height: SizeConfig.blockSizeVertical * 3,
                fit: BoxFit.fill,
              ),
            ),
          ]),
        ));
  }
}
