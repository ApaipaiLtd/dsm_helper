import 'package:dsm_helper/pages/control_panel/users/user_tab.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  // List users = [];
  List groups = [];
  @override
  void initState() {
    if (Utils.version < 7) {
      _tabController = TabController(length: 2, vsync: this);
    }
    super.initState();
  }

  getData() async {
    // try{
    //   users = await SynoUser.list();
    //   setState(() {
    //     loading = false;
    //   });
    // }catch(e){
    //     Utils.toast("加载失败");
    //     context.pop();
    // }
    // var res = await Api.users();
    // if (res['success']) {
    //   setState(() {
    //     users = res['data']['users'];
    //   });
    // } else {
    //   Utils.toast("加载失败");
    //   Navigator.of(context).pop();
    // }
    // var group = await Api.userGroups();
    // if (group['success']) {
    //   setState(() {
    //     loading = false;
    //     groups = group['data']['groups'];
    //   });
    // } else {
    //   Utils.toast("加载失败");
    //   Navigator.of(context).pop();
    // }
  }

  Widget _buildGroupItem(group) {
    return Container(
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
                  Text(
                    "${group['name']}",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (group['description'] != "")
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "${group['description']}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.version < 7 ? "用户账户" : "用户与群组"),
        bottom: Utils.version == 7
            ? TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "用户账号",
                  ),
                  Tab(
                    text: "用户群组",
                  ),
                ],
              )
            : null,
      ),
      body: Utils.version < 7
          ? UserTab()
          : TabBarView(
              controller: _tabController,
              children: [
                UserTab(),
                ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, i) {
                    return _buildGroupItem(groups[i]);
                  },
                  itemCount: groups.length,
                )
              ],
            ),
    );
  }
}
