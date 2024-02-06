class BaseResponse {
  int? code;
  String? message;
  Map<String, dynamic>? data;

  BaseResponse({this.code, this.message, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    // data = json['data'];
    data = json['data'];
  }
}
