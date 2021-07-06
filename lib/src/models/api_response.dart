class ApiResponse<T>{

  final int? statusCode;
  final bool? success;
  final String? message;
  final T? body;

  ApiResponse({this.statusCode, this.success, this.message, this.body});

  bool get failure => !(success ?? false);
}