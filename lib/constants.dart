import 'package:weather/models/onboaridng_data.dart';
import 'package:flutter/material.dart';

List<OnboaridngData> onboardingDetails = [
  OnboaridngData(
      title: "Weather News & Feed",
      description:
          "Wherever you go, no matter what the weather, always bring your own sunshine",
      assetUrl: "assets/3dIcons/sun/28.png",
      textColors: Colors.white,
      buttonColor: Colors.white),
  OnboaridngData(
      title: "Daily Weather Updates",
      description:
          "Weather is a literary specialty, and no untrained hand can turn out a good article on it",
      assetUrl: "assets/3dIcons/moon/40.png",
      textColors: const Color.fromARGB(255, 56, 96, 228),
      buttonColor: const Color.fromARGB(255, 56, 96, 228)),
];

const mapBaseURL = "https://maps.googleapis.com/maps/api";
const weatherBaseURL = "https://api.openweathermap.org/data/2.5";
