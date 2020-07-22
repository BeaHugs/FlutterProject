

import 'package:FlutterProject/project/models/user.dart';

import '../http_request.dart';

Future<User> login(Map<String,String> map) async {

  var login = await  HttpRequest.request("user/login",method: "post",params: map);

  var user = User.fromJson(login);

  return user;

}
