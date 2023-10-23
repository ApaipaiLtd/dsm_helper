import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/line_progress_bar.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class HostTab extends StatefulWidget {
  const HostTab({super.key});

  @override
  State<HostTab> createState() => _HostTabState();
}

class _HostTabState extends State<HostTab> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: LoadingWidget(
            size: 30,
          ))
        : ListView();
  }

  Widget _buildHostItem(host) {
    List networks = host['nics'];
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  host['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                host['type'] == "healthy"
                    ? Label("正常", Colors.green)
                    : host['type'] == "warning"
                        ? Label("警告", Colors.orange)
                        : Label("错误", Colors.red),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text("CPU："),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: LineProgressBar(
                      value: host['cpu_usage'],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text("RAM："),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: LineProgressBar(
                      value: host['ram_usage'],
                    ),
                  ),
                ),
              ],
            ),
            ...networks.map((network) {
              return _buildNetworkItem(network, networks.indexOf(network));
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkItem(network, index) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text("局域网${index + 1}：")),
          Icon(
            Icons.upload_sharp,
            color: Colors.blue,
          ),
          Text(
            Utils.formatSize(network['tx']) + "/S",
            style: TextStyle(color: Colors.blue),
          ),
          Spacer(),
          Icon(
            Icons.download_sharp,
            color: Colors.green,
          ),
          Text(
            Utils.formatSize(network['rx']) + "/S",
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
