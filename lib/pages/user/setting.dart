import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/NormalUser.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/user/otp_bind.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class UserSetting extends StatefulWidget {
  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  NormalUser normalUser = NormalUser();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool loading = true;
  bool saving = false;
  Map<String, dynamic> changedData = {
    "username": "",
    "fullname": "",
    "email": "",
    "old_password": "",
    "password": "",
    "confirm_password": "",
  };
  @override
  void initState() {
    getNormalUser();
    super.initState();
  }

  getNormalUser() async {
    try {
      normalUser = await NormalUser.get();
      _usernameController.value = TextEditingValue(text: normalUser.username ?? '');
      _fullnameController.value = TextEditingValue(text: normalUser.fullname ?? '');
      _emailController.value = TextEditingValue(text: normalUser.email ?? '');
      setState(() {
        loading = false;
      });
    } on DsmException catch (e) {
      Utils.toast("加载失败，code:${e.code}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("个人设置"),
        actions: [
          CupertinoButton(
            onPressed: () async {
              if (saving) {
                return;
              }
              setState(() {
                saving = true;
              });
              Map<String, dynamic> data = {};
              if (changedData['old_password'] == "") {
                changedData.remove("old_password");
                changedData.remove("password");
                changedData.remove("confirm_password");
              } else {
                if (changedData['password'] == "") {
                  Utils.toast("请输入新密码");
                  return;
                }
                if (changedData['confirm_password'] != changedData['password']) {
                  Utils.toast("确认密码与新密码不一致");
                  return;
                }
              }
              changedData.forEach((key, value) {
                if (value is String) {
                  if (value.isNotEmpty && key != "confirm_password") {
                    data[key] = value;
                  }
                } else if (value is bool) {
                  data[key] = value;
                }
              });
              try {
                bool? res = await NormalUser.set(data);
                if (res == true) {
                  Utils.vibrate(FeedbackType.success);
                  Utils.toast("保存成功");
                }
              } catch (e) {}
              setState(() {
                saving = false;
              });
              // NormalUser
              // var res = await Api.normalUser("set", changedData: data);
              // if (res['success']) {
              //   Utils.toast("保存成功");
              //   Navigator.of(context).pop(true);
              // } else {
              //   setState(() {
              //     saving = false;
              //   });
              //   Utils.toast("保存失败，原因:${res['error']['code']}");
              // }
            },
            child: saving
                ? LoadingWidget(size: 20)
                : Image.asset(
                    'assets/icons/save.png',
                    width: 24,
                  ),
          ),
        ],
      ),
      body: loading
          ? Center(
              child: LoadingWidget(size: 30),
            )
          : ListView(
              children: [
                WidgetCard(
                  title: "基础信息",
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _usernameController,
                        onChanged: (v) => changedData['username'] = v,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '名称',
                        ),
                      ),
                      TextField(
                        controller: _fullnameController,
                        onChanged: (v) => changedData['fullname'] = v,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '描述',
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        onChanged: (v) => changedData['email'] = v,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '邮箱',
                        ),
                      ),
                    ],
                  ),
                ),
                if (!(normalUser.disallowchpasswd ?? true)) ...[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CupertinoButton(
                      onPressed: () {},
                      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.all(16),
                      color: AppTheme.of(context)?.cardColor,
                      borderRadius: BorderRadius.circular(10),

                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "修改密码",
                              style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Icon(
                            CupertinoIcons.right_chevron,
                            color: AppTheme.of(context)?.placeholderColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //   child: CupertinoButton(
                  //     onPressed: () {},
                  //     // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //     padding: EdgeInsets.all(16),
                  //     color: AppTheme.of(context)?.cardColor,
                  //     borderRadius: BorderRadius.circular(10),
                  //
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             "双重验证",
                  //             style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: 20,
                  //           child: Transform.scale(
                  //             scale: 0.8,
                  //             child: CupertinoSwitch(
                  //               value: normalUser.otpEnable ?? false,
                  //               onChanged: (v) {
                  //                 if (v) {
                  //                   context.push(OtpBind(normalUser.username ?? '', normalUser.email ?? ''), name: "otp_bind");
                  //                 } else {
                  //                   setState(() {
                  //                     normalUser.otpEnable = v;
                  //                   });
                  //                 }
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //         Icon(
                  //           CupertinoIcons.right_chevron,
                  //           color: AppTheme.of(context)?.placeholderColor,
                  //           size: 16,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).scaffoldBackgroundColor,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //   child: TextField(
                  //     onChanged: (v) => changedData['old_password'] = v,
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       labelText: '密码',
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).scaffoldBackgroundColor,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //   child: TextField(
                  //     onChanged: (v) => changedData['password'] = v,
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       labelText: '新密码',
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).scaffoldBackgroundColor,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //   child: TextField(
                  //     onChanged: (v) => changedData['confirm_password'] = v,
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       labelText: '确认密码',
                  //     ),
                  //   ),
                  // ),
                ],
              ],
            ),
    );
  }
}
