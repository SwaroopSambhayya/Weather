import 'package:dio/dio.dart';
import 'package:weather/constants.dart';
import 'package:weather/keys.dart';
import 'package:weather/models/place_detail.dart';

Future getGeometry(String placeId) async {
  Dio dio = Dio();
  try {
    Response response = await dio.get('$mapBaseURL/geocode/json',
        queryParameters: {"place_id": placeId, "key": apiKey});
    return Location.fromJson(
        response.data["results"][0]["geometry"]["location"]);
  } on DioError catch (e) {
    return e;
  }
}
