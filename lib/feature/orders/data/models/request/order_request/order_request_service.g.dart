// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequestService _$OrderRequestServiceFromJson(Map<String, dynamic> json) =>
    OrderRequestService(
      orderServiceName: json['orderServiceName'] as String?,
      orderSubServices:
          (json['orderSubServices'] as List<dynamic>?)
              ?.map(
                (e) =>
                    OrderRequestSubService.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$OrderRequestServiceToJson(
  OrderRequestService instance,
) => <String, dynamic>{
  'orderServiceName': instance.orderServiceName,
  'orderSubServices': instance.orderSubServices,
};
