import 'package:stream_e_cart/utils/extensions.dart';

class ChatTokenModel {
  String? userToken;
  String? appToken;
  String? username;
  String? uuid;

  ChatTokenModel({this.userToken, this.appToken, this.username, this.uuid});

  ChatTokenModel.fromJson(Map<String, dynamic> json) {
    userToken = json['userToken'].toString().toStringConversion();
    appToken = json['appToken'].toString().toStringConversion();
    username = json['username'].toString().toStringConversion();
    uuid = json['uuid'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userToken'] = userToken;
    data['appToken'] = appToken;
    data['username'] = username;
    data['uuid'] = uuid;
    return data;
  }
}