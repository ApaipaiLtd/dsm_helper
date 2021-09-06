import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class Feedback extends StatefulWidget {
  const Feedback({Key key}) : super(key: key);

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  String content = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("问题反馈"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            bevel: 20,
            curveType: CurveType.flat,
            child: TextField(
              onChanged: (v) => content = v,
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: '请输入反馈内容',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          NeuButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                Util.toast("感谢您的反馈");
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "提交",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
