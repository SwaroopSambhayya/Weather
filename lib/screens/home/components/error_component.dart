import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/error.dart';
import 'package:weather/services/error_helper.dart';

class ErrorComponent extends StatelessWidget {
  final DioError error;
  final double? illustrationWidth;
  final double? illustartionHeight;
  final double? titleFontSize;
  final double? subtitleFontSize;

  const ErrorComponent(
      {Key? key,
      required this.error,
      this.illustartionHeight,
      this.illustrationWidth,
      this.titleFontSize,
      this.subtitleFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Error errorType = getDioErrorMessage(error);
    return Column(
      children: [
        Lottie.asset(errorType.asset,
            fit: BoxFit.contain,
            repeat: false,
            width: illustrationWidth,
            height: illustartionHeight),
        Column(
          children: [
            Text(
              errorType.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: titleFontSize ?? 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              errorType.subtitle,
              style: TextStyle(fontSize: subtitleFontSize),
            )
          ],
        )
      ],
    );
  }
}
