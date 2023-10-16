import 'package:dsm_helper/models/Syno/Core/SynoUser.dart';
import 'package:dsm_helper/pages/control_panel/users/enums/user_expired_enum.dart';
import 'package:dsm_helper/pages/control_panel/users/user_detail.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  SynoUser users = SynoUser();
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      users = await SynoUser.list();
      setState(() {
        loading = false;
      });
    } catch (e) {
      Utils.toast("加载失败");
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: LoadingWidget(
              size: 30,
            ),
          )
        : users.users != null && users.users!.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(20),
                itemBuilder: (context, i) {
                  return _buildUserItem(users.users![i]);
                },
                itemCount: users.users!.length,
              )
            : EmptyWidget(
                text: "暂无用户",
              );
  }

  Widget _buildUserItem(Users user) {
    return GestureDetector(
      onTap: () {
        context.push(UserDetail(user), name: "user_detail");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (user.expiredEnum == UserExpiredEnum.date) Label("${user.expired}", AppTheme.of(context)!.warningColor!) else Label(user.expiredEnum.label, user.expiredEnum.color),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${user.name}",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    if (user.email != null && user.email != '')
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "${user.email}",
                        ),
                      ),
                    if (user.description != null && user.description != '')
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "${user.description}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
