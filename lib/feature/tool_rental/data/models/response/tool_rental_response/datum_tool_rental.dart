class DatumToolRental {
  int? subServiceId;
  int? serviceId;
  String? subServiceName;
  String? description;
  dynamic service;
  List<dynamic>? offerSubServices;

  DatumToolRental({
    this.subServiceId,
    this.serviceId,
    this.subServiceName,
    this.description,
    this.service,
    this.offerSubServices,
  });

  factory DatumToolRental.fromJson(Map<String, dynamic> json) =>
      DatumToolRental(
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
