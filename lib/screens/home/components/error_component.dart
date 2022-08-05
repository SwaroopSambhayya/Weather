import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/networkerror.json',
            fit: BoxFit.contain, repeat: false),
        Column(
          children: const [
            Text(
              "Oops!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Something went wrong, please try again")
          ],
        )
      ],
    );
  }
}
