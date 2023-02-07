import 'package:stream_e_cart/utils/extensions.dart';

class EventDetailModel {
  int? code;
  String? message;
  EventDetail? data;

  EventDetailModel({this.code, this.message, this.data});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString().toIntConversion();
    data = json['data'] != null ? new EventDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EventDetail {
  int? id;
  String? title;
  String? eventDesc;
  String? channelName;
  List<Products>? products;

  EventDetail({this.id, this.title, this.eventDesc, this.channelName, this.products});

  EventDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString().toIntConversion();
    title = json['title'].toString().toStringConversion();
    eventDesc = json['event_desc'].toString().toStringConversion();
    channelName = json['channel_name'].toString().toStringConversion();
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['event_desc'] = this.eventDesc;
    data['channel_name'] = this.channelName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? url;
  double? price;
  String? image;

  Products({this.id, this.title, this.url, this.price, this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString().toIntConversion();
    title = json['title'].toString().toStringConversion();
    url = json['url'].toString().toStringConversion();
    price = json['price'].toString().toDoubleConversion();
    image = json['image'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}