import 'package:stream_e_cart/utils/extensions.dart';

class ListEventModel {
  int? code;
  String? message;
  List<Events>? data;

  ListEventModel({this.code, this.message, this.data});

  ListEventModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString().toIntConversion();
    message = json['message'].toString().toStringConversion();
    if (json['data'] != null) {
      data = <Events>[];
      json['data'].forEach((v) {
        data!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  int? id;
  String? title;
  String? eventDesc;
  String? createdAt;
  String? updatedAt;
  String? eventStartTime;
  String? eventEndTime;
  String? hostId;
  int? businessId;
  int? createdById;
  String? videoLink;
  String? channelName;
  String? bannerImage;
  int? status;
  int? isPublished;

  Events(
      {this.id,
      this.title,
      this.eventDesc,
      this.createdAt,
      this.updatedAt,
      this.eventStartTime,
      this.eventEndTime,
      this.hostId,
      this.businessId,
      this.createdById,
      this.videoLink,
      this.channelName,
      this.bannerImage,
      this.status,
      this.isPublished});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString().toIntConversion();
    title = json['title'].toString().toStringConversion();
    eventDesc = json['event_desc'].toString().toStringConversion();
    createdAt = json['created_at'].toString().toStringConversion();
    updatedAt = json['updated_at'].toString().toStringConversion();
    eventStartTime = json['event_start_time'].toString().toStringConversion();
    eventEndTime = json['event_end_time'].toString().toStringConversion();
    hostId = json['host_id'].toString().toStringConversion();
    businessId = json['business_id'].toString().toIntConversion();
    createdById = json['created_by_id'].toString().toIntConversion();
    videoLink = json['video_link'].toString().toStringConversion() ?? "";
    channelName = json['channel_name'].toString().toStringConversion() ?? "";
    bannerImage = json['banner_image'].toString().toStringConversion();
    status = json['status'].toString().toIntConversion();
    isPublished = json['is_published'].toString().toIntConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['event_desc'] = this.eventDesc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['event_start_time'] = this.eventStartTime;
    data['event_end_time'] = this.eventEndTime;
    data['host_id'] = this.hostId;
    data['business_id'] = this.businessId;
    data['created_by_id'] = this.createdById;
    data['video_link'] = this.videoLink;
    data['channel_name'] = this.channelName;
    data['banner_image'] = this.bannerImage;
    data['status'] = this.status;
    data['is_published'] = this.isPublished;
    return data;
  }
}
