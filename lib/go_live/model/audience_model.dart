import 'package:stream_e_cart/utils/extensions.dart';

class AudienceModel {
  bool? success;
  Data? data;

  AudienceModel({this.success, this.data});

  AudienceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? channelExist;
  int? mode;
  List<int>? broadcasters;
  List<int>? audience;
  int? audienceTotal;

  Data(
      {this.channelExist,
        this.mode,
        this.broadcasters,
        this.audience,
        this.audienceTotal});

  Data.fromJson(Map<String, dynamic> json) {
    channelExist = json['channel_exist'];
    mode = json['mode'];
    broadcasters = json['broadcasters'].cast<int>();
    audience = json['audience'].cast<int>();
    audienceTotal = json['audience_total'].toString().toIntConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_exist'] = this.channelExist;
    data['mode'] = this.mode;
    data['broadcasters'] = this.broadcasters;
    data['audience'] = this.audience;
    data['audience_total'] = this.audienceTotal;
    return data;
  }
}