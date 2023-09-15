import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class Feedback extends StatefulWidget {
  const Feedback({super. key});

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  String content = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("问题反馈"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

            
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
          CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              onPressed: () {
                Utils.toast("感谢您的反馈");
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
