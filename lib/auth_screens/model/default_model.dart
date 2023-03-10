import 'package:stream_e_cart/utils/extensions.dart';

class DefaultModel {
  bool? success;
  String? message;

  DefaultModel({this.success, this.message});

  DefaultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
