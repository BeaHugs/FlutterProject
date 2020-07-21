import 'package:FlutterProject/project/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier{

  User _user;


  UserModel(this._user);

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

}