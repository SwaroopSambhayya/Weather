import 'package:dio/dio.dart';
import 'package:weather/constants.dart';
import 'package:weather/keys.dart';
import 'package:weather/models/place_detail.dart';

Future getAutoCompleteList(inputString) async {
  Dio dio = Dio();
  try {
    Response response = await dio.get('$mapBaseURL/place/autocomplete/json',
        queryParameters: {
          "input": inputString,
          "types": "(regions)",
          "key": apiKey
        });
    PlaceDetail placeDetails = PlaceDetail.fromJson(response.data);
    return placeDetails.predictions;
  } on DioError catch (e) {
    return e;
  }
}
