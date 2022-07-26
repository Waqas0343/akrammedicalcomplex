import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const SizedBox(
              child:
              CircularProgressIndicator()),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Please Wait...",
            style: Get.theme.textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
