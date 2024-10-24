class ActivityLogResponseModel {
  final String status;

  ActivityLogResponseModel({required this.status});

  // Factory method to create an instance from JSON
  factory ActivityLogResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogResponseModel(
      status: json['status'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
