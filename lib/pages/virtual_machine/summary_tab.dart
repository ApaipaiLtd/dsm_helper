import 'package:dsm_helper/models/Syno/Virtualization/ClusterSummary.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class SummaryTab extends StatefulWidget {
  const SummaryTab({super.key});

  @override
  State<SummaryTab> createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
  bool loading = true;
  ClusterSummary clusterSummary = ClusterSummary();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    clusterSummary = await ClusterSummary.get();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget(size: 30)
        : ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppTheme.of(context)?.cardColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppTheme.of(context)?.successColor,
                      child: Image.asset(
                        "assets/icons/check.png",
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "正常",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "您的虚拟化环境运转正常",
                          style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.of(context)?.cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("主机"),
                                Spacer(),
                                Text("${clusterSummary.hostSumm?.total}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if ((clusterSummary.hostSumm?.error ?? 0) > 0)
                              Text(
                                "${clusterSummary.hostSumm?.error}",
                                style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.errorColor),
                              )
                            else if ((clusterSummary.hostSumm?.warning ?? 0) > 0)
                              Text(
                                "${clusterSummary.hostSumm?.warning}",
                                style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.warningColor),
                              )
                            else
                              Text(
                                "${clusterSummary.hostSumm?.healthy}",
                                style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.successColor),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        // onTap: () {
                        //   setState(() {
                        //     _currentIndex = 1;
                        //   });
                        //   getGuests();
                        // },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.of(context)?.cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("虚拟机"),
                                  Spacer(),
                                  Text("${clusterSummary.guestSumm?.total}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if ((clusterSummary.guestSumm?.error ?? 0) > 0)
                                Text(
                                  "${clusterSummary.guestSumm?.error}",
                                  style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.errorColor),
                                )
                              else if ((clusterSummary.guestSumm?.warning ?? 0) > 0)
                                Text(
                                  "${clusterSummary.guestSumm?.warning}",
                                  style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.warningColor),
                                )
                              else
                                Text(
                                  "${clusterSummary.guestSumm?.healthy}",
                                  style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.successColor),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        // onTap: () {
                        //   setState(() {
                        //     _currentIndex = 2;
                        //   });
                        //   getRepos();
                        // },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.of(context)?.cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("存储"),
                                  Spacer(),
                                  Text("${clusterSummary.repoSumm?.total}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if ((clusterSummary.repoSumm?.error ?? 0) > 0)
                                Text(
                                  "${clusterSummary.repoSumm?.error}",
                                  style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.errorColor),
                                )
                              else if ((clusterSummary.repoSumm?.warning ?? 0) > 0)
                                Text(
                                  "${clusterSummary.repoSumm?.warning}",
                                  style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.warningColor),
                                )
                              else
                                Text(
                                  "${clusterSummary.repoSumm?.healthy}",
                                  style: TextStyle(fontSize: 40, color: AppTheme.of(context)?.successColor),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
