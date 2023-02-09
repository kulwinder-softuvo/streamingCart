class AgoraTokenGeneratorModel {
  String? rtcTokenAccount;
  String? rtcTokenUID;
  String? rtmToken;

  AgoraTokenGeneratorModel(
      {this.rtcTokenAccount, this.rtcTokenUID, this.rtmToken});

  AgoraTokenGeneratorModel.fromJson(Map<String, dynamic> json) {
    rtcTokenAccount = json['rtcToken_Account'];
    rtcTokenUID = json['rtcToken_UID'];
    rtmToken = json['rtmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rtcToken_Account'] = rtcTokenAccount;
    data['rtcToken_UID'] = rtcTokenUID;
    data['rtmToken'] = rtmToken;
    return data;
  }
}
