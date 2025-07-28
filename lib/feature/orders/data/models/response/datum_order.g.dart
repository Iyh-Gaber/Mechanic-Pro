// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatumOrder _$DatumOrderFromJson(Map<String, dynamic> json) => DatumOrder(
  orderId: (json['orderId'] as num?)?.toInt(),
  userId: (json['userId'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  orderServices:
      (json['orderServices'] as List<dynamic>?)
          ?.map((e) => OrderRequestService.fromJson(e as Map<String, dynamic>))
          .toList(),
  maintenanceCenter: json['maintenanceCenter'] as String?,
  isHomeService: json['isHomeService'] as bool?,
  orderDate:
      json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  isPaid: json['isPaid'] as bool?,
  orderAmount: (json['orderAmount'] as num?)?.toDouble(),
  isCanceled: json['isCanceled'] as bool?,
);

Map<String, dynamic> _$DatumOrderToJson(DatumOrder instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'userId': instance.userId,
      'userName': instance.userName,
      'orderServices': instance.orderServices,
      'maintenanceCenter': instance.maintenanceCenter,
      'isHomeService': instance.isHomeService,
      'orderDate': instance.orderDate?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isPaid': instance.isPaid,
      'orderAmount': instance.orderAmount,
      'isCanceled': instance.isCanceled,
    };
