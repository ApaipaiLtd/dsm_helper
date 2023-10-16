import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class UploadTab extends StatefulWidget {
  const UploadTab({super.key});

  @override
  State<UploadTab> createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab> {
  List downloads = [];
  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      text: "暂无上传任务",
    );
  }
}
