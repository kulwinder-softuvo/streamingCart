
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
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.host != null) {
      data['host'] = this.host!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['host_id'] = this.hostId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['business_id'] = this.businessId;
    data['created_by_id'] = this.createdById;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
