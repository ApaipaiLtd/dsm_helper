import 'package:dsm_helper/models/photos/geocoding_model.dart';
import 'package:dsm_helper/pages/photos/timeline_page.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeocodingPage extends StatefulWidget {
  const GeocodingPage(this.isTeam, {super.key});
  final bool isTeam;
  @override
  State<GeocodingPage> createState() => _GeocodingPageState();
}

class _GeocodingPageState extends State<GeocodingPage> {
  bool loading = true;
  double? photoWidth;
  List<GeocodingModel> geocodings = [];
  Map<String, List<GeocodingModel>> geocodingGroups = {};
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    geocodings = await GeocodingModel.fetch(additional: ['thumbnail'], isTeam: widget.isTeam);
    geocodings.forEach((element) {
      if (geocodingGroups[element.country] == null) {
        geocodingGroups[element.country!] = [];
      }
      geocodingGroups[element.country]!.add(element);
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (photoWidth == null) {
      photoWidth = (MediaQuery.of(context).size.width - 81) / 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("位置"),
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
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, i) {
                MapEntry<String, List<GeocodingModel>> entry = geocodingGroups.entries.toList()[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("${entry.key}"),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: entry.value.map((geocoding) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                              return TimelinePage(
                                title: geocoding.name!,
                                isTeam: widget.isTeam,
                                geocodingId: geocoding.id!,
                              );
                            }));
                          },
                          child: SizedBox(
                            width: photoWidth,
                            child: Column(
                              children: [
                                ExtendedImage.network(
                                  geocoding.additional!.thumbnail!.thumbUrl(size: 'sm', isTeam: widget.isTeam),
                                  width: photoWidth,
                                  height: photoWidth,
                                  shape: BoxShape.rectangle,
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                Text(
                                  geocoding.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${geocoding.itemCount}个项目",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                );
              },
              itemCount: geocodingGroups.length,
            ),
    );
  }
}
