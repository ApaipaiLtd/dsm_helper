import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class VipLogin extends StatefulWidget {
  const VipLogin({Key key}) : super(key: key);

  @override
  State<VipLogin> createState() => _VipLoginState();
}

class _VipLoginState extends State<VipLogin> {
  bool isRegister = false;
  bool loading = false;
  String account = "";
  String password = "";
  String confirmPassword = "";
  _login() async {
    if (account.isBlank) {
      Util.toast("请输入用户名");
      return;
    }
    if (password.length < 8 || password.length > 16) {
      Util.toast("请输入8-16位密码");
      return;
    }

    try {
      var res = await Util.post("${Util.appUrl}/login/password", data: {
        "account": account,
        "password": password,
      });
      if (res['code'] == 1) {
        Util.toast("登录成功");
        Util.setStorage("user_token", res['data']['token']);
        Navigator.of(context).pop(true);
      } else {
        Util.toast(res['msg'] ?? '登录失败，请检查网络');
      }
    } catch (e) {
      Util.toast("登录失败");
    }
  }

  _register() async {
    if (account.length < 6 || password.length > 30) {
      Util.toast("请输入6-30位用户名");
      return;
    }
    if (password.length < 8 || password.length > 16) {
      Util.toast("请输入8-16位密码");
      return;
    }
    if (confirmPassword != password) {
      Util.toast("两次密码输入不一致");
      return;
    }
    try {
      var res = await Util.post("${Util.appUrl}/login/register", data: {
        "account": account,
        "password": password,
      });
      if (res['code'] == 1) {
        Util.toast("注册成功");
        Util.setStorage("user_token", res['data']['token']);
        Navigator.of(context).pop(true);
      } else {
        Util.toast(res['msg'] ?? '注册失败，请检查网络');
      }
    } catch (e) {
      Util.toast("注册失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("账号登录"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: NeuCard(
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    bevel: 20,
                    curveType: CurveType.flat,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      autocorrect: false,
                      keyboardAppearance: Brightness.light,
                      onChanged: (v) => account = v,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '用户名',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            NeuCard(
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              bevel: 12,
              curveType: CurveType.flat,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                onChanged: (v) => password = v,
                obscureText: true,
                textInputAction: isRegister ? TextInputAction.next : TextInputAction.done,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '密码',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (isRegister) ...[
              NeuCard(
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 12,
                curveType: CurveType.flat,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  onChanged: (v) => confirmPassword = v,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '确认密码',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
            NeuButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                if (isRegister) {
                  _register();
                } else {
                  _login();
                }
              },
              child: loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(
                          radius: 13,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "取消",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  : Text(
                      isRegister ? ' 注册 ' : ' 登录 ',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: isRegister
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isRegister = false;
                        });
                      },
                      child: Text("返回登录"),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isRegister = true;
                        });
                      },
                      child: Text("注册账号"),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
