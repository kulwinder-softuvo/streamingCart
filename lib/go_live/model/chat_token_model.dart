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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userToken'] = userToken;
    data['appToken'] = appToken;
    return data;
  }
}