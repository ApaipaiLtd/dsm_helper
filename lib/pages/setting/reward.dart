import 'package:dsm_helper/utils/utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reward extends StatefulWidget {
  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  bool loading = true;
  List rewards = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var res = await Api.reward();
    if (res['code'] == 1) {
      setState(() {
        loading = false;
        rewards = res['data'];
      });
    } else {
      Utils.toast("获取列表失败");
      Navigator.of(context).pop();
    }
  }

  Widget _buildRewardItem(reward) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(child: Text(reward['name'])),
          if (reward['amount'] != null) Text("￥${reward['amount']}"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("打赏名单"),
      ),
      body: loading
          ? Center(
              child: Container(
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(20),
              itemBuilder: (context, i) {
                return _buildRewardItem(rewards[i]);
              },
              itemCount: rewards.length,
              separatorBuilder: (context, i) {
                return SizedBox(
                  height: 20,
                );
              },
            ),
    );
  }
}
