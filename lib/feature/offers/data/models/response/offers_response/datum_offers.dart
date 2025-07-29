import 'offer_sub_service.dart';

class DatumOffers {
  int? offerId;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  int? discountValue;
  bool? isPercentage;
  bool? isActive;
  List<OfferSubService>? offerSubServices;

  DatumOffers({
    this.offerId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.discountValue,
    this.isPercentage,
    this.isActive,
    this.offerSubServices,
  });

  factory DatumOffers.fromJson(Map<String, dynamic> json) => DatumOffers(
    offerId: json['offerId'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    startDate: json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    discountValue: json['discountValue'] as int?,
    isPercentage: json['isPercentage'] as bool?,
    isActive: json['isActive'] as bool?,
    offerSubServices: (json['offerSubServices'] as List<dynamic>?)
        ?.map((e) => OfferSubService.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'offerId': offerId,
    'title': title,
    'description': description,
    'startDate': startDate?.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'discountValue': discountValue,
    'isPercentage': isPercentage,
    'isActive': isActive,
    'offerSubServices': offerSubServices?.map((e) => e.toJson()).toList(),
  };
}
