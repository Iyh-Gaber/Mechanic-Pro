class OrderSubService {
  String? orderSubServiceName;

  OrderSubService({this.orderSubServiceName});

  factory OrderSubService.fromJson(Map<String, dynamic> json) {
    return OrderSubService(
      orderSubServiceName: json['orderSubServiceName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderSubServiceName': orderSubServiceName,
      };
}
