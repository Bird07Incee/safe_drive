class SocialToken {
  String? uid;
  String? accessToken;
  String? refreshToken;
  int? expiresIn;
  String? tcVersion;
  String? pdpaVersion;
  String? tcAccept;
  String? pdpaAccept;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['expires_in'] = expiresIn;
    data['tc_version'] = tcVersion;
    data['pdpa_version'] = pdpaVersion;
    data['tc_accept'] = tcAccept;
    data['pdpa_accept'] = pdpaAccept;
    return data;
  }
}
