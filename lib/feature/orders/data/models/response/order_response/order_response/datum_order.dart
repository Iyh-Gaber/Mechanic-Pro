import 'order_service.dart';

class DatumOrder {
  int? orderId;
  int? userId;
  String? userName;
  List<OrderService>? orderServices;
  String? maintenanceCenter;
  bool? isHomeService;
  DateTime? orderDate;
  dynamic startDate;
  dynamic endDate;
  bool? isPaid;
  dynamic orderAmount;
  bool? isCanceled;

  DatumOrder({
    this.orderId,
    this.userId,
    this.userName,
    this.orderServices,
    this.maintenanceCenter,
    this.isHomeService,
    this.orderDate,
    this.startDate,
    this.endDate,
    this.isPaid,
    this.orderAmount,
    this.isCanceled,
  });

  factory DatumOrder.fromJson(Map<String, dynamic> json) => DatumOrder(
        orderId: json['orderId'] as int?,
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
        startDate: json['startDate'] as dynamic,
        endDate: json['endDate'] as dynamic,
        isPaid: json['isPaid'] as bool?,
        orderAmount: json['orderAmount'] as dynamic,
        isCanceled: json['isCanceled'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'userId': userId,
        'userName': userName,
        'orderServices': orderServices?.map((e) => e.toJson()).toList(),
        'maintenanceCenter': maintenanceCenter,
        'isHomeService': isHomeService,
        'orderDate': orderDate?.toIso8601String(),
        'startDate': startDate,
        'endDate': endDate,
        'isPaid': isPaid,
        'orderAmount': orderAmount,
        'isCanceled': isCanceled,
      };
}
