import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/home/home.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        nextButtonBuilder: (context) {
          return const Icon(IconlyLight.arrowRight);
        },
        onFinish: () async {
          Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
            return const Home();
          }));
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("onboarded", true);
        },
        itemBuilder: (index) {
          return Stack(children: [
            Positioned(
              top: 80,
              left: 50,
              right: 40,
              child: Image.asset(
                onboardingDetails[index].assetUrl!,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Text(
                    onboardingDetails[index].title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: onboardingDetails[index].textColors),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    onboardingDetails[index].description!,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: onboardingDetails[index].textColors),
                  )
                ],
              ),
            )
          ]);
        },
        colors: const <Color>[Color.fromARGB(255, 56, 96, 228), Colors.white],
        itemCount: 2,
      ),
    );
  }
}
