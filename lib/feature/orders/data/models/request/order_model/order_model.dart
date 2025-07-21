import 'order_service.dart';

class OrderModel {
  int? userId;
  String? userName;
  List<OrderService>? orderServices;
  String? maintenanceCenter;
  bool? isHomeService;
  DateTime? orderDate;

  OrderModel({
    this.userId,
    this.userName,
    this.orderServices,
    this.maintenanceCenter,
    this.isHomeService,
    this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        userId: json['userId'] as int?,
        userName: json['userName'] as String?,
        orderServices: (json['orderServices'] as List<dynamic>?)
            ?.map((e) => OrderService.fromJson(e as Map<String, dynamic>))
            .toList(),
        maintenanceCenter: json['maintenanceCenter'] as String?,
        isHomeService: json['isHomeService'] as bool?,
        orderDate: json['orderDate'] == null
            ? null
            : DateTime.parse(json['orderDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'orderServices': orderServices?.map((e) => e.toJson()).toList(),
        'maintenanceCenter': maintenanceCenter,
        'isHomeService': isHomeService,
        'orderDate': orderDate?.toIso8601String(),
      };
}
