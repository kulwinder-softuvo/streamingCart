import 'package:stream_e_cart/utils/extensions.dart';

class AudienceModel {
  bool? success;
  Data? data;

  AudienceModel({this.success, this.data});

  AudienceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    } else {
      data = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel_exist'] = channelExist;
    data['mode'] = mode;
    data['broadcasters'] = broadcasters;
    data['audience'] = audience;
    data['audience_total'] = audienceTotal;
    return data;
  }
}