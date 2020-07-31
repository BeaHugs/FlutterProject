import 'package:FlutterProject/project/models/user.dart';

import '../http_request.dart';

void login({
  Map<String, String> params,
  NetSuccessCallback onSuccess,
  NetErrorCallback onError,
}) async {
  HttpRequest.requestNetWork("user/login", method: "post", params: params,
      onSuccess: (data) {
    onSuccess(User.fromJson(data));
  }, onError: onError);
}

Future<User> register(Map<String, String> map) async {
  var register =
      await HttpRequest.request("user/register", method: "post", params: map);

  var user = User.fromJson(register);

  return user;
}
