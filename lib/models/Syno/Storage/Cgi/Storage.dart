import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/pages/dashboard/enums/volume_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_overview_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_smart_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/storage_pool_device_type_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/storage_pool_scrubbing_status_enum.dart';

/// detected_pools : []
/// disks : [{"action":{"alert":false,"notification":false,"selectable":true,"show_lifetime_chart":true},"adv_progress":"","adv_status":"not_support","below_remain_life_mail_notify_thr":false,"below_remain_life_show_thr":false,"below_remain_life_thr":false,"compatibility":"support","container":{"order":0,"str":"DS918+","supportPwrBtnDisable":false,"type":"internal"},"container_id":0,"device":"/dev/sda","disable_secera":false,"diskType":"SATA","disk_code":"","disk_location":"Main","erase_time":510,"firm":"MEAOA5C0","firmware_status":"-","has_system":true,"hide_info":[],"i18nNamingInfo":"[\"dsm:volume:volume_disk\",\" \",\"1\"]","id":"sda","ihm_testing":false,"is4Kn":false,"isSsd":false,"isSynoDrive":false,"isSynoPartition":true,"is_bundle_ssd":false,"is_erasing":false,"longName":"硬盘 1","model":"HUS724030ALE641","name":"硬盘 1","num_id":1,"order":1,"overview_status":"normal","pciSlot":-1,"perf_testing":false,"portType":"normal","remain_life":-1,"remain_life_danger":false,"remote_info":{"compatibility":"disabled","unc":0},"sb_days_left":0,"sb_days_left_critical":false,"sb_days_left_warning":false,"serial":"MJ0351YNG9HR4A","size_total":"3000592982016","slot_id":1,"smart_progress":"","smart_status":"normal","smart_test_limit":0,"smart_test_support":true,"smart_testing":false,"status":"normal","summary_status_category":"space","summary_status_key":"normal","temp":45,"testing_progress":"","testing_type":"idle","tray_status":"join","ui_serial":"MJ0351YNG9HR4A","unc":0,"used_by":"reuse_3","vendor":"Hitachi ","wcache_force_off":false,"wcache_force_on":false,"wdda_support":false},{"action":{"alert":false,"notification":false,"selectable":true,"show_lifetime_chart":true},"adv_progress":"","adv_status":"not_support","below_remain_life_mail_notify_thr":false,"below_remain_life_show_thr":false,"below_remain_life_thr":false,"compatibility":"support","container":{"order":0,"str":"DS918+","supportPwrBtnDisable":false,"type":"internal"},"container_id":0,"device":"/dev/sdc","disable_secera":false,"diskType":"SATA","disk_code":"","disk_location":"Main","erase_time":1128,"firm":"81.00A81","firmware_status":"-","has_system":true,"hide_info":[],"i18nNamingInfo":"[\"dsm:volume:volume_disk\",\" \",\"3\"]","id":"sdc","ihm_testing":false,"is4Kn":false,"isSsd":false,"isSynoDrive":false,"isSynoPartition":true,"is_bundle_ssd":false,"is_erasing":false,"longName":"硬盘 3","model":"WD120EMAZ-11BLFA0","name":"硬盘 3","num_id":3,"order":3,"overview_status":"normal","pciSlot":-1,"perf_testing":false,"portType":"normal","remain_life":-1,"remain_life_danger":false,"remote_info":{"compatibility":"disabled","unc":0},"sb_days_left":0,"sb_days_left_critical":false,"sb_days_left_warning":false,"serial":"5PGEL6TE","size_total":"12000138625024","slot_id":3,"smart_progress":"","smart_status":"normal","smart_test_limit":0,"smart_test_support":true,"smart_testing":false,"status":"normal","summary_status_category":"space","summary_status_key":"normal","temp":47,"testing_progress":"","testing_type":"idle","tray_status":"join","ui_serial":"5PGEL6TE","unc":0,"used_by":"reuse_4","vendor":"WDC     ","wcache_force_off":false,"wcache_force_on":false,"wdda_support":false},{"action":{"alert":false,"notification":false,"selectable":true,"show_lifetime_chart":true},"adv_progress":"","adv_status":"not_support","below_remain_life_mail_notify_thr":false,"below_remain_life_show_thr":false,"below_remain_life_thr":false,"compatibility":"support","container":{"order":0,"str":"DS918+","supportPwrBtnDisable":false,"type":"internal"},"container_id":0,"device":"/dev/sdf","disable_secera":false,"diskType":"SATA","disk_code":"","disk_location":"Main","erase_time":1226,"firm":"0101","firmware_status":"-","has_system":true,"hide_info":[],"i18nNamingInfo":"[\"dsm:volume:volume_disk\",\" \",\"6\"]","id":"sdf","ihm_testing":false,"is4Kn":false,"isSsd":false,"isSynoDrive":false,"isSynoPartition":true,"is_bundle_ssd":false,"is_erasing":false,"longName":"硬盘 6","model":"MG07ACA14TE","name":"硬盘 6","num_id":6,"order":6,"overview_status":"normal","pciSlot":-1,"perf_testing":false,"portType":"normal","remain_life":-1,"remain_life_danger":false,"remote_info":{"compatibility":"disabled","unc":0},"sb_days_left":0,"sb_days_left_critical":false,"sb_days_left_warning":false,"serial":"6090A0KTF94G","size_total":"14000519643136","slot_id":6,"smart_progress":"","smart_status":"normal","smart_test_limit":0,"smart_test_support":true,"smart_testing":false,"status":"normal","summary_status_category":"space","summary_status_key":"normal","temp":42,"testing_progress":"","testing_type":"idle","tray_status":"join","ui_serial":"6090A0KTF94G","unc":0,"used_by":"reuse_1","vendor":"TOSHIBA ","wcache_force_off":false,"wcache_force_on":false,"wdda_support":false}]
/// env : {"batchtask":{"max_task":64,"remain_task":64},"bay_number":"16","cache_max_ssd_num":6,"data_scrubbing":{"sche_enabled":"0","sche_pool_order":["/dev/vg1002/lv","/dev/vg1001/lv"],"sche_status":"disabled"},"eunits":[],"fs_acting":false,"is_space_actioning":false,"m2_card_info":[],"max_fs_bytes":"118747255799808","max_fs_bytes_high_end":"219902325555200","model_name":"DS918+","multipathStatus":"normal","multipathSupport":false,"ram_enough_for_fs_high_end":false,"ram_size":8,"ram_size_required":32,"showpooltab":true,"space_size_limit":{"allocatable_size":0,"is_limited":false,"size_limit":0},"status":{"is_support_sha_peta_volume":false,"root_size_byte":2549940224,"system_crashed":false,"system_need_repair":false,"system_rebuilding":false},"storageMachineInfo":[{"isInternal":true,"isSAS":false,"machineSerial":"17A0PDN881802","machineStatus":"existed","modelName":"DS918+","nameStr":"ChallengerV","order":0,"ports":[]}],"support":{"ebox":true,"raid_cross":true,"sysdef":true},"unique_key":"f97a03249c"}
/// missing_pools : []
/// overview_data : {"incompatible_eunit":[],"pools_to_show":{"detected_pool":[],"storage_pool":["reuse_3","reuse_4"]},"sample_level_str":{"attention":"status_level_abnormal","danger":"status_level_danger","normal":"status_level_normal"},"space_affect_by_eunit_lost":false,"space_affect_by_location_mismatch":false,"status_level":"status_level_abnormal"}
/// ports : []
/// sharedCaches : []
/// ssdCaches : []
/// storagePools : [{"cacheStatus":"","cache_disks":[],"can_assemble":false,"can_do":{"delete":true,"expand_by_disk":1,"migrate":{"to_shr2":3},"raid_cross":true},"compatibility":true,"container":"internal","data_scrubbing":{"can_do_manual":true,"can_do_schedule":true,"reason":""},"desc":"","device_type":"shr_without_disk_protect","disk_failure_number":0,"disks":["sdf"],"drive_type":0,"has_full_child_vol":true,"id":"reuse_1","is_actioning":false,"is_backgroundbuilding":false,"is_scheduled":false,"is_writable":true,"last_done_time":0,"limited_disk_number":24,"maximal_disk_size":"0","minimal_disk_size":"13994375675904","minimal_spare_size":"0","missing_drives":[],"next_schedule_time":0,"num_id":1,"pool_child":[{"id":"volume_1","size":{"total":"13988708483072"}}],"pool_path":"reuse_1","progress":{"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0},"raidType":"multiple","raids":[{"designedDiskCount":1,"devices":[{"id":"sdf","slot":0,"status":"normal"}],"hasParity":false,"minDevSize":"13994375675904","normalDevCount":1,"raidCrashedReason":0,"raidPath":"/dev/md2","raidStatus":1,"spares":[]}],"repair_action":"none","scrubbingStatus":"ready","show_assemble_btn":false,"size":{"total":"13989526372352","used":"13988721065984"},"space_path":"/dev/vg1","space_status":{"detail":"pool_normal","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"pool_normal","summary_status":"normal"},"spares":[],"status":"normal","suggestions":[],"summary_status":"normal","timebackup":false,"uuid":"QQBed0-Ysag-KFgp-2gUP-2RK7-SOve-ozRyg7","vspace_can_do":{"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":768,"stopService":false},"remove":{"can_do":false,"errCode":768,"stopService":false},"resize":{"can_do":false,"errCode":768,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}},{"cacheStatus":"","cache_disks":[],"can_assemble":false,"can_do":{"convert_shr_to_pool":2,"delete":true,"expand_by_disk":1,"migrate":{"to_shr2":3},"raid_cross":true},"compatibility":true,"container":"internal","data_scrubbing":{"can_do_manual":true,"can_do_schedule":true,"reason":""},"deploy_path":"volume_4","desc":"西数12T","device_type":"shr_without_disk_protect","disk_failure_number":0,"disks":["sdc"],"drive_type":0,"id":"reuse_4","is_actioning":false,"is_backgroundbuilding":false,"is_scheduled":true,"is_writable":true,"last_done_time":0,"limited_disk_number":24,"maximal_disk_size":"0","minimal_disk_size":"12000029081600","minimal_spare_size":"0","missing_drives":[],"next_schedule_time":0,"num_id":4,"pool_path":"reuse_4","progress":{"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0},"raidType":"single","raids":[{"designedDiskCount":1,"devices":[{"id":"sdc","slot":0,"status":"normal"}],"hasParity":false,"minDevSize":"12000029081600","normalDevCount":1,"raidCrashedReason":0,"raidPath":"/dev/md5","raidStatus":1,"spares":[]}],"repair_action":"none","scrubbingStatus":"ready","show_assemble_btn":false,"size":{"total":"11995185152000","used":"11995185152000"},"space_path":"/dev/vg1002/lv","space_status":{"detail":"fs_almost_full","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"pool_normal","summary_status":"attention"},"spares":[],"ssd_trim":{"support":"not support"},"status":"attention","suggestions":[{"arg":["4"],"section":"volume","str":"volume_usage_suggestion","type":"warning"}],"summary_status":"attention","timebackup":false,"uuid":"Ufsj6M-9MPK-ehDx-O0bR-RDJg-pnuO-f5H3yy","vol_desc":"","vspace_can_do":{"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":49152,"stopService":false},"remove":{"can_do":true,"errCode":0,"stopService":true},"resize":{"can_do":true,"errCode":0,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}},{"cacheStatus":"","cache_disks":[],"can_assemble":false,"can_do":{"convert_shr_to_pool":2,"delete":true,"expand_by_disk":1,"migrate":{"to_shr2":3},"raid_cross":true},"compatibility":true,"container":"internal","data_scrubbing":{"can_do_manual":true,"can_do_schedule":true,"reason":""},"deploy_path":"volume_3","desc":"希捷3T","device_type":"shr_without_disk_protect","disk_failure_number":0,"disks":["sda"],"drive_type":0,"id":"reuse_3","is_actioning":false,"is_backgroundbuilding":false,"is_scheduled":true,"is_writable":true,"last_done_time":1682856430,"limited_disk_number":24,"maximal_disk_size":"0","minimal_disk_size":"3000487034880","minimal_spare_size":"0","missing_drives":[],"next_schedule_time":0,"num_id":3,"pool_path":"reuse_3","progress":{"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0},"raidType":"single","raids":[{"designedDiskCount":1,"devices":[{"id":"sda","slot":0,"status":"normal"}],"hasParity":false,"minDevSize":"3000487034880","normalDevCount":1,"raidCrashedReason":0,"raidPath":"/dev/md4","raidStatus":1,"spares":[]}],"repair_action":"none","scrubbingStatus":"ready","show_assemble_btn":false,"size":{"total":"2995643219968","used":"2995643219968"},"space_path":"/dev/vg1001/lv","space_status":{"detail":"fs_almost_full","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"pool_normal","summary_status":"attention"},"spares":[],"ssd_trim":{"support":"not support"},"status":"attention","suggestions":[{"arg":["3"],"section":"volume","str":"volume_usage_suggestion","type":"warning"}],"summary_status":"attention","timebackup":false,"uuid":"8q9It7-xI7Q-2cpt-OqYX-mwGw-P50G-S41pGT","vol_desc":"","vspace_can_do":{"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":49152,"stopService":false},"remove":{"can_do":true,"errCode":0,"stopService":true},"resize":{"can_do":true,"errCode":0,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}}]
/// volumes : [{"atime_checked":false,"atime_opt":"relatime","cacheStatus":"","cache_advisor_running":false,"cache_disks":[],"can_assemble":false,"can_do":{"convert_shr_to_pool":2,"delete":true,"expand_by_disk":1,"migrate":{"to_shr2":3},"raid_cross":true},"container":"internal","deploy_path":"volume_4","desc":"西数12T","device_type":"shr_without_disk_protect","disk_failure_number":0,"disks":[],"drive_type":0,"fs_type":"btrfs","id":"volume_4","is_acting":false,"is_actioning":false,"is_backgroundbuilding":false,"is_inode_full":false,"is_scheduled":true,"is_writable":true,"last_done_time":0,"limited_disk_number":24,"max_fs_size":"1152921504606846976","metadata_cache_hard_lower_bound_byte":202689740800,"metadata_cache_option_show":true,"missing_drives":[],"next_schedule_time":0,"num_id":4,"pool_path":"reuse_4","progress":{"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0},"raidType":"single","repair_action":"none","scrubbingStatus":"ready","show_assemble_btn":false,"size":{"free_inode":"0","total":"11515377745920","total_device":"11995185152000","total_inode":"0","used":"11463320182784"},"space_path":"/dev/vg1002/lv","space_status":{"detail":"fs_almost_full","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"fs_almost_full","summary_status":"attention"},"ssd_trim":{"support":"not support"},"status":"attention","suggestions":[],"summary_status":"attention","timebackup":false,"used_by_gluster":false,"uuid":"Ufsj6M-9MPK-ehDx-O0bR-RDJg-pnuO-f5H3yy","vol_attribute":"generic","vol_desc":"","vol_path":"/volume4","vspace_can_do":{"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":49152,"stopService":false},"remove":{"can_do":true,"errCode":0,"stopService":true},"resize":{"can_do":true,"errCode":0,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}},{"atime_checked":false,"atime_opt":"relatime","cacheStatus":"","cache_advisor_running":false,"cache_disks":[],"can_assemble":false,"can_do":{"convert_shr_to_pool":2,"delete":true,"expand_by_disk":1,"migrate":{"to_shr2":3},"raid_cross":true},"container":"internal","deploy_path":"volume_3","desc":"希捷3T","device_type":"shr_without_disk_protect","disk_failure_number":0,"disks":[],"drive_type":0,"fs_type":"btrfs","id":"volume_3","is_acting":false,"is_actioning":false,"is_backgroundbuilding":false,"is_inode_full":false,"is_scheduled":true,"is_writable":true,"last_done_time":1682856430,"limited_disk_number":24,"max_fs_size":"1152921504606846976","metadata_cache_hard_lower_bound_byte":122242990080,"metadata_cache_option_show":true,"missing_drives":[],"next_schedule_time":0,"num_id":3,"pool_path":"reuse_3","progress":{"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0},"raidType":"single","repair_action":"none","scrubbingStatus":"ready","show_assemble_btn":false,"size":{"free_inode":"0","total":"2875817492480","total_device":"2995643219968","total_inode":"0","used":"2838785794048"},"space_path":"/dev/vg1001/lv","space_status":{"detail":"fs_almost_full","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"fs_almost_full","summary_status":"attention"},"ssd_trim":{"support":"not support"},"status":"attention","suggestions":[],"summary_status":"attention","timebackup":false,"used_by_gluster":false,"uuid":"8q9It7-xI7Q-2cpt-OqYX-mwGw-P50G-S41pGT","vol_attribute":"generic","vol_desc":"","vol_path":"/volume3","vspace_can_do":{"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":49152,"stopService":false},"remove":{"can_do":true,"errCode":0,"stopService":true},"resize":{"can_do":true,"errCode":0,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}},{"atime_checked":false,"atime_opt":"relatime","cacheStatus":"","cache_advisor_running":false,"cache_disks":[],"can_assemble":false,"can_do":{"delete":true,"raid_cross":true},"container":"internal","device_type":"shr_without_disk_protect","disk_failure_number":0,"disks":[],"drive_type":0,"fs_type":"btrfs","id":"volume_1","is_acting":false,"is_actioning":false,"is_backgroundbuilding":false,"is_inode_full":false,"is_scheduled":false,"is_writable":true,"last_done_time":0,"limited_disk_number":24,"max_fs_size":"1152921504606846976","metadata_cache_hard_lower_bound_byte":2705326080,"metadata_cache_option_show":true,"missing_drives":[],"next_schedule_time":0,"num_id":1,"pool_path":"reuse_1","progress":{"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0},"raidType":"multiple","repair_action":"none","scrubbingStatus":"","show_assemble_btn":false,"size":{"free_inode":"0","total":"13429160144896","total_device":"13988708483072","total_inode":"0","used":"23326720"},"space_status":{"detail":"pool_normal","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"fs_normal","summary_status":"normal"},"ssd_trim":{"support":"not support"},"status":"normal","suggestions":[],"summary_status":"normal","timebackup":false,"used_by_gluster":false,"uuid":"rt9zUF-0o0r-xHLv-1q7R-gOlL-0GYe-sxAmy5","vol_attribute":"generic","vol_desc":"","vol_path":"/volume1","vspace_can_do":{"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":49152,"stopService":false},"remove":{"can_do":true,"errCode":0,"stopService":true},"resize":{"can_do":true,"errCode":0,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}}]

class Storage extends BaseModel {
  Storage({
    this.detectedPools,
    this.disks,
    this.env,
    this.missingPools,
    this.overviewData,
    this.ports,
    this.sharedCaches,
    this.ssdCaches,
    this.storagePools,
    this.volumes,
  });

  static Future<Storage> loadInfo() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Storage.CGI.Storage",
      "load_info",
      parser: Storage.fromJson,
    );
    return res.data;
  }

  fromJson(dynamic json) {
    return Storage.fromJson(json);
  }

  Storage.fromJson(dynamic json) {
    if (json['detected_pools'] != null) {
      detectedPools = json['detected_pools'];
      // json['detected_pools'].forEach((v) {
      //   detectedPools?.add(Dynamic.fromJson(v));
      // });
    }
    if (json['disks'] != null) {
      disks = [];
      json['disks'].forEach((v) {
        disks?.add(Disks.fromJson(v));
      });
    }
    env = json['env'] != null ? Env.fromJson(json['env']) : null;
    if (json['missing_pools'] != null) {
      missingPools = json['missing_pools'];
      // json['missing_pools'].forEach((v) {
      //   missingPools?.add(Dynamic.fromJson(v));
      // });
    }
    overviewData = json['overview_data'] != null ? OverviewData.fromJson(json['overview_data']) : null;
    if (json['ports'] != null) {
      ports = json['ports'];
      // json['ports'].forEach((v) {
      //   ports?.add(Dynamic.fromJson(v));
      // });
    }
    if (json['sharedCaches'] != null) {
      sharedCaches = json['sharedCaches'];
      // json['sharedCaches'].forEach((v) {
      //   sharedCaches?.add(Dynamic.fromJson(v));
      // });
    }
    if (json['ssdCaches'] != null) {
      ssdCaches = [];
      json['ssdCaches'].forEach((v) {
        ssdCaches?.add(Volumes.fromJson(v));
      });
      ssdCaches!.sort((a, b) {
        return a.numId!.compareTo(b.numId!);
      });
    }
    if (json['storagePools'] != null) {
      storagePools = [];
      json['storagePools'].forEach((v) {
        storagePools?.add(StoragePools.fromJson(v));
      });
    }
    if (json['volumes'] != null) {
      volumes = [];
      json['volumes'].forEach((v) {
        volumes?.add(Volumes.fromJson(v));
      });
      volumes!.sort((a, b) {
        return a.numId!.compareTo(b.numId!);
      });
    }
  }
  String? api = "SYNO.Storage.CGI.Storage";
  String? method = "load_info";
  int? version = 1;
  List<dynamic>? detectedPools;
  List<Disks>? disks;
  Env? env;
  List<dynamic>? missingPools;
  OverviewData? overviewData;
  List<dynamic>? ports;
  List<dynamic>? sharedCaches;
  List<Volumes>? ssdCaches;
  List<StoragePools>? storagePools;
  List<Volumes>? volumes;
  Storage copyWith({
    List<dynamic>? detectedPools,
    List<Disks>? disks,
    Env? env,
    List<dynamic>? missingPools,
    OverviewData? overviewData,
    List<dynamic>? ports,
    List<dynamic>? sharedCaches,
    List<Volumes>? ssdCaches,
    List<StoragePools>? storagePools,
    List<Volumes>? volumes,
  }) =>
      Storage(
        detectedPools: detectedPools ?? this.detectedPools,
        disks: disks ?? this.disks,
        env: env ?? this.env,
        missingPools: missingPools ?? this.missingPools,
        overviewData: overviewData ?? this.overviewData,
        ports: ports ?? this.ports,
        sharedCaches: sharedCaches ?? this.sharedCaches,
        ssdCaches: ssdCaches ?? this.ssdCaches,
        storagePools: storagePools ?? this.storagePools,
        volumes: volumes ?? this.volumes,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (detectedPools != null) {
      map['detected_pools'] = detectedPools?.map((v) => v.toJson()).toList();
    }
    if (disks != null) {
      map['disks'] = disks?.map((v) => v.toJson()).toList();
    }
    if (env != null) {
      map['env'] = env?.toJson();
    }
    if (missingPools != null) {
      map['missing_pools'] = missingPools?.map((v) => v.toJson()).toList();
    }
    if (overviewData != null) {
      map['overview_data'] = overviewData?.toJson();
    }
    if (ports != null) {
      map['ports'] = ports?.map((v) => v.toJson()).toList();
    }
    if (sharedCaches != null) {
      map['sharedCaches'] = sharedCaches?.map((v) => v.toJson()).toList();
    }
    if (ssdCaches != null) {
      map['ssdCaches'] = ssdCaches?.map((v) => v.toJson()).toList();
    }
    if (storagePools != null) {
      map['storagePools'] = storagePools?.map((v) => v.toJson()).toList();
    }
    if (volumes != null) {
      map['volumes'] = volumes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// atime_checked : false
/// atime_opt : "relatime"
/// cacheStatus : ""
/// cache_advisor_running : false
/// cache_disks : []
/// can_assemble : false
/// can_do : {"convert_shr_to_pool":2,"delete":true,"expand_by_disk":1,"migrate":{"to_shr2":3},"raid_cross":true}
/// container : "internal"
/// deploy_path : "volume_4"
/// desc : "西数12T"
/// device_type : "shr_without_disk_protect"
/// disk_failure_number : 0
/// disks : []
/// drive_type : 0
/// fs_type : "btrfs"
/// id : "volume_4"
/// is_acting : false
/// is_actioning : false
/// is_backgroundbuilding : false
/// is_inode_full : false
/// is_scheduled : true
/// is_writable : true
/// last_done_time : 0
/// limited_disk_number : 24
/// max_fs_size : "1152921504606846976"
/// metadata_cache_hard_lower_bound_byte : 202689740800
/// metadata_cache_option_show : true
/// missing_drives : []
/// next_schedule_time : 0
/// num_id : 4
/// pool_path : "reuse_4"
/// progress : {"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0}
/// raidType : "single"
/// repair_action : "none"
/// scrubbingStatus : "ready"
/// show_assemble_btn : false
/// size : {"free_inode":"0","total":"11515377745920","total_device":"11995185152000","total_inode":"0","used":"11463320182784"}
/// space_path : "/dev/vg1002/lv"
/// space_status : {"detail":"fs_almost_full","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"fs_almost_full","summary_status":"attention"}
/// ssd_trim : {"support":"not support"}
/// status : "attention"
/// suggestions : []
/// summary_status : "attention"
/// timebackup : false
/// used_by_gluster : false
/// uuid : "Ufsj6M-9MPK-ehDx-O0bR-RDJg-pnuO-f5H3yy"
/// vol_attribute : "generic"
/// vol_desc : ""
/// vol_path : "/volume4"
/// vspace_can_do : {"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":49152,"stopService":false},"remove":{"can_do":true,"errCode":0,"stopService":true},"resize":{"can_do":true,"errCode":0,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}

class Volumes {
  Volumes({
    this.atimeChecked,
    this.atimeOpt,
    this.cacheStatus,
    this.cacheAdvisorRunning,
    this.cacheDisks,
    this.canAssemble,
    this.canDo,
    this.container,
    this.deployPath,
    this.desc,
    this.deviceType,
    this.diskFailureNumber,
    this.disks,
    this.driveType,
    this.fsType,
    this.id,
    this.isActing,
    this.isActioning,
    this.isBackgroundbuilding,
    this.isInodeFull,
    this.isScheduled,
    this.isWritable,
    this.lastDoneTime,
    this.limitedDiskNumber,
    this.maxFsSize,
    this.metadataCacheHardLowerBoundByte,
    this.metadataCacheOptionShow,
    this.missingDrives,
    this.nextScheduleTime,
    this.numId,
    this.poolPath,
    this.progress,
    this.raidType,
    this.repairAction,
    this.scrubbingStatus,
    this.showAssembleBtn,
    this.size,
    this.spacePath,
    this.spaceStatus,
    this.ssdTrim,
    this.status,
    this.suggestions,
    this.summaryStatus,
    this.timebackup,
    this.usedByGluster,
    this.uuid,
    this.volAttribute,
    this.volDesc,
    this.volPath,
    this.vspaceCanDo,
  });

  Volumes.fromJson(dynamic json) {
    atimeChecked = json['atime_checked'];
    atimeOpt = json['atime_opt'];
    cacheStatus = json['cacheStatus'];
    cacheAdvisorRunning = json['cache_advisor_running'];
    if (json['cache_disks'] != null) {
      cacheDisks = json['cache_disks'];
      // json['cache_disks'].forEach((v) {
      //   cacheDisks?.add(Dynamic.fromJson(v));
      // });
    }
    canAssemble = json['can_assemble'];
    canDo = json['can_do'] != null ? CanDo.fromJson(json['can_do']) : null;
    container = json['container'];
    deployPath = json['deploy_path'];
    desc = json['desc'];
    deviceType = json['device_type'];
    diskFailureNumber = json['disk_failure_number'];
    if (json['disks'] != null) {
      disks = json['disks'];
      // json['disks'].forEach((v) {
      //   disks?.add(Dynamic.fromJson(v));
      // });
    }
    driveType = json['drive_type'];
    fsType = json['fs_type'];
    id = json['id'];
    isActing = json['is_acting'];
    isActioning = json['is_actioning'];
    isBackgroundbuilding = json['is_backgroundbuilding'];
    isInodeFull = json['is_inode_full'];
    isScheduled = json['is_scheduled'];
    isWritable = json['is_writable'];
    lastDoneTime = json['last_done_time'];
    limitedDiskNumber = json['limited_disk_number'];
    maxFsSize = json['max_fs_size'];
    metadataCacheHardLowerBoundByte = json['metadata_cache_hard_lower_bound_byte'];
    metadataCacheOptionShow = json['metadata_cache_option_show'];
    if (json['missing_drives'] != null) {
      missingDrives = json['missing_drives'];
      // json['missing_drives'].forEach((v) {
      //   missingDrives?.add(Dynamic.fromJson(v));
      // });
    }
    nextScheduleTime = json['next_schedule_time'];
    numId = json['num_id'];
    poolPath = json['pool_path'];
    progress = json['progress'] != null ? Progress.fromJson(json['progress']) : null;
    raidType = json['raidType'];
    repairAction = json['repair_action'];
    scrubbingStatus = json['scrubbingStatus'];
    showAssembleBtn = json['show_assemble_btn'];
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
    spacePath = json['space_path'];
    spaceStatus = json['space_status'] != null ? SpaceStatus.fromJson(json['space_status']) : null;
    ssdTrim = json['ssd_trim'] != null ? SsdTrim.fromJson(json['ssd_trim']) : null;
    status = json['status'];
    if (json['suggestions'] != null) {
      suggestions = json['suggestions'];
      // json['suggestions'].forEach((v) {
      //   suggestions?.add(Dynamic.fromJson(v));
      // });
    }
    summaryStatus = json['summary_status'];
    timebackup = json['timebackup'];
    usedByGluster = json['used_by_gluster'];
    uuid = json['uuid'];
    volAttribute = json['vol_attribute'];
    volDesc = json['vol_desc'];
    volPath = json['vol_path'];
    vspaceCanDo = json['vspace_can_do'] != null ? VspaceCanDo.fromJson(json['vspace_can_do']) : null;
  }
  bool? atimeChecked;
  String? atimeOpt;
  String? cacheStatus;
  bool? cacheAdvisorRunning;
  List<dynamic>? cacheDisks;
  bool? canAssemble;
  CanDo? canDo;
  String? container;
  String? deployPath;

  String get displayName => "${(deployPath ?? id ?? "").replaceFirst("volume_", "存储空间 ").replaceFirst("ssd_", "SSD 缓存 ")}";

  String? desc;
  String? deviceType;
  num? diskFailureNumber;
  List<dynamic>? disks;
  num? driveType;
  String? fsType;
  String? id;
  bool? isActing;
  bool? isActioning;
  bool? isBackgroundbuilding;
  bool? isInodeFull;
  bool? isScheduled;
  bool? isWritable;
  num? lastDoneTime;
  num? limitedDiskNumber;
  String? maxFsSize;
  num? metadataCacheHardLowerBoundByte;
  bool? metadataCacheOptionShow;
  List<dynamic>? missingDrives;
  num? nextScheduleTime;
  num? numId;
  String? poolPath;
  Progress? progress;
  String? raidType;
  String? repairAction;
  String? scrubbingStatus;
  bool? showAssembleBtn;
  Size? size;
  String? spacePath;
  SpaceStatus? spaceStatus;
  SsdTrim? ssdTrim;
  String? status;
  VolumeStatusEnum get statusEnum => VolumeStatusEnum.fromValue(status ?? 'unknown');
  List<dynamic>? suggestions;
  String? summaryStatus;
  bool? timebackup;
  bool? usedByGluster;
  String? uuid;
  String? volAttribute;
  String? volDesc;
  String? volPath;
  VspaceCanDo? vspaceCanDo;
  Volumes copyWith({
    bool? atimeChecked,
    String? atimeOpt,
    String? cacheStatus,
    bool? cacheAdvisorRunning,
    List<dynamic>? cacheDisks,
    bool? canAssemble,
    CanDo? canDo,
    String? container,
    String? deployPath,
    String? desc,
    String? deviceType,
    num? diskFailureNumber,
    List<dynamic>? disks,
    num? driveType,
    String? fsType,
    String? id,
    bool? isActing,
    bool? isActioning,
    bool? isBackgroundbuilding,
    bool? isInodeFull,
    bool? isScheduled,
    bool? isWritable,
    num? lastDoneTime,
    num? limitedDiskNumber,
    String? maxFsSize,
    num? metadataCacheHardLowerBoundByte,
    bool? metadataCacheOptionShow,
    List<dynamic>? missingDrives,
    num? nextScheduleTime,
    num? numId,
    String? poolPath,
    Progress? progress,
    String? raidType,
    String? repairAction,
    String? scrubbingStatus,
    bool? showAssembleBtn,
    Size? size,
    String? spacePath,
    SpaceStatus? spaceStatus,
    SsdTrim? ssdTrim,
    String? status,
    List<dynamic>? suggestions,
    String? summaryStatus,
    bool? timebackup,
    bool? usedByGluster,
    String? uuid,
    String? volAttribute,
    String? volDesc,
    String? volPath,
    VspaceCanDo? vspaceCanDo,
  }) =>
      Volumes(
        atimeChecked: atimeChecked ?? this.atimeChecked,
        atimeOpt: atimeOpt ?? this.atimeOpt,
        cacheStatus: cacheStatus ?? this.cacheStatus,
        cacheAdvisorRunning: cacheAdvisorRunning ?? this.cacheAdvisorRunning,
        cacheDisks: cacheDisks ?? this.cacheDisks,
        canAssemble: canAssemble ?? this.canAssemble,
        canDo: canDo ?? this.canDo,
        container: container ?? this.container,
        deployPath: deployPath ?? this.deployPath,
        desc: desc ?? this.desc,
        deviceType: deviceType ?? this.deviceType,
        diskFailureNumber: diskFailureNumber ?? this.diskFailureNumber,
        disks: disks ?? this.disks,
        driveType: driveType ?? this.driveType,
        fsType: fsType ?? this.fsType,
        id: id ?? this.id,
        isActing: isActing ?? this.isActing,
        isActioning: isActioning ?? this.isActioning,
        isBackgroundbuilding: isBackgroundbuilding ?? this.isBackgroundbuilding,
        isInodeFull: isInodeFull ?? this.isInodeFull,
        isScheduled: isScheduled ?? this.isScheduled,
        isWritable: isWritable ?? this.isWritable,
        lastDoneTime: lastDoneTime ?? this.lastDoneTime,
        limitedDiskNumber: limitedDiskNumber ?? this.limitedDiskNumber,
        maxFsSize: maxFsSize ?? this.maxFsSize,
        metadataCacheHardLowerBoundByte: metadataCacheHardLowerBoundByte ?? this.metadataCacheHardLowerBoundByte,
        metadataCacheOptionShow: metadataCacheOptionShow ?? this.metadataCacheOptionShow,
        missingDrives: missingDrives ?? this.missingDrives,
        nextScheduleTime: nextScheduleTime ?? this.nextScheduleTime,
        numId: numId ?? this.numId,
        poolPath: poolPath ?? this.poolPath,
        progress: progress ?? this.progress,
        raidType: raidType ?? this.raidType,
        repairAction: repairAction ?? this.repairAction,
        scrubbingStatus: scrubbingStatus ?? this.scrubbingStatus,
        showAssembleBtn: showAssembleBtn ?? this.showAssembleBtn,
        size: size ?? this.size,
        spacePath: spacePath ?? this.spacePath,
        spaceStatus: spaceStatus ?? this.spaceStatus,
        ssdTrim: ssdTrim ?? this.ssdTrim,
        status: status ?? this.status,
        suggestions: suggestions ?? this.suggestions,
        summaryStatus: summaryStatus ?? this.summaryStatus,
        timebackup: timebackup ?? this.timebackup,
        usedByGluster: usedByGluster ?? this.usedByGluster,
        uuid: uuid ?? this.uuid,
        volAttribute: volAttribute ?? this.volAttribute,
        volDesc: volDesc ?? this.volDesc,
        volPath: volPath ?? this.volPath,
        vspaceCanDo: vspaceCanDo ?? this.vspaceCanDo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['atime_checked'] = atimeChecked;
    map['atime_opt'] = atimeOpt;
    map['cacheStatus'] = cacheStatus;
    map['cache_advisor_running'] = cacheAdvisorRunning;
    if (cacheDisks != null) {
      map['cache_disks'] = cacheDisks?.map((v) => v.toJson()).toList();
    }
    map['can_assemble'] = canAssemble;
    if (canDo != null) {
      map['can_do'] = canDo?.toJson();
    }
    map['container'] = container;
    map['deploy_path'] = deployPath;
    map['desc'] = desc;
    map['device_type'] = deviceType;
    map['disk_failure_number'] = diskFailureNumber;
    if (disks != null) {
      map['disks'] = disks?.map((v) => v.toJson()).toList();
    }
    map['drive_type'] = driveType;
    map['fs_type'] = fsType;
    map['id'] = id;
    map['is_acting'] = isActing;
    map['is_actioning'] = isActioning;
    map['is_backgroundbuilding'] = isBackgroundbuilding;
    map['is_inode_full'] = isInodeFull;
    map['is_scheduled'] = isScheduled;
    map['is_writable'] = isWritable;
    map['last_done_time'] = lastDoneTime;
    map['limited_disk_number'] = limitedDiskNumber;
    map['max_fs_size'] = maxFsSize;
    map['metadata_cache_hard_lower_bound_byte'] = metadataCacheHardLowerBoundByte;
    map['metadata_cache_option_show'] = metadataCacheOptionShow;
    if (missingDrives != null) {
      map['missing_drives'] = missingDrives?.map((v) => v.toJson()).toList();
    }
    map['next_schedule_time'] = nextScheduleTime;
    map['num_id'] = numId;
    map['pool_path'] = poolPath;
    if (progress != null) {
      map['progress'] = progress?.toJson();
    }
    map['raidType'] = raidType;
    map['repair_action'] = repairAction;
    map['scrubbingStatus'] = scrubbingStatus;
    map['show_assemble_btn'] = showAssembleBtn;
    if (size != null) {
      map['size'] = size?.toJson();
    }
    map['space_path'] = spacePath;
    if (spaceStatus != null) {
      map['space_status'] = spaceStatus?.toJson();
    }
    if (ssdTrim != null) {
      map['ssd_trim'] = ssdTrim?.toJson();
    }
    map['status'] = status;
    if (suggestions != null) {
      map['suggestions'] = suggestions?.map((v) => v.toJson()).toList();
    }
    map['summary_status'] = summaryStatus;
    map['timebackup'] = timebackup;
    map['used_by_gluster'] = usedByGluster;
    map['uuid'] = uuid;
    map['vol_attribute'] = volAttribute;
    map['vol_desc'] = volDesc;
    map['vol_path'] = volPath;
    if (vspaceCanDo != null) {
      map['vspace_can_do'] = vspaceCanDo?.toJson();
    }
    return map;
  }
}

/// drbd : {"resize":{"can_do":false,"errCode":53504,"stopService":false}}
/// flashcache : {"apply":{"can_do":false,"errCode":49152,"stopService":false},"remove":{"can_do":true,"errCode":0,"stopService":true},"resize":{"can_do":true,"errCode":0,"stopService":false}}
/// snapshot : {"resize":{"can_do":false,"errCode":53504,"stopService":false}}

class VspaceCanDo {
  VspaceCanDo({
    this.drbd,
    this.flashcache,
    this.snapshot,
  });

  VspaceCanDo.fromJson(dynamic json) {
    drbd = json['drbd'] != null ? Drbd.fromJson(json['drbd']) : null;
    flashcache = json['flashcache'] != null ? Flashcache.fromJson(json['flashcache']) : null;
    snapshot = json['snapshot'] != null ? Snapshot.fromJson(json['snapshot']) : null;
  }
  Drbd? drbd;
  Flashcache? flashcache;
  Snapshot? snapshot;
  VspaceCanDo copyWith({
    Drbd? drbd,
    Flashcache? flashcache,
    Snapshot? snapshot,
  }) =>
      VspaceCanDo(
        drbd: drbd ?? this.drbd,
        flashcache: flashcache ?? this.flashcache,
        snapshot: snapshot ?? this.snapshot,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (drbd != null) {
      map['drbd'] = drbd?.toJson();
    }
    if (flashcache != null) {
      map['flashcache'] = flashcache?.toJson();
    }
    if (snapshot != null) {
      map['snapshot'] = snapshot?.toJson();
    }
    return map;
  }
}

class MissingDrives {
  MissingDrives({
    this.containerId,
    this.diskType,
    this.diskOrderId,
    this.i18nNamingInfo,
    this.mediumType,
    this.model,
    this.name,
    this.numId,
    this.pciSlot,
    this.portType,
    this.serial,
    this.sizeTotal,
    this.usage,
    this.vendor,
  });

  MissingDrives.fromJson(dynamic json) {
    containerId = json['container_id'];
    diskType = json['diskType'];
    diskOrderId = json['disk_order_id'];
    i18nNamingInfo = json['i18nNamingInfo'];
    mediumType = json['mediumType'];
    model = json['model'];
    name = json['name'];
    numId = json['num_id'];
    pciSlot = json['pciSlot'];
    portType = json['portType'];
    serial = json['serial'];
    sizeTotal = json['size_total'];
    usage = json['usage'];
    vendor = json['vendor'];
  }
  num? containerId;
  String? diskType;
  num? diskOrderId;
  String? i18nNamingInfo;
  String? mediumType;
  String? model;
  String? name;
  num? numId;
  num? pciSlot;
  String? portType;
  String? serial;
  num? sizeTotal;
  String? usage;
  String? vendor;
  MissingDrives copyWith({
    num? containerId,
    String? diskType,
    num? diskOrderId,
    String? i18nNamingInfo,
    String? mediumType,
    String? model,
    String? name,
    num? numId,
    num? pciSlot,
    String? portType,
    String? serial,
    num? sizeTotal,
    String? usage,
    String? vendor,
  }) =>
      MissingDrives(
        containerId: containerId ?? this.containerId,
        diskType: diskType ?? this.diskType,
        diskOrderId: diskOrderId ?? this.diskOrderId,
        i18nNamingInfo: i18nNamingInfo ?? this.i18nNamingInfo,
        mediumType: mediumType ?? this.mediumType,
        model: model ?? this.model,
        name: name ?? this.name,
        numId: numId ?? this.numId,
        pciSlot: pciSlot ?? this.pciSlot,
        portType: portType ?? this.portType,
        serial: serial ?? this.serial,
        sizeTotal: sizeTotal ?? this.sizeTotal,
        usage: usage ?? this.usage,
        vendor: vendor ?? this.vendor,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['container_id'] = containerId;
    map['diskType'] = diskType;
    map['disk_order_id'] = diskOrderId;
    map['i18nNamingInfo'] = i18nNamingInfo;
    map['mediumType'] = mediumType;
    map['model'] = model;
    map['name'] = name;
    map['num_id'] = numId;
    map['pciSlot'] = pciSlot;
    map['portType'] = portType;
    map['serial'] = serial;
    map['size_total'] = sizeTotal;
    map['usage'] = usage;
    map['vendor'] = vendor;
    return map;
  }
}

/// resize : {"can_do":false,"errCode":53504,"stopService":false}

class Snapshot {
  Snapshot({
    this.resize,
  });

  Snapshot.fromJson(dynamic json) {
    resize = json['resize'] != null ? Resize.fromJson(json['resize']) : null;
  }
  Resize? resize;
  Snapshot copyWith({
    Resize? resize,
  }) =>
      Snapshot(
        resize: resize ?? this.resize,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (resize != null) {
      map['resize'] = resize?.toJson();
    }
    return map;
  }
}

/// can_do : false
/// errCode : 53504
/// stopService : false

class Resize {
  Resize({
    this.canDo,
    this.errCode,
    this.stopService,
  });

  Resize.fromJson(dynamic json) {
    canDo = json['can_do'];
    errCode = json['errCode'];
    stopService = json['stopService'];
  }
  bool? canDo;
  num? errCode;
  bool? stopService;
  Resize copyWith({
    bool? canDo,
    num? errCode,
    bool? stopService,
  }) =>
      Resize(
        canDo: canDo ?? this.canDo,
        errCode: errCode ?? this.errCode,
        stopService: stopService ?? this.stopService,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_do'] = canDo;
    map['errCode'] = errCode;
    map['stopService'] = stopService;
    return map;
  }
}

/// apply : {"can_do":false,"errCode":49152,"stopService":false}
/// remove : {"can_do":true,"errCode":0,"stopService":true}
/// resize : {"can_do":true,"errCode":0,"stopService":false}

class Flashcache {
  Flashcache({
    this.apply,
    this.remove,
    this.resize,
  });

  Flashcache.fromJson(dynamic json) {
    apply = json['apply'] != null ? Apply.fromJson(json['apply']) : null;
    remove = json['remove'] != null ? Remove.fromJson(json['remove']) : null;
    resize = json['resize'] != null ? Resize.fromJson(json['resize']) : null;
  }
  Apply? apply;
  Remove? remove;
  Resize? resize;
  Flashcache copyWith({
    Apply? apply,
    Remove? remove,
    Resize? resize,
  }) =>
      Flashcache(
        apply: apply ?? this.apply,
        remove: remove ?? this.remove,
        resize: resize ?? this.resize,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (apply != null) {
      map['apply'] = apply?.toJson();
    }
    if (remove != null) {
      map['remove'] = remove?.toJson();
    }
    if (resize != null) {
      map['resize'] = resize?.toJson();
    }
    return map;
  }
}

/// can_do : true
/// errCode : 0
/// stopService : true

class Remove {
  Remove({
    this.canDo,
    this.errCode,
    this.stopService,
  });

  Remove.fromJson(dynamic json) {
    canDo = json['can_do'];
    errCode = json['errCode'];
    stopService = json['stopService'];
  }
  bool? canDo;
  num? errCode;
  bool? stopService;
  Remove copyWith({
    bool? canDo,
    num? errCode,
    bool? stopService,
  }) =>
      Remove(
        canDo: canDo ?? this.canDo,
        errCode: errCode ?? this.errCode,
        stopService: stopService ?? this.stopService,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_do'] = canDo;
    map['errCode'] = errCode;
    map['stopService'] = stopService;
    return map;
  }
}

/// can_do : false
/// errCode : 49152
/// stopService : false

class Apply {
  Apply({
    this.canDo,
    this.errCode,
    this.stopService,
  });

  Apply.fromJson(dynamic json) {
    canDo = json['can_do'];
    errCode = json['errCode'];
    stopService = json['stopService'];
  }
  bool? canDo;
  num? errCode;
  bool? stopService;
  Apply copyWith({
    bool? canDo,
    num? errCode,
    bool? stopService,
  }) =>
      Apply(
        canDo: canDo ?? this.canDo,
        errCode: errCode ?? this.errCode,
        stopService: stopService ?? this.stopService,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_do'] = canDo;
    map['errCode'] = errCode;
    map['stopService'] = stopService;
    return map;
  }
}

/// resize : {"can_do":false,"errCode":53504,"stopService":false}

class Drbd {
  Drbd({
    this.resize,
  });

  Drbd.fromJson(dynamic json) {
    resize = json['resize'] != null ? Resize.fromJson(json['resize']) : null;
  }
  Resize? resize;
  Drbd copyWith({
    Resize? resize,
  }) =>
      Drbd(
        resize: resize ?? this.resize,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (resize != null) {
      map['resize'] = resize?.toJson();
    }
    return map;
  }
}

/// support : "not support"

class SsdTrim {
  SsdTrim({
    this.support,
  });

  SsdTrim.fromJson(dynamic json) {
    support = json['support'];
  }
  String? support;
  SsdTrim copyWith({
    String? support,
  }) =>
      SsdTrim(
        support: support ?? this.support,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['support'] = support;
    return map;
  }
}

/// detail : "fs_almost_full"
/// show_attention : false
/// show_danger : false
/// show_flag_detail : ""
/// status : "fs_almost_full"
/// summary_status : "attention"

class SpaceStatus {
  SpaceStatus({
    this.detail,
    this.showAttention,
    this.showDanger,
    this.showFlagDetail,
    this.status,
    this.summaryStatus,
  });

  SpaceStatus.fromJson(dynamic json) {
    detail = json['detail'];
    showAttention = json['show_attention'];
    showDanger = json['show_danger'];
    showFlagDetail = json['show_flag_detail'];
    status = json['status'];
    summaryStatus = json['summary_status'];
  }
  String? detail;
  bool? showAttention;
  bool? showDanger;
  String? showFlagDetail;
  String? status;
  String? summaryStatus;
  SpaceStatus copyWith({
    String? detail,
    bool? showAttention,
    bool? showDanger,
    String? showFlagDetail,
    String? status,
    String? summaryStatus,
  }) =>
      SpaceStatus(
        detail: detail ?? this.detail,
        showAttention: showAttention ?? this.showAttention,
        showDanger: showDanger ?? this.showDanger,
        showFlagDetail: showFlagDetail ?? this.showFlagDetail,
        status: status ?? this.status,
        summaryStatus: summaryStatus ?? this.summaryStatus,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detail'] = detail;
    map['show_attention'] = showAttention;
    map['show_danger'] = showDanger;
    map['show_flag_detail'] = showFlagDetail;
    map['status'] = status;
    map['summary_status'] = summaryStatus;
    return map;
  }
}

/// free_inode : "0"
/// total : "11515377745920"
/// total_device : "11995185152000"
/// total_inode : "0"
/// used : "11463320182784"

class Size {
  Size({
    this.freeInode,
    this.total,
    this.totalDevice,
    this.totalInode,
    this.used,
  });

  Size.fromJson(dynamic json) {
    freeInode = json['free_inode'];
    total = int.parse(json['total'] ?? '0');
    totalDevice = json['total_device'];
    totalInode = json['total_inode'];
    used = int.parse(json['used'] ?? '0');
  }
  String? freeInode;
  int? total;
  String? totalDevice;
  String? totalInode;
  int? used;

  int? get free => total != null && used != null ? total! - used! : null;

  double get usedPercent => total != null && used != null ? used! / total! * 100 : 0;
  Size copyWith({
    String? freeInode,
    int? total,
    String? totalDevice,
    String? totalInode,
    int? used,
  }) =>
      Size(
        freeInode: freeInode ?? this.freeInode,
        total: total ?? this.total,
        totalDevice: totalDevice ?? this.totalDevice,
        totalInode: totalInode ?? this.totalInode,
        used: used ?? this.used,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['free_inode'] = freeInode;
    map['total'] = total;
    map['total_device'] = totalDevice;
    map['total_inode'] = totalInode;
    map['used'] = used;
    return map;
  }
}

/// cur_step : 0
/// is_resync_speed_limited : false
/// percent : "-1"
/// remaining_time : 0
/// step : "none"
/// total_step : 0

class Progress {
  Progress({
    this.curStep,
    this.isResyncSpeedLimited,
    this.percent,
    this.remainingTime,
    this.step,
    this.totalStep,
  });

  Progress.fromJson(dynamic json) {
    curStep = json['cur_step'];
    isResyncSpeedLimited = json['is_resync_speed_limited'];
    percent = json['percent'];
    remainingTime = json['remaining_time'];
    step = json['step'];
    totalStep = json['total_step'];
  }
  num? curStep;
  bool? isResyncSpeedLimited;
  String? percent;
  num? remainingTime;
  String? step;
  num? totalStep;
  Progress copyWith({
    num? curStep,
    bool? isResyncSpeedLimited,
    String? percent,
    num? remainingTime,
    String? step,
    num? totalStep,
  }) =>
      Progress(
        curStep: curStep ?? this.curStep,
        isResyncSpeedLimited: isResyncSpeedLimited ?? this.isResyncSpeedLimited,
        percent: percent ?? this.percent,
        remainingTime: remainingTime ?? this.remainingTime,
        step: step ?? this.step,
        totalStep: totalStep ?? this.totalStep,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cur_step'] = curStep;
    map['is_resync_speed_limited'] = isResyncSpeedLimited;
    map['percent'] = percent;
    map['remaining_time'] = remainingTime;
    map['step'] = step;
    map['total_step'] = totalStep;
    return map;
  }
}

/// convert_shr_to_pool : 2
/// delete : true
/// expand_by_disk : 1
/// migrate : {"to_shr2":3}
/// raid_cross : true

class CanDo {
  CanDo({
    this.convertShrToPool,
    this.delete,
    this.expandByDisk,
    this.migrate,
    this.raidCross,
  });

  CanDo.fromJson(dynamic json) {
    convertShrToPool = json['convert_shr_to_pool'];
    delete = json['delete'];
    expandByDisk = json['expand_by_disk'];
    migrate = json['migrate'] != null ? Migrate.fromJson(json['migrate']) : null;
    raidCross = json['raid_cross'];
  }
  num? convertShrToPool;
  bool? delete;
  num? expandByDisk;
  Migrate? migrate;
  bool? raidCross;
  CanDo copyWith({
    num? convertShrToPool,
    bool? delete,
    num? expandByDisk,
    Migrate? migrate,
    bool? raidCross,
  }) =>
      CanDo(
        convertShrToPool: convertShrToPool ?? this.convertShrToPool,
        delete: delete ?? this.delete,
        expandByDisk: expandByDisk ?? this.expandByDisk,
        migrate: migrate ?? this.migrate,
        raidCross: raidCross ?? this.raidCross,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['convert_shr_to_pool'] = convertShrToPool;
    map['delete'] = delete;
    map['expand_by_disk'] = expandByDisk;
    if (migrate != null) {
      map['migrate'] = migrate?.toJson();
    }
    map['raid_cross'] = raidCross;
    return map;
  }
}

/// to_shr2 : 3

class Migrate {
  Migrate({
    this.toShr2,
  });

  Migrate.fromJson(dynamic json) {
    toShr2 = json['to_shr2'];
  }
  num? toShr2;
  Migrate copyWith({
    num? toShr2,
  }) =>
      Migrate(
        toShr2: toShr2 ?? this.toShr2,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['to_shr2'] = toShr2;
    return map;
  }
}

/// cacheStatus : ""
/// cache_disks : []
/// can_assemble : false
/// can_do : {"delete":true,"expand_by_disk":1,"migrate":{"to_shr2":3},"raid_cross":true}
/// compatibility : true
/// container : "internal"
/// data_scrubbing : {"can_do_manual":true,"can_do_schedule":true,"reason":""}
/// desc : ""
/// device_type : "shr_without_disk_protect"
/// disk_failure_number : 0
/// disks : ["sdf"]
/// drive_type : 0
/// has_full_child_vol : true
/// id : "reuse_1"
/// is_actioning : false
/// is_backgroundbuilding : false
/// is_scheduled : false
/// is_writable : true
/// last_done_time : 0
/// limited_disk_number : 24
/// maximal_disk_size : "0"
/// minimal_disk_size : "13994375675904"
/// minimal_spare_size : "0"
/// missing_drives : []
/// next_schedule_time : 0
/// num_id : 1
/// pool_child : [{"id":"volume_1","size":{"total":"13988708483072"}}]
/// pool_path : "reuse_1"
/// progress : {"cur_step":0,"is_resync_speed_limited":false,"percent":"-1","remaining_time":0,"step":"none","total_step":0}
/// raidType : "multiple"
/// raids : [{"designedDiskCount":1,"devices":[{"id":"sdf","slot":0,"status":"normal"}],"hasParity":false,"minDevSize":"13994375675904","normalDevCount":1,"raidCrashedReason":0,"raidPath":"/dev/md2","raidStatus":1,"spares":[]}]
/// repair_action : "none"
/// scrubbingStatus : "ready"
/// show_assemble_btn : false
/// size : {"total":"13989526372352","used":"13988721065984"}
/// space_path : "/dev/vg1"
/// space_status : {"detail":"pool_normal","show_attention":false,"show_danger":false,"show_flag_detail":"","status":"pool_normal","summary_status":"normal"}
/// spares : []
/// status : "normal"
/// suggestions : []
/// summary_status : "normal"
/// timebackup : false
/// uuid : "QQBed0-Ysag-KFgp-2gUP-2RK7-SOve-ozRyg7"
/// vspace_can_do : {"drbd":{"resize":{"can_do":false,"errCode":53504,"stopService":false}},"flashcache":{"apply":{"can_do":false,"errCode":768,"stopService":false},"remove":{"can_do":false,"errCode":768,"stopService":false},"resize":{"can_do":false,"errCode":768,"stopService":false}},"snapshot":{"resize":{"can_do":false,"errCode":53504,"stopService":false}}}

class StoragePools {
  StoragePools({
    this.cacheStatus,
    this.cacheDisks,
    this.canAssemble,
    this.canDo,
    this.compatibility,
    this.container,
    this.dataScrubbing,
    this.desc,
    this.deviceType,
    this.diskFailureNumber,
    this.disks,
    this.driveType,
    this.hasFullChildVol,
    this.id,
    this.isActioning,
    this.isBackgroundbuilding,
    this.isScheduled,
    this.isWritable,
    this.lastDoneTime,
    this.limitedDiskNumber,
    this.maximalDiskSize,
    this.minimalDiskSize,
    this.minimalSpareSize,
    this.missingDrives,
    this.nextScheduleTime,
    this.numId,
    this.poolChild,
    this.poolPath,
    this.progress,
    this.raidType,
    this.raids,
    this.repairAction,
    this.scrubbingStatus,
    this.showAssembleBtn,
    this.size,
    this.spacePath,
    this.spaceStatus,
    this.spares,
    this.status,
    this.suggestions,
    this.summaryStatus,
    this.timebackup,
    this.uuid,
    this.vspaceCanDo,
  });

  StoragePools.fromJson(dynamic json) {
    cacheStatus = json['cacheStatus'];
    if (json['cache_disks'] != null) {
      cacheDisks = json['cache_disks'];
      // json['cache_disks'].forEach((v) {
      //   cacheDisks?.add(Dynamic.fromJson(v));
      // });
    }
    canAssemble = json['can_assemble'];
    canDo = json['can_do'] != null ? CanDo.fromJson(json['can_do']) : null;
    compatibility = json['compatibility'];
    container = json['container'];
    dataScrubbing = json['data_scrubbing'] != null ? DataScrubbing.fromJson(json['data_scrubbing']) : null;
    desc = json['desc'];
    deviceType = json['device_type'];
    diskFailureNumber = json['disk_failure_number'];
    disks = json['disks'] != null ? json['disks'].cast<String>() : [];
    driveType = json['drive_type'];
    hasFullChildVol = json['has_full_child_vol'];
    id = json['id'];
    isActioning = json['is_actioning'];
    isBackgroundbuilding = json['is_backgroundbuilding'];
    isScheduled = json['is_scheduled'];
    isWritable = json['is_writable'];
    lastDoneTime = json['last_done_time'];
    limitedDiskNumber = json['limited_disk_number'];
    maximalDiskSize = json['maximal_disk_size'];
    minimalDiskSize = json['minimal_disk_size'];
    minimalSpareSize = json['minimal_spare_size'];
    if (json['missing_drives'] != null) {
      missingDrives = [];
      json['missing_drives'].forEach((v) {
        missingDrives?.add(MissingDrives.fromJson(v));
      });
    }
    nextScheduleTime = json['next_schedule_time'];
    numId = json['num_id'];
    if (json['pool_child'] != null) {
      poolChild = [];
      json['pool_child'].forEach((v) {
        poolChild?.add(PoolChild.fromJson(v));
      });
    }
    poolPath = json['pool_path'];
    progress = json['progress'] != null ? Progress.fromJson(json['progress']) : null;
    raidType = json['raidType'];
    if (json['raids'] != null) {
      raids = [];
      json['raids'].forEach((v) {
        raids?.add(Raids.fromJson(v));
      });
    }
    repairAction = json['repair_action'];
    scrubbingStatus = json['scrubbingStatus'];
    showAssembleBtn = json['show_assemble_btn'];
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
    spacePath = json['space_path'];
    spaceStatus = json['space_status'] != null ? SpaceStatus.fromJson(json['space_status']) : null;
    if (json['spares'] != null) {
      spares = json['spares'];
      // json['spares'].forEach((v) {
      //   spares?.add(Dynamic.fromJson(v));
      // });
    }
    status = json['status'];
    if (json['suggestions'] != null) {
      suggestions = json['suggestions'];
      // json['suggestions'].forEach((v) {
      //   suggestions?.add(Dynamic.fromJson(v));
      // });
    }
    summaryStatus = json['summary_status'];
    timebackup = json['timebackup'];
    uuid = json['uuid'];
    vspaceCanDo = json['vspace_can_do'] != null ? VspaceCanDo.fromJson(json['vspace_can_do']) : null;
  }
  String? cacheStatus;
  List<dynamic>? cacheDisks;
  bool? canAssemble;
  CanDo? canDo;
  bool? compatibility;
  String? container;
  DataScrubbing? dataScrubbing;
  String? desc;
  String? deviceType; // basic(Basic) shr_without_disk_protect(Synology Hybrid RAID (SHR)) raid_0 raid_1 raid_5 raid10
  StoragePoolDeviceTypeEnum get deviceTypeEnum => StoragePoolDeviceTypeEnum.fromValue(deviceType ?? 'unknown');
  num? diskFailureNumber;
  List<String>? disks;
  num? driveType;
  bool? hasFullChildVol;
  String? id;
  bool? isActioning;
  bool? isBackgroundbuilding;
  bool? isScheduled;
  bool? isWritable;
  num? lastDoneTime;
  num? limitedDiskNumber;
  String? maximalDiskSize;
  String? minimalDiskSize;
  String? minimalSpareSize;
  List<MissingDrives>? missingDrives;
  num? nextScheduleTime;
  num? numId;
  List<PoolChild>? poolChild;
  String? poolPath;
  Progress? progress;
  String? raidType;
  List<Raids>? raids;
  String? repairAction;
  String? scrubbingStatus;
  StoragePoolScrubbingStatusEnum get scrubbingStatusEnum => StoragePoolScrubbingStatusEnum.fromValue(scrubbingStatus ?? 'unknown');
  bool? showAssembleBtn;
  Size? size;
  String? spacePath;
  SpaceStatus? spaceStatus;
  List<dynamic>? spares;
  String? status;
  VolumeStatusEnum get statusEnum => VolumeStatusEnum.fromValue(status ?? 'unknown');
  List<dynamic>? suggestions;
  String? summaryStatus;
  bool? timebackup;
  String? uuid;
  VspaceCanDo? vspaceCanDo;
  StoragePools copyWith({
    String? cacheStatus,
    List<dynamic>? cacheDisks,
    bool? canAssemble,
    CanDo? canDo,
    bool? compatibility,
    String? container,
    DataScrubbing? dataScrubbing,
    String? desc,
    String? deviceType,
    num? diskFailureNumber,
    List<String>? disks,
    num? driveType,
    bool? hasFullChildVol,
    String? id,
    bool? isActioning,
    bool? isBackgroundbuilding,
    bool? isScheduled,
    bool? isWritable,
    num? lastDoneTime,
    num? limitedDiskNumber,
    String? maximalDiskSize,
    String? minimalDiskSize,
    String? minimalSpareSize,
    List<MissingDrives>? missingDrives,
    num? nextScheduleTime,
    num? numId,
    List<PoolChild>? poolChild,
    String? poolPath,
    Progress? progress,
    String? raidType,
    List<Raids>? raids,
    String? repairAction,
    String? scrubbingStatus,
    bool? showAssembleBtn,
    Size? size,
    String? spacePath,
    SpaceStatus? spaceStatus,
    List<dynamic>? spares,
    String? status,
    List<dynamic>? suggestions,
    String? summaryStatus,
    bool? timebackup,
    String? uuid,
    VspaceCanDo? vspaceCanDo,
  }) =>
      StoragePools(
        cacheStatus: cacheStatus ?? this.cacheStatus,
        cacheDisks: cacheDisks ?? this.cacheDisks,
        canAssemble: canAssemble ?? this.canAssemble,
        canDo: canDo ?? this.canDo,
        compatibility: compatibility ?? this.compatibility,
        container: container ?? this.container,
        dataScrubbing: dataScrubbing ?? this.dataScrubbing,
        desc: desc ?? this.desc,
        deviceType: deviceType ?? this.deviceType,
        diskFailureNumber: diskFailureNumber ?? this.diskFailureNumber,
        disks: disks ?? this.disks,
        driveType: driveType ?? this.driveType,
        hasFullChildVol: hasFullChildVol ?? this.hasFullChildVol,
        id: id ?? this.id,
        isActioning: isActioning ?? this.isActioning,
        isBackgroundbuilding: isBackgroundbuilding ?? this.isBackgroundbuilding,
        isScheduled: isScheduled ?? this.isScheduled,
        isWritable: isWritable ?? this.isWritable,
        lastDoneTime: lastDoneTime ?? this.lastDoneTime,
        limitedDiskNumber: limitedDiskNumber ?? this.limitedDiskNumber,
        maximalDiskSize: maximalDiskSize ?? this.maximalDiskSize,
        minimalDiskSize: minimalDiskSize ?? this.minimalDiskSize,
        minimalSpareSize: minimalSpareSize ?? this.minimalSpareSize,
        missingDrives: missingDrives ?? this.missingDrives,
        nextScheduleTime: nextScheduleTime ?? this.nextScheduleTime,
        numId: numId ?? this.numId,
        poolChild: poolChild ?? this.poolChild,
        poolPath: poolPath ?? this.poolPath,
        progress: progress ?? this.progress,
        raidType: raidType ?? this.raidType,
        raids: raids ?? this.raids,
        repairAction: repairAction ?? this.repairAction,
        scrubbingStatus: scrubbingStatus ?? this.scrubbingStatus,
        showAssembleBtn: showAssembleBtn ?? this.showAssembleBtn,
        size: size ?? this.size,
        spacePath: spacePath ?? this.spacePath,
        spaceStatus: spaceStatus ?? this.spaceStatus,
        spares: spares ?? this.spares,
        status: status ?? this.status,
        suggestions: suggestions ?? this.suggestions,
        summaryStatus: summaryStatus ?? this.summaryStatus,
        timebackup: timebackup ?? this.timebackup,
        uuid: uuid ?? this.uuid,
        vspaceCanDo: vspaceCanDo ?? this.vspaceCanDo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cacheStatus'] = cacheStatus;
    if (cacheDisks != null) {
      map['cache_disks'] = cacheDisks?.map((v) => v.toJson()).toList();
    }
    map['can_assemble'] = canAssemble;
    if (canDo != null) {
      map['can_do'] = canDo?.toJson();
    }
    map['compatibility'] = compatibility;
    map['container'] = container;
    if (dataScrubbing != null) {
      map['data_scrubbing'] = dataScrubbing?.toJson();
    }
    map['desc'] = desc;
    map['device_type'] = deviceType;
    map['disk_failure_number'] = diskFailureNumber;
    map['disks'] = disks;
    map['drive_type'] = driveType;
    map['has_full_child_vol'] = hasFullChildVol;
    map['id'] = id;
    map['is_actioning'] = isActioning;
    map['is_backgroundbuilding'] = isBackgroundbuilding;
    map['is_scheduled'] = isScheduled;
    map['is_writable'] = isWritable;
    map['last_done_time'] = lastDoneTime;
    map['limited_disk_number'] = limitedDiskNumber;
    map['maximal_disk_size'] = maximalDiskSize;
    map['minimal_disk_size'] = minimalDiskSize;
    map['minimal_spare_size'] = minimalSpareSize;
    if (missingDrives != null) {
      map['missing_drives'] = missingDrives?.map((v) => v.toJson()).toList();
    }
    map['next_schedule_time'] = nextScheduleTime;
    map['num_id'] = numId;
    if (poolChild != null) {
      map['pool_child'] = poolChild?.map((v) => v.toJson()).toList();
    }
    map['pool_path'] = poolPath;
    if (progress != null) {
      map['progress'] = progress?.toJson();
    }
    map['raidType'] = raidType;
    if (raids != null) {
      map['raids'] = raids?.map((v) => v.toJson()).toList();
    }
    map['repair_action'] = repairAction;
    map['scrubbingStatus'] = scrubbingStatus;
    map['show_assemble_btn'] = showAssembleBtn;
    if (size != null) {
      map['size'] = size?.toJson();
    }
    map['space_path'] = spacePath;
    if (spaceStatus != null) {
      map['space_status'] = spaceStatus?.toJson();
    }
    if (spares != null) {
      map['spares'] = spares?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    if (suggestions != null) {
      map['suggestions'] = suggestions?.map((v) => v.toJson()).toList();
    }
    map['summary_status'] = summaryStatus;
    map['timebackup'] = timebackup;
    map['uuid'] = uuid;
    if (vspaceCanDo != null) {
      map['vspace_can_do'] = vspaceCanDo?.toJson();
    }
    return map;
  }
}

/// designedDiskCount : 1
/// devices : [{"id":"sdf","slot":0,"status":"normal"}]
/// hasParity : false
/// minDevSize : "13994375675904"
/// normalDevCount : 1
/// raidCrashedReason : 0
/// raidPath : "/dev/md2"
/// raidStatus : 1
/// spares : []

class Raids {
  Raids({
    this.designedDiskCount,
    this.devices,
    this.hasParity,
    this.minDevSize,
    this.normalDevCount,
    this.raidCrashedReason,
    this.raidPath,
    this.raidStatus,
    this.spares,
  });

  Raids.fromJson(dynamic json) {
    designedDiskCount = json['designedDiskCount'];
    if (json['devices'] != null) {
      devices = [];
      json['devices'].forEach((v) {
        devices?.add(Devices.fromJson(v));
      });
    }
    hasParity = json['hasParity'];
    minDevSize = json['minDevSize'];
    normalDevCount = json['normalDevCount'];
    raidCrashedReason = json['raidCrashedReason'];
    raidPath = json['raidPath'];
    raidStatus = json['raidStatus'];
    if (json['spares'] != null) {
      spares = json['spares'];
      // json['spares'].forEach((v) {
      //   spares?.add(Dynamic.fromJson(v));
      // });
    }
  }
  num? designedDiskCount;
  List<Devices>? devices;
  bool? hasParity;
  String? minDevSize;
  num? normalDevCount;
  num? raidCrashedReason;
  String? raidPath;
  num? raidStatus;
  List<dynamic>? spares;
  Raids copyWith({
    num? designedDiskCount,
    List<Devices>? devices,
    bool? hasParity,
    String? minDevSize,
    num? normalDevCount,
    num? raidCrashedReason,
    String? raidPath,
    num? raidStatus,
    List<dynamic>? spares,
  }) =>
      Raids(
        designedDiskCount: designedDiskCount ?? this.designedDiskCount,
        devices: devices ?? this.devices,
        hasParity: hasParity ?? this.hasParity,
        minDevSize: minDevSize ?? this.minDevSize,
        normalDevCount: normalDevCount ?? this.normalDevCount,
        raidCrashedReason: raidCrashedReason ?? this.raidCrashedReason,
        raidPath: raidPath ?? this.raidPath,
        raidStatus: raidStatus ?? this.raidStatus,
        spares: spares ?? this.spares,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['designedDiskCount'] = designedDiskCount;
    if (devices != null) {
      map['devices'] = devices?.map((v) => v.toJson()).toList();
    }
    map['hasParity'] = hasParity;
    map['minDevSize'] = minDevSize;
    map['normalDevCount'] = normalDevCount;
    map['raidCrashedReason'] = raidCrashedReason;
    map['raidPath'] = raidPath;
    map['raidStatus'] = raidStatus;
    if (spares != null) {
      map['spares'] = spares?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "sdf"
/// slot : 0
/// status : "normal"

class Devices {
  Devices({
    this.id,
    this.slot,
    this.status,
  });

  Devices.fromJson(dynamic json) {
    id = json['id'];
    slot = json['slot'];
    status = json['status'];
  }
  String? id;
  num? slot;
  String? status;
  Devices copyWith({
    String? id,
    num? slot,
    String? status,
  }) =>
      Devices(
        id: id ?? this.id,
        slot: slot ?? this.slot,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slot'] = slot;
    map['status'] = status;
    return map;
  }
}

/// id : "volume_1"
/// size : {"total":"13988708483072"}

class PoolChild {
  PoolChild({
    this.id,
    this.size,
  });

  PoolChild.fromJson(dynamic json) {
    id = json['id'];
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
  }
  String? id;
  Size? size;
  PoolChild copyWith({
    String? id,
    Size? size,
  }) =>
      PoolChild(
        id: id ?? this.id,
        size: size ?? this.size,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (size != null) {
      map['size'] = size?.toJson();
    }
    return map;
  }
}

/// can_do_manual : true
/// can_do_schedule : true
/// reason : ""

class DataScrubbing {
  DataScrubbing({
    this.canDoManual,
    this.canDoSchedule,
    this.reason,
    this.scheEnabled,
    this.schePoolOrder,
    this.scheStatus,
  });

  DataScrubbing.fromJson(dynamic json) {
    canDoManual = json['can_do_manual'];
    canDoSchedule = json['can_do_schedule'];
    scheEnabled = json['sche_enabled'];
    schePoolOrder = json['sche_pool_order'] != null ? json['sche_pool_order'].cast<String>() : [];
    scheStatus = json['sche_status'];
    reason = json['reason'];
  }
  bool? canDoManual;
  bool? canDoSchedule;
  String? reason;
  String? scheEnabled;
  List<String>? schePoolOrder;
  String? scheStatus;
  DataScrubbing copyWith({
    bool? canDoManual,
    bool? canDoSchedule,
    String? reason,
    String? scheEnabled,
    List<String>? schePoolOrder,
    String? scheStatus,
  }) =>
      DataScrubbing(
        canDoManual: canDoManual ?? this.canDoManual,
        canDoSchedule: canDoSchedule ?? this.canDoSchedule,
        scheEnabled: scheEnabled ?? this.scheEnabled,
        schePoolOrder: schePoolOrder ?? this.schePoolOrder,
        scheStatus: scheStatus ?? this.scheStatus,
        reason: reason ?? this.reason,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_do_manual'] = canDoManual;
    map['can_do_schedule'] = canDoSchedule;
    map['reason'] = reason;
    map['sche_enabled'] = scheEnabled;
    map['sche_pool_order'] = schePoolOrder;
    map['sche_status'] = scheStatus;
    return map;
  }
}

/// incompatible_eunit : []
/// pools_to_show : {"detected_pool":[],"storage_pool":["reuse_3","reuse_4"]}
/// sample_level_str : {"attention":"status_level_abnormal","danger":"status_level_danger","normal":"status_level_normal"}
/// space_affect_by_eunit_lost : false
/// space_affect_by_location_mismatch : false
/// status_level : "status_level_abnormal"

class OverviewData {
  OverviewData({
    this.incompatibleEunit,
    this.poolsToShow,
    this.sampleLevelStr,
    this.spaceAffectByEunitLost,
    this.spaceAffectByLocationMismatch,
    this.statusLevel,
  });

  OverviewData.fromJson(dynamic json) {
    if (json['incompatible_eunit'] != null) {
      incompatibleEunit = json['incompatible_eunit'];
      // json['incompatible_eunit'].forEach((v) {
      //   incompatibleEunit?.add(Dynamic.fromJson(v));
      // });
    }
    poolsToShow = json['pools_to_show'] != null ? PoolsToShow.fromJson(json['pools_to_show']) : null;
    sampleLevelStr = json['sample_level_str'] != null ? SampleLevelStr.fromJson(json['sample_level_str']) : null;
    spaceAffectByEunitLost = json['space_affect_by_eunit_lost'];
    spaceAffectByLocationMismatch = json['space_affect_by_location_mismatch'];
    statusLevel = json['status_level'];
  }
  List<dynamic>? incompatibleEunit;
  PoolsToShow? poolsToShow;
  SampleLevelStr? sampleLevelStr;
  bool? spaceAffectByEunitLost;
  bool? spaceAffectByLocationMismatch;
  String? statusLevel;
  OverviewData copyWith({
    List<dynamic>? incompatibleEunit,
    PoolsToShow? poolsToShow,
    SampleLevelStr? sampleLevelStr,
    bool? spaceAffectByEunitLost,
    bool? spaceAffectByLocationMismatch,
    String? statusLevel,
  }) =>
      OverviewData(
        incompatibleEunit: incompatibleEunit ?? this.incompatibleEunit,
        poolsToShow: poolsToShow ?? this.poolsToShow,
        sampleLevelStr: sampleLevelStr ?? this.sampleLevelStr,
        spaceAffectByEunitLost: spaceAffectByEunitLost ?? this.spaceAffectByEunitLost,
        spaceAffectByLocationMismatch: spaceAffectByLocationMismatch ?? this.spaceAffectByLocationMismatch,
        statusLevel: statusLevel ?? this.statusLevel,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (incompatibleEunit != null) {
      map['incompatible_eunit'] = incompatibleEunit?.map((v) => v.toJson()).toList();
    }
    if (poolsToShow != null) {
      map['pools_to_show'] = poolsToShow?.toJson();
    }
    if (sampleLevelStr != null) {
      map['sample_level_str'] = sampleLevelStr?.toJson();
    }
    map['space_affect_by_eunit_lost'] = spaceAffectByEunitLost;
    map['space_affect_by_location_mismatch'] = spaceAffectByLocationMismatch;
    map['status_level'] = statusLevel;
    return map;
  }
}

/// attention : "status_level_abnormal"
/// danger : "status_level_danger"
/// normal : "status_level_normal"

class SampleLevelStr {
  SampleLevelStr({
    this.attention,
    this.danger,
    this.normal,
  });

  SampleLevelStr.fromJson(dynamic json) {
    attention = json['attention'];
    danger = json['danger'];
    normal = json['normal'];
  }
  String? attention;
  String? danger;
  String? normal;
  SampleLevelStr copyWith({
    String? attention,
    String? danger,
    String? normal,
  }) =>
      SampleLevelStr(
        attention: attention ?? this.attention,
        danger: danger ?? this.danger,
        normal: normal ?? this.normal,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attention'] = attention;
    map['danger'] = danger;
    map['normal'] = normal;
    return map;
  }
}

/// detected_pool : []
/// storage_pool : ["reuse_3","reuse_4"]

class PoolsToShow {
  PoolsToShow({
    this.detectedPool,
    this.storagePool,
  });

  PoolsToShow.fromJson(dynamic json) {
    if (json['detected_pool'] != null) {
      detectedPool = json['detected_pool'];
      // json['detected_pool'].forEach((v) {
      //   detectedPool?.add(Dynamic.fromJson(v));
      // });
    }
    storagePool = json['storage_pool'] != null ? json['storage_pool'].cast<String>() : [];
  }
  List<dynamic>? detectedPool;
  List<String>? storagePool;
  PoolsToShow copyWith({
    List<dynamic>? detectedPool,
    List<String>? storagePool,
  }) =>
      PoolsToShow(
        detectedPool: detectedPool ?? this.detectedPool,
        storagePool: storagePool ?? this.storagePool,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (detectedPool != null) {
      map['detected_pool'] = detectedPool?.map((v) => v.toJson()).toList();
    }
    map['storage_pool'] = storagePool;
    return map;
  }
}

/// batchtask : {"max_task":64,"remain_task":64}
/// bay_number : "16"
/// cache_max_ssd_num : 6
/// data_scrubbing : {"sche_enabled":"0","sche_pool_order":["/dev/vg1002/lv","/dev/vg1001/lv"],"sche_status":"disabled"}
/// eunits : []
/// fs_acting : false
/// is_space_actioning : false
/// m2_card_info : []
/// max_fs_bytes : "118747255799808"
/// max_fs_bytes_high_end : "219902325555200"
/// model_name : "DS918+"
/// multipathStatus : "normal"
/// multipathSupport : false
/// ram_enough_for_fs_high_end : false
/// ram_size : 8
/// ram_size_required : 32
/// showpooltab : true
/// space_size_limit : {"allocatable_size":0,"is_limited":false,"size_limit":0}
/// status : {"is_support_sha_peta_volume":false,"root_size_byte":2549940224,"system_crashed":false,"system_need_repair":false,"system_rebuilding":false}
/// storageMachineInfo : [{"isInternal":true,"isSAS":false,"machineSerial":"17A0PDN881802","machineStatus":"existed","modelName":"DS918+","nameStr":"ChallengerV","order":0,"ports":[]}]
/// support : {"ebox":true,"raid_cross":true,"sysdef":true}
/// unique_key : "f97a03249c"

class Env {
  Env({
    this.batchtask,
    this.bayNumber,
    this.cacheMaxSsdNum,
    this.dataScrubbing,
    this.eunits,
    this.fsActing,
    this.isSpaceActioning,
    this.m2CardInfo,
    this.maxFsBytes,
    this.maxFsBytesHighEnd,
    this.modelName,
    this.multipathStatus,
    this.multipathSupport,
    this.ramEnoughForFsHighEnd,
    this.ramSize,
    this.ramSizeRequired,
    this.showpooltab,
    this.spaceSizeLimit,
    this.status,
    this.storageMachineInfo,
    this.support,
    this.uniqueKey,
  });

  Env.fromJson(dynamic json) {
    batchtask = json['batchtask'] != null ? Batchtask.fromJson(json['batchtask']) : null;
    bayNumber = json['bay_number'];
    cacheMaxSsdNum = json['cache_max_ssd_num'];
    dataScrubbing = json['data_scrubbing'] != null ? DataScrubbing.fromJson(json['data_scrubbing']) : null;
    if (json['eunits'] != null) {
      eunits = json['eunits'];
      // json['eunits'].forEach((v) {
      //   eunits?.add(Dynamic.fromJson(v));
      // });
    }
    fsActing = json['fs_acting'];
    isSpaceActioning = json['is_space_actioning'];
    if (json['m2_card_info'] != null) {
      m2CardInfo = json['m2_card_info'];
      // json['m2_card_info'].forEach((v) {
      //   m2CardInfo?.add(Dynamic.fromJson(v));
      // });
    }
    maxFsBytes = json['max_fs_bytes'];
    maxFsBytesHighEnd = json['max_fs_bytes_high_end'];
    modelName = json['model_name'];
    multipathStatus = json['multipathStatus'];
    multipathSupport = json['multipathSupport'];
    ramEnoughForFsHighEnd = json['ram_enough_for_fs_high_end'];
    ramSize = json['ram_size'];
    ramSizeRequired = json['ram_size_required'];
    showpooltab = json['showpooltab'];
    spaceSizeLimit = json['space_size_limit'] != null ? SpaceSizeLimit.fromJson(json['space_size_limit']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['storageMachineInfo'] != null) {
      storageMachineInfo = [];
      json['storageMachineInfo'].forEach((v) {
        storageMachineInfo?.add(StorageMachineInfo.fromJson(v));
      });
    }
    support = json['support'] != null ? Support.fromJson(json['support']) : null;
    uniqueKey = json['unique_key'];
  }
  Batchtask? batchtask;
  String? bayNumber;
  num? cacheMaxSsdNum;
  DataScrubbing? dataScrubbing;
  List<dynamic>? eunits;
  bool? fsActing;
  bool? isSpaceActioning;
  List<dynamic>? m2CardInfo;
  String? maxFsBytes;
  String? maxFsBytesHighEnd;
  String? modelName;
  String? multipathStatus;
  bool? multipathSupport;
  bool? ramEnoughForFsHighEnd;
  num? ramSize;
  num? ramSizeRequired;
  bool? showpooltab;
  SpaceSizeLimit? spaceSizeLimit;
  Status? status;
  List<StorageMachineInfo>? storageMachineInfo;
  Support? support;
  String? uniqueKey;
  Env copyWith({
    Batchtask? batchtask,
    String? bayNumber,
    num? cacheMaxSsdNum,
    DataScrubbing? dataScrubbing,
    List<dynamic>? eunits,
    bool? fsActing,
    bool? isSpaceActioning,
    List<dynamic>? m2CardInfo,
    String? maxFsBytes,
    String? maxFsBytesHighEnd,
    String? modelName,
    String? multipathStatus,
    bool? multipathSupport,
    bool? ramEnoughForFsHighEnd,
    num? ramSize,
    num? ramSizeRequired,
    bool? showpooltab,
    SpaceSizeLimit? spaceSizeLimit,
    Status? status,
    List<StorageMachineInfo>? storageMachineInfo,
    Support? support,
    String? uniqueKey,
  }) =>
      Env(
        batchtask: batchtask ?? this.batchtask,
        bayNumber: bayNumber ?? this.bayNumber,
        cacheMaxSsdNum: cacheMaxSsdNum ?? this.cacheMaxSsdNum,
        dataScrubbing: dataScrubbing ?? this.dataScrubbing,
        eunits: eunits ?? this.eunits,
        fsActing: fsActing ?? this.fsActing,
        isSpaceActioning: isSpaceActioning ?? this.isSpaceActioning,
        m2CardInfo: m2CardInfo ?? this.m2CardInfo,
        maxFsBytes: maxFsBytes ?? this.maxFsBytes,
        maxFsBytesHighEnd: maxFsBytesHighEnd ?? this.maxFsBytesHighEnd,
        modelName: modelName ?? this.modelName,
        multipathStatus: multipathStatus ?? this.multipathStatus,
        multipathSupport: multipathSupport ?? this.multipathSupport,
        ramEnoughForFsHighEnd: ramEnoughForFsHighEnd ?? this.ramEnoughForFsHighEnd,
        ramSize: ramSize ?? this.ramSize,
        ramSizeRequired: ramSizeRequired ?? this.ramSizeRequired,
        showpooltab: showpooltab ?? this.showpooltab,
        spaceSizeLimit: spaceSizeLimit ?? this.spaceSizeLimit,
        status: status ?? this.status,
        storageMachineInfo: storageMachineInfo ?? this.storageMachineInfo,
        support: support ?? this.support,
        uniqueKey: uniqueKey ?? this.uniqueKey,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (batchtask != null) {
      map['batchtask'] = batchtask?.toJson();
    }
    map['bay_number'] = bayNumber;
    map['cache_max_ssd_num'] = cacheMaxSsdNum;
    if (dataScrubbing != null) {
      map['data_scrubbing'] = dataScrubbing?.toJson();
    }
    if (eunits != null) {
      map['eunits'] = eunits?.map((v) => v.toJson()).toList();
    }
    map['fs_acting'] = fsActing;
    map['is_space_actioning'] = isSpaceActioning;
    if (m2CardInfo != null) {
      map['m2_card_info'] = m2CardInfo?.map((v) => v.toJson()).toList();
    }
    map['max_fs_bytes'] = maxFsBytes;
    map['max_fs_bytes_high_end'] = maxFsBytesHighEnd;
    map['model_name'] = modelName;
    map['multipathStatus'] = multipathStatus;
    map['multipathSupport'] = multipathSupport;
    map['ram_enough_for_fs_high_end'] = ramEnoughForFsHighEnd;
    map['ram_size'] = ramSize;
    map['ram_size_required'] = ramSizeRequired;
    map['showpooltab'] = showpooltab;
    if (spaceSizeLimit != null) {
      map['space_size_limit'] = spaceSizeLimit?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (storageMachineInfo != null) {
      map['storageMachineInfo'] = storageMachineInfo?.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      map['support'] = support?.toJson();
    }
    map['unique_key'] = uniqueKey;
    return map;
  }
}

/// ebox : true
/// raid_cross : true
/// sysdef : true

class Support {
  Support({
    this.ebox,
    this.raidCross,
    this.sysdef,
  });

  Support.fromJson(dynamic json) {
    ebox = json['ebox'];
    raidCross = json['raid_cross'];
    sysdef = json['sysdef'];
  }
  bool? ebox;
  bool? raidCross;
  bool? sysdef;
  Support copyWith({
    bool? ebox,
    bool? raidCross,
    bool? sysdef,
  }) =>
      Support(
        ebox: ebox ?? this.ebox,
        raidCross: raidCross ?? this.raidCross,
        sysdef: sysdef ?? this.sysdef,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ebox'] = ebox;
    map['raid_cross'] = raidCross;
    map['sysdef'] = sysdef;
    return map;
  }
}

/// isInternal : true
/// isSAS : false
/// machineSerial : "17A0PDN881802"
/// machineStatus : "existed"
/// modelName : "DS918+"
/// nameStr : "ChallengerV"
/// order : 0
/// ports : []

class StorageMachineInfo {
  StorageMachineInfo({
    this.isInternal,
    this.isSAS,
    this.machineSerial,
    this.machineStatus,
    this.modelName,
    this.nameStr,
    this.order,
    this.ports,
  });

  StorageMachineInfo.fromJson(dynamic json) {
    isInternal = json['isInternal'];
    isSAS = json['isSAS'];
    machineSerial = json['machineSerial'];
    machineStatus = json['machineStatus'];
    modelName = json['modelName'];
    nameStr = json['nameStr'];
    order = json['order'];
    if (json['ports'] != null) {
      ports = json['ports'];
      // json['ports'].forEach((v) {
      //   ports?.add(Dynamic.fromJson(v));
      // });
    }
  }
  bool? isInternal;
  bool? isSAS;
  String? machineSerial;
  String? machineStatus;
  String? modelName;
  String? nameStr;
  num? order;
  List<dynamic>? ports;
  StorageMachineInfo copyWith({
    bool? isInternal,
    bool? isSAS,
    String? machineSerial,
    String? machineStatus,
    String? modelName,
    String? nameStr,
    num? order,
    List<dynamic>? ports,
  }) =>
      StorageMachineInfo(
        isInternal: isInternal ?? this.isInternal,
        isSAS: isSAS ?? this.isSAS,
        machineSerial: machineSerial ?? this.machineSerial,
        machineStatus: machineStatus ?? this.machineStatus,
        modelName: modelName ?? this.modelName,
        nameStr: nameStr ?? this.nameStr,
        order: order ?? this.order,
        ports: ports ?? this.ports,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isInternal'] = isInternal;
    map['isSAS'] = isSAS;
    map['machineSerial'] = machineSerial;
    map['machineStatus'] = machineStatus;
    map['modelName'] = modelName;
    map['nameStr'] = nameStr;
    map['order'] = order;
    if (ports != null) {
      map['ports'] = ports?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// is_support_sha_peta_volume : false
/// root_size_byte : 2549940224
/// system_crashed : false
/// system_need_repair : false
/// system_rebuilding : false

class Status {
  Status({
    this.isSupportShaPetaVolume,
    this.rootSizeByte,
    this.systemCrashed,
    this.systemNeedRepair,
    this.systemRebuilding,
  });

  Status.fromJson(dynamic json) {
    isSupportShaPetaVolume = json['is_support_sha_peta_volume'];
    rootSizeByte = json['root_size_byte'];
    systemCrashed = json['system_crashed'];
    systemNeedRepair = json['system_need_repair'];
    systemRebuilding = json['system_rebuilding'];
  }
  bool? isSupportShaPetaVolume;
  num? rootSizeByte;
  bool? systemCrashed;
  bool? systemNeedRepair;
  bool? systemRebuilding;
  Status copyWith({
    bool? isSupportShaPetaVolume,
    num? rootSizeByte,
    bool? systemCrashed,
    bool? systemNeedRepair,
    bool? systemRebuilding,
  }) =>
      Status(
        isSupportShaPetaVolume: isSupportShaPetaVolume ?? this.isSupportShaPetaVolume,
        rootSizeByte: rootSizeByte ?? this.rootSizeByte,
        systemCrashed: systemCrashed ?? this.systemCrashed,
        systemNeedRepair: systemNeedRepair ?? this.systemNeedRepair,
        systemRebuilding: systemRebuilding ?? this.systemRebuilding,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_support_sha_peta_volume'] = isSupportShaPetaVolume;
    map['root_size_byte'] = rootSizeByte;
    map['system_crashed'] = systemCrashed;
    map['system_need_repair'] = systemNeedRepair;
    map['system_rebuilding'] = systemRebuilding;
    return map;
  }
}

/// allocatable_size : 0
/// is_limited : false
/// size_limit : 0

class SpaceSizeLimit {
  SpaceSizeLimit({
    this.allocatableSize,
    this.isLimited,
    this.sizeLimit,
  });

  SpaceSizeLimit.fromJson(dynamic json) {
    allocatableSize = json['allocatable_size'];
    isLimited = json['is_limited'];
    sizeLimit = json['size_limit'];
  }
  num? allocatableSize;
  bool? isLimited;
  num? sizeLimit;
  SpaceSizeLimit copyWith({
    num? allocatableSize,
    bool? isLimited,
    num? sizeLimit,
  }) =>
      SpaceSizeLimit(
        allocatableSize: allocatableSize ?? this.allocatableSize,
        isLimited: isLimited ?? this.isLimited,
        sizeLimit: sizeLimit ?? this.sizeLimit,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allocatable_size'] = allocatableSize;
    map['is_limited'] = isLimited;
    map['size_limit'] = sizeLimit;
    return map;
  }
}

/// max_task : 64
/// remain_task : 64

class Batchtask {
  Batchtask({
    this.maxTask,
    this.remainTask,
  });

  Batchtask.fromJson(dynamic json) {
    maxTask = json['max_task'];
    remainTask = json['remain_task'];
  }
  num? maxTask;
  num? remainTask;
  Batchtask copyWith({
    num? maxTask,
    num? remainTask,
  }) =>
      Batchtask(
        maxTask: maxTask ?? this.maxTask,
        remainTask: remainTask ?? this.remainTask,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['max_task'] = maxTask;
    map['remain_task'] = remainTask;
    return map;
  }
}

/// action : {"alert":false,"notification":false,"selectable":true,"show_lifetime_chart":true}
/// adv_progress : ""
/// adv_status : "not_support"
/// below_remain_life_mail_notify_thr : false
/// below_remain_life_show_thr : false
/// below_remain_life_thr : false
/// compatibility : "support"
/// container : {"order":0,"str":"DS918+","supportPwrBtnDisable":false,"type":"internal"}
/// container_id : 0
/// device : "/dev/sda"
/// disable_secera : false
/// diskType : "SATA"
/// disk_code : ""
/// disk_location : "Main"
/// erase_time : 510
/// firm : "MEAOA5C0"
/// firmware_status : "-"
/// has_system : true
/// hide_info : []
/// i18nNamingInfo : "[\"dsm:volume:volume_disk\",\" \",\"1\"]"
/// id : "sda"
/// ihm_testing : false
/// is4Kn : false
/// isSsd : false
/// isSynoDrive : false
/// isSynoPartition : true
/// is_bundle_ssd : false
/// is_erasing : false
/// longName : "硬盘 1"
/// model : "HUS724030ALE641"
/// name : "硬盘 1"
/// num_id : 1
/// order : 1
/// overview_status : "normal"
/// pciSlot : -1
/// perf_testing : false
/// portType : "normal"
/// remain_life : -1
/// remain_life_danger : false
/// remote_info : {"compatibility":"disabled","unc":0}
/// sb_days_left : 0
/// sb_days_left_critical : false
/// sb_days_left_warning : false
/// serial : "MJ0351YNG9HR4A"
/// size_total : "3000592982016"
/// slot_id : 1
/// smart_progress : ""
/// smart_status : "normal"
/// smart_test_limit : 0
/// smart_test_support : true
/// smart_testing : false
/// status : "normal"
/// summary_status_category : "space"
/// summary_status_key : "normal"
/// temp : 45
/// testing_progress : ""
/// testing_type : "idle"
/// tray_status : "join"
/// ui_serial : "MJ0351YNG9HR4A"
/// unc : 0
/// used_by : "reuse_3"
/// vendor : "Hitachi "
/// wcache_force_off : false
/// wcache_force_on : false
/// wdda_support : false

class Disks {
  Disks({
    this.action,
    this.advProgress,
    this.advStatus,
    this.belowRemainLifeMailNotifyThr,
    this.belowRemainLifeShowThr,
    this.belowRemainLifeThr,
    this.compatibility,
    this.container,
    this.containerId,
    this.device,
    this.disableSecera,
    this.diskType,
    this.diskCode,
    this.diskLocation,
    this.eraseTime,
    this.firm,
    this.firmwareStatus,
    this.hasSystem,
    this.hideInfo,
    this.i18nNamingInfo,
    this.id,
    this.ihmTesting,
    this.is4Kn,
    this.isSsd,
    this.isSynoDrive,
    this.isSynoPartition,
    this.isBundleSsd,
    this.isErasing,
    this.longName,
    this.model,
    this.name,
    this.numId,
    this.order,
    this.overviewStatus,
    this.pciSlot,
    this.perfTesting,
    this.portType,
    // this.remainLife,
    this.remainLifeDanger,
    this.remoteInfo,
    this.sbDaysLeft,
    this.sbDaysLeftCritical,
    this.sbDaysLeftWarning,
    this.serial,
    this.sizeTotal,
    this.slotId,
    this.smartProgress,
    this.smartStatus,
    this.smartTestLimit,
    this.smartTestSupport,
    this.smartTesting,
    this.status,
    this.summaryStatusCategory,
    this.summaryStatusKey,
    this.temp,
    this.testingProgress,
    this.testingType,
    this.trayStatus,
    this.uiSerial,
    this.unc,
    this.usedBy,
    this.vendor,
    this.wcacheForceOff,
    this.wcacheForceOn,
    this.wddaSupport,
  });

  Disks.fromJson(dynamic json) {
    action = json['action'] != null ? Action.fromJson(json['action']) : null;
    advProgress = json['adv_progress'];
    advStatus = json['adv_status'];
    belowRemainLifeMailNotifyThr = json['below_remain_life_mail_notify_thr'];
    belowRemainLifeShowThr = json['below_remain_life_show_thr'];
    belowRemainLifeThr = json['below_remain_life_thr'];
    compatibility = json['compatibility'];
    container = json['container'] != null ? StorageContainer.fromJson(json['container']) : null;
    containerId = json['container_id'];
    device = json['device'];
    disableSecera = json['disable_secera'];
    diskType = json['diskType'];
    diskCode = json['disk_code'];
    diskLocation = json['disk_location'];
    eraseTime = json['erase_time'];
    firm = json['firm'];
    firmwareStatus = json['firmware_status'];
    hasSystem = json['has_system'];
    if (json['hide_info'] != null) {
      hideInfo = json['hide_info'];
      // json['hide_info'].forEach((v) {
      //   hideInfo?.add(Dynamic.fromJson(v));
      // });
    }
    i18nNamingInfo = json['i18nNamingInfo'];
    id = json['id'];
    ihmTesting = json['ihm_testing'];
    is4Kn = json['is4Kn'];
    isSsd = json['isSsd'];
    isSynoDrive = json['isSynoDrive'];
    isSynoPartition = json['isSynoPartition'];
    isBundleSsd = json['is_bundle_ssd'];
    isErasing = json['is_erasing'];
    longName = json['longName'];
    model = json['model'];
    name = json['name'];
    numId = json['num_id'];
    order = json['order'];
    overviewStatus = json['overview_status'];
    pciSlot = json['pciSlot'];
    perfTesting = json['perf_testing'];
    portType = json['portType'];
    // remainLife = json['remain_life'];
    remainLifeDanger = json['remain_life_danger'];
    remoteInfo = json['remote_info'] != null ? RemoteInfo.fromJson(json['remote_info']) : null;
    sbDaysLeft = json['sb_days_left'];
    sbDaysLeftCritical = json['sb_days_left_critical'];
    sbDaysLeftWarning = json['sb_days_left_warning'];
    serial = json['serial'];
    sizeTotal = json['size_total'];
    slotId = json['slot_id'];
    smartProgress = json['smart_progress'];
    smartStatus = json['smart_status'];
    smartTestLimit = json['smart_test_limit'];
    smartTestSupport = json['smart_test_support'];
    smartTesting = json['smart_testing'];
    status = json['status'];
    summaryStatusCategory = json['summary_status_category'];
    summaryStatusKey = json['summary_status_key'];
    temp = json['temp'];
    testingProgress = json['testing_progress'];
    testingType = json['testing_type'];
    trayStatus = json['tray_status'];
    uiSerial = json['ui_serial'];
    unc = json['unc'];
    usedBy = json['used_by'];
    vendor = json['vendor'];
    wcacheForceOff = json['wcache_force_off'];
    wcacheForceOn = json['wcache_force_on'];
    wddaSupport = json['wdda_support'];
  }
  Action? action;
  String? advProgress;
  String? advStatus;
  bool? belowRemainLifeMailNotifyThr;
  bool? belowRemainLifeShowThr;
  bool? belowRemainLifeThr;
  String? compatibility;
  StorageContainer? container;
  num? containerId;
  String? device;
  bool? disableSecera;
  String? diskType;
  String? diskCode;
  String? diskLocation;
  num? eraseTime;
  String? firm;
  String? firmwareStatus;
  bool? hasSystem;
  List<dynamic>? hideInfo;
  String? i18nNamingInfo;
  String? id;
  bool? ihmTesting;
  bool? is4Kn;
  bool? isSsd;
  bool? isSynoDrive;
  bool? isSynoPartition;
  bool? isBundleSsd;
  bool? isErasing;
  String? longName;
  String? model;
  String? name;
  num? numId;
  num? order;
  String? overviewStatus;
  DiskOverviewStatusEnum get overviewStatusEnum => DiskOverviewStatusEnum.fromValue(overviewStatus ?? 'known');
  num? pciSlot;
  bool? perfTesting;
  String? portType;
  // num? remainLife;
  bool? remainLifeDanger;
  RemoteInfo? remoteInfo;
  num? sbDaysLeft;
  bool? sbDaysLeftCritical;
  bool? sbDaysLeftWarning;
  String? serial;
  String? sizeTotal;
  num? slotId;
  String? smartProgress;
  String? smartStatus;
  DiskSmartStatusEnum get smartStatusEnum => DiskSmartStatusEnum.fromValue(smartStatus ?? 'known');
  num? smartTestLimit;
  bool? smartTestSupport;
  bool? smartTesting;
  String? status;
  DiskStatusEnum get statusEnum => DiskStatusEnum.fromValue(status ?? 'known');
  String? summaryStatusCategory;
  String? summaryStatusKey;
  num? temp;
  String? testingProgress;
  String? testingType;
  String? trayStatus;
  String? uiSerial;
  num? unc;
  String? usedBy;
  String? vendor;
  bool? wcacheForceOff;
  bool? wcacheForceOn;
  bool? wddaSupport;
  Disks copyWith({
    Action? action,
    String? advProgress,
    String? advStatus,
    bool? belowRemainLifeMailNotifyThr,
    bool? belowRemainLifeShowThr,
    bool? belowRemainLifeThr,
    String? compatibility,
    StorageContainer? container,
    num? containerId,
    String? device,
    bool? disableSecera,
    String? diskType,
    String? diskCode,
    String? diskLocation,
    num? eraseTime,
    String? firm,
    String? firmwareStatus,
    bool? hasSystem,
    List<dynamic>? hideInfo,
    String? i18nNamingInfo,
    String? id,
    bool? ihmTesting,
    bool? is4Kn,
    bool? isSsd,
    bool? isSynoDrive,
    bool? isSynoPartition,
    bool? isBundleSsd,
    bool? isErasing,
    String? longName,
    String? model,
    String? name,
    num? numId,
    num? order,
    String? overviewStatus,
    num? pciSlot,
    bool? perfTesting,
    String? portType,
    // num? remainLife,
    bool? remainLifeDanger,
    RemoteInfo? remoteInfo,
    num? sbDaysLeft,
    bool? sbDaysLeftCritical,
    bool? sbDaysLeftWarning,
    String? serial,
    String? sizeTotal,
    num? slotId,
    String? smartProgress,
    String? smartStatus,
    num? smartTestLimit,
    bool? smartTestSupport,
    bool? smartTesting,
    String? status,
    String? summaryStatusCategory,
    String? summaryStatusKey,
    num? temp,
    String? testingProgress,
    String? testingType,
    String? trayStatus,
    String? uiSerial,
    num? unc,
    String? usedBy,
    String? vendor,
    bool? wcacheForceOff,
    bool? wcacheForceOn,
    bool? wddaSupport,
  }) =>
      Disks(
        action: action ?? this.action,
        advProgress: advProgress ?? this.advProgress,
        advStatus: advStatus ?? this.advStatus,
        belowRemainLifeMailNotifyThr: belowRemainLifeMailNotifyThr ?? this.belowRemainLifeMailNotifyThr,
        belowRemainLifeShowThr: belowRemainLifeShowThr ?? this.belowRemainLifeShowThr,
        belowRemainLifeThr: belowRemainLifeThr ?? this.belowRemainLifeThr,
        compatibility: compatibility ?? this.compatibility,
        container: container ?? this.container,
        containerId: containerId ?? this.containerId,
        device: device ?? this.device,
        disableSecera: disableSecera ?? this.disableSecera,
        diskType: diskType ?? this.diskType,
        diskCode: diskCode ?? this.diskCode,
        diskLocation: diskLocation ?? this.diskLocation,
        eraseTime: eraseTime ?? this.eraseTime,
        firm: firm ?? this.firm,
        firmwareStatus: firmwareStatus ?? this.firmwareStatus,
        hasSystem: hasSystem ?? this.hasSystem,
        hideInfo: hideInfo ?? this.hideInfo,
        i18nNamingInfo: i18nNamingInfo ?? this.i18nNamingInfo,
        id: id ?? this.id,
        ihmTesting: ihmTesting ?? this.ihmTesting,
        is4Kn: is4Kn ?? this.is4Kn,
        isSsd: isSsd ?? this.isSsd,
        isSynoDrive: isSynoDrive ?? this.isSynoDrive,
        isSynoPartition: isSynoPartition ?? this.isSynoPartition,
        isBundleSsd: isBundleSsd ?? this.isBundleSsd,
        isErasing: isErasing ?? this.isErasing,
        longName: longName ?? this.longName,
        model: model ?? this.model,
        name: name ?? this.name,
        numId: numId ?? this.numId,
        order: order ?? this.order,
        overviewStatus: overviewStatus ?? this.overviewStatus,
        pciSlot: pciSlot ?? this.pciSlot,
        perfTesting: perfTesting ?? this.perfTesting,
        portType: portType ?? this.portType,
        // remainLife: remainLife ?? this.remainLife,
        remainLifeDanger: remainLifeDanger ?? this.remainLifeDanger,
        remoteInfo: remoteInfo ?? this.remoteInfo,
        sbDaysLeft: sbDaysLeft ?? this.sbDaysLeft,
        sbDaysLeftCritical: sbDaysLeftCritical ?? this.sbDaysLeftCritical,
        sbDaysLeftWarning: sbDaysLeftWarning ?? this.sbDaysLeftWarning,
        serial: serial ?? this.serial,
        sizeTotal: sizeTotal ?? this.sizeTotal,
        slotId: slotId ?? this.slotId,
        smartProgress: smartProgress ?? this.smartProgress,
        smartStatus: smartStatus ?? this.smartStatus,
        smartTestLimit: smartTestLimit ?? this.smartTestLimit,
        smartTestSupport: smartTestSupport ?? this.smartTestSupport,
        smartTesting: smartTesting ?? this.smartTesting,
        status: status ?? this.status,
        summaryStatusCategory: summaryStatusCategory ?? this.summaryStatusCategory,
        summaryStatusKey: summaryStatusKey ?? this.summaryStatusKey,
        temp: temp ?? this.temp,
        testingProgress: testingProgress ?? this.testingProgress,
        testingType: testingType ?? this.testingType,
        trayStatus: trayStatus ?? this.trayStatus,
        uiSerial: uiSerial ?? this.uiSerial,
        unc: unc ?? this.unc,
        usedBy: usedBy ?? this.usedBy,
        vendor: vendor ?? this.vendor,
        wcacheForceOff: wcacheForceOff ?? this.wcacheForceOff,
        wcacheForceOn: wcacheForceOn ?? this.wcacheForceOn,
        wddaSupport: wddaSupport ?? this.wddaSupport,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (action != null) {
      map['action'] = action?.toJson();
    }
    map['adv_progress'] = advProgress;
    map['adv_status'] = advStatus;
    map['below_remain_life_mail_notify_thr'] = belowRemainLifeMailNotifyThr;
    map['below_remain_life_show_thr'] = belowRemainLifeShowThr;
    map['below_remain_life_thr'] = belowRemainLifeThr;
    map['compatibility'] = compatibility;
    if (container != null) {
      map['container'] = container?.toJson();
    }
    map['container_id'] = containerId;
    map['device'] = device;
    map['disable_secera'] = disableSecera;
    map['diskType'] = diskType;
    map['disk_code'] = diskCode;
    map['disk_location'] = diskLocation;
    map['erase_time'] = eraseTime;
    map['firm'] = firm;
    map['firmware_status'] = firmwareStatus;
    map['has_system'] = hasSystem;
    if (hideInfo != null) {
      map['hide_info'] = hideInfo?.map((v) => v.toJson()).toList();
    }
    map['i18nNamingInfo'] = i18nNamingInfo;
    map['id'] = id;
    map['ihm_testing'] = ihmTesting;
    map['is4Kn'] = is4Kn;
    map['isSsd'] = isSsd;
    map['isSynoDrive'] = isSynoDrive;
    map['isSynoPartition'] = isSynoPartition;
    map['is_bundle_ssd'] = isBundleSsd;
    map['is_erasing'] = isErasing;
    map['longName'] = longName;
    map['model'] = model;
    map['name'] = name;
    map['num_id'] = numId;
    map['order'] = order;
    map['overview_status'] = overviewStatus;
    map['pciSlot'] = pciSlot;
    map['perf_testing'] = perfTesting;
    map['portType'] = portType;
    // map['remain_life'] = remainLife;
    map['remain_life_danger'] = remainLifeDanger;
    if (remoteInfo != null) {
      map['remote_info'] = remoteInfo?.toJson();
    }
    map['sb_days_left'] = sbDaysLeft;
    map['sb_days_left_critical'] = sbDaysLeftCritical;
    map['sb_days_left_warning'] = sbDaysLeftWarning;
    map['serial'] = serial;
    map['size_total'] = sizeTotal;
    map['slot_id'] = slotId;
    map['smart_progress'] = smartProgress;
    map['smart_status'] = smartStatus;
    map['smart_test_limit'] = smartTestLimit;
    map['smart_test_support'] = smartTestSupport;
    map['smart_testing'] = smartTesting;
    map['status'] = status;
    map['summary_status_category'] = summaryStatusCategory;
    map['summary_status_key'] = summaryStatusKey;
    map['temp'] = temp;
    map['testing_progress'] = testingProgress;
    map['testing_type'] = testingType;
    map['tray_status'] = trayStatus;
    map['ui_serial'] = uiSerial;
    map['unc'] = unc;
    map['used_by'] = usedBy;
    map['vendor'] = vendor;
    map['wcache_force_off'] = wcacheForceOff;
    map['wcache_force_on'] = wcacheForceOn;
    map['wdda_support'] = wddaSupport;
    return map;
  }
}

/// compatibility : "disabled"
/// unc : 0

class RemoteInfo {
  RemoteInfo({
    this.compatibility,
    this.unc,
  });

  RemoteInfo.fromJson(dynamic json) {
    compatibility = json['compatibility'];
    unc = json['unc'];
  }
  String? compatibility;
  num? unc;
  RemoteInfo copyWith({
    String? compatibility,
    num? unc,
  }) =>
      RemoteInfo(
        compatibility: compatibility ?? this.compatibility,
        unc: unc ?? this.unc,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['compatibility'] = compatibility;
    map['unc'] = unc;
    return map;
  }
}

/// order : 0
/// str : "DS918+"
/// supportPwrBtnDisable : false
/// type : "internal"

class StorageContainer {
  StorageContainer({
    this.order,
    this.str,
    this.supportPwrBtnDisable,
    this.type,
  });

  StorageContainer.fromJson(dynamic json) {
    order = json['order'];
    str = json['str'];
    supportPwrBtnDisable = json['supportPwrBtnDisable'];
    type = json['type'];
  }
  num? order;
  String? str;
  bool? supportPwrBtnDisable;
  String? type;
  StorageContainer copyWith({
    num? order,
    String? str,
    bool? supportPwrBtnDisable,
    String? type,
  }) =>
      StorageContainer(
        order: order ?? this.order,
        str: str ?? this.str,
        supportPwrBtnDisable: supportPwrBtnDisable ?? this.supportPwrBtnDisable,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order'] = order;
    map['str'] = str;
    map['supportPwrBtnDisable'] = supportPwrBtnDisable;
    map['type'] = type;
    return map;
  }
}

/// alert : false
/// notification : false
/// selectable : true
/// show_lifetime_chart : true

class Action {
  Action({
    this.alert,
    this.notification,
    this.selectable,
    this.showLifetimeChart,
  });

  Action.fromJson(dynamic json) {
    alert = json['alert'];
    notification = json['notification'];
    selectable = json['selectable'];
    showLifetimeChart = json['show_lifetime_chart'];
  }
  bool? alert;
  bool? notification;
  bool? selectable;
  bool? showLifetimeChart;
  Action copyWith({
    bool? alert,
    bool? notification,
    bool? selectable,
    bool? showLifetimeChart,
  }) =>
      Action(
        alert: alert ?? this.alert,
        notification: notification ?? this.notification,
        selectable: selectable ?? this.selectable,
        showLifetimeChart: showLifetimeChart ?? this.showLifetimeChart,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alert'] = alert;
    map['notification'] = notification;
    map['selectable'] = selectable;
    map['show_lifetime_chart'] = showLifetimeChart;
    return map;
  }
}
