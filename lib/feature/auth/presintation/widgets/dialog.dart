import 'package:flutter/material.dart';

showErrorToast(String text, BuildContext context) {
  SnackBar(content: Text(text));
}

showDailogTaost(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            // child: Lottie.asset('assets/images/Animation - 1740397466836.json',
            //     width: 170),
          ),
        ],
      );
    },
  );
}
