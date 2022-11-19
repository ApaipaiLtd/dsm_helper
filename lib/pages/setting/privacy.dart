import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("${Util.appName}隐私政策"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: Text(
              "《${Util.appName}隐私政策》",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Text('''
引言

本隐私政策适用于青岛阿派派软件有限公司（以下简称我公司）提供的${Util.appName}的产品及服务，请您在使用${Util.appName}相关服务之前，认真阅读此隐私政策。

我们重视用户的隐私。您在使用我们的服务时，我们可能会收集和使用您的相关信息。我们希望通过本《隐私政策》向您说明，在使用我们的服务时，我们如何收集、使用、储存和分享这些信息，以及我们为您提供的访问、更新、控制和保护这些信息的方式。本《隐私政策》与您所使用的服务息息相关，希望您仔细阅读，在需要时，按照本《隐私政策》的指引，作出您认为适当的选择。本《隐私政策》中涉及的相关技术词汇，我们尽量以简明扼要的表述，并提供进一步说明的链接，以便您的理解。

您使用或继续使用我们的服务，即意味着同意我们按照本《隐私政策》收集、使用、储存和分享您的相关信息。

我们可能收集的信息

我们提供服务时，可能会收集、储存和使用下列与您有关的信息。如果您不提供相关信息，可能无法享受我们提供的某些服务，或者无法达到相关服务拟达到的效果。

您使用服务时我们可能收集如下信息：

日志信息，指您使用我们的服务时，系统可能自动采集的技术信息，包括：

设备或软件信息、页面访问信息。

我们可能如何使用信息

我们可能将在向您提供服务的过程之中所收集的信息用作下列用途：

软件升级；

帮助我们设计新服务，改善我们现有服务；

使我们更加了解您如何接入和使用我们的服务，从而针对性地回应您的个性化需求，或对您和其他用户作出其他方面的回应；

我们可能如何收集信息

我们或我们的第三方合作伙伴，可能收集和使用您的信息，并将该等信息储存为日志信息，该日志信息不包含任何含有用户隐私的敏感信息。

第三方隐私政策：

友盟：https://www.umeng.com/page/policy

群晖DSM：https://kb.synology.com/zh-tw/DSM/help/DSM/Home/legal_info?version=6

${Util.account == "jinx" ? ""
                  "账号注销：\n"
                  "如您需要注销账号，请前往设置-右上角齿轮-账号注销进行申请，所有与此账号有关的文件、操作记录等信息将被删除并永久无法恢复，请在申请注销账号前备份好重要文件，因账号注销造成的损失与群晖助手无关。\n"
                  "提交账号注销申请后，将由管理员在3个工作日内审核完成。" : ""}

开发者信息：

公司名称：青岛阿派派软件有限公司
注册地址：青岛市李沧区顺河路113号2单元401户
常用办公地址：青岛市李沧区顺河路113号2单元401户
信息保护负责人联系电话：18953292540

隐私政策的适用范围

除某些特定服务外，我们所有的服务均适用本《隐私政策》。这些特定服务将适用特定的隐私政策。针对某些特定服务的特定隐私政策，将更具体地说明我们在该等服务中如何使用您的信息。该特定服务的隐私政策构成本《隐私政策》的一部分。如相关特定服务的隐私政策与本《隐私政策》有不一致之处，适用该特定服务的隐私政策。

请您注意，本《隐私政策》不适用于以下情况：

通过我们的服务而接入的第三方服务（包括任何第三方网站）收集的信息；

通过在我们服务中进行广告服务的其他公司或机构所收集的信息。

变更

我们可能适时修订本《隐私政策》的条款，该等修订构成本《隐私政策》的一部分。如该等修订造成您在本《隐私政策》下权利的实质减少，我们将在软件更新时对《隐私政策》进行更新，不再另行通知。在该种情况下，若您继续使用我们的服务，即表示同意受经修订的本《隐私政策》的约束。

政策生效日期：2021-05-31
          '''),
        ],
      ),
    );
  }
}
