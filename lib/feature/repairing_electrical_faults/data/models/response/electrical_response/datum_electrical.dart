class DatumElectrical {
  int? subServiceId;
  int? serviceId;
  String? subServiceName;
  String? description;
  dynamic service;
  List<dynamic>? offerSubServices;

  DatumElectrical({
    this.subServiceId,
    this.serviceId,
    this.subServiceName,
    this.description,
    this.service,
    this.offerSubServices,
  });

  factory DatumElectrical.fromJson(Map<String, dynamic> json) =>
      DatumElectrical(
        subServiceId: json['subServiceId'] as int?,
        serviceId: json['serviceId'] as int?,
        subServiceName: json['subServiceName'] as String?,
        description: json['description'] as String?,
        service: json['service'] as dynamic,
        offerSubServices: json['offerSubServices'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
    'subServiceId': subServiceId,
    'serviceId': serviceId,
    'subServiceName': subServiceName,
    'description': description,
    'service': service,
    'offerSubServices': offerSubServices,
  };
}
