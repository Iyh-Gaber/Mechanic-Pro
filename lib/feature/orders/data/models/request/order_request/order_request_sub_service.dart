/*class OrderRequestSubService {
  OrderRequestSubService();

  factory OrderRequestSubService.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError(
      'OrderSubService.fromJson($json) is not implemented',
    );
  }

  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
*/

import 'package:json_annotation/json_annotation.dart'; // <--- **تأكد من وجود هذا الاستيراد**

part 'order_request_sub_service.g.dart'; // <--- **تأكد من وجود هذا السطر بالظبط**

@JsonSerializable() // <--- **تأكد من وجود هذه التعليمة (Annotation)**
class OrderRequestSubService {
  // <--- **هنا تكمن المشكلة! يجب أن تضيف الحقول هنا**
  final String? orderSubServiceName; // <--- **أضف هذا السطر**

  // <--- **تأكد أن الـ constructor يأخذ الحقل الجديد**
  OrderRequestSubService({
    this.orderSubServiceName,
  }); // <--- **عدل الـ constructor ليحتوي على الحقل**

  // <--- **تأكد أن الدوال المولدة تستخدم أسماء الدوال الصحيحة**
  factory OrderRequestSubService.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestSubServiceFromJson(json);
  Map<String, dynamic> toJson() => _$OrderRequestSubServiceToJson(this);
}
