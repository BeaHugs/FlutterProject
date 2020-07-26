import 'package:FlutterProject/project/login/widgets/my_text_field.dart';
import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerOk = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();

  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: EasyRefresh.custom(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              //height: double.infinity,
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                //keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2]),
                children: _buildBody,
              ),
            )
          ]))
        ],
      ),
    );
  }

  List<Widget> get _buildBody => <Widget>[
        Text(
          "账号注册",
          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        MyTextField(
          key: const Key('phone'),
          focusNode: _nodeText1,
          controller: _nameController,
          maxLength: 11,
          //keyboardType: TextInputType.phone,
          hintText: "用户名",
        ),
        SizedBox(
          height: 8,
        ),
        MyTextField(
          key: const Key('password'),
          keyName: 'password',
          focusNode: _nodeText2,
          isInputPwd: true,
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          maxLength: 16,
          hintText: "密码",
        ),
        SizedBox(
          height: 8,
        ),
        MyTextField(
          key: const Key('passwords'),
          keyName: 'password',
          focusNode: _nodeText3,
          isInputPwd: true,
          controller: _passwordControllerOk,
          keyboardType: TextInputType.visiblePassword,
          maxLength: 16,
          hintText: "确认密码",
        ),
        SizedBox(
          height: 13,
        ),
        LoginButtonWidget(
          child: Text(
            "注册",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {
            var username = _nameController.text;
            var password = _passwordController.text;
            var repassword = _passwordControllerOk.text;

            Map<String, String> map = {
              "username": username,
              "password": password,
              "repassword": repassword
            };
            userModel.userRegister(map).then((value) {
              if (value.errorCode == 0) {
                Navigator.of(context).pop();
              } else {
                Toast.show(value.errorMsg, context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
            });
          },
        ),
      ];
}

class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(1),
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        color: color,
        disabledColor: color,
        borderRadius: BorderRadius.circular(5),
        pressedOpacity: 0.5,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
