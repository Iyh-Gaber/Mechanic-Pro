// هذا الملف (lib/shared_widgets/service_card.dart) هو "قالب الكارت"
/*import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String serviceName; // فراغ لاسم الخدمة
  final String serviceDescription; // فراغ لوصف الخدمة
  final double servicePrice; // فراغ لسعر الخدمة
  final IconData icon; // فراغ للأيقونة
  final bool isSelected; // فراغ لتحديد هل الكارت مختار أم لا
  final VoidCallback onTap; // فراغ لما يحدث عند الضغط على الكارت

  const ServiceCard({
    super.key,
    required this.serviceName,
    required this.serviceDescription,
    required this.servicePrice,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // هنا كل كود الـ UI الثابت (الشكل، الألوان، الحدود، التظليل)
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // هنا نستخدم الفراغات لملء المحتوى
            children: [
              Icon(icon, size: 48), // هنا نضع الأيقونة الممررة
              Text(serviceName), // هنا نضع اسم الخدمة الممرر
              Text(serviceDescription), // هنا نضع الوصف الممرر
              Text(
                '\$${servicePrice.toStringAsFixed(2)}',
              ), // هنا نضع السعر الممرر
            ],
          ),
        ),
      ),
    );
  }
}
*/
// هذا الملف (lib/shared_widgets/service_card.dart) هو "قالب الكارت"
import 'package:flutter/material.dart';
import 'package:mechpro/feature/repairing_electrical_faults/data/models/response/electrical_response/datum_electrical.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';

class ServiceCard extends StatelessWidget {
  // الآن ServiceCard سيستقبل كائن الخدمة كاملاً
  // سنستخدم dynamic هنا لأنه يمكن أن يكون DatumElectrical أو DatumMechanical
  // الأفضل هو استخدام نوع عام أو واجهة إذا كانت النماذج تشترك في نفس الخصائص
  // لكن للتبسيط ولأن كلاهما يحتوي على subServiceName و description، سنستخدم dynamic مؤقتًا.
  // أو الأفضل، نستخدم Object ونقوم بالتحقق من النوع.
  // بما أن كلا DatumElectrical و DatumMechanical لهما subServiceName و description،
  // سنقوم بإنشاء واجهة بسيطة أو نستخدم Object مع التحقق.
  // الأسهل هو جعل service من نوع Object والوصول للخصائص بشكل آمن.

  // لتجنب التعقيد، سنفترض أن service له خصائص subServiceName و description.
  // إذا كانت هناك خصائص أخرى مثل السعر، يجب أن تكون موجودة في النموذج أو يتم تمريرها بشكل منفصل.
  // بما أن DatumElectrical و DatumMechanical لا يحتويان على servicePrice، سنقوم بإزالته من ServiceCard.

  final dynamic service; // هذا سيستقبل DatumElectrical أو DatumMechanical
  final IconData icon; // الأيقونة
  final bool isSelected; // هل الكارت مختار أم لا
  final VoidCallback onTap; // ما يحدث عند الضغط على الكارت

  const ServiceCard({
    super.key,
    required this.service, // الآن نطلب كائن الخدمة كاملاً
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // الوصول إلى اسم الخدمة والوصف من الكائن service
    // نستخدم ?? '' لتجنب الأخطاء إذا كانت القيمة null
    final String serviceName = service?.subServiceName ?? 'N/A Service Name';
    final String serviceDescription =
        service?.description ?? 'No description available';
    // إذا كان هناك سعر، يجب أن يكون ضمن كائن الخدمة أو يتم تمريره بشكل منفصل
    // بما أن DatumElectrical و DatumMechanical لا يحتويان على price، سنقوم بإزالة عرضه مؤقتًا.
    // إذا كان السعر موجودًا في النموذج، يمكنك الوصول إليه هكذا:
    // final double? servicePrice = service?.price;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected
            ? Colors.green.shade100
            : Colors.white, // مثال لتغيير اللون عند الاختيار
        elevation: isSelected ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isSelected
              ? const BorderSide(color: Colors.green, width: 2)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: isSelected ? Colors.green : Colors.blueGrey,
              ), // نضع الأيقونة الممررة
              const SizedBox(height: 8),
              Text(
                serviceName, // نستخدم اسم الخدمة المستخرج
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected ? Colors.green.shade800 : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                serviceDescription, // نستخدم الوصف المستخرج
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? Colors.green.shade600
                      : Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // بما أن DatumElectrical و DatumMechanical لا يحتويان على سعر، لن نعرضه هنا.
              // إذا كان السعر موجودًا في النموذج، يمكنك إضافة هذا الكود:
              /*
              if (servicePrice != null) ...[
                const SizedBox(height: 8),
                Text(
                  '\$${servicePrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isSelected ? Colors.green.shade900 : Colors.blue.shade700,
                  ),
                ),
              ],
              */
            ],
          ),
        ),
      ),
    );
  }
}
