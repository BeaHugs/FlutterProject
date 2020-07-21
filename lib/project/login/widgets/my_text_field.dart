
import 'dart:async';

import 'package:FlutterProject/project/login/widgets/load_image.dart';
import 'package:FlutterProject/project/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// 登录模块的输入框封装
class MyTextField extends StatefulWidget {
  
  const MyTextField({
    Key key,
    @required this.controller,
    this.maxLength = 16,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.isInputPwd = false,
    this.getVCode,
    this.keyName
  }): super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;
  final Future<bool> Function() getVCode;
  /// 用于集成测试寻找widget
  final String keyName;
  
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;
  /// 倒计时秒数
  final int _second = 30;
  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  @override
  void initState() {
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;
    /// 监听输入改变  
    widget.controller.addListener(isEmpty);
    super.initState();
  }
  
  void isEmpty() {
    bool isEmpty = widget.controller.text.isEmpty;
    /// 状态不一样在刷新，避免重复不必要的setState
    if (isEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isEmpty;
      });
    }
  }
  
  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller?.removeListener(isEmpty);
    super.dispose();
  }

  Future _getVCode() async {
    bool isSuccess = await widget.getVCode();
    if (isSuccess != null && isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });
      _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i).take(_second).listen((int i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;

    final TextField textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd ? !_isShowPwd : false,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
      inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ? 
      [WhitelistingTextInputFormatter(RegExp('[0-9]'))] : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: widget.hintText,
        counterText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themeData.primaryColor,
            width: 0.8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.8,
          ),
        ),
      ),
    );
    
    Widget clear = Semantics(
      label: '清空',
      hint: '清空输入框',
      child: GestureDetector(
        child: LoadAssetImage('login/qyg_shop_icon_delete',
          key: Key('${widget.keyName}_delete'),
          width: 18.0,
          height: 40.0,
        ),
        onTap: () => widget.controller.text = '',
      ),
    );

    Widget pwdVisible = Semantics(
      label: '密码可见开关',
      hint: '密码是否可见',
      child: GestureDetector(
        child: LoadAssetImage(
          _isShowPwd ? 'login/qyg_shop_icon_display' : 'login/qyg_shop_icon_hide',
          key: Key('${widget.keyName}_showPwd'),
          width: 18.0,
          height: 40.0,
        ),
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
      ),
    );

    Widget getVCodeButton = Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: const ButtonThemeData(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 26.0,
          minWidth: 76.0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      child: FlatButton(
        key: const Key('getVerificationCode'),
        onPressed: _clickable ? _getVCode : null,
        textColor: themeData.primaryColor,
        color: Colors.transparent,
        disabledTextColor: isDark ? Colours.dark_text : Colors.white,
        disabledColor: isDark ? Colours.dark_text_gray : Colours.text_gray_c,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.0),
          side: BorderSide(
            color: _clickable ? themeData.primaryColor : Colors.transparent,
            width: 0.8,
          ),
        ),
        child: Text(
          _clickable ? "获取验证码" : '（$_currentSecond s）',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
    
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_isShowDelete) SizedBox.shrink() else clear,
            if (!widget.isInputPwd) SizedBox.shrink() else SizedBox(width: 15,),
            if (!widget.isInputPwd) SizedBox.shrink() else pwdVisible,
            if (widget.getVCode == null) SizedBox.shrink() else SizedBox(width: 15,),
            if (widget.getVCode == null) SizedBox.shrink() else getVCodeButton,
          ],
        )
      ],
    );
  }
}
