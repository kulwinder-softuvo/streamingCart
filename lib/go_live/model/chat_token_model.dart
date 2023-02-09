import 'dart:ffi';

import 'package:stream_e_cart/utils/extensions.dart';

class ChatTokenModel {
  String? userToken;
  String? appToken;

  ChatTokenModel({this.userToken, this.appToken});

  ChatTokenModel.fromJson(Map<String, dynamic> json) {
    userToken = json['userToken'].toString().toStringConversion();
    appToken = json['appToken'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userToken'] = this.userToken;
    data['appToken'] = this.appToken;
    return data;
  }
}