import 'package:flutter/material.dart';

class GroupTab extends StatefulWidget {
  const GroupTab({super.key});

  @override
  State<GroupTab> createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    // try{
    //   users = await SynoUser.list();
    //   setState(() {
    //     loading = false;
    //   });
    // }catch(e){
    //   Utils.toast("加载失败");
    //   context.pop();
    // }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
