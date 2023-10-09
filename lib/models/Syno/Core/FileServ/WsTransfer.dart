/// enable_wstransfer : true

class WsTransfer {
  WsTransfer({
    this.enableWstransfer,
  });

  WsTransfer.fromJson(dynamic json) {
    enableWstransfer = json['enable_wstransfer'];
  }
  bool? enableWstransfer;
  WsTransfer copyWith({
    bool? enableWstransfer,
  }) =>
      WsTransfer(
        enableWstransfer: enableWstransfer ?? this.enableWstransfer,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_wstransfer'] = enableWstransfer;
    return map;
  }
}
