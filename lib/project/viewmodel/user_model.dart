

import 'package:FlutterProject/project/models/user.dart';
import 'package:FlutterProject/project/service/api/login_api.dart';
import 'package:FlutterProject/project/service/config/storage_manager.dart';
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

  Future<bool> userLogin(Map<String, String> map) async {
    var user = await login(map);

    if(user.errorCode == 0){
      setUser(user);
      return true;
    }
    return false;
  }
}
