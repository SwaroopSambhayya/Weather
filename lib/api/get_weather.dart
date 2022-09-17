import 'package:dio/dio.dart';
import 'package:weather/constants.dart';
import 'package:weather/keys.dart';
import 'package:weather/models/place_detail.dart';
import 'package:weather/models/weather.dart';

Future getWeatherData(Location location) async {
  try {
    Dio dio = Dio();
    Response response = await dio.get("$weatherBaseURL/weather",
        queryParameters: {
          "appid": weatherKey,
          "lat": location.lat,
          "lon": location.lng,
          "units": "metric"
        });
    return Weather.fromJson(response.data);
  } on DioError catch (e) {
    return e;
  }
}
