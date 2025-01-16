class BaseApiResponse<T> {
  String message;
  bool? status;
  final T? data;

  BaseApiResponse({required this.message, this.status, this.data});

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T? data) toJsonT) {
    return {
      'status': status,
      'message': message,
      'data': data != null ? toJsonT(data) : null
    };
  }

  factory BaseApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    return BaseApiResponse<T>(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] == null ? null : fromJsonT(json['data']),
    );
  }
}
