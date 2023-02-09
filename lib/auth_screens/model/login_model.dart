
import 'package:stream_e_cart/utils/extensions.dart';

class LoginModel {
  String? token;
  int? code;
  String? status;
  String? message;
  Host? host;

  LoginModel({this.token, this.code, this.status, this.message, this.host});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'].toString().toStringConversion();
    code = json['code'].toString().toIntConversion();
    status = json['status'].toString().toStringConversion();
    message = json['message'].toString().toStringConversion();
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (host != null) {
      data['host'] = host!.toJson();
    }
    return data;
  }
}

class Host {
  int? id;
  String? name;
  String? hostId;
  String? email;
  String? password;
  int? businessId;
  int? createdById;
  String? createdAt;
  String? updatedAt;

  Host(
      {this.id,
      this.name,
      this.hostId,
      this.email,
      this.password,
      this.businessId,
      this.createdById,
      this.createdAt,
      this.updatedAt});

  Host.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString().toIntConversion();
    name = json['name'].toString().toStringConversion();
    hostId = json['host_id'].toString().toStringConversion();
    email = json['email'].toString().toStringConversion();
    password = json['password'].toString().toStringConversion();
    businessId = json['business_id'].toString().toIntConversion();
    createdById = json['created_by_id'].toString().toIntConversion();
    createdAt = json['created_at'].toString().toStringConversion();
    updatedAt = json['updated_at'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['host_id'] = hostId;
    data['email'] = email;
    data['password'] = password;
    data['business_id'] = businessId;
    data['created_by_id'] = createdById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
