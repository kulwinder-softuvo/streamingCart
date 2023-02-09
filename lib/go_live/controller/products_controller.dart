import 'package:get/get.dart';

import '../../common/widgets.dart';
import '../../event_listing/events_repo.dart';
import '../model/event_details_model.dart';

class ProductsController extends GetxController{
  var productsList = <Products>[].obs;
  var eventId = "".obs;


  void getEventDetails(String eventId) {
    EventsRepo().getEventDetails(eventId).then((value) async {
      if (value.code == 200) {
        if (value.data != null) {
          productsList.clear();
          for (int i = 0; i < value.data!.products!.length; i++) {
            productsList.add(value.data!.products![i]);
            productsList.refresh();
          }
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