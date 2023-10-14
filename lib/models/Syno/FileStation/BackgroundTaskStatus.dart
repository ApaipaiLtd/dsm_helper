/// dest_folder_path : "/home/Photos"
/// finished : false
/// path : "/home/Photos/婚纱照.zip"
/// processing_path : "/home/Photos/婚纱照.zip"
/// progress : 0.1

class BackgroundTaskStatus {
  BackgroundTaskStatus({
    this.destFolderPath,
    this.finished,
    this.foundDirNum,
    this.foundFileNum,
    this.foundFileSize,
    this.path,
    this.processedSize,
    this.processingPath,
    this.progress,
    this.status,
    this.total,
    this.transferRate,
  });

  BackgroundTaskStatus.fromJson(dynamic json) {
    destFolderPath = json['dest_folder_path'];
    finished = json['finished'];
    path = json['path'];
    foundDirNum = json['found_dir_num'];
    foundFileNum = json['found_file_num'];
    foundFileSize = json['found_file_size'];
    processedSize = json['processed_size'];
    processingPath = json['processing_path'];
    progress = json['progress'];
    status = json['status'];
    total = json['total'];
    transferRate = json['transfer_rate'];
  }
  String? destFolderPath;
  bool? finished;
  num? foundDirNum;
  num? foundFileNum;
  num? foundFileSize;
  String? path;
  String? processingPath;
  num? processedSize;
  num? progress;
  String? status;
  num? total;
  num? transferRate;
  BackgroundTaskStatus copyWith({
    String? destFolderPath,
    bool? finished,
    num? foundDirNum,
    num? foundFileNum,
    num? foundFileSize,
    String? path,
    String? processingPath,
    num? processedSize,
    num? progress,
    String? status,
    num? total,
    num? transferRate,
  }) =>
      BackgroundTaskStatus(
        destFolderPath: destFolderPath ?? this.destFolderPath,
        finished: finished ?? this.finished,
        path: path ?? this.path,
        foundDirNum: foundDirNum ?? this.foundDirNum,
        foundFileNum: foundFileNum ?? this.foundFileNum,
        foundFileSize: foundFileSize ?? this.foundFileSize,
        processingPath: processingPath ?? this.processingPath,
        processedSize: processedSize ?? this.processedSize,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        total: total ?? this.total,
        transferRate: transferRate ?? this.transferRate,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dest_folder_path'] = destFolderPath;
    map['finished'] = finished;
    map['found_dir_num'] = foundDirNum;
    map['found_file_num'] = foundFileNum;
    map['found_file_size'] = foundFileSize;
    map['path'] = path;
    map['processing_path'] = processingPath;
    map['processed_size'] = processedSize;
    map['progress'] = progress;
    map['status'] = status;
    map['total'] = total;
    map['transfer_rate'] = transferRate;
    return map;
  }
}
