import 'package:stream_e_cart/utils/extensions.dart';

class EventDetailModel {
  int? code;
  String? message;
  EventDetail? data;

  EventDetailModel({this.code, this.message, this.data});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString().toIntConversion();
    data = json['data'] != null ? EventDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
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
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['event_desc'] = eventDesc;
    data['channel_name'] = channelName;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}