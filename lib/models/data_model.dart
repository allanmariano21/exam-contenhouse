import 'dart:developer';

class DataModel {
  final int statusCode;
  final String image;
  final String message;
  final int count;
  final String errorMessage;

  DataModel({
    required this.statusCode,
    required this.image,
    required this.message,
    required this.count,
    required this.errorMessage,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    inspect(json);
    return DataModel(
      statusCode: json['status_code'],
      image: json['image'] ?? '',
      message: json['message'] ?? '',
      count: json['count'] ?? 0,
      errorMessage: json['error_message'] ?? '',
    );
  }
}
