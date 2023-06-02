// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names

class LineProfile {
  String userId;
  String displayName;
  Uri? pictureUrl;
  String statusMessage;
  String accessToken;
  bool status;

  LineProfile({this.userId = "", this.displayName = "", this.pictureUrl, this.statusMessage = "", this.accessToken = "", this.status = false});

  factory LineProfile.fromJson(Map<String, dynamic> json) {
    String _userId = (json.containsKey("userId") && json["userId"] != "") ? json["userId"] : "";
    String _displayName = (json.containsKey("displayName") && json["displayName"] != "") ? json["displayName"] : "";
    Uri _pictureUrl = (json.containsKey("pictureUrl") && json["pictureUrl"] != "") ? Uri.parse(json["pictureUrl"]) : Uri();
    String _statusMessage = (json.containsKey("statusMessage") && json["statusMessage"] != "") ? json["statusMessage"] : "";
    String _accessToken = (json.containsKey("accessToken") && json["accessToken"] != "") ? json["accessToken"] : "";
    bool _status = (json.containsKey("status") && json["status"] != "") ? json["status"] : false;
    return LineProfile(
        userId: _userId,
        displayName: _displayName,
        pictureUrl: _pictureUrl,
        statusMessage: _statusMessage,
        accessToken: _accessToken,
        status: _status);
  }
}
