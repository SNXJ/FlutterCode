class BaseResponse {
  int? code;
  String? message;
  Map<String, dynamic>? data;

  // T? data;

  BaseResponse({this.code, this.message, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
    // if(json.containsKey('data')){
    //   data=_generateOBJ(json['data']);
    // }
  }

// T? _generateOBJ<O>(Object? json) {
//   if (json == null) {
//     return null;
//   }
//   if (T.toString() == 'String') {
//     return json.toString() as T;
//   } else if (T.toString() == 'Map<dynamic, dynamic>') {
//     return json as T;
//   } else {
//     /// List类型数据由fromJsonAsT判断处理
//     return JsonConvert.fromJsonAsT<T>(json);
//   }
// }
}
