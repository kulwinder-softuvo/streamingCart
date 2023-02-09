import 'package:stream_e_cart/utils/extensions.dart';

class ChatModel {
  String? name;
  String? message;


  ChatModel({this.name, this.message});

  ChatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString().toStringConversion();
    message = json['message'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['message'] = message;
    return data;
  }
}
