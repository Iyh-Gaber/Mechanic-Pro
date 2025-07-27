class Datum {
  int? serviceId;
  String? activityName;
  String? serviceName;
  bool? isdeleted;

  Datum({this.serviceId, this.activityName, this.serviceName, this.isdeleted});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    serviceId: json['serviceId'] as int?,
    activityName: json['activityName'] as String?,
    serviceName: json['serviceName'] as String?,
    isdeleted: json['isdeleted'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'serviceId': serviceId,
    'activityName': activityName,
    'serviceName': serviceName,
    'isdeleted': isdeleted,
  };
}
