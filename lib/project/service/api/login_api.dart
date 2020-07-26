

import 'package:FlutterProject/project/models/user.dart';

import '../http_request.dart';

Future<User> login(Map<String,String> map) async {

  var login = await  HttpRequest.request("user/login",method: "post",params: map);

  var user = User.fromJson(login);

  return user;

}

Future<User> register(Map<String,String> map) async {

     var register = await HttpRequest.request("user/register",method: "post",params: map);

     var user = User.fromJson(register);

     return user;

}
