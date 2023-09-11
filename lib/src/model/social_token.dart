class SocialToken {
  String? uid;
  String? accessToken;
  String? refreshToken;
  int? expiresIn;
  int? tcVersion;
  int? pdpaVersion;
  bool? tcAccept;
  bool? pdpaAccept;

  SocialToken(
      {this.uid,
      this.accessToken,
      this.refreshToken,
      this.expiresIn,
      this.tcVersion,
      this.pdpaVersion,
      this.tcAccept,
      this.pdpaAccept});

  SocialToken.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    tcVersion = json['tc_version'];
    pdpaVersion = json['pdpa_version'];
    tcAccept = json['tc_accept'];
    pdpaAccept = json['pdpa_accept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    data['tc_version'] = this.tcVersion;
    data['pdpa_version'] = this.pdpaVersion;
    data['tc_accept'] = this.tcAccept;
    data['pdpa_accept'] = this.pdpaAccept;
    return data;
  }
}
