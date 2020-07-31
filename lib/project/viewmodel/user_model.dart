

import 'package:FlutterProject/project/models/user.dart';
import 'package:FlutterProject/project/service/api/login_api.dart';
import 'package:FlutterProject/project/service/config/storage_manager.dart';
import 'package:FlutterProject/project/service/http_request.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {

  static const String kUser = 'kUser';

  User _user;

  UserModel(this._user);

  User get user => _user;

  void setUser(User value) {
    _user = value;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, _user);
  }

  void userLogin({
    Map<String, String> params,
    NetSuccessCallback onSuccess,
    NetErrorCallback onError,
  }) async {
    HttpRequest.requestNetWork("user/login", method: "post", params: params,
        onSuccess: (data) {
          var user = User.fromJson(data);
          onSuccess(user);
          setUser(user);

        }, onError: onError);
  }

  Future<User>  userRegister(Map<String,String> map) async {
    var user = await register(map);
    return user;
  }

}
