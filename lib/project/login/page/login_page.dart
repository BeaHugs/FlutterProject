import 'package:FlutterProject/project/login/page/register_page.dart';
import 'package:FlutterProject/project/login/widgets/my_text_field.dart';
import 'package:FlutterProject/project/models/user.dart';
import 'package:FlutterProject/project/service/api/login_api.dart';
import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

/// design/1注册登录/index.html
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //定义一个controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  @override
  void initState() {
    super.initState();
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {}
  UserModel usermodel = null;

  @override
  Widget build(BuildContext context) {
    usermodel = Provider.of<UserModel>(context);

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
          "账号登陆",
          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        MyTextField(
          key: const Key('phone'),
          focusNode: _nodeText1,
          controller: _nameController,
          maxLength: 11,
          //keyboardType: TextInputType.phone,
          hintText: "请输入账号",
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
          hintText: "请输入密码",
        ),
        SizedBox(
          height: 13,
        ),
        GestureDetector(
          onTap: () {

            Navigator.of(context).push(new  MaterialPageRoute(builder: (ctx){
              return  RegisterPage();
            }));

          },
          child: Container(
            alignment: Alignment.centerRight,
            child: Text("还没账号?去注册"),
          ),
        ),
        SizedBox(
          height: 13,
        ),
        LoginButtonWidget(
          child: Text(
            "登录",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {
            var username = _nameController.text;
            var password = _passwordController.text;

            Map<String, String> map = {
              "username": username,
              "password": password
            };
            usermodel.userLogin(map).then((value) {
              if (value) {
                Navigator.of(context).pop();
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
