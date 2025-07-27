 /*import 'order_request_service.dart';

class OrderRequest {
  int? userId;
  String? userName;
  List<OrderRequestService>? orderServices;
  String? maintenanceCenter;
  bool? isHomeService;
  DateTime? orderDate;

  OrderRequest({
    this.userId,
    this.userName,
    this.orderServices,
    this.maintenanceCenter,
    this.isHomeService,
    this.orderDate,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
    userId: json['userId'] as int?,
    userName: json['userName'] as String?,
    orderServices: (json['orderServices'] as List<dynamic>?)
        ?.map((e) => OrderRequestService.fromJson(e as Map<String, dynamic>))
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
*/
import 'package:json_annotation/json_annotation.dart'; // أضف هذا الاستيراد
import 'order_request_service.dart';

part 'order_request.g.dart'; // أضف هذا السطر

@JsonSerializable() // أضف هذا التعليق التوضيحي (annotation)
class OrderRequest {
  int? userId;
  String? userName;
  List<OrderRequestService>? orderServices;
  String? maintenanceCenter;
  bool? isHomeService;
  DateTime? orderDate;

  OrderRequest({
    this.userId,
    this.userName,
    this.orderServices,
    this.maintenanceCenter,
    this.isHomeService,
    this.orderDate,
  });

  // استبدل الدالة المكتوبة يدوياً بـ fromJson المولدة
  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);

  // استبدل الدالة المكتوبة يدوياً بـ toJson المولدة
  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}
