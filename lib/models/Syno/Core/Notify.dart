import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/utils/extensions/datetime_ext.dart';

/// admingrpsetmtime : "1693832600"
/// items : [{"bindEvt":true,"className":"SYNO.SDS.SecurityScan.Instance","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%ACCOUNT%\":\"jinx\",\"%BROWSER%\":\"Other\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%COUNTRY%\":\"合肥, 安徽, 中国大陆\",\"%DATE%\":\"2023-09-20\",\"%DISKSTATION%\":\"DiskStation\",\"%DS_IP%\":\"\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%LINK%\":\"\",\"%OS%\":\"Other\",\"%OSNAME%\":\"DSM\",\"%PROTOCOL%\":\"DSM\",\"%SRC_IP%\":\"36.161.77.138\",\"%TIME%\":\"2023/09/20 22:41:09\",\"DESKTOP_NOTIFY_CLASSNAME\":\"SYNO.SDS.SecurityScan.Instance\",\"DESKTOP_NOTIFY_TITLE\":\"helptoc:securityscan\"}"],"tag":"","time":1695220870,"title":"SecurityAdvisorAbnormalLoginSimple"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-18\",\"%DISKSTATION%\":\"DiskStation\",\"%FREE_SPACE%\":\"53.58\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"19:25\",\"%USAGE%\":\"0.50\",\"%VOLUME_ID%\":\"4\",\"%VOLUME_ID_ENCODED%\":\"4\",\"%VOLUME_SIZE%\":\"10724.53\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1695036317,"title":"DataVolumeLowCapacity"},{"bindEvt":true,"className":"SYNO.SDS.PkgManApp.Instance","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%DATE%\":\"2023-09-14\",\"%HOSTNAME%\":\"ChallengerV\",\"%OSNAME%\":\"DSM\",\"%PKG_NUM%\":\"3\",\"%POST_APP_LINK%\":\"</a>\",\"%PRE_APP_LINK%\":\"<a data-syno-app='SYNO.SDS.PkgManApp.Instance' data-syno-fn='SYNO.SDS.PkgManApp.Installed.Panel'>\",\"%TIME%\":\"14:35\"}"],"tag":"","time":1694673316,"title":"PkgMgr_UpgradePkgPlural"},{"bindEvt":true,"className":"SYNO.SDS.SecurityScan.Instance","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%ACCOUNT%\":\"jinx\",\"%BROWSER%\":\"Other\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%COUNTRY%\":\"Slough, 英格兰, 英国\",\"%DATE%\":\"2023-09-11\",\"%DISKSTATION%\":\"DiskStation\",\"%DS_IP%\":\"\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%LINK%\":\"\",\"%OS%\":\"Other\",\"%OSNAME%\":\"DSM\",\"%PROTOCOL%\":\"DSM\",\"%SRC_IP%\":\"17.232.89.36\",\"%TIME%\":\"2023/09/11 17:26:13\",\"DESKTOP_NOTIFY_CLASSNAME\":\"SYNO.SDS.SecurityScan.Instance\",\"DESKTOP_NOTIFY_TITLE\":\"helptoc:securityscan\"}"],"tag":"","time":1694424375,"title":"SecurityAdvisorAbnormalLoginSimple"},{"bindEvt":true,"className":"SYNO.SDS.SecurityScan.Instance","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%ACCOUNT%\":\"jinx\",\"%BROWSER%\":\"Other\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%COUNTRY%\":\"中国大陆\",\"%DATE%\":\"2023-09-10\",\"%DISKSTATION%\":\"DiskStation\",\"%DS_IP%\":\"\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%LINK%\":\"\",\"%OS%\":\"Other\",\"%OSNAME%\":\"DSM\",\"%PROTOCOL%\":\"DSM\",\"%SRC_IP%\":\"58.240.94.146\",\"%TIME%\":\"2023/09/10 14:20:08\",\"DESKTOP_NOTIFY_CLASSNAME\":\"SYNO.SDS.SecurityScan.Instance\",\"DESKTOP_NOTIFY_TITLE\":\"helptoc:securityscan\"}"],"tag":"","time":1694326810,"title":"SecurityAdvisorAbnormalLoginSimple"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-07\",\"%DISKSTATION%\":\"DiskStation\",\"%FREE_SPACE%\":\"40.15\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"21:13\",\"%USAGE%\":\"1.50\",\"%VOLUME_ID%\":\"3\",\"%VOLUME_ID_ENCODED%\":\"3\",\"%VOLUME_SIZE%\":\"2678.31\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1694092404,"title":"DataVolumeLowCapacity"},{"bindEvt":true,"className":"SYNO.SDS.CSTN.Instance","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%ANCHOR_END_TAG%\":\"</a>\",\"%ANCHOR_TAG%\":\"<a data-syno-app=\\\"SYNO.SDS.CSTN.Instance\\\">\",\"%DATE%\":\"2023-09-04\",\"%HOSTNAME%\":\"ChallengerV\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"21:04\"}"],"tag":"","time":1693832645,"title":"synologydrive_welcome_msg"},{"bindEvt":true,"className":"","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%DISK_NAME%\":\"%_DRIVE% 6\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"20:55\",\"%_DRIVE%\":\"dsm:volume:volume_disk\",\"DESKTOP_NOTIFY_HTML_ENCODE\":\"false\"}"],"tag":"","time":1693832139,"title":"StgMgrPluginDriveDetectedNotification"},{"bindEvt":true,"className":"","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%DISK_NAME%\":\"%_DRIVE% 5\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"20:53\",\"%_DRIVE%\":\"dsm:volume:volume_disk\",\"DESKTOP_NOTIFY_HTML_ENCODE\":\"false\"}"],"tag":"","time":1693831980,"title":"StgMgrPluginDriveDetectedNotification"},{"bindEvt":true,"className":"","fn":[],"hasMail":false,"isEncoded":true,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%SPACE_NAME%\":\"%_POOL% 1\",\"%TIME%\":\"20:51\",\"%_POOL%\":\"dsm:volume:volume_storage_pool\"}"],"tag":"","time":1693831916,"title":"StgMgrDeleteSpaceDone"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%POOL_ID%\":\"1\",\"%TIME%\":\"20:12\"}"],"tag":"","time":1693829529,"title":"StgMgrMissingPoolAssembleFail"},{"bindEvt":true,"className":"","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%POOL_ID%\":\"1\",\"%TIME%\":\"19:33\",\"DESKTOP_NOTIFY_HTML_ENCODE\":\"false\"}"],"tag":"","time":1693827190,"title":"StgMgrMissingPoolCanAssembleNotification"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%DISK_INFO%\":\"%_ABNORMAL_DISK%<br>%_DRIVE% 5, %_DISK_MODEL%: MG07ACA14TE, %_DISK_SERIAL%: 6090A0KTF94G\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%RAID_ID%\":\"1\",\"%TIME%\":\"10:38\",\"%_ABNORMAL_DISK%\":\"dsm:volume:pool_with_abnormal_disks\",\"%_DISK_MODEL%\":\"dsm:volume:volume_diskmodel\",\"%_DISK_SERIAL%\":\"dsm:smart:smart_disk_serial\",\"%_DRIVE%\":\"dsm:volume:volume_disk\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1693795080,"title":"RaidGroupCrashed"},{"bindEvt":true,"className":"SYNO.SDS.Virtualization.Application","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%DATE%\":\"2023-09-04\",\"%FREE_SPACE_PERCENT%\":\"0.30\",\"%HOSTNAME%\":\"ChallengerV\",\"%OSNAME%\":\"DSM\",\"%REPONAME%\":\"ChallengerV - VM Storage 1\",\"%TIME%\":\"09:19\"}"],"tag":"","time":1693790343,"title":"VIRT_repo_low_space_lower"},{"bindEvt":true,"className":"SYNO.SDS.Virtualization.Application","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%DATE%\":\"2023-09-04\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_NAME%\":\"ChallengerV\",\"%OSNAME%\":\"DSM\",\"%REPONAME%\":\"ChallengerV - VM Storage 1\",\"%TIME%\":\"09:18\"}"],"tag":"","time":1693790308,"title":"VIRT_repo_low_space"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%FREE_SPACE%\":\"7.23\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"09:07\",\"%USAGE%\":\"0.27\",\"%VOLUME_ID%\":\"3\",\"%VOLUME_ID_ENCODED%\":\"3\",\"%VOLUME_SIZE%\":\"2678.31\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1693789666,"title":"DataVolumeLowCapacity"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%FREE_SPACE%\":\"32.30\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"09:07\",\"%USAGE%\":\"0.30\",\"%VOLUME_ID%\":\"4\",\"%VOLUME_ID_ENCODED%\":\"4\",\"%VOLUME_SIZE%\":\"10724.53\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1693789663,"title":"DataVolumeLowCapacity"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"09:07\",\"%VOLUME_NAME%\":\"%_VOLUME% 1\",\"%_VOLUME%\":\"dsm:volume:volume\"}"],"tag":"","time":1693789639,"title":"StgMgrROVolumeMountRW"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-09-04\",\"%DISKSTATION%\":\"DiskStation\",\"%DISK_INFO%\":\"%_ABNORMAL_DISK%<br>%_DRIVE% 5, %_DISK_MODEL%: MG07ACA14TE, %_DISK_SERIAL%: 6090A0KTF94G\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%RAID_ID%\":\"1\",\"%TIME%\":\"03:11\",\"%_ABNORMAL_DISK%\":\"dsm:volume:pool_with_abnormal_disks\",\"%_DISK_MODEL%\":\"dsm:volume:volume_diskmodel\",\"%_DISK_SERIAL%\":\"dsm:smart:smart_disk_serial\",\"%_DRIVE%\":\"dsm:volume:volume_disk\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1693768302,"title":"RaidGroupCrashed"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%CONTAINER_NAME%\":\"DS918+\",\"%CONTENT%\":\"S.M.A.R.T. 状态： 正常<br>硬盘 I/O 命令超时情况： <font color=\\\"red\\\">严重</font><br>硬盘重新连接次数： 573<br>硬盘重新识别次数： 0<br>\",\"%DATE%\":\"2023-09-03\",\"%DISKSTATION%\":\"DiskStation\",\"%DISK_CAPACITY%\":\"12.7 TB\",\"%DISK_FIRM%\":\"0101\",\"%DISK_ID%\":\"5\",\"%DISK_MODEL%\":\"MG07ACA14TE\",\"%DISK_NAME%\":\"硬盘 5\",\"%DISK_SN%\":\"6090A0KTF94G\",\"%DISK_VENDOR%\":\"TOSHIBA\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"18:31\"}"],"tag":"","time":1693737116,"title":"DiskStatusCritical"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-08-31\",\"%DISKSTATION%\":\"DiskStation\",\"%FREE_SPACE%\":\"53.45\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"17:14\",\"%USAGE%\":\"0.50\",\"%VOLUME_ID%\":\"4\",\"%VOLUME_ID_ENCODED%\":\"4\",\"%VOLUME_SIZE%\":\"10724.53\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1693473298,"title":"DataVolumeLowCapacity"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%CONTAINER_NAME%\":\"DS918+\",\"%CONTENT%\":\"S.M.A.R.T. 状态： 正常<br>硬盘 I/O 命令超时情况： <font color=\\\"red\\\">严重</font><br>硬盘重新连接次数： 84<br>硬盘重新识别次数： 0<br>\",\"%DATE%\":\"2023-08-30\",\"%DISKSTATION%\":\"DiskStation\",\"%DISK_CAPACITY%\":\"12.7 TB\",\"%DISK_FIRM%\":\"0101\",\"%DISK_ID%\":\"5\",\"%DISK_MODEL%\":\"MG07ACA14TE\",\"%DISK_NAME%\":\"硬盘 5\",\"%DISK_SN%\":\"6090A0KTF94G\",\"%DISK_VENDOR%\":\"TOSHIBA\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"20:10\"}"],"tag":"","time":1693397450,"title":"DiskStatusCritical"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_WARN","mailType":"html","msg":["{\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-08-30\",\"%DISKSTATION%\":\"DiskStation\",\"%DISK_ID%\":\"硬盘 5\",\"%EUNIT_ID%\":\"DS918+\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"15:17\",\"MAIL_TYPE\":\"html\"}"],"tag":"","time":1693379869,"title":"DiskErrorTimeout"},{"bindEvt":true,"className":"SYNO.SDS.PkgManApp.Instance","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%DATE%\":\"2023-08-30\",\"%HOSTNAME%\":\"ChallengerV\",\"%OSNAME%\":\"DSM\",\"%PKG_NUM%\":\"5\",\"%POST_APP_LINK%\":\"</a>\",\"%PRE_APP_LINK%\":\"<a data-syno-app='SYNO.SDS.PkgManApp.Instance' data-syno-fn='SYNO.SDS.PkgManApp.Installed.Panel'>\",\"%TIME%\":\"06:50\"}"],"tag":"","time":1693349449,"title":"PkgMgr_UpgradePkgPlural"},{"bindEvt":true,"className":"SYNO.SDS.PkgManApp.Instance","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%DATE%\":\"2023-08-27\",\"%HOSTNAME%\":\"ChallengerV\",\"%OSNAME%\":\"DSM\",\"%PKG_NUM%\":\"3\",\"%POST_APP_LINK%\":\"</a>\",\"%PRE_APP_LINK%\":\"<a data-syno-app='SYNO.SDS.PkgManApp.Instance' data-syno-fn='SYNO.SDS.PkgManApp.Installed.Panel'>\",\"%TIME%\":\"09:32\"}"],"tag":"","time":1693099967,"title":"PkgMgr_UpgradePkgPlural"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%1%\":\"emby\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-08-23\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"10:17\"}"],"tag":"","time":1692757024,"title":"docker_container_unexpected_exit"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%1%\":\"qbittorrent\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-08-23\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"10:10\"}"],"tag":"","time":1692756638,"title":"docker_container_unexpected_exit"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%1%\":\"qinglong\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-08-23\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"09:46\"}"],"tag":"","time":1692755197,"title":"docker_container_unexpected_exit"},{"bindEvt":true,"className":"","fn":[],"hasMail":true,"isEncoded":true,"level":"NOTIFICATION_ERROR","mailType":"html","msg":["{\"%1%\":\"ChatGPT\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%DATE%\":\"2023-08-23\",\"%DISKSTATION%\":\"DiskStation\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%OSNAME%\":\"DSM\",\"%TIME%\":\"09:38\"}"],"tag":"","time":1692754736,"title":"docker_container_unexpected_exit"},{"bindEvt":true,"className":"SYNO.SDS.PkgManApp.Instance","fn":[],"hasMail":false,"isEncoded":false,"level":"NOTIFICATION_INFO","mailType":"html","msg":["{\"%DATE%\":\"2023-08-21\",\"%HOSTNAME%\":\"ChallengerV\",\"%OSNAME%\":\"DSM\",\"%PKG_NUM%\":\"3\",\"%POST_APP_LINK%\":\"</a>\",\"%PRE_APP_LINK%\":\"<a data-syno-app='SYNO.SDS.PkgManApp.Instance' data-syno-fn='SYNO.SDS.PkgManApp.Installed.Panel'>\",\"%TIME%\":\"07:12\"}"],"tag":"","time":1692573151,"title":"PkgMgr_UpgradePkgPlural"}]
/// newestMsgTime : 1695220870
/// total : 30

class DsmNotify {
  DsmNotify({
    this.admingrpsetmtime,
    this.items,
    this.newestMsgTime,
    this.total,
  });

  static Future<DsmNotify> notify() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.DSMNotify",
      "notify",
      parser: DsmNotify.fromJson,
      data: {
        "action": "load",
        "lastRead": DateTime.now().secondsSinceEpoch,
        "lastSeen": DateTime.now().secondsSinceEpoch,
      },
    );
    return res.data;
  }

  static Future<bool?> clean() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.DSMNotify", "notify", version: 1, data: {
      "action": "apply",
      "clean": "all",
    });
    return res.success;
  }

  DsmNotify.fromJson(dynamic json) {
    admingrpsetmtime = json['admingrpsetmtime'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(DsmNotifyItems.fromJson(v));
      });
    }
    newestMsgTime = json['newestMsgTime'];
    total = json['total'];
  }
  String? admingrpsetmtime;
  List<DsmNotifyItems>? items;
  num? newestMsgTime;
  num? total;
  DsmNotify copyWith({
    String? admingrpsetmtime,
    List<DsmNotifyItems>? items,
    num? newestMsgTime,
    num? total,
  }) =>
      DsmNotify(
        admingrpsetmtime: admingrpsetmtime ?? this.admingrpsetmtime,
        items: items ?? this.items,
        newestMsgTime: newestMsgTime ?? this.newestMsgTime,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['admingrpsetmtime'] = admingrpsetmtime;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['newestMsgTime'] = newestMsgTime;
    map['total'] = total;
    return map;
  }
}

/// bindEvt : true
/// className : "SYNO.SDS.SecurityScan.Instance"
/// fn : []
/// hasMail : true
/// isEncoded : true
/// level : "NOTIFICATION_WARN"
/// mailType : "html"
/// msg : ["{\"%ACCOUNT%\":\"jinx\",\"%BROWSER%\":\"Other\",\"%COMPANY_NAME%\":\"Synology DiskStation\",\"%COUNTRY%\":\"合肥, 安徽, 中国大陆\",\"%DATE%\":\"2023-09-20\",\"%DISKSTATION%\":\"DiskStation\",\"%DS_IP%\":\"\",\"%HOSTNAME%\":\"ChallengerV\",\"%HOST_SN%\":\"17A0PDN881802\",\"%HTTPS_URL%\":\"https://192.168.0.100:5001/\",\"%HTTP_URL%\":\"http://192.168.0.100:5000/\",\"%IP_ADDR%\":\"192.168.0.100\",\"%LINK%\":\"\",\"%OS%\":\"Other\",\"%OSNAME%\":\"DSM\",\"%PROTOCOL%\":\"DSM\",\"%SRC_IP%\":\"36.161.77.138\",\"%TIME%\":\"2023/09/20 22:41:09\",\"DESKTOP_NOTIFY_CLASSNAME\":\"SYNO.SDS.SecurityScan.Instance\",\"DESKTOP_NOTIFY_TITLE\":\"helptoc:securityscan\"}"]
/// tag : ""
/// time : 1695220870
/// title : "SecurityAdvisorAbnormalLoginSimple"

class DsmNotifyItems {
  DsmNotifyItems({
    this.bindEvt,
    this.className,
    this.fn,
    this.hasMail,
    this.isEncoded,
    this.level,
    this.mailType,
    this.msg,
    this.tag,
    this.time,
    this.title,
  });

  DsmNotifyItems.fromJson(dynamic json) {
    bindEvt = json['bindEvt'];
    className = json['className'];
    if (json['fn'] != null) {
      fn = json['fn'];
      // json['fn'].forEach((v) {
      //   fn?.add(Dynamic.fromJson(v));
      // });
    }
    hasMail = json['hasMail'];
    isEncoded = json['isEncoded'];
    level = json['level'];
    mailType = json['mailType'];
    msg = json['msg'] != null ? json['msg'].cast<String>() : [];
    tag = json['tag'];
    time = json['time'];
    title = json['title'];
  }
  bool? bindEvt;
  String? className;
  List<dynamic>? fn;
  bool? hasMail;
  bool? isEncoded;
  String? level;
  String? mailType;
  List<String>? msg;
  String? tag;
  int? time;
  String? title;
  List<String> contents = [];
  DsmNotifyItems copyWith({
    bool? bindEvt,
    String? className,
    List<dynamic>? fn,
    bool? hasMail,
    bool? isEncoded,
    String? level,
    String? mailType,
    List<String>? msg,
    String? tag,
    int? time,
    String? title,
  }) =>
      DsmNotifyItems(
        bindEvt: bindEvt ?? this.bindEvt,
        className: className ?? this.className,
        fn: fn ?? this.fn,
        hasMail: hasMail ?? this.hasMail,
        isEncoded: isEncoded ?? this.isEncoded,
        level: level ?? this.level,
        mailType: mailType ?? this.mailType,
        msg: msg ?? this.msg,
        tag: tag ?? this.tag,
        time: time ?? this.time,
        title: title ?? this.title,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bindEvt'] = bindEvt;
    map['className'] = className;
    if (fn != null) {
      map['fn'] = fn?.map((v) => v.toJson()).toList();
    }
    map['hasMail'] = hasMail;
    map['isEncoded'] = isEncoded;
    map['level'] = level;
    map['mailType'] = mailType;
    map['msg'] = msg;
    map['tag'] = tag;
    map['time'] = time;
    map['title'] = title;
    return map;
  }
}
