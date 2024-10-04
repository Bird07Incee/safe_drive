class ActivityLogResponseModel {
  final String encryptionType;
  final String sequenceNumber;
  final String shardId;

  ActivityLogResponseModel({
    required this.encryptionType,
    required this.sequenceNumber,
    required this.shardId,
  });

  // Create a factory constructor to parse the JSON
  factory ActivityLogResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogResponseModel(
      encryptionType: json['EncryptionType'] as String,
      sequenceNumber: json['SequenceNumber'] as String,
      shardId: json['ShardId'] as String,
    );
  }

  // You can also add a method to convert the model back to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'EncryptionType': encryptionType,
      'SequenceNumber': sequenceNumber,
      'ShardId': shardId,
    };
  }
}
