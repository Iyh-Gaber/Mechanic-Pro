// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
  userId: json['userId'] as String?,
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

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'orderServices': instance.orderServices,
      'maintenanceCenter': instance.maintenanceCenter,
      'isHomeService': instance.isHomeService,
      'orderDate': instance.orderDate?.toIso8601String(),
    };
