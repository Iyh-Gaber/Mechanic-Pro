class DatumRegular {
  int? subServiceId;
  int? serviceId;
  String? subServiceName;
  String? description;
  dynamic service;
  List<dynamic>? offerSubServices;

  DatumRegular({
    this.subServiceId,
    this.serviceId,
    this.subServiceName,
    this.description,
    this.service,
    this.offerSubServices,
  });

  factory DatumRegular.fromJson(Map<String, dynamic> json) => DatumRegular(
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
