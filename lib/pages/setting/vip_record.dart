import 'package:dsm_helper/models/setting/vip_record_model.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class VipRecord extends StatefulWidget {
  const VipRecord({Key key}) : super(key: key);

  @override
  State<VipRecord> createState() => _VipRecordState();
}

class _VipRecordState extends State<VipRecord> {
  List<VipRecordModel> records = [];
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      records = await VipRecordModel.fetch();
      setState(() {
        loading = false;
      });
    } catch (e) {
      Util.toast(e.message);
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("开通记录"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("注意：仅包含积分兑换与在线支付方式的开通记录"),
          ),
          Expanded(
            child: loading
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : records.length > 0
                    ? ListView.builder(
                        itemBuilder: (context, i) {
                          return _buildRecordItem(records[i]);
                        },
                        itemCount: records.length,
                      )
                    : Center(
                        child: Text(
                          "暂无开通记录",
                          style: TextStyle(color: AppTheme.of(context).placeholderColor),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordItem(VipRecordModel record) {
    return NeuCard(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      bevel: 20,
      curveType: CurveType.flat,
      decoration: NeumorphicDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("开通方式：${record.type == 1 ? '积分兑换' : '在线支付'} - ${record.cost}"),
              Text("开通时间：${record.createTime}"),
              Text("生效时间：${record.startTime}"),
              Text("过期时间：${record.isForever == 0 ? record.endTime : '永不过期'}"),
            ],
          )
        ],
      ),
    );
  }
}
