import 'package:dsm_helper/models/photos/general_tag_model.dart';
import 'package:dsm_helper/pages/photos/timeline_page.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class GeneralTagPage extends StatefulWidget {
  const GeneralTagPage(this.isTeam, {Key key}) : super(key: key);
  final bool isTeam;
  @override
  State<GeneralTagPage> createState() => _GeneralTagPageState();
}

class _GeneralTagPageState extends State<GeneralTagPage> {
  bool loading = true;
  double photoWidth;

  List<GeneralTagModel> tags = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    tags = await GeneralTagModel.fetch(additional: ['thumbnail'], isTeam: widget.isTeam);
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
        leading: AppBackButton(context),
        title: Text("标签"),
      ),
      body: loading
          ? Center(
              child: NeuCard(
                padding: EdgeInsets.all(50),
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                child: CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: tags.map((tag) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                        return TimelinePage(
                          title: tag.name,
                          isTeam: widget.isTeam,
                          generalTagId: tag.id,
                        );
                      }));
                    },
                    child: SizedBox(
                      width: photoWidth,
                      child: Column(
                        children: [
                          ExtendedImage.network(
                            tag.additional.thumbnail.thumbUrl(size: 'sm', isTeam: widget.isTeam),
                            width: photoWidth,
                            height: photoWidth,
                            shape: BoxShape.rectangle,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          Text(
                            tag.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${tag.itemCount}个项目",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
