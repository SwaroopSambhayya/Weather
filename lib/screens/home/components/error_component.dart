import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/error.dart';
import 'package:weather/services/error_helper.dart';

class ErrorComponent extends StatelessWidget {
  final DioError error;
  const ErrorComponent({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Error errorType = getDioErrorMessage(error);
    return Column(
      children: [
        Lottie.asset(errorType.asset, fit: BoxFit.contain, repeat: false),
        Column(
          children: [
            Text(
              errorType.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(errorType.subtitle)
          ],
        )
      ],
    );
  }
}
