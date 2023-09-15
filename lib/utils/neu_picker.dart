import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef CallBack = Function(int);

class NeuPicker extends StatefulWidget {
  final int value;
  final List<String> data;
  final CallBack? onConfirm;
  NeuPicker(this.data, {this.value = 0, this.onConfirm});
  @override
  _NeuPickerState createState() => _NeuPickerState();
}

class _NeuPickerState extends State<NeuPicker> {
  late FixedExtentScrollController _controller;
  late int value;
  @override
  void initState() {
    value = widget.value;
    _controller = FixedExtentScrollController(initialItem: value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("取消"),
                  ),
                  Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    onPressed: () {
                      widget.onConfirm?.call(value);
                      Navigator.of(context).pop();
                    },
                    child: Text("确定"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker.builder(
                itemBuilder: (context, i) {
                  return Center(
                    child: Text(
                      widget.data[i],
                    ),
                  );
                },
                childCount: widget.data.length,
                scrollController: _controller,
                itemExtent: 40,
                onSelectedItemChanged: (v) => value = v,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
