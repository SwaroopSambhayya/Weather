import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather/api/geocoding.dart';
import 'package:weather/api/get_weather.dart';
import 'package:weather/models/place_detail.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/weatherDetails/weather_details.dart';

class SearchWeather extends ChangeNotifier {
  bool loading = false;
  DioError? error;
  Weather? weather;

  reset() {
    error = null;
    weather = null;
    loading = false;
    notifyListeners();
  }

  getWeather(String placeId, BuildContext? context) async {
    loading = true;
    error = null;
    notifyListeners();
    var result = await getGeometry(placeId);
    if (result is DioError) {
      error = result;
    } else {
      Location location = result;
      result = await getWeatherData(location);
      if (result is DioError) {
        error = result;
      } else {
        weather = result;
      }
    }
    loading = false;
    if (weather != null && context != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        PageTransition(
            child: WeatherDetails(
              weather: weather!,
            ),
            type: PageTransitionType.fade),
      );
    }
    notifyListeners();
  }
}
