/// enable_domain : false

class Domain {
  Domain({
    this.enableDomain,
  });

  Domain.fromJson(dynamic json) {
    enableDomain = json['enable_domain'];
  }
  bool? enableDomain;
  Domain copyWith({
    bool? enableDomain,
  }) =>
      Domain(
        enableDomain: enableDomain ?? this.enableDomain,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_domain'] = enableDomain;
    return map;
  }
}
