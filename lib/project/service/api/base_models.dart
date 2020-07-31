 class BaseResponse<T> {
  static const int parse_error = 1000;

  dynamic data;
  int errorCode;
  String errorMsg;

  BaseResponse({this.data, this.errorCode, this.errorMsg});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    //print(json['data']);
    data = json;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}
