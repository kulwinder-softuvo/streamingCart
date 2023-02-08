class GetAudienceTokenModel {
  bool? success;
  List<Projects>? projects;

  GetAudienceTokenModel({this.success, this.projects});

  GetAudienceTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Projects {
  String? id;
  String? name;
  int? status;
  String? signKey;
  String? vendorKey;
  Null? recordingServer;
  int? created;

  Projects(
      {this.id,
        this.name,
        this.status,
        this.signKey,
        this.vendorKey,
        this.recordingServer,
        this.created});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    signKey = json['sign_key'];
    vendorKey = json['vendor_key'];
    recordingServer = json['recording_server'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['sign_key'] = this.signKey;
    data['vendor_key'] = this.vendorKey;
    data['recording_server'] = this.recordingServer;
    data['created'] = this.created;
    return data;
  }
}