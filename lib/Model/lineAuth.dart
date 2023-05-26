// ignore_for_file: file_names

class LineAuth {
  String code;
  String liffClientId;
  String state;
  Uri? liffRedirectUri;

  LineAuth({this.code = "", this.liffClientId = "", this.state = "", this.liffRedirectUri});

  factory LineAuth.fromJson(Map<String, dynamic> json) {
    return LineAuth(
      code: json["code"],
      liffClientId: json["liffClientId"],
      state: json["state"],
      liffRedirectUri: json["liffRedirectUri"],
    );
  }
}