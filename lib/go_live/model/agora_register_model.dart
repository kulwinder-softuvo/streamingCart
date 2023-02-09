class AgoraRegisterModel {
  String? path;
  String? uri;
  int? timestamp;
  String? organization;
  String? application;
  List<Entities>? entities;
  String? action;
  int? duration;
  String? applicationName;

  AgoraRegisterModel(
      {this.path,
        this.uri,
        this.timestamp,
        this.organization,
        this.application,
        this.entities,
        this.action,
        this.duration,
        this.applicationName});

  AgoraRegisterModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    uri = json['uri'];
    timestamp = json['timestamp'];
    organization = json['organization'];
    application = json['application'];
    if (json['entities'] != null) {
      entities = <Entities>[];
      json['entities'].forEach((v) {
        entities!.add(new Entities.fromJson(v));
      });
    }
    action = json['action'];
    duration = json['duration'];
    applicationName = json['applicationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['uri'] = this.uri;
    data['timestamp'] = this.timestamp;
    data['organization'] = this.organization;
    data['application'] = this.application;
    if (this.entities != null) {
      data['entities'] = this.entities!.map((v) => v.toJson()).toList();
    }
    data['action'] = this.action;
    data['duration'] = this.duration;
    data['applicationName'] = this.applicationName;
    return data;
  }
}

class Entities {
  String? uuid;
  String? type;
  int? created;
  int? modified;
  String? username;
  bool? activated;
  String? nickname;

  Entities(
      {this.uuid,
        this.type,
        this.created,
        this.modified,
        this.username,
        this.activated,
        this.nickname});

  Entities.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    type = json['type'];
    created = json['created'];
    modified = json['modified'];
    username = json['username'];
    activated = json['activated'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['type'] = this.type;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['username'] = this.username;
    data['activated'] = this.activated;
    data['nickname'] = this.nickname;
    return data;
  }
}