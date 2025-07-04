import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // الخلفية (التي ستظهر ضبابية)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQUg-riKOmTZd1i27kIGegM27qNijqgJbdK7dvKtZMa5ePYjsJmEQocWJBr5uh1vUbdY8Wh0lD7MipZieQ'), // مثال لصورة خلفية
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter:
                    ImageFilter.blur(sigmaX: 7, sigmaY: 7), // مقدار الضبابية
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 209, 111, 111)
                        .withOpacity(0.3), // لون وشفافية العنصر الزجاجي
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2)), // حدود خفيفة
                  ),
                  child: Center(
                    child: Text(
                      'Glass Effect',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
