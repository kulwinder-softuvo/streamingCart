class GetAudienceTokenModel {
  bool? success;
  List<Projects>? projects;

  GetAudienceTokenModel({this.success, this.projects});

  GetAudienceTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
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
  String? recordingServer;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['sign_key'] = signKey;
    data['vendor_key'] = vendorKey;
    data['recording_server'] = recordingServer;
    data['created'] = created;
    return data;
  }
}